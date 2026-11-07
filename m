Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794090289;
	b=DFPMIZbGBMBtUtos2pPCPu/E8q8j17b/vXg6F2zWmMSgBqr8oJX+Ge7SkUsH3HAHuiXd
	 42xXei6lvKbdC0McUZY1pjdYHMasUYbYkXCZh4NEjXozpeiFU24PHokdVItG0R9jgdsrL
	 +YjgjYxG0kFP+Xuan4yISR+LMpFXPoXr32Iu/gMMpIrGDerryAv28rBcDNpeegpY1sWW/
	 7VTFiXExsn26PWUjM7qsgO1vF+lCfs1rT38P1hvouhxoeSo0PROI+tjwfT10ULCkUGL8/
	 Fw9WPOuex29zG5jGpqtWcf3vxu4lHwggYIz07ay2R11QNYBD3vGERm1FaHsH6PDv/Qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=mwqhlxozl71jUxqWVbYRftLtKaUqDm291hxWuD+hFgs=;
	b=lKIkq2RJynJUb0aZWJfHDLAyNN/Zqyf43Ng3W1dLLE0lJsRF2YtAcaRC6nBPQ/INeFVM
	 AYF0RiRGu2X9/cmqAFldjMQfR4+s2bvL/ho6Mk5Gq4kJeIU3pQulemtZyTGhauFHA04IA
	 KsRwSWh7thvKhIJuQhbJP1Cu1hAM0gHjqkjMsGTktj8v1xncsbKRB9FnH+/qJJZOgbc52
	 BX2RR0onsvgdLTAe+P/BehIT3G7aD1J0nnP32lFLiqMvStT4XJBFvS+akfq/MsnFpdYs9
	 GjD9k54YAOWKuO2MtRhhBeG7HYUJWPFimwXYSkbOnnFDs+OUJHiaRRxM2hYPxFp+DQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L21g4ChV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A9606A32E
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 22:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC0A9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L21g4ChV
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-84e513877a3so68380a34.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 14:24:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794090288; cv=none;
        d=google.com; s=arc-20260327;
        b=clB/VeOGwn/66ACZNnrmetxNRg38vlnRhLaJm25jpwW299nhXK7ms8t/TTuO8e6aam
         3kvK365dG8XD2lkVdXpcFXi0+Wd7pRicSBATYsRRzhNqEXU3pzaVCPUB7hANJStUqtZm
         8Urry8VdgauatKuTcJYV8h4d55iJV5PL1B7JaqJIkKNZOOaGXFs+LXXrhjWFw4HU/6GX
         gxiLiWi9sW2sulWvwKNMhAsWneBb3VGCAJn6HoPCqX0wZv5fCpWIaNpu1QNiToa+Djx5
         OtJNfk35mQM6SHhjQqUCqtpYqefEI19Ff/2oPmPBo9qGDvquqNlvdZE7MhalK4sqID0X
         ycfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mwqhlxozl71jUxqWVbYRftLtKaUqDm291hxWuD+hFgs=;
        fh=uLroqYqcx80GBCiwIGXxfGNsg5J6DEKTsHj898AfvWc=;
        b=cg+Tj8l6wdbbzwdSUKZblwGuUoERbbAGJ/0VM3nommY+TRIXKkq5jOJldFnR/MyESx
         TMerTM61vCHcGuT/IRlfwbPqWk1yYpMHaQc/0InJ+tPMiwRMrxJJvSMqmVLDqU5QsqCa
         2KtGTp3i2aHbwcOXXQu+MFNS2jZxcxNYTACkOkuLBjNfO2fVnFJMlPcCztvZNT9KaSHv
         TI27CssxBAkY6CKO7xQS2fJB5EBBkEQLLeqse+QCmNp4P+cMX6iupJgqXImft47AwLgc
         KYbAn/b1oq90+8j09gFtxaQi/2ASK2F9Va6k4D6UhPgX/rrPOTGUtmk55QidmllAcau6
         mwsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794090288; x=1794695088; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mwqhlxozl71jUxqWVbYRftLtKaUqDm291hxWuD+hFgs=;
        b=L21g4ChVK5WweJqPFi53/PttvG4UVm8+tpRkbgT70qRRq26VEcyGv519az735xcehp
         SyAWv3sPadyw4T+4qDh12YmfbcttWHz+va5GP0z6PMDL7m9bsObuVEko8a1Xk4tgvRkr
         YBKv3tVtP/O0h3AL4/Zw4hqnBr8G2wzA8wxmg5Jbd/AxkxEGE7MW3EVT/+puIAoQuMzn
         3zvhuQOujiHfFEp5tO+Xz6j9bEuGZix0u7Kk6QAwJg3eQk2xC5+z39IH61zvBollP37Z
         KYKkX+3EX6CIP+hu6Ib5/KS4ny8OQbTObBv7MQM3JWRpdVCKZU94chzmWnYR3ySMdGr/
         qhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794090288; x=1794695088;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mwqhlxozl71jUxqWVbYRftLtKaUqDm291hxWuD+hFgs=;
        b=VuRhJYkSxqcDoDVbRmESBJHK8lR7Gts7bXAbIC8RAIUNeCEdGV2pLLxsZEssBohL/p
         LSJZDfr9xI+CZJl0qilNgJZkq9vbs4LlmppMDg7tbTNlgq06GbuG4Pxu35MsNiX2bW9y
         AP0Dft9ZbpmbEfgZvFE8Qjo8sMlrAOZmn/CtDOSRwq15SgcfOjADM2J3aRUP4AM79Mr5
         zyNO0TVaEvewjr0d3s2fDcjS0KehbvKnf4GWK9WKehKErnZcPEk9NkQsWgKa5TIQ93E5
         FjxGMyOwQJMchzLr7yekde7B2pQiLafm21Z5l9+id+zZBf6BVSezDor6Y1NgYwYquNeG
         clsg==
