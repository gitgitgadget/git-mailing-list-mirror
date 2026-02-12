Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575D211A28
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917631; cv=none; b=e20mPMDUW+WVzqYtoka7x+6lWydRWNN9aVzyQUmC8EUD8RjivwRFhLQwcEpchXtx7+4gid2g+VCxRfMLB1zEw9ICnYcv7YgaXjCoqe0TpolL76DGUg0siMQVMdUX+LnQPxKpkr9Z7ZKuSssuZpm/niGUa4uDDXq1FmQGFhJ3MvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917631; c=relaxed/simple;
	bh=D90ErHCkF5gcz1DaWuwsKjUZc6rRLKJFawD+tjejQco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbtixbDusNi0U1BPQiFK+RhSin4l4DxwFGaN/iS5UNtQ4rpduFghUbXyvKycv2kY3CE9QIL1q/JYDzU1tcayxxEtK1axYlPJiItP7uuwDclkQZfRNQxHi4pW8BIIdL+bceQiAf3AlbB6ftW4WJ+pHstQUI7+ikUGKNZCSv4yh98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv0p18dc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv0p18dc"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aae985a839so70635ad.3
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 09:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770917630; x=1771522430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D90ErHCkF5gcz1DaWuwsKjUZc6rRLKJFawD+tjejQco=;
        b=hv0p18dcCiuY/4BmVzc/ctUjeaOpYdVcln0YxxlkCiP1jG33EGj2TPKNiWtR6gDcoe
         00Lny860VwqvnclELkENJJqyiWFF/s4ZdRs3t0w+oFl3AD1+2fa7TVWrq9hlRRr5VP+K
         6BqbWzCRIyMhofo3zeGSN3rJm6rPXw2u6hluWxJXRBVpYQA+uFng4Zni0c9/Nt7LuDED
         Fc1k7FcAd3DgodPcXupj9yvZy/1NqbkDY5THaWDaSOsNTtemcdmgBwuHX8fAQ+Y0Ho6g
         XqGDk9OJJaa4zyi2Jvf0M4rXwQ4guMr5Sds2uHHtRoGr+FgqjcVhBtl7LG2JgW9LCdzK
         wG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917630; x=1771522430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D90ErHCkF5gcz1DaWuwsKjUZc6rRLKJFawD+tjejQco=;
        b=egmnambBMEMhPpnS6uRKFwymENm5TI8zqTXvIvLqeB+fKPdSLPBfXVGA8hYA+D9ZqR
         m8/fSrHnsqzYno1rzRPhtaqhk4v/TkuC5Szx0B4oqTbkdNlJo7k7GJSxYZEe66eBmwQX
         z8X+Zyqm1sfnRf7LO2sOdzUMV6naJ7Qu2st8M6bted2pxrZSr7qotvFYNjwdJHUyy+we
         uWCY6QfxH8rwAlbRCa+NrXUxWSxmFblgni0gIh1kFWq0hXFeGZemyHrpX3xqWdo4NMF1
         Hn1kAVYi9q1DzqsUdSBxjn8PRMisZ1qGl2bw04bGScAHV0jy6r/u2BL4AhojG5NIG77x
         UrLg==
X-Gm-Message-State: AOJu0YzeuObb2lL9C9L7QV8JYFO3tqfOLd1OQz9Czr3m3E+9L8fundFo
	6j78vuLtc3gXFhjefSpvzKTBPUqAJEG0cXxMD5jbvwjb+YI0DDQ8aUYPkZ4cunp1
X-Gm-Gg: AZuq6aJinSDmF5brLFXl+nnTgo/rLdbxErXrNspjy+gXRhPjR4IL+hy/QPPg80r2zZ7
	LV84sOqqdLzvBv84evevZ98v6wcOIgvZk9kYdI/NJGuMIrq8fBPdG2UcEatfJ1Kcd2omPbuq+tv
	htakdI42kUGs4zToMFRO6RDOtVZZg6GkthjuD0A2Z1QT0DHa8m3zVHnzd6F5GvoRTQpU/ix8vrn
	FrUmWn1Bf4t3d/tEDVEYAKEdMa0CmmmAlF7EjkFDrs7tGZh4lDmDv+TPJJhTLRuz92GtsXON2Va
	yEbbhXUwTDBjs8P0Kj8S1UXg8PArcbGdL/rQHfm/ZPdocKIhCv1KbDbm26s99S+KyPqnF1u0e64
	PvILGcHMORiAWWnEIMhkFz+/bnzNM6ojAB3406IkYxiNX2WljFuy2SCuz8+VTumOPNiNCM18DlO
	ZfO1nOxwwEQYAXRSvLKIVA0kE4n0I=
X-Received: by 2002:a17:903:35d0:b0:297:f3a7:9305 with SMTP id d9443c01a7336-2ab39ca1d30mr26821745ad.6.1770917629780;
        Thu, 12 Feb 2026 09:33:49 -0800 (PST)
Received: from [192.168.0.105] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984ad4asm58234485ad.6.2026.02.12.09.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 09:33:49 -0800 (PST)
Message-ID: <950a54d3-2b00-4e1e-937d-d22bf5cbbf27@gmail.com>
Date: Fri, 13 Feb 2026 01:33:46 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] setup: fail if .git is not a file or directory
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20260211182122.35352-1-a3205153416@gmail.com>
 <xmqq3437t643.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqq3437t643.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio,

I've rewrote the code based on your suggestions. If there
are further improvements to be made regarding coding style
or readability(especially the style of comments), please
let me know.

Happy valentine's day(though it's tomorrow)!

Yuchen
