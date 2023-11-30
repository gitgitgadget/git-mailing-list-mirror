Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jguk.org header.i=@jguk.org header.b="Vdg62u/7"
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B491D6C
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 10:14:07 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9c39b7923so16275531fa.0
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 10:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google; t=1701368045; x=1701972845; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYpkHCaIJmB/iT/OfV3Kzg2pfHGNMIk40xs9twZ7QUQ=;
        b=Vdg62u/7m+ZgA2/AFliO8/HiRt4fSlYaF+nUNO0ZFgVOKOqgQRKpkF97zB+Rdo81Wb
         ZvCrlaqeZPKn1z30nhYQY6mzzCi9ko10fLFrU2hepSS6p1Ocn5ewqowu4c9eWmGxnyiw
         7apXchcdPxle75kb6YveWQlzOL16w8FQ7DPcl/7PuPpse5h9NDFse9g3b+JN7lkbCaVe
         3tDZx5t4QReHB3Qr0n8dNOuPhS6860+Um56BPyQwmERdTmZFz9ya7H5MtAL4fN5XbT4F
         F6hmC9sqCtDltxZaJV18tdKLP5UBy4pzU9L1nEIBEp8rvsHKNW3qiLsNbqWlNSVumu+z
         6GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701368045; x=1701972845;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XYpkHCaIJmB/iT/OfV3Kzg2pfHGNMIk40xs9twZ7QUQ=;
        b=tY+XkWZTEEK1h1YFtUOBxF115sM/e7wZ/8i3In9Ej6BHuQuwepuFGHYzwrpRV5gyqm
         ytDUVIfmkyCw3ZOuNX6gACv4J0jhFT+6KcBcEr00/bQERAM/DJNGEkEau1y8lq6eMwpQ
         f1VF5twYmh9C4pcBBDaYU2D0drYjDsmVTj6Xmc1OhstDNL94Zc/Vp95TUNksKWvyX0m+
         c0mCge56+v3k1dHPxIaTOEyJGaGOp2gJpVz3AUjMegS2vPi0oi6KBfa4SOg5WFDcUyvu
         7wx376fUA21ZSNuLlC2USNqnIWcpH4gVDhjeEBIKBpe3MSGxW7mlFVR1COpUFNj41DQB
         tNxQ==
X-Gm-Message-State: AOJu0YztjI/jBnBSZVkDRLO56z3tFedyr7aM5REEqzWCxtl/7tUm50Ug
	1noCsoJOV6HdIb1Q9nXKeRK21KkVp/KL8CkJXfE=
X-Google-Smtp-Source: AGHT+IEdrxhUzlObQPxdch/4mn+yi+fnYeM9cZOvhS3JTUNbpWEY6dbXmIbss1wxRD35PrTWCm7oUw==
X-Received: by 2002:a5d:4fd1:0:b0:333:1b9e:624a with SMTP id h17-20020a5d4fd1000000b003331b9e624amr3021wrw.47.1701367918449;
        Thu, 30 Nov 2023 10:11:58 -0800 (PST)
Received: from [192.168.0.12] (cpc87345-slou4-2-0-cust172.17-4.cable.virginm.net. [81.101.252.173])
        by smtp.gmail.com with ESMTPSA id d9-20020a056000114900b00332e8dd713fsm2139101wrx.74.2023.11.30.10.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 10:11:58 -0800 (PST)
Message-ID: <637be919-0b04-4e5c-8f2e-43340521e6d1@jguk.org>
Date: Thu, 30 Nov 2023 18:11:57 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: git@vger.kernel.org
From: Jonny Grant <jg@jguk.org>
Subject: Consider dropping the decimal places for KiB/s 52.00 KiB/s
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello

May I suggest taking off the .00 KiB/s suffix, has that been considered? As the decimal places don't appear to change, they're stuck on .00.

I noticed the KiB/s is neatly rounded to the kibibyte.

Apologies I'm not using latest release. 
git version 2.40.1


$ git clone git://gcc.gnu.org/git/gcc.git git_1
Cloning into 'git_1'...
remote: Enumerating objects: 2949348, done.
remote: Counting objects: 100% (209238/209238), done.
remote: Compressing objects: 100% (14579/14579), done.
Receiving objects:   7% (210878/2949348), 76.33 MiB | 52.00 KiB/s


Meanwhile I'll keep waiting for this slow server.

Kind regards, Jonny