X-Gm-Message-State: APuU4Z9Y/R8aaV9kNCJ8Y9mNkDV/8s46MFgL41TFndJ1kPq4RltxeHcQ
	O1T0BJqei5yMJnKMEitiVe9zbB079yPIIFIbDQAIUrCPqEG+rvvUD/udFIZU9uHvmzIklCg1Hmc
	w9cvqP/Tbt8PEFx23/up7h/B18PWn6GM=
X-Gm-Gg: AYBFou39sdU7Z7mVBLxnDF3k0bC9I69Iu0bF4T8udfZNFIp5kyfu/TXOIGbg95vnFIG
	9WNhgpIOt3M5v3EMBwuhW8MN5QODDduvPirs2soVN81OwI21I/Op6bhxKAy8YxiAufX3x2Wriox
	dW89gbzlEX7k6+NUHbUfWQawfnrIzxvPSZCH+COpDbA5m4IZa0O1/uhCZAnD3v9TRyXAc7Z/HFK
	MjJRcHplLqeqGnQNGR6PPUfVpEVKPWe/avguHq/DtzhhoxYh4AhummMVlks8O9dd+fXhzUkrBCn
	cKNZbm6CjG3CDsAInm80TOLuKsYWRePL2r6/QXceaTM1wMFrFjHHhoBCKfdPtCPjJspuuvt2rKc
	Zfy4zAWBIAkcUwCRz/hHOSOXQeqgUjD2HzaKTUXakfrxzgrvAUyBSd7UMZ6to8Ul0YC2qnIH4WB
	tlGMWVN3+fpIy92rgAggWd0pLACkOUAgNsF6VjiUm8hr0XyxEw+JHL
X-Received: by 2002:a05:6830:441e:b0:823:d058:c236 with SMTP id
 46e09a7af769-85f341aab58mr1584378a34.3.1794090287779; Sat, 07 Nov 2026
 14:24:47 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107121119.2995843-1-andy.koppe@gmail.com>
 <CAKrRMNpaBrOybe0hw_B+RTZ5GWeUASpR+sRte0OLL2x6xJba8g@mail.gmail.com> <CAHWeT-abY9_OOji+WkL3_Rpnzy0xBh3MGQCnhuUO9Wdr1hJy0Q@mail.gmail.com>
In-Reply-To: <CAHWeT-abY9_OOji+WkL3_Rpnzy0xBh3MGQCnhuUO9Wdr1hJy0Q@mail.gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Sun, 8 Nov 2026 01:24:11 +0300
X-Gm-Features: AclHuK_U5NYSww_kZEn5b7n8-jH2oQUAPwXPrk77VTUelqDCbyzDApSkqY4KU7c
Message-ID: <CAKrRMNr17jK4rT_9_oOnFrx5ukZu_Jj3tSJK+JzmGnDa1xE3ZQ@mail.gmail.com>
Subject: Re: [BUG] splitIndex with skipHash corrupts index and crashes status
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

You're welcome Andy.

On Sun, 8 Nov 2026 at 00:55, Andy Koppe <andy.koppe@gmail.com> wrote:
> Thank you very much for looking into this! I haven't dared wading into it.

That's alright, and thanks for confirming! I'll keep you posted as I
make progress
on the fix.

Best,
Tanga
