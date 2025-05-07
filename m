Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D24AEE2
	for <git@vger.kernel.org>; Wed,  7 May 2025 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746579118; cv=none; b=u8Pbaka0O85tIQNpbAFVhW0cKHRdo4P64ZV+EPpGNbqyNCclHjyxZMO50eTbloMa4dug6pZ4kKzKny+JK4QVQFC719GEYk6el+QCBRqJrqEakBLV0b2IR5leQuI/Vr7v6Q8RKxKXW5qo6ECOD8vmq5UgdPZm61zTUaGZ3p/eu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746579118; c=relaxed/simple;
	bh=fBcyx0ok6/mOHVuWrVAbpaiyRbFmOVQn5gWwyGmhyVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nmp72BzeYUrh35VkBse7aDtEzw9NTwitMlWWttHl5/3KfMhdhcIdnVJjAQY7wseu8hw1qk71wBY2ggvBcRfolUFAfJA03hgPxlI+qqqLR1sHGVQ9Dh8oNVsGdgZdp+BegyNwtlzX38mv8RTlbWZ+CMBDuaPzPgnrGcvQ1eE1gD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGhH3wqV; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGhH3wqV"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e6582542952so5009124276.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 17:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746579115; x=1747183915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=juiYZBDW9ccLxNV7mwPUk15t8UoPTux5UB5XZoTSWzs=;
        b=EGhH3wqV5sAlS2PydrkXa6uUBk6W5gNxInfj4BpfffSmAckyWpr46zFGFbxNuX69r9
         CAOfmTlI4LtUCDMgv0Ucg/x+4PpGTCMCpj1U5bsdZwOGMcyb6il/NiZ6F8PaM231q1wz
         IM+2dlrLAYOQqdTqPBhxwECeQ5PYvam9TMJOOC1gEejuR0CfQn9x0oASaOJ932uvpzJH
         LMW3PixLXhODPn+xga+l9900wKpDfznDbMbrLCtywgxUs8u4dWce7IdvzuGOmldfJQBD
         HpX0AkCkPdxRz9HYBBWYULlOtyOOJauisLI8rk6gPNfZ4nj59kS4Djb5qghoElR1OCsE
         01hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746579115; x=1747183915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=juiYZBDW9ccLxNV7mwPUk15t8UoPTux5UB5XZoTSWzs=;
        b=oV7ttIXGCyAV10FOZxuKZe9CwW0QQzfNuOs9QKy88heAYR6Cpz9r5krNKtQ8gdbJPE
         q26YkKm2TydSxHsGUIBdK8Vjd+bBEFC6SLu1jTp92rauW8cdjTWOHME30NNKFfpO/rfi
         4txuzddPwl2bgcrz2TykMOqrxXIIvR4bcdxvDfLVXeMjRM+LT8qTY7holW3pR7G/+V6/
         z+icg4PCfyi7wjwd/azjUxh4mSLQHrz2o5FE9dI1R2RZ1qN2EGP0LasyBFXqeJ/Gz2Ck
         +jnR5e/yWENKNfYDdHXHDHVdJBzFQXu4VTWdG9xV0BbHrjXDRhEV60PEEuVUQ35ldrCV
         7e2A==
X-Forwarded-Encrypted: i=1; AJvYcCWbIJPe1e2cWRuciqZBtgC3tHugFoYmrjZw9FEBmtSb6zLUWfClmk1sf+NepJO2i3oydMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBukXBFkXYy+LpjSBMVNWWVXDUSn0xG6TBhQJJA8wdgvqDaaG+
	zgwU64qDGtqpgrbh+6YcDE68Yc6oaDgApRP2Rsw+AwjmfQD4k4zX5oM+Xw==
X-Gm-Gg: ASbGnct/ten4z1am3Wt5yDIJV2SM+icTHVXnpQOJ4kBHhuGlJZXmaYF3Lr/wLVdzNku
	dtPo4R5UKb1k+fH6wJGRuAmBmEk40gc8ZEGidkkol3qeoWJX/ZjA3quPG+XHn5t1xQ1AGUEF0Bd
	g2+724rtUhFhjn2jT2ethtPCb1t2Uf+oI1Y69g+jLY3pkRhwB33bnzeq/NpskD7+ycvEDqLsxGv
	h9jzOJng5IGlfanczhKtGAsmPnZArh/gMm9RUPfyQvN13NNC7DuCsWfTjcI+byj4uJxDk11XAI7
	AIjr1XL7qeeRvTnukoTX835TqjSGSQlXjBBjGmYY3u/Od3SiaY9cO5EcrehCOYusrmbnGeiZ/gb
	+p74tpI48TcHncf8ygm0M5nTnxo94
X-Google-Smtp-Source: AGHT+IGPURar4x25JhQZiQVezCk90/qpD3TWZmxesCNIykwjpQ54dyXH3ElwxGzTWtB+x6BNukkPiw==
X-Received: by 2002:a05:6902:2701:b0:e72:f556:2644 with SMTP id 3f1490d57ef6-e78810eba4fmr1919608276.26.1746579115411;
        Tue, 06 May 2025 17:51:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cc2e:477b:d336:3346? ([2600:1700:60ba:9810:cc2e:477b:d336:3346])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e755e6e6f3asm2661601276.9.2025.05.06.17.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 17:51:55 -0700 (PDT)
Message-ID: <e23e7e63-1d66-4a5c-8c4e-19b5078a75ad@gmail.com>
Date: Tue, 6 May 2025 20:51:54 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] object-store: rename `object_directory` to
 `odb_backend`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-2-c05b82e7b126@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-2-c05b82e7b126@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/25 7:09 AM, Patrick Steinhardt wrote:
> The `object_directory` structure is used as an access point for a single
> object directory like ".git/objects". While the structure isn't yet
> fully self-contained, the intent is for it to eventually contain all
> information required to access objects in one specific location.
> 
> While the name "object directory" is a good fit for now, this will
> change over time as we continue with the agenda to make pluggable object
> databases a thing. Eventually, objects may not be accessed via any kind
> of directory at all anymore, but they could instead be backed by any
> kind of durable storage mechanism. While it seems quite far-fetched for
> now, it is thinkable that eventually this might even be some form of a
> database, for example.

I agree that "object directory" is leaking some of the abstraction, and
that we'd want to be able to have pluggable ODB backends.

> As such, the current name of this structure will become worse over time
> as we evolve into the direction of pluggable ODBs. Immediate next steps
> will start to carve out proper self-contained object directories, which
> requires us to pass in these object directories as parameters. Based on
> our modern naming schema this means that those functions should then be
> named after their subsystem, which means that we would start to bake the
> current name into the codebase more and more.
> 
> Let's preempt this by renaming the structure to `odb_backend` now
> already. This name is agnostic of how exactly objects are stored and
> allows us to easily introduce e.g. a `files_odb_backend` and other
> specific implementations over time.

But here's where I'll get a little nitpicky and say that these are
"odb"s not "odb_backend"s.

* odb: a single object database. A repo can have multiple, currently
   only one that is read/write and multiple read-only alternates.

* odb backend: an _implementation_ of an object database. This would
   be the structure that containts a vtable of implementation methods.
   Each individual 'odb' would point to a single backend describing
   how to access the data in it.

Does that make sense? If we are going through the effort of renaming
things, I think it's worth being a little more future-proof here.

Thanks,
-Stolee

