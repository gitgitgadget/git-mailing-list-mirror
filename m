Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115BE1EF0B9
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765548382; cv=none; b=vBWdQYVK9KL1e5w7ml9VylatHkcs+aoVL0jn7RSdRtqeZgG+c+bOzCbSPxM7euevaQsxV2Y5Eegear7vHRbxE9v8R44UuQyc0jdROACqAdaPqrfH+Jw9Ygk5+UUfki8hqqEoKFRFB/Phw6wax/+OkP4q563iwvCqksc78Lyb6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765548382; c=relaxed/simple;
	bh=FHkHXmVRrdBhb6YmAz/HPwLpRM7aiq3FcfdXlG1tAMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwsmflQeL8suG3DwH5gs5mIEQIOM/i1hyF+8ma2B/ewRPQIGkrYWuLkd4dMVKhEYduenvR4fH5y/BYpoHMs6v9vENLB0QhDYW4C+lTfpmQ55j4wIxsGRCyl1pYcTaSOWKfsP8aorwL8nwon00ymdJJ3CoOmdbjBmxSgRbGp/G+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQW4Ur3q; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQW4Ur3q"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-4ee2014c228so9267251cf.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 06:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765548380; x=1766153180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFE4R1YFzZ/aJuuhrCOysu2HuGafSZEIlF8lq447fWg=;
        b=gQW4Ur3qm6jJ1OgGK9eNApaqftVrEgtdAcS883vbVQHFsD+kHFYpH+nI0hp59p4eqE
         85G+/VnJPLvCsn+2ft67dIS45BlnH3njwFMtAczamTLsvluiNqXcqAozAg9GAxQRo+fS
         hapemS+br+/2qFNQscN9/eiuyhKSSLUHhacJiVE60RuKxM3Qm07jRnutmeCOYdGMyA1P
         EFdJVjs9O71DwrJACKrj5NifkZhACTa60j9fuz7qfITaCipr5g4zvi0/mbMIoVV/xjIV
         G+XU8vlzaOVZWManHRSKHwF40vmNhXiuqGHaH4Z0/r1rSBHqFxWIj7WV26Zw6IP5/BQW
         kl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765548380; x=1766153180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFE4R1YFzZ/aJuuhrCOysu2HuGafSZEIlF8lq447fWg=;
        b=a/nxLYKTbD2b5qKL32GvZgSGM80HQRwu+qy71j/3QRJvIEq2ER387+P74VTwYxZOGT
         APL+zB+k6IJSwbriVK9H1rI/eE1lYibkxf090upA/UMKI5twQjvPCO3GCZvZhDSxxL2U
         zV1XiBtaa6PZynsEjFzVEry/qQTlCwPDbQ45anx9o4UH7fUGISisYkEYmR0WjDu947a4
         K7prCOfXv43wurn181va0c7ybLZ3oLNR8aHlf+vNvQ+MQamrIZoDS7Kh0xVM97IAAeY4
         el3so8hh7V8pShHx15CK3ra8c0X9Mht+im7LKlqyL7/CtGdWGBStmQuHyIcw29Kw196m
         bO9g==
X-Forwarded-Encrypted: i=1; AJvYcCVRqUgZMo8WcIDMyU66DzowZUphQ/yLRkyO/udvkYZPKR4JsMiCOM+rKMyaBtwKUVFnEuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPT37u7uVWPd3dOua93CEPns4+SvS7t+a7RzyBQcVaqD7Fz5ex
	IEr6VFEhVelovkn3x7pb5Uv3Ygm5RNs/L3Yk4qdl/XD5XeQJST80Qqgp
X-Gm-Gg: AY/fxX5MhMEdmOmY69ZUaKFqoe1qCdGhiouKOaAjTmRv3UyedXHgcbV5+hCDMKzfOv9
	IsTzTPC6egQf2z/Y185rDUu3vBh2QMvdlFE6WYZKLnxiwHv8yBq6u+6WZsbPk8siyWKY+h6Ph5D
	Ud1a9NxHpTqsvNWMmRz2Tn8qdAkhhuPZtIiZ7GKA5AiKlIpz/kghbcHeyGCV6/uBc4nM8MjmaMd
	omrErirI5Hz1DjSPPIC9IYKG9/IRxdgUerqwlI7akNiGj8VQ2MDqcN/qio1GF2ibET7+gGF5GQl
	8yXy4Gtbl1JnU+QFzxJtH7BIcYiDn0Ve3RtDBtqJzggOKyE24cCpp8YMthZuLEb5npkmVQIS7An
	9DjCH6phLzwqXfzQ6pbh2AVY1vkAv5upYjfVzR5A+k6dexDNlbyTpwE5CcMqHSMrKCjflgrAM6g
	TRB6CiSB4Fu6AYla3ttY0kVTKzNbAiFnBpZevSq8faGfHeL6UMJOH/uS9Cxg==
