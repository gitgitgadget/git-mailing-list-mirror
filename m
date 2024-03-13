Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327D745978
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342608; cv=none; b=fXWJLENOfDbsMxZPSRro8WIFS+5MqcZZrk7GgLt0LrDzwL5gHhgVUJ53EubYW8YG46guANagMmaT1L+H6d0n2MXiya4s9mBL4tp/HMYO1/fHhEp2Yglkq1P6SgfsC0WxyJX32KFSEwF9NPg18JnDE8UC0Vhx+GIDpQZrXR0zwoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342608; c=relaxed/simple;
	bh=Jxd4Q/d2FmNCbKMhLyzeQfMH/J/XCUSWP6VxFw7EUWM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p3DoOHQdzMCftY5vzfgMUMBgpVdWpyb1UKv4sg3FVpmMNxnvdkyhuy0OMsM8zpV0RK/SSuI2/YqI5FY4Z/pXSqBksM/7qWVkkOcEp+foquEYf0kvCdL2kly9+3zoYg9RF/Yqt4tKCUwhmn07dT5IzCyFvD1epNQOETCsY1SRi00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyHEASIA; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyHEASIA"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c8b95f7f73so36842739f.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2024 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710342606; x=1710947406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OZ5wqqYcOm0MQzDl9L7ji39hZShoOAcwlMvuoxqfIKw=;
        b=cyHEASIA8/ukCZkau3+MlwgUYudAFqzf6vEFY0k5bylgTxTRolCvGIX8hcPm04t2Ks
         a1O5R6HUeCzxDkcxtthoflwQr+aikxqJMZLdevVD6cDiUQyck0znE9ApGMmmynbwM+Bd
         qa6+imQFYYJxHAX5bhTPgN3FP+LIdNd9h/sBxa9QFrKYEA6qoYj40km/7cGzq8Nrmkjc
         Kdjehg3+aCvKufGvboJ2cMi/hUVniwt6ZH83c+4uFNUo8dNh7JYsc6KLYZwktOwwNWvE
         co6ZnfCuNiLpvbtXFPilAXH9wgI9OPnQYxdK4UZifWiVmk7Y82gPUUyod9uTFHeD1Zgl
         94Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710342606; x=1710947406;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZ5wqqYcOm0MQzDl9L7ji39hZShoOAcwlMvuoxqfIKw=;
        b=UQ8EU/RAjJ5q1uYSRLfcKSeWBEaESh2038MC6J2SAErFfR5OQfe+sHm695WgYxBh6q
         nAkIFZ/BxBYT6BzKB4eKVhP82LGzXjD9ZH5NO3QnRiQxXu49/2gw4Jl3eHeTClc2MNvN
         RShkkztQNJ7B9PoMoD1PdSNI6TxkjWzsg1BEXXt3i5naTlmz7XP2K7GpW0IIuDMC60Yn
         e6Y3Pf3f+A6ctvFAidIiA8/CE6Tx8hqU+tOMMg2p02cvQB0S/iYamGXlq+Z5kVqRuuzY
         U/oxqaXMDwlQp7cIMmPpAj1oJ0L08sT9a3aJs6UIZ4M/WxZIUAOZWTP3UyQ9u9NeRr6B
         I3fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtOYM6PXq5pWVslb6SodOVaO2v0k8HSqpvlzRY/xnyMi25yX+w/5o6+c3VnJGAm0KK4bSiOH8apYoDUPkjhX8PAnOI
X-Gm-Message-State: AOJu0YwTgtXcT6rL3rI2GEOBX4NnqqA90sRwAygdLbGxKIhx2xt8AfJ3
	rOGMBOVV5XNuJ5culiWudtgqJxprbmw2nPa1TEUcoSWD1T+VI6JC
X-Google-Smtp-Source: AGHT+IHu69mfp8onk7yav0gfZk9iDG7a6WveEiCBpNy+JXWDDbByISLgVpqacbBeldS0xAN9UZOTSg==
X-Received: by 2002:a05:6602:19d6:b0:7c8:9978:44e1 with SMTP id ba22-20020a05660219d600b007c8997844e1mr90840iob.1.1710342606273;
        Wed, 13 Mar 2024 08:10:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id y10-20020a6bc80a000000b007c8ba7bfed5sm2070356iof.2.2024.03.13.08.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 08:10:05 -0700 (PDT)
Message-ID: <87155d50-40b8-4394-99f3-5194d7da785a@gmail.com>
Date: Wed, 13 Mar 2024 15:10:02 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/7] sequencer: treat error reading HEAD as unborn
 branch
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Cc: newren@gmail.com, me@ttaylorr.com, gitster@pobox.com,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240310184602.539656-5-brianmlyles@gmail.com>
In-Reply-To: <20240310184602.539656-5-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 10/03/2024 18:42, Brian Lyles wrote:
> - Avoid using `--quiet` in the `git diff` call to make debugging easier
>    in the event of a failure

Sorry, I forgot when I was reviewing v2 that we need to replace --quiet 
with --exit-code otherwise the diff will never fail. Apart from that I 
don't have anything to add to Junio's comments on this patch.

Best Wishes

Phillip
