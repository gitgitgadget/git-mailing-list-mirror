Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D93A8FE0
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952500; cv=none; b=rc6cw4zNTP8RYJ0eO53DVsFWgf9lWodNVSg4QTOWFXfNnTk5e9Z8c+IdA6pmjB6fYRaTjb/rHPmqK/iE+AzpcCZG3QhFaMqboinw6NijBkuEbumAd9waAj4RfiuloG1+oszVxRcC7/QA733G+192TCvjO5a430V6k+8a/bbGmUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952500; c=relaxed/simple;
	bh=5I3lCxUK6j8RcrwHj6rF5RGGpbaKBKsacPGa0Ebn/qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfOczdz9DF4aQItqKlubCWLLwNcciriQUYNeGUscoC4zpLiqljXTylTgQTyohEaj1RCppPcXmZO1rgdC6K+M+W/uNuUDe71ML8JdISUYZ4xEsGTxpZm6kvEGzIDnOGEYXXAdyvBKkSdXHOyIiF0VwLcDSNkVhNTjf7LsC++K5YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMgA6iOy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMgA6iOy"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-824b621ef8aso514948b3a.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 09:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771952499; x=1772557299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xz3+ds9rhqQfsVkHYTjUqRRlLLKxoAmx7jvrQIIsJR4=;
        b=PMgA6iOy9JQti7suEJ5h++dLescurnQGAI1fc4wnBVhNX9IkKikkv5Rqe6Q5QYwvde
         cPTnn2YOBIqffRrDRjz0ScN1TcCThMWZ2pxZDErPzeWQ+KkzjoXnYXVhacCxJVe5887E
         v/5jmKVx7oYfk/DZzs77hN/Ma9EXXSPxGBSPcC3CLKYLEd6fFu4qN52U9tr6iUHfL0Oh
         4liwIwbl4b5Fvx3xsIrM5II8S7YMGWilY1SA+8X4ZkhRIZH6SBN+RX+5ZsUsh0qsadRt
         XGrIonnqJbdNZ4bvMYWzm7oNV6qtw657pKXjWJw7RPhQ20qOnMkmwosRRS03QahSdzit
         xyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952499; x=1772557299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xz3+ds9rhqQfsVkHYTjUqRRlLLKxoAmx7jvrQIIsJR4=;
        b=rCEKQKzkMZA0T9QkAFjRfFYAcyrQHdcgyEFUGEOKd1vveGJ95fTuyVPK+xD05hxXMr
         U7/VMFe8yEDaUoCaCiPh1CKRLdbszC6PlB233FkQ7zjWtkWi18je8rdh79nQEU2Fn9UF
         oda4rfVHdRRPr6Z+vNsrvO44MIhidKJSyLMhGpUO8k4253JLWQkM97IEfTUFzRwPHM34
         GIT2yhTt7WU5RfybtmiOGBTMGI/LuyUwMz/cu55corOZHUgPosCYtdelJ3WgtLAj1OjE
         Tyr8rghW92vCzSiDrRsCBkY0BWyr0oRAvDZadEQpc3z97CPPoUkkpgfXunOdEqXhcDx4
         hChw==
X-Gm-Message-State: AOJu0YxMyiFCu2v6XslDFedLzM4D+ovRM1V05wOOrOwPQf/ZGogvL/EY
	QMf54wQUhEKHHLD9/x4lXD/6xSS6nPg5e9D0Seph2oEjGNxDQSpSyengxduO9Q==
X-Gm-Gg: ATEYQzyG7tBhLopZ8hlNKruM57YvfnD2AAx+jQEGXVydyQCHJNCq3+62Eol08lz9yvL
	asat84XTQBRY8t2jVtFY71nRr3Vbr+3lQ5vC7uZ5z6+KSQZL2i0wh5msO2zNppkFis7P0sqeAY+
	Iaewyk+9J14IEdpnYKssKr26t3OUcXSQHfvkqiNj9gnwisk6ki+N/uQEXCDzqLqA95xPV//BQLM
	r2/3HBeHatbRg5XKcYl7hiXCylkwvYo/oPH7hW5ML/YgAD00c0oX7q9VhO1+qEff6atlnD2ccwg
	XsPREa/u8/YyWjXDFQGNuE2YLZXMD7jJucaT07lAYbf12Sl5fQ9PLPxyYpPERT4eSaBvdFlJRbR
	I6sDrJda3mfc5aUGcbZ22+Ic7duZlflV1JpWvZ/Ng/TLG+uhCBWScZD6daCMi/DjtiEV5MemOJ9
	nm20H1CTqQo1YIdvVMKwpYGsOfSEI=
X-Received: by 2002:a05:6a00:124e:b0:81f:e791:ea3d with SMTP id d2e1a72fcca58-826da718f3fmr7781653b3a.0.1771952499089;
        Tue, 24 Feb 2026 09:01:39 -0800 (PST)
Received: from [192.168.0.103] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd68d450sm11450164b3a.18.2026.02.24.09.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 09:01:38 -0800 (PST)
Message-ID: <e48c68ce-de45-4d45-8bd2-1307686a8910@gmail.com>
Date: Wed, 25 Feb 2026 01:01:36 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] setup: improve error diagnosis for invalid .git files
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
References: <20260221083001.220061-1-a3205153416@gmail.com>
 <20260222102928.377519-1-a3205153416@gmail.com> <xmqq4in8quxn.fsf@gitster.g>
 <xmqqqzqcpatz.fsf@gitster.g> <5263825f-163c-43af-bac7-152d670919d9@gmail.com>
 <xmqqfr6soxjq.fsf@gitster.g> <xmqq7bs3piz7.fsf@gitster.g>
 <a2b2e581-18ba-42ad-9bf1-a3e16b85f4e9@gmail.com> <xmqqwm03mfax.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqwm03mfax.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio,

I believe we have made some progress so far. However, after reviewing 
the code again just now, I still have a few questions I'd like to ask:

  1. Perhaps I took it literally, but as far as the original intent 
goes, shouldn't 'read_gitfile_gently()' be solely responsible for 
*opening a .git file and parsing the gitdir: <path> format*? However, it 
currently executes 'stat()', checks 'S_ISDIR', checks 'S_ISREG', handles 
missing components, and *then* attempts to parse. Do we need an 'enum 
git_componet_type git_componet(cost char *path)' which returns pure 
filesystem states, then parse it with 'parse_gitfile_format(const char 
*path)'? I don't know.

  2. Let's say, when stat() encounters a EACCES when cheaking a 
restricted sub-folder. Git funnels this into STAT_FAILED and 
subsequently invokes die(), which calls exit(). I'm thinking of 
libification: if a long running multi threaded git server encounters a 
permission-denied directory, is killing the entire process the expected 
behavior? Should 'permission-denied' really be considered as an 'error'? 
Does a library has the authority to terminate the application?

I won't touch any of this right now to keep the current scope focused, 
but I plan to incorporate thoughts into my GSoC proposal for the global 
state/libification project.

If you have more important things to do, feel free to ignore this email. 
After all, I consider it a minor issue.

This is my first patch at my nineteen, and I'm more than delighted to 
spend my birthday reviewing git code ;)

Regards,

Yuchen

