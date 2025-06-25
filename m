Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016025B697
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859861; cv=none; b=NbdnNJ01JVE0xuKkwgaX18mlrTuRR/jo3UOCcgqLy7zSsfdHhVfYhssG9wnNlxAh/KJQIuDl/cgsUxZYosGVpp+Pa7o6xNXEmKMi6N4Z9e632m3MBNnD5oixpCvBh7FIHzDcXPeZ5+HNJhAvJKj4gxh0zzsL7rvTR8ZSGVAHD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859861; c=relaxed/simple;
	bh=wg5Xh9ph3hdwBLVNXMJToR5e0QXXm4FFctvQut9/gDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NdasYAQ6oatQB1zH6J7HjtJu7pJH3gTD18jbrl/jd2kluKjCM8n9XZEH+njBpPnl05/iZqrEpzZnfA+CPmvDJtDQu32WMUTBv5iTqTCJY4S2kqICD611DZ6rJ8ms94pCJ0ButsNKulAMRoFNO4z4Io5Y0LhOw2s5izU5gVu1XE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0KDP8Fv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0KDP8Fv"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so1590404f8f.0
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 06:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750859858; x=1751464658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QWdIroLeUeiW9D68xRrAHZR464dS4pppLT/cEyQvebo=;
        b=V0KDP8Fv7rWqW96ZdEa7/MjxmZFOXLVLLxMjzrHtlv//6YAR4XYWiaFPIomVX9dfep
         Uqa9UTTf7WptAfs0d3NcEHxw79fi3UqOGBGQnbd7ZHy9/bRwztqf4/0iR24T6m2+RPG0
         h8Zg6zA+zgxaUZ/pz1lFt4EU4oUSMTspRXE7IYQvdF+TdzahhMay5zlYJUfFVX18qnhd
         J2BljU3PeiUPZoTPHeirBWOFb9KY1p1VBQFrPEWYCHXR5+52Ruw3+7Do/Y/glvjTbwKD
         kPMj/1OmlMtPOFxsVj0m8xAGVi4fs6OjmoD1K9VKubGjdLTm29DqVJD7vAcxIY4J+aJN
         Gbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859858; x=1751464658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWdIroLeUeiW9D68xRrAHZR464dS4pppLT/cEyQvebo=;
        b=BJUh/SlQoe/6QR7EvchpipYGbTNAVFNQGJWgrxK2I/QhozrAc1+DaM7F02g/g7nESx
         nHb7aAId/uvxb5lhFx3tZe36O0BXfZS4bcENLYg70IJJmU4FvsSlCG0SNgDFs1spA69U
         RQfncmPvttae++pnD9Z9nlvne++cd14G2U+pkuNnCzMHbS3+V8xnNQgF/FaknIi92zCo
         p695ul6YIEIEUJBmAjgP5hMd2WiomhHkKES0phSACEk3d6PXr23lWdsmlEiLKk1tj1Jt
         uLX3VKaXkA60aae7vVTn7cxujUjj3MGpnAX+U9xJD+Fhdx91ck80JMFthJ07Xjk8Af9g
         DvSA==
X-Forwarded-Encrypted: i=1; AJvYcCXsvGjazikIPvYfpm5fTDF49Z/kF0VAZhSbWnyXqoAZ7U3bECojqCjVLNpXPWw/mMo55jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrYNytPgcVEBb2gyZMcqu+OK2G4m9QwSWicxaiwdtzM+WTCm6
	S//9IVCb+/7BHRWVFFcqVVLtpIrToGkw4DUEoMVZu9uFUKvcdAd4l8bp
X-Gm-Gg: ASbGncv/g0ufL896y1k0e8BjG6+6dfhLnIa59eDY5hE5aqAbXEh3lsS842aL2cVObmM
	2LvvSUNwQFE45Bk6T+tMUpD3QQRgKBGOhZgB/vJytKZ0o0gbo/AWBTkpUXJym9ST1nVnliC1n75
	uRI+4DGPQDKXWbnLeI2nedFoaIRo1pgnrMrugZxjuJOcvYyxyME2U2Y9E2n0TVj2A3EWigSNxcJ
	0n+0YeEJCpv7iyoEXTLl2acIO/4/demNtnt7qCWc5uPmYlL6d3Cb6FG+aMWTRjNezcHZApUE/Nj
	2kuaoEeOPkAXhi5bqN79qq5KSK74yQBVP8v+xzOO1LPqIge6qoGf0NKUbZ2es+tLFsNPAEBu+wp
	zFkShIXANU4L71m4KCeJRYr0zv3XloYUiFYp5tw==
X-Google-Smtp-Source: AGHT+IFx47cdUcTN2Xv7kUW3Xa8MIk1du8X3+W0Tcb8mxwgWSSoMncnxDx6tYIH5rDjMbNNuNoT3zg==
X-Received: by 2002:a05:6000:2a0b:b0:3a4:f513:7f03 with SMTP id ffacd0b85a97d-3a6ed646f6dmr2319186f8f.44.1750859858114;
        Wed, 25 Jun 2025 06:57:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e810caefsm4587039f8f.87.2025.06.25.06.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 06:57:37 -0700 (PDT)
Message-ID: <84eccfa1-88fe-43b8-a839-61ea4fa4e4e9@gmail.com>
Date: Wed, 25 Jun 2025 14:57:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: bash: unescaped `>` character when switching branches
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 =?UTF-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?= <opohorel@redhat.com>,
 git@vger.kernel.org
References: <CA+B51BHEB24JNzOroTxFodxiuPJ1=Vj7KRFevrm2YatnTVuoYA@mail.gmail.com>
 <8515698b-4ab7-4901-bacb-1c47180c2530@app.fastmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <8515698b-4ab7-4901-bacb-1c47180c2530@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/06/2025 09:53, Kristoffer Haugsbakk wrote:
> On Tue, Jun 24, 2025, at 14:59, Ondrej Pohorelsky wrote:
>> Hi,
>>
>> Our customer has found a possible issue when switching branches.
>> Output redirection character `>` is not escaped properly when
>> switching/checking out to different branch.
>>
>> Steps to reproduce:
>> 1. Create a new branch and switch back to master
>> ```
>> $ git switch -C 'issue#1234>/tmp/dangerfile'
>> Switched to a new branch 'issue#1234>/tmp/dangerfile'
>> $ git switch master
>> ```
> 
> It’s too bad that git-check-ref-format(1) does not disallow `>`.

It also allows `<`, `$`, `&`, `;`, `(`, `)`, `#`, `"`, `'`, '`' and `|`. 
Our ref format is not designed for them to be used unquoted in the 
shell. I think the problem here is with our completion script not 
quoting the refname, not the format.

Best Wishes

Phillip
> It would be nice to have an opt-in extension to the ref format check
> which disallows `>`.
> 

