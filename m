Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA388368277
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791139383; cv=none; b=NaHtYCTCF4CjFSvhW71sXC4uJ9Kdv+m+7/UJFXMr6MZwOevuj3zzKVpYSitq6qJccymKPqD0YmQV2xRBRoh84zwoetPihkiaPCT7v8bz5tFZcTdXf0kHquMMvHB57+xj/dlzBwoaerU7I35BO/My+1wwbDCdPTiFk2ej7RnO+iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791139383; c=relaxed/simple;
	bh=z6zwUQsBucCuxVcySjdyhmhU3s3+DooPzAPjTt/f3zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpnxdygP3FvUP0kNAoUs8XAt4bOfiPLcKSKyfNUfOcjLWTLjMha+cbuJbZEb76snAeOAVjw0Phl1R7J0mXkklxlca+rCaNF/NLyxGKVAFkWww6zT52oRO5xUqxdUJIBBMRCHIJ4+KWP6Z+NwTZdi72C+1EjoOmq+Cx4qaGCgx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhrO4zJI; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhrO4zJI"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-48c54d65743so440956f8f.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791139380; x=1791744180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1Yb7vX5EMupdeZkDOlebsJLVmPNbXmmGQTDP+/Bdz/Y=;
        b=OhrO4zJIW0hj7c6XxoRIqjj+X1CZ/AWX0Mwj5QOejfQ+lkGALDZQR/emfY4x9jc9HB
         0+3aVw1kN+HWxOIW89SC1kXKouBLtSyN/LPiVsPay9sU73QuslcWBYl0lzFJEyg+XqSx
         w146OT6xpcRfzGLAQZdzhRCw0vDp53c6ACRVvgqp/tZCS9/rZc/ZGBaoB/m9/KlBNxvh
         v4KauddojlBt9kcjVp4NX1hrBHMFIGXRKagdrtCt+2hXuTBdrx80jv6jV+/8spZWMaji
         ZXzQK78vEt8L+p5QIG8XLs8LEWbeitEQQ2ThVrTnCJCSBElOm7gwGXzqgD8FpkBnPyDg
         2m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791139380; x=1791744180;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1Yb7vX5EMupdeZkDOlebsJLVmPNbXmmGQTDP+/Bdz/Y=;
        b=nFUrXt6k4dRl2KpGJ+/rVxNF2C7z/5SrS0/ua/E68JlhfhBCfuHQ5rVocz7DbnSvqT
         3yo3lWc84nrK0Woztm2c/KBp87zGdWBE7t+7NR04UOnEIk2iJbIuv2KZW3aY7HMDrTm+
         HfrAQisnVirxiJ7XNzZHD91yx2d1hacTwh713G9Gxkgyg0T79uqiNnlLh2nnUOkRyB2M
         pmVF0W2kaVTrIO15menF1TGmrGx1A8YIsxrCp2EGirRxuVSo6OTGQZj7zoASwFPPZNNV
         h8KbpNyerU3S7pkKw5KRA3rM3WbPArpyV/TfXxXhiPY1ddQyn4A8yaKQAwRYhQ7csrzd
         ExxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKS8WQpvmEfVR9ibEp8c+sxkhIBpK+P4b2DUKDEj08ZrEPn1w6E/m6Tcz0JakAVuqLxJc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPkCjpP3Uw0+6ODttIBeGhBotWOF6hmKs1orZ8scc7Sho1rMti
	pPUtSPfJCyjj150hJpQ1amYng2dUR0jfcjSwM8c2bnlVgFM5tuiaEmR+
X-Gm-Gg: AYBFou0dztbyl51xp2froZPTxaB8VNoW8QaeX/pVaOLyAI+WwoelFBioXiPZIlZyfAB
	h+CmAJ+dJcFxhhgGlNNB0kCQ4TAZxjbOuIDF8u/jDtSW0p+/oYSk16zQKif8wkN/Q39ZPjerO8l
	DFh7RfxusjujxxYjGwRiA13Yx6ibj7YOd9R3dLRjizPzdl+nUUMytLgJK50jm8fuBuKTO7twfbq
	WSNxP7GGatijpfdmydkMApxw4HxIKSErbBAtnF9FtzrIAEoGnRQbyMKjzf2LCO1+bs+TUWuLZZH
	fDFdL8BaEX6sxBDhrWHnqmPYNqO/ZiQtxx3xW3nAj6mhHkZa6Wri9E/23CS/Uezm6w9oB0byFAD
	/4DsFZR0sCrCRgJ6F+QSjCaqdHpD5Mk/hYbGfh3wKrcOCbMrFMCUh1nSGuMJR5pYoTfowk/nSXQ
	1S5SIGj6KAacGCiBH85QoddkHwpGB1vOSSmPBk8rjGkcpvkXXWEVyz7DOd+B5BNCGjVOpJ0dJt9
	LVhEyJhWI52/dEwnS6nA/y11m0/bSGGGoo58CsyYT444Bp2zxnX8A==
X-Received: by 2002:a05:6000:46c7:b0:48a:f62c:61e2 with SMTP id ffacd0b85a97d-48b126c2531mr8662553f8f.6.1791139379639;
        Sun, 04 Oct 2026 11:42:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104417sm19747206f8f.27.2026.10.04.11.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 11:42:58 -0700 (PDT)
Message-ID: <79a242b0-ea1a-40d0-b1d2-8ef029fb0521@gmail.com>
Date: Sun, 4 Oct 2026 19:42:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] branch: let --delete-merged default to every upstream
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2428.git.git.1790960147943.gitgitgadget@gmail.com>
 <ae47baff-daaa-4b78-97e9-94faebb8e694@gmail.com>
 <CAHwyqnXN=DZ_EzfTfxZ_==8HS7zX25NKoQw58Ou6HZELP_n+Qg@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHwyqnXN=DZ_EzfTfxZ_==8HS7zX25NKoQw58Ou6HZELP_n+Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 04/10/2026 14:16, Harald Nordgren wrote:
>> With hindsight maybe
>>
>>          git branch --delete-merged [<upstream>...] -- [<branch>...]
>>
>> and
>>
>>          git branch --forked [<upstream>...] -- [<branch>...]
>>
>> would have been a better design. That's the sort of design mistake that
>> is much more likely to happen when a contributor sends an endless stream
>> of patches because they're eager to get something merged, rather than
>> engaging in a thoughtful discussion with the reviewer.
> 
> I appreciate all the help here, but it's not necessary to throw blame
> either way. It sours the collaboration.
I'm sorry if it sounded like I was blaming you. Getting a patch series 
merged is a collaborative effort and any issues we discover later are 
the collective responsibility of all those involved. I do though think 
it is helpful to think about what we can do to try and avoid design 
mistakes and feel that spending a bit more time discussing things and a 
bit less time re-rolling patches would help. I also think that would 
likely end up with things getting merged sooner as, if we've had a 
reasonably detailed discussion about the design and implementation, 
we're likely to have ironed out a lot of potential problems earlier in 
the evolution of the patch series.

Thanks

Phillip


