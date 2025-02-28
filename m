Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD61B4250
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740390; cv=none; b=ke6gyZIRRSvOuPYVLdRjkPspZoh5DkIPnJZq5xnWkFKs5PPXgPVoShmkzoTHmiPnaQakWwiY0pJiueG8Wxn839XWZNuHH7GaLXDQuDUTPeF1mjNHffGyTTCuUH3qxivdYk7lX1N29cruhy7t37VfFvojkdFLAnYl3swmhg65YCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740390; c=relaxed/simple;
	bh=3SDN4QT1jnjeQGaHgQ/pxhMCWjnFPh4fSiM/AJqb6Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4WAtepYAwoWY9TfxxL5N1XBy2NejPb3qvVrVCP6n1kfFrpcTwBgN+HWBVixFpdRZjB9u2k8iPSzf093nQhF7fV42wwMEEdyryUCt90ZdLwDJmzmTuq35m0vzQ307j2/w26w6mvZGAgnoxk8L+t1yrXzU1nXB66kgbLE/WIkwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dx+qZRyS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dx+qZRyS"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-439946a49e1so12623565e9.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 02:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740740387; x=1741345187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/EU+rT5JagI8MgGYWALBAZQy2I2xbSsTyWQMWQwI7/4=;
        b=dx+qZRySwUziDwQZtytztpDdM1+GEER+bRjqbx92iLQpe4REXgxQB5IehvoB0spSxd
         lGpncBnAg8b8HDU5Zfz6D5Xvf5b+h/lDcHmRjqxEWxK+tThl6XxIwEcqvAK+/T/AUQrR
         c6RxnGF95gzSnF0Yhv9IPGdu4+P+TmclfoILX62EWdtPgrE0sUEpyqg0yckh7SQUZkKQ
         eg04Z8VHebwb2dUks84ftiGvUBwtMmS8oX/moIuuoU4BOC+B+paxrzeNovy3+eRxTlck
         I4LFv4b497CxFGvED3gxZ8R8R5xVOVT9NP22YwLAYc/sGeCKbr/4HZ6KDKVtxVn5aMYK
         9VXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740740387; x=1741345187;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EU+rT5JagI8MgGYWALBAZQy2I2xbSsTyWQMWQwI7/4=;
        b=Kpv2JR4jAfYB83kUUFXJuKWWDHxw5HGRlIS3R1VRD1qFR2NHOzBpHUKNqkCIpNNiPn
         Zfx4XXNc/RbmHPwyfN9/EhLhwpbPQhCjMK/vhCGpGSrbu7IsUhFe61QGM8lgtLv9TmpU
         qQqJm+Si1tp+Bc4bbXKAU2GSM4Sdfeh/IgDKA5QYdi7Ar8T6Z5mqpDExy2rNl634Nbhp
         uViOhhB168iOkc/WQBc3a14asu3+d3f0my570okjKptL91TOZSEPjELeH1Ql9iHPou+P
         +N9a2rCUJMKvYl65+tJ/uUihiLHN0WnTpsFK5YL/UTPPOcJmlFgihqyYntJucF1DS/zd
         WnrA==
X-Gm-Message-State: AOJu0YxxtGOwjjiGeJlSFigI2g6gY1vkqoxtC0GSkCOkMDP2+L6xmkP1
	GLNIy0ydfdfQD5vAutH1h+Pk1Dq5AR+5cWObEeGto4IGYyYmysPm
X-Gm-Gg: ASbGncsXoUdxiiTaYl4Ax+qDaHRcLCHYiDA1cpvsPe/ZhLnHb/l6RdRhFXAlFldwMb8
	MGzdL55q++V98An5xCBdgMzYLSwNHj0+WVGZCawheU8y3L37Odnkn619LwGcYL/5HuBDxMs2wvg
	7mWtG7E/4tB4GMArGbQVCOIK2PVNLp1dV72Nkp8i3jiTEgKPtJ0kTUeE7ss0JeglhcB6ZOJ99Kg
	7oKX3+bTRSJ+NQXYMyqJMJU/Q/G35rXQNLXc+bjsLBoaguubIOqm058JRifFoO/vcigPNPm9o+Z
	kknvN25zJ6q/OSmaczWbaivEflANp0fLu9N5juP49K/psvsBPRNplbZMLLX/FEkVthIW28ZjlIQ
	A1pTn
X-Google-Smtp-Source: AGHT+IEkRul+notIzO9wAk4sUrXci1UaBgBox5DHikXmYFxQkiw1CcoK1ForNVTXgqQoqfvgVbR08A==
X-Received: by 2002:a05:6000:2102:b0:390:d777:6505 with SMTP id ffacd0b85a97d-390ec7cebb6mr1720455f8f.19.1740740386845;
        Fri, 28 Feb 2025 02:59:46 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796051sm4929492f8f.12.2025.02.28.02.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 02:59:46 -0800 (PST)
Message-ID: <d7b1416d-d201-400e-a0eb-b9e526f740ab@gmail.com>
Date: Fri, 28 Feb 2025 10:59:44 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: 'git rev-list' commit ordering issue
To: Clement Moyroud <clement.moyroud@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git List <git@vger.kernel.org>
References: <CABXAcUxHp3LnyqR=NM0coh6wG-1uy4GB3FdeZEg8mPHu-vt0bQ@mail.gmail.com>
 <CALnO6CA2j60gpPhUjxOY6_q5WdU7MHoL1GLDN_AVwWVNx_JddQ@mail.gmail.com>
 <CABXAcUwHd2Rr8iOZ7F2k5DGiBNH87pwG3oyRWLrP40=MgD91-w@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CABXAcUwHd2Rr8iOZ7F2k5DGiBNH87pwG3oyRWLrP40=MgD91-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Clement

On 26/02/2025 22:30, Clement Moyroud wrote:
> On Wed, Feb 26, 2025 at 10:58 AM D. Ben Knoble <ben.knoble@gmail.com> wrote:
 >
>> Is `--topo-order` of no help here?
> 
> Unfortunately no, because it'll look at the ancestors. I get more
> commits (400k+ extra
> commits in my real world case) than I have on stdin:
> $ git log -1 --pretty=%H 2025.2 | git rev-list --stdin --topo-order --count
> 417776

This seems to have lost "--no-walk".

     ... | git rev-list --stdin --topo-order --no-walk

should list only the commits passed on stdin in topographic order I think.

Best Wishes

Phillip

> --
> Clement
> 
>>
>>>
>>> Below is the system info gathered by `git bugreport`.
>>>
>>> Take care,
>>>
>>> Clement
>>>
>>>
>>> [System Info]
>>> git version:
>>> git version 2.48.1
>>> cpu: x86_64
>>> no commit associated with this build
>>> sizeof-long: 8
>>> sizeof-size_t: 8
>>> shell-path: /bin/sh
>>> libcurl: 7.87.0
>>> OpenSSL: OpenSSL 1.0.1e-fips 11 Feb 2013
>>> zlib: 1.2.3
>>> uname: Linux 4.18.0-553.33.1.el8_10.x86_64 #1 SMP Thu Dec 19 14:28:01
>>> UTC 2024 x86_64
>>> compiler info: gnuc: 6.2
>>> libc info: glibc: 2.28
>>> $SHELL (typically, interactive shell): /bin/zsh
>>>
>>>
>>> [Enabled Hooks]
>>
>>
>>
>> --
>> D. Ben Knoble
> 

