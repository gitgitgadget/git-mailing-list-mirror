Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61019168BE
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710616848; cv=none; b=X/Dk/9veV9OsBkBuA1401feuI/6BUjJBFHJQ1CXPs6dIupNjxV+NrxWQBvx8IErx+fyGlrrB17ceAvrOU35Fv9Lqb60G1NWayyeBFRWzJn7eYfMrXQwIO0E6Z6KO32155DmBlKNAMht7Xrmhy8AK/KH+VxQszWKBezBrJRyWzFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710616848; c=relaxed/simple;
	bh=xzwSpukllQUhdsf0UW1u4wrP3MTzLMlsehkuQEqNx/Q=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=Ko6LyNOnGEAG8Kee4fE2rpJyxFa+3INK+eXrx3eQ8SPjMFsRCjuqfxAg6PO9ym9f1oLJ2Vb/nHtI2dMblJZs3IdrehVwGSp06jTy0ie5KDzMEtxIt09Mk2bRKSu/kJ3075ngwAwHCqNgS0BmotINfB8eKVGp6ti0fdla/e8kKzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDqEg0tp; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDqEg0tp"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-690bd329df2so22357456d6.2
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710616846; x=1711221646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IC1RH+oB39/4UEPAlLOFL7M8ArgBqmMMglPM8SJR9I=;
        b=MDqEg0tprpF531V6+kD20Kz6hVAUahaD6e1n1hVxP2CNjhwiY56QP8rftMOwmmIbe/
         MZYPhKgD+lXK1jKfw/M+IAguHR2KDIH+D7DwAv+rbQXKoL5eIUKzuqsPqoWqoKbBeZUC
         loThpCxqM3kq4lfd2BdvvOXv9h1njqbTGYGrDG8M5eZZ8CQjfPsjl63iaetb7dC9lx9H
         RzI+sDq7s6Z17pexZtPLMOTod3DPGGMM1ReiMfV+CnKFDXTpX2wc/Sg3ZT1gPye3EvAI
         2xLeUW6X2PUQQsJpMKRlIa+rCINlhX+p0XKyxx9zu2njNx23rNZyswSz6bXw5kOaH/QD
         HE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710616846; x=1711221646;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IC1RH+oB39/4UEPAlLOFL7M8ArgBqmMMglPM8SJR9I=;
        b=H5HCtITqR7Z3KbWq5WRIcg4ickWgFEa0AyXpDShH7fceZhGRrxlv1RYKo4Dfe1Ywmk
         yZLzu/LJxYG9kgN+3bYR6O/5gWb9CuTlMai/kreZqzUHfkxDb6WiFxz8GZfg6CdStziO
         EXdrN0J4cru/Wm9fqJbvq/lKLub91ZvJZfueW0cGIhOHniFcQZW+vFgZhqRJiukW9DJq
         p/3+cuIsjhrE7fT3unziIy7Ll+SY40SE0EjVlVSHmcNujNv6od19J/xi6Mde2OSMykgY
         2IR0QwJ+pFbGEBxxMBOf8gGDOi0qhRE6ZiTONtQRSmpdGfWa+FjygckK2RcBsU1knbI3
         GGSw==
X-Gm-Message-State: AOJu0YziRQsxzmlTWrtJM9EJh9N4kkMXnHXNQgUlFTHd7KIE9+akNbA/
	UdetoTYvoHhIOihMMVxWm6uFul9S9f2YHunphAeODMRZbcf8AAXMQomvxs80
X-Google-Smtp-Source: AGHT+IGqgUOQLkyAiaqHqm82gknAszBoFn0TOApxrLQf5G6sM24eWIKmNSWv8JdyNBl7BPd7MY/UUw==
X-Received: by 2002:a0c:e14c:0:b0:690:c7a5:1dc9 with SMTP id c12-20020a0ce14c000000b00690c7a51dc9mr8626171qvl.42.1710616846092;
        Sat, 16 Mar 2024 12:20:46 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:103b:f04a:b551:cd51:32ac? ([2606:6d00:15:103b:f04a:b551:cd51:32ac])
        by smtp.gmail.com with ESMTPSA id g12-20020a0caacc000000b0069186a078b3sm1349485qvb.143.2024.03.16.12.20.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 12:20:45 -0700 (PDT)
To: Git mailing list <git@vger.kernel.org>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Failures in GitHub Actions linux-leaks and linux-asan-ubsan
Message-ID: <3e217121-f49b-33bd-b76f-df24efca6d14@gmail.com>
Date: Sat, 16 Mar 2024 15:20:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit

Hi everyone,

You might have noticed that the linux-leaks and linux-asan-ubsan
jobs in GitHub Actions started failing last week. I investigated 
this so I'm sharing my findinds in case it helps.

The failures are due to the new ubuntu-22.04 GitHub Actions image
(release 20240310.1.0, [1]) which uses a kernel where ASLR is configured
in a way that is incompatible with ASan and LSan as used in 
the GCC and Clang versions in that image. More info can be found
in [2] and [3] and pages linked there.

A workaround was already implemented in the image generation process 
[4], so the next version of the image should work. I think the images
are released weekly. We could maybe add the same sysctl command to reduce
the entropy to our YAML file, or we could live with it for the next week
or so while waiting for the next image to roll out.

Cheers,

Philippe.

[1] https://github.com/actions/runner-images/commit/d67fa31aeeec3cf0d666d0eb2976b683471c6b90
[2] https://github.com/actions/runner-images/issues/9491#issuecomment-1989718917
[3] https://github.com/actions/runner-images/issues/9524#issuecomment-2002065399
[4] https://github.com/actions/runner-images/pull/9513
