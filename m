Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF032F9C23
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150443; cv=none; b=L0CI4bOAZaqEMoDuCWo6dVZIsQBj3TktOEafnsky5ib0h+OZdPaVblbYdGgaHJqpm1egWzPAwm7+l9BwsJR32H4nqf5tmJ8WA9VyVzsTIOJerb3U6g/ht6C2GY1vsr5pVelX3w4N5TnWvO4+BO2lXbv5sdKYTtYfylMPVQWWGTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150443; c=relaxed/simple;
	bh=NRSWrf6qNN7B9+YjOXpzFB797qId1aesU5TJDhiHKxU=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=nez9Hxp2DAVTMAS9pKn3acAxyKufeGNwY4VOpB9onjivp3QdOVfmP7Uq4+5fTcbeUVMfslaqwJwEysCDa6dzDxDR3xzu1LxYALG/Ze1Q4+LKT4z9Nfvbka/sVcDi6QpVO4M+pWmbUMafvKAVOIdMp2xrZ+0BaSCP8U6kWqAIHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr8U7lip; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr8U7lip"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so17331855e9.0
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 12:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763150440; x=1763755240; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from:reply-to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4ZvbkglsEwePHQfr1X2JjCrrdE2qEDpjylsIFWxfqc=;
        b=Dr8U7lippuXLI7B4NZZH90o0yv9DF4xz4uEn1lgbSL0E10Uqb29CpG+Yc2Bpf68WVE
         ycRDFKE5HrTmZEUxEUgZzD2+RrJIc4REvA9FgWEgoWQPeO9lBsydSFX2qRa2GHBy4jhr
         Re5RjqRbCkErQCrlMdpuI0nhzGVxhA9I4UtGaYE/12ZTTOgd/+T7XLR+tZCNQNKOqYwk
         eQhLUadtb3uHrxEv+E3b3eqGXr5MRLrlgU8SaQaRTIFroRzgMZkbgXor6kVK+D8u9nBu
         +PQs8uDhQk3xfds9wdfDkDkeic7VUZdPQJM9r1srC7FE/6bcppTFQh33ZGRuypY74AEp
         ApVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763150440; x=1763755240;
        h=content-transfer-encoding:subject:to:content-language:from:reply-to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m4ZvbkglsEwePHQfr1X2JjCrrdE2qEDpjylsIFWxfqc=;
        b=C+1LwLge10N1Wj/DGX3KxckcVH9pGf31v+95c6F5AatOaL8j9vu/AC9RJCf0zUfVa1
         NVIQDd0R5Gv59bHuT7yaqTiM42C+mr/Sf0zW3DRZLsKNpPVr2dnFIt8NV48mLjysBSFM
         33Ffn7VATF3fBoWaJMk3JTS9ikGyN/kWlad039uW98oUPDSb6WNsq3H5OBH6fIuJT5Us
         aK6BtiMk02HaNTSb+/6zthoqXF3SEVkdAJvdlHL4Ug4HjOV1LNgbaniMYWNE9S8nULEt
         qRRndnbCFFLUaVpHzTJ2Cuf1AzykoYOVcCm3ujyuvwyIgOnToBgxE7yZaTaIoQ8QgFam
         N96w==
X-Gm-Message-State: AOJu0Yw7jDJP/esrP4jeQbl5RD3ZDgN5/gZCMSc2MwB6WNSfnUXpCOZH
	GxCHDTYxQHq2HvpSGCzGXQFEqLkhczFn0tnlBsBnloYhbnc6MBQZcLW1TUpLkA==
X-Gm-Gg: ASbGncu06pErXoWOQ9/JXONyn/DFW2yvH7uy8wflpXOvC4yMxWkh6SPoPqDNMLE+Nju
	HMwbErYjm+JakVH0NT62W5E7weXlXW3eY9q6+M9ZIgRTFyb4v5pQY7e1BJZnaAZwwyoARbiyp/s
	Kj1GXA3VgCK5qu/M5EOl23KhZCaQe6jMSJV1l9P4f+Y81LbI+SDFGp0oUbG5UmXYB0KP33vbVee
	2JxCd2BwXrbWGjx0AZulYCHogJIzE6bUnaYniZDIP2t6CScF8td7SW6gq+HmuX08RE83bjXMYG0
	2UzyqhoO4bBkDo8KLeeDB0C3OmNjDT2Qp+4whubyjpk/1hT6kiXlH0r9JCsOCtoDBZCvZ52EMH7
	wA+MyNftf0EqhYmMjS/YmAJzs5D8+JU5ME7msNGn3DlkG+LHl9IdVVv624DRmf1NMTAP+xPTNN2
	IKtrV+Vz8sIuI+yplu9mojQNfArhxVXQOg93n9fxP8bwsfO7+vO2EKocW3336Ij9Q=
X-Google-Smtp-Source: AGHT+IEkGqhDTkgeqkmcoVMm8k5K0iLKPCDXTPLmHrSh1Gsl9f4Kb305XZbk15XxPr0CWLnz8x8zGw==
X-Received: by 2002:a05:600c:6289:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-4778fe62100mr40390025e9.9.1763150439829;
        Fri, 14 Nov 2025 12:00:39 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779524d4basm23162645e9.1.2025.11.14.12.00.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 12:00:39 -0800 (PST)
Message-ID: <ddefb36d-f023-45c1-b518-a9f70dba0696@gmail.com>
Date: Fri, 14 Nov 2025 20:00:36 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
To: Git Mailing List <git@vger.kernel.org>
Subject: CI Failures
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm seeing all the Ubuntu based jobs fail. Judging by the error messages 
at [1] it appears that their version of sudo no longer supports 
"--preserve-env" which breaks all of our scripts. Does anyone know how 
to make sure we install the C version of sudo rather than the rust 
version? Failing that I guess we could switch to using "runuser"

Thanks

Phillip

[1] 
https://github.com/phillipwood/git/actions/runs/19371231059/job/55427466699