X-Google-Smtp-Source: AGHT+IE1RZFrEjrqgjbcHtOEHzInOXN+Uxgw0jcWT/h+6a+3kMT40Ov6PJKOWPswgd2gLmY0R1i6/w==
X-Received: by 2002:a05:622a:1f87:b0:4ee:5fc:43da with SMTP id d75a77b69052e-4f1d0473f8amr27073071cf.11.1765548379604;
        Fri, 12 Dec 2025 06:06:19 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5d3e14csm465675585a.46.2025.12.12.06.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 06:06:19 -0800 (PST)
Message-ID: <e1d51a8f-582f-425e-9682-c93411b4d090@gmail.com>
Date: Fri, 12 Dec 2025 09:06:18 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] scalar: document config settings
To: Henrique Ferreiro <hferreiro@igalia.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, atthewhughes934@gmail.com,
 johannes.schindelin@gmx.de
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
 <ac1627dbd94e3330117fbaeac2e2373104aef531.1764607847.git.gitgitgadget@gmail.com>
 <e19246a7-40db-41d0-9cdf-817833123f45@igalia.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <e19246a7-40db-41d0-9cdf-817833123f45@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/11/2025 9:20 AM, Henrique Ferreiro wrote:
> On 12/1/25 5:50 PM, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> Add user-facing documentation that justifies the values being set by
>> 'scalar clone', 'scalar register', and 'scalar reconfigure'.
> 
> Hi Derrick. I was planning to contribute a patch removing some config
> options so I'll take this opportunity to just discuss those here.
> 
> My motivation is that some of the options seem to be related to things
> other than performance and the list is huge, so I believe that some
> options don't belong to scalar.
> 
>> +REQUIRED AND RECOMMENDED CONFIG
>> +-------------------------------
> 
> There's no mention on which configs are required and which are
> recommended, and it looks like none are actually required so maybe just
> remove REQUIRED.

You're absolutely right. Good eye! I started this documentation before
going back and removing the "required" configs.
 
>> +am.keepCR=true::
>> +core.logAllRefUpdates=true::
>> +credential.https://dev.azure.com.useHttpPath=true::
>> +http.sslBackend=schannel::
> 
> These options are not related to performance. Why not keeping them out
> of scalar?
> 
>> +core.autoCRLF=false::
>> +core.safeCRLF=false::
>> +index.threads=true::
> 
> These options just duplicate the default settings.

We did find that index.threads=true gives something more when explicitly
set, so there is currently value in keeping it explicit.

The CRLF configs are sometimes set globally on Windows systems, but we
want the local repository to override those global settings for
performance reasons.
 
>> +feature.manyFiles=false::
>> +    This disables the "many files" optimizations grouped under this feature
>> +    config. The expectation is that all valuable optimizations are also set
>> +    explicitly by Scalar config, and any differences are intentional.
> 
> I disagree with this reasoning. This thread was actually brought to my
> attention when working on setting manyFiles to true in scalar:
> https://github.com/git/git/pull/2125.
> 
> Do you foresee any features that would apply to scalar but not to
> manyFiles? I'd even say that some scalar options could be moved to
> manyFiles instead, so that people that don't use scalar can benefit too.

I suppose that the default reason is that registering a repo with Scalar
already enables some config in an "indirect" way and having it rely on
features.manyFiles would be another layer of indirection.

The historical reason is that we initially didn't want changes to the
features.* config settings to automatically be assigned to Scalar. I
think this is more important on the features.experimental side, as
the intention of features.manyFiles is very similar to the intention of
cloning/registering with Scalar.

For now, I'm going to leave this as-is, because we have enough changes
to the config settings and documentation. You can submit a change on top
of this one to demonstrate the value of setting features.manyFiles=true
and how that impacts the code in its new shape.

Thanks,
-Stolee

