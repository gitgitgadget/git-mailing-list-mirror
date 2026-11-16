Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794851699;
	b=27h/+Wt+QE6S71O96fg1VO2HOZmQMD/Jthu5W++HUD1oqMBkj/LBbLY6xYRt0FIF3lXF
	 Qjzw2pC/VU6H6K+yHnoudQkmK4ywMDZEZxUACFN2W1ZO+ogCSUDPhgyIT6KtoTqpu6QOH
	 4pCMGe5SM7+6BFznPW4DRW2lE1TwcdwnhSLwN46els1agPHh5Vs+HsfjilWzFI0tIINOR
	 VEeu4TX7wYGSWwHzvPImg+EyMCFTzJJ7vpIhIahcGFDu3ExEtCekfqI6w4UmmsnDyhYl/
	 4micii09F8yNzJYJTz5OcGpX4Rng4h8aemaYWxjpteCEtMMDKa5+fbQy6Oi4bKBYjkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=RsYkkrCytPYpChFLW5RYMcccomIpp/ZaiKlFN19Y55I=;
	b=DJUsld7Pqehb65feUrh8P+xdWDq2kktyXUrm6E8SKwMfIwql9KNtOc40oE0Yd4dLRS8g
	 2syKbNl4klT4HVkXXV645E9tGN5NAZYhP6Mps/C0dDwBzWQoySJGpbF0n2tHUpF0e8Tdm
	 xQI4RU0kTKFQfFS7qAV7tmsXjqitNO6Ont02Ybpe+v+1FxQL5qTQ4ItHSotyRvqaLja4f
	 itrVdpcOQc1u1K4C8aDvs0jv+Ts0r1xXxzAQO1JfUYul3M1nc9KY9qOPRwrnYGg2WAgAt
	 tXSnY2I+o+JexNSSpErncm9+8nB97CvMFsLC5NN6V90Mlokl3GjR1XttMzl2Cz6Yjcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qPJKFM3T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6645E606A894
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 17:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6645E606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qPJKFM3T
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4932b13c4ccso2600882fac.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 09:54:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794851698; cv=none;
        d=google.com; s=arc-20260327;
        b=G3UN8SClj95gRJbeDZy92a5bWygkiZlae0cJHozQT8/LiaZTAG34geIaJzYCFmp/FG
         FcemL7wgS6aD/6D2UFAEl+sJpd9BkEecus5Z4j93FLFEIN4ljsiFTrH8bKOAImbm0LmG
         xcbEhbdsGlRqAiXzm8AGKetOEn+PrGW/4DRpkXYtOT7JTmifpNwZtZGbTpbjMH01waNL
         1lM88lyclayyDxbHwe9J+6LbyHhVqyfd/1nmcAAI1VI4FPQgOR/1jQorsiuWHahyQ1+O
         wibCaBZh6fGnzaLhydUzWUJVybbig5FyEmX4rDkDTDeShaNF730MIM77Ljoi9ZyTy4zU
         Fg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RsYkkrCytPYpChFLW5RYMcccomIpp/ZaiKlFN19Y55I=;
        fh=i9vsaPPshn7u+XwFiZFqNCRDG4JV4Hxz6+h1mCSMxb0=;
        b=miUmVwcgDeVX8gZfUr3pZ9F6uT4wUDKWGYyUEHB4HvirQ/Xs9t58JqCO0/7Xgre5VN
         mfu8rXWjid+V66xyoNnedWJu5iwLmKs/F7b9IYR0ftkgOc3dzTU5esayPhjyAuUjruKT
         iZ9+GowJ5wKYRGLh1Jl13AV5ylGuoPN2UnsMb4TQcBkhMZJ+k9qpznf60Zxy4fK0E98t
         j4FykUoL6SDz7A9LujblwOla5uJvz9twQ4badWiugLR2UPanm0Zd+xnQNlnXsEvcHFhy
         urpmUNeOzM+ijvB04t0AKteFrNqzfnW6Kimoe5TLcK2WPq+YgA8yZdK+uxmBgWG4Chsy
         pO9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794851698; x=1795456498; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RsYkkrCytPYpChFLW5RYMcccomIpp/ZaiKlFN19Y55I=;
        b=qPJKFM3TXuumLmdR7IYMX0f/wLzTzp7HmlfT9gAfwwLg8bGPvDU732JNvqRc7msDaB
         T5LnK1rBeu0HgVxWggTGVzuJ3G2m5H3kbidsZBvwbAeqpeIYTd0LcTISF9gVlxwOZkd1
         ocsELNZaerSjJFB4/kxDJBpBd+dhb//DefXWD8tnILSn0CxPjo92DeEEG6G/yXvIPQ5M
         ZPD85F+Bw2nz1LDTANdJJFim0mIpaRMfx14K4pqRBtrU+w3NPYWmkU5qVEcQM/p4BMFo
         s676uOR8YaMEZaeBWWjieAD/9GHQwcYedYfhS9g7rSgNm6lXGCh6IZQvjmZKRCJ6mFic
         vYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794851698; x=1795456498;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RsYkkrCytPYpChFLW5RYMcccomIpp/ZaiKlFN19Y55I=;
        b=apVS34FvBXrzGNMs5uCxWz2M9NQFhMtqSeZRQZHEFn68HYYmiBFx7IxOL2l9D8KSCb
         0vh/+cAZpNH+UDSZFEXA5aVCm3evlwYtbDrtJT7YOhOX2fhGBusQClxbeQxgxlJmLxGi
         KPtqPBhKJFH38mKF2HCMMab/s4xmvjsZgGoaGVaKThN0+rz3JnEBLZqMb7TNE+Rcn0b/
         YCjSKDFZDWyDl33helCHF00SzTRIJprW9zol1VyyESFuJw1qnnc6hm1VKlHVh/FVWLqD
         jH2q58HpC/5ADqBQMgfaVcqHX6VQ57n0PPPQCjM1pUsTkCVA9JpWjx5NCqtE2jc5L+B5
         /9hw==
