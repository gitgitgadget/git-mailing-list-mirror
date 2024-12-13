Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8681E04BF
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100686; cv=none; b=Kf/PrD1UO6RAMDQRP8iblUq4bhyIJFGcyAiFWcS+oxOdg1ElKf/QODY/GcEetcYfLiV29NzN5LFM7O1gBWUARohs4mSdeYN1D2DqZxv3UtnoPiUXGdBVj0pK++oIVnNbA7blpwjb4vYYNT5eRsrrA95cAJ54VheLRZJHfau7lA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100686; c=relaxed/simple;
	bh=6GNHcXf9MiXauf9k6aHMeN/HjPnnBQ0d+tcfzN0Z9l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NTMaCT9Rr40WBkNRdSAVpKU+LRTDRnuuGheGMAu7yl0E+XWgjUH8MPdN+yO1OSsMnzbMJa9bleKktpOJbHK9FdqpOVrn16fZJRpj/eFI8O01xGwAq0KW7kNQKDkmwwfvwFGJL5mqCb0yarE7WIQC/Ixs7dUArEjL0mfz6SROUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2xqJN8G; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2xqJN8G"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436249df846so12929125e9.3
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 06:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734100683; x=1734705483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=htAyILjydmR/x2wznYHMXhzeoRL8v8iaczcEAtxVkzo=;
        b=M2xqJN8GmtmAA6LGAQKLNLJqcLUc5LjnPypXFms+ls82Hhc2S6Q08SFpdYREMZsuEp
         xSBxZSywoVY4F8k6GosqqFxUHs3QEB4ml2r9qIrMMTfZbpSfhPUXPmVLLkcV1B8VId8b
         B+v0dbJZ82WH4+cComdfL7je9c8rRt1VeHoMu61BFQycHKKrIIiRYE2/izzS3JeDVsON
         2bzyOyD1hPKs5fx26dsXUVesKb4GJ+NEpxhYAYVL++mAHvFcemFMaRGR0DhRgaUC4Z88
         V611nehds/5fft4zIBrYWgJhGnPO7XeZyWb9EDRLyafawHB8sLVaW3zslWQbclSYywow
         ht3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734100683; x=1734705483;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htAyILjydmR/x2wznYHMXhzeoRL8v8iaczcEAtxVkzo=;
        b=eKUkIxS+3TPuuYS7FHcUIfQRe/x3heIn3/qgsxMapQpzxXnLsVfB8JBPE3WomgPCg7
         CtipjfU0v56qlmRKB2SUDPr1YsJzfVrMPAIahXZkoV1JGX+EPgiz4ENHbbAD6J84U2VX
         LsuZPNLyobakVlmz6iB3jzSvfCQEhgewXOub2J5P20+9YkbIdEJmuTluRnXfOO5BbwQI
         I3X2/GtmcJzB908vGlk4I9NfiEq4QbI5Uu/dbCTtok/kQaCajdFYdSD3NoYywOqIS/Lm
         ajlYdL7224mmN8VgdUq1cmQS2IWGhBVbcs7hcwHOKxi5jJ0NM0+17bEGqIShvTMg5VCs
         EiAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzwrAETD+AjuxPvhN+APbUOFXPKFBVIJpaN05wwSBgsL30OtOcI5vH3IufIMgaBCu2HkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL34Th/b3SHybshzLATVhCfUd7wKQypWKGRfvVE96dC4KE3jQU
	3R1OREdlM5tHU4jbFTA41URlHzfgg/bfWiJGX25I68p25ZuZCg+5
X-Gm-Gg: ASbGnctScONMAwzzICNIneArfhnA0rwNRdBBndX+RrrFmu9EUNeX47Xd8n6ek8hft5u
	jFqlK+lNqZpOYQochAH/VsPAyYYtnfwdqmitTYnhJPSsjOq3ERxl9X14VrIT9MwwznC0QTRo/Tc
	ZeD5TRKUmgYevy09wnS0itgXg4nbP1YB099AEVr13Ry7mc7OSzTjXamjKpxQknnBxfcTPnJzVoI
	It+khDDDSACWFkpMhLJsfUFQ+pLRheCbrtVPVhAB2sWOvTXSLACtSUPIPF0Jtp616TNJM/1pEzK
	yimIFHXbqMAVqpPnUoHnvn0LElcBuT9G1fE=
X-Google-Smtp-Source: AGHT+IFPGqF+OvMNg1ORX+ULQ4p5oaDET7Zyuh60xO1+qLOs02WRveAWMboG/Ec9qQsnBoKf15n9Sg==
X-Received: by 2002:adf:f545:0:b0:385:f409:b42 with SMTP id ffacd0b85a97d-3888e0c0831mr1951889f8f.53.1734100682984;
        Fri, 13 Dec 2024 06:38:02 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:62a:6d01:db19:6b99:fd5f:b9c2? ([2a0a:ef40:62a:6d01:db19:6b99:fd5f:b9c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251bc16sm7350074f8f.86.2024.12.13.06.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 06:38:02 -0800 (PST)
Message-ID: <534e8534-a9bd-428b-87f9-a512c9378b19@gmail.com>
Date: Fri, 13 Dec 2024 14:38:00 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git rebase --continue error message is misleading
To: =?UTF-8?Q?Bj=C3=B6rn_Lindqvist?= <bjourne@gmail.com>, git@vger.kernel.org
References: <CALG+76eJL5dC3o+yq7zreoRDQan1MPgfNXB42k5f2iq2bZEbNw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CALG+76eJL5dC3o+yq7zreoRDQan1MPgfNXB42k5f2iq2bZEbNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Björn

Thanks for reporting this

On 09/12/2024 13:02, Björn Lindqvist wrote:
> $ LANG=C git rebase --continue
> hint: Waiting for your editor to close the file... error: cannot run
> vi: No such file or directory
> error: unable to start editor 'vi'
> Please supply the message using either -m or -F option.

This line comes from "git commit" whenever launch_editor() fails. I 
wonder if we'd be better to recommend that the user sets up a working 
editor instead. The message is certainly unhelpful when we run "git 
commit" from "git cherry-pick/merge/rebase/revert" where we want to seed 
the message that the user edits.

> error: could not commit staged changes.
> $ git rebase --continue -m "done"
> ...
> $ git rebase --continue -F "done ffs"
> ...
> 
> It should say: Please commit the staged changes using git commit -m
> "commit message"

I don't think that is a good idea when "git commit" is being run from 
"git rebase". In that case we want to preserve the original message and 
authorship and using '-F' or '-m' would not do that.

Best Wishes

Phillip

