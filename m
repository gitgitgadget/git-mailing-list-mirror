Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85AA13A258
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826138; cv=none; b=OSr1jWNjySTTmoFRR98j7e9pEAuUyB7R74zhNpjFqUEwZ9VAMOh3M9CvvhqGtum9Zhulzrq0E8clC/Xq9p982/H0YVZgmUYgKyI5e6O9eQ0oWBWrYGztLO3h4rZU+PfTnf7rxLXYqoF8ROKtsWnYN8ZB7/bfQoBMVyBKTJcMu9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826138; c=relaxed/simple;
	bh=CwBcWx0Wccrdot1FSW1qsianEFsUsNcvKmSVhu+QcI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXVm4PggJcw+7zTlZe7YJDjM/J5N8XcWFWjptOQVwkthV1UrMQLktXo9jupWJJozy72xTL5euATc7N+vgzsTQfTP/dehBfXfpR/syKRUZsa4StUb/TWx2H3752+zzxqiXhsJLcfZ2KUx8orGb88toftrUU8+ibvCHWl97Wo2FMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFtV4+MU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFtV4+MU"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d428da4300so210218785a.3
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 06:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775826136; x=1776430936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7tXH1ONZzv2NBpBV3m7W0mmjvqsvOau0eIozg2sS5Q=;
        b=AFtV4+MU2IcVfIU+Qi6oAJdEJ/VR+HCeHJKDF4JlG5SWrjIVXziJCXmot3HSE6pmff
         9JtsvubRUq3bA69a/3qw8RWYrGUr49vYly03iVnj3n4Hjh+6GITIj9tZ2xAmYPhMj7Y5
         qEhbWvY0Y/X6sRu/BC3S20im3f0br3pMT+DEkZkNUjyyFCPeKQfzerjeGzrkI2FWfdWZ
         5Fb1/AbreHEuJ4hZ9JzyCWY0zhx/kqxBN+lSre0n21zzZHZgegUfOmUpNTKQX91aLUDd
         1p9z/WzRqGn9CLtrVBLttb1US4StNsuP7s4S5aEGycqxdEkMnguDgb8B+bGBdLm9Jjz1
         7y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775826136; x=1776430936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7tXH1ONZzv2NBpBV3m7W0mmjvqsvOau0eIozg2sS5Q=;
        b=ipGWneeeK6TZX9yemUA82ea27wlQDhS5YQDFIRLnxo3/GMtaufautsuN0Xci3jtwM5
         c91aSDCiZgEC96nXD2FB+4Qh+ZQ6oyY/98t07WkS2gLY+QZijdGC9MoELFtMi5uXP+IG
         9dV0f7IR7kOf0uD7e7q8DMVO2XEcj2YB8yXCJeD+WEARCRNHu4JImwRKlr7IbpENtGV5
         aqO3U6j7RCkwpZ1OC933cwCQkFFRDytjoSyxRBxOSx4UFii5YwFxhaGZsgRWhqVCLfBB
         GyZKhYFTzWKbeZqJPzxcVNbfxkyG6lmeirvESxDP7DX8ytipVXbLiaOhog/uG0LlZKB2
         5fSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe+rPvli39HO/tGUng/Ken6H/JdUGy9U95G8hGo7R8Oaw+l0YTVMuzytf3NP1ObjFwpGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV9M8+6x27/JgN+3ZtQOuXRMD5LjqLiTmVTbcM6evZGo9rKIZS
	exOYV/0QNTCQW06aed5JM7YmELpj+gD8vChUQIP2gmyoL0nC/ov7DrqZ
X-Gm-Gg: AeBDieus4bh10N5l5KsMhoN3eCJvYxWaozMfTJeQQCJHzlC3ptyfAt/uHiKxhXYlmYe
	3/IaxJn38DrSzdv4TvCpgV2vhRDwF+g0vz2gJ4d6kZ/a2aEq2FulIXFzg8xZqbEdpNOGNj4KEAx
	gRCnpS37Kn488H7yWnwaHnvn2IAGHTdZ0S/xNrDsQ9Uoc0j/yBH8WuTC1AElX6zR9dw7N7ANsXG
	KcugF2cOiQP3GA+U+mZsQDBJt5TwDqotLDcL8aJTPeb3Eeg1xk5Jm0Pe9K6pWqaAFSfDQLrQBNe
	sbdEtLQFrpNOsPIsyiVpaqLESALHx+pqVD/tj/T+MPs03bC5m7nh1knCVsIrYdfLkZp6Ip+IOxU
	AN4PfJvtNlNkIwxsFgkNTPhx/34AZsZXQ3PzyXfniOxaNJsO6DlU1AZ0YtB94N4dSgpwJrHNY7T
	gWCAy7kHbZP1g8CqEhGcAGJr276xs/FVu3xoqtoAgZEZoRPTNTe2CmLKLSzeQse0zsxs8WUw==
X-Received: by 2002:a05:620a:1a11:b0:8cf:e2b3:5b1c with SMTP id af79cd13be357-8ddcf2bfc1amr406629385a.35.1775826135531;
        Fri, 10 Apr 2026 06:02:15 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8dead5143b3sm30264785a.3.2026.04.10.06.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 06:02:14 -0700 (PDT)
Message-ID: <4efc4133-3726-4b9d-8f06-03c07d48af99@gmail.com>
Date: Fri, 10 Apr 2026 09:02:13 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Enable Rust by default
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/2026 6:44 PM, brian m. carlson wrote:
> Our breaking changes document said that we would enable Rust support by
> default in Git 2.53, while still leaving the ability for it to be
> disabled.  Unfortunately, we forgot to do that and my time machine is
> broken right now, so this series sets it up for Git 2.54.

I'm glad you're remembering to help us follow through on this promise.

However, I'm worried that we shouldn't do this change during the rc
window for 2.54.0. Perhaps we could get a small patch that updates the
docs to say "we really mean 2.55.0" that lands in the 2.54.0 release,
and then we merge the requirements for the build in the first batch
after the release.

This would give us a full release cycle to simmer with the requirement
instead of slipping it in for the last rc.

Thanks,
-Stolee