X-Forwarded-Encrypted: i=1; AL+hErHL0Mw4sBnPwQ9OyH48Di6foZ2y/A6J5Cqps3RflTnZkOGtN+z6/unaoBONkzGgI1S+DQM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8g2PSUHMaw9LZskc5eBsxRzrvtz/ilOAoCO1xBF0aj5cJ5blQF
	kXwDdGjwjFbaxOQFn0sZQ/UciMf6k9eE00bgnRrgp1KdVq3G6nGrfOYPF0ccldmuezwFVZHlVOj
	2eM3FwrN9+vhv6qW3WTwCPLuKNqOHIZU=
X-Gm-Gg: AYBFou3rG9JybxRmAY2jUZs3SpHg9Wysk4PAaNpPvqPszLAL41buAGULQNcXM3vVY2u
	IuHLu+eBYgs9nXlda/gtw9IkNCTxb9KZxqtiHeNZiDBJMgARPQdKRkIkihLgZUSUA1JYVn5IUJw
	68RL6KqSimsI6vrISrsfQCTJBPqCF8skzg7mL6sudStTLbmjkJYrEezZx6/Gfuk8FlMeI6ADiT/
	FExb1Pti4GXM75QY2oEZFMqbi2LKF8Y7OPCJgWVY0uf8Mqj4vfnfOXCtPUrgkrkFT0qbrv4fwLt
	26gGPOOP/dYmBw73MAlITzgkbc/Y9EDL4tF8BAiB+9Lhl6jWbcQkb9/Pl/cncSe1sHaQ7kTz6ih
	h6fD24TWquFkOuR0j9UifSFY2qUV1QlD6ymvBOp5RZ0Jd56LSQwVSt6dXYnRr981BGf6N/tFWjt
	NrkBZTHTO1Zx7x1POJZSeQPqC63UHP80FxrfojqP6PhQ26jZ+INC2w8g==
X-Received: by 2002:a05:6870:ac29:b0:49d:999d:c25a with SMTP id
 586e51a60fabf-4afdf16402amr8598809fac.6.1794851698366; Mon, 16 Nov 2026
 09:54:58 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107195429.96842-1-tangajoris@gmail.com> <20261114012055.127905-1-tangajoris@gmail.com>
 <d4c22268-44e0-4e33-9ad4-2a9b3a5f5cae@gmail.com>
In-Reply-To: <d4c22268-44e0-4e33-9ad4-2a9b3a5f5cae@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Mon, 16 Nov 2026 20:54:21 +0300
X-Gm-Features: AclHuK9jGeapvMJ2PhkmvWveIKi9xwTobIrGNZ_IbvFL8yYNyuFcUMX5D90cGT0
Message-ID: <CAKrRMNq44ybUc3y-iMPrDHauQ0ST2z99KPYKBXwzkGsE-GwQLA@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2 1/2] apply: reject a patch after an empty
 "diff --git" line
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, gitster@pobox.com, jackrawlings2011@gmail.com, 
	christian.couder@gmail.com, kaartic.sivaraam@gmail.com, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Siddharth,

Thank you for reviewing this.

On Sun, 15 Nov 2026 at 15:39, Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
> The leak is actually in parse_git_diff_header(), we overwrite
> patch->def_name without freeing the old value, so it leaks when the
> function runs again for the next "diff --git". A free() before the
> assignment fixes it, and both callers zero the patch first so it's safe.
> Can't we do that in a prep patch and keep the test?

Yes, I tried it. With the free(), the test passes under SANITIZE=leak,
so I'll add it as a preparatory patch in v3 and keep the test.

> Nit: the notes under "---" describe both patches, so a cover letter with
> "--cover-letter --range-diff=<v2>" would be nicer for v3.

Alright, I'll send v3 with a cover letter and a range-diff.

Thanks,
Tanga
