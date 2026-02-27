Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0433984D
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 03:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772164296; cv=none; b=TRrhOQgQTOaQRzuTcx+82zsJiu2OtbVnfA/80IdaITjqZiDqHLpJcTi3/ex2vTG1L7YPPm/GgIBgCqR5dbCrCo0nrMI8a3A1mhEy6DHBvyuLpTgUOUVXGy5SSym3EU0A+pnndFHY7RkiX6nkzMaeVT0MOAvxv5i0zJ80hRot1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772164296; c=relaxed/simple;
	bh=VXo4V9u7xCckrYiyALMEvJTdxwCN1AoG09Re6zGB6oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFTxDUgOnJt+SGQGrf9WN3UYClJfAAwReEr9f0ixOP4UwTAU3UYLRgtiZZsKHSqBCCuZMSYtHTqc0t1GfGW3gJjMBiR9lfS3HaYKlsXkHSNj9ofEGHZ7Ggw6uREcDITlXzQPQkeQbmt94T5tAzvjF847meo/E4LVuaDaHDHnH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFFKQRB4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFFKQRB4"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2adcede372cso6540515ad.0
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 19:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772164294; x=1772769094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0PJweZewVNU2ErZKkM85OcIFI6YBaIsWA1uVkceuMY=;
        b=WFFKQRB49oE8cDWC4kAfgybGSg24eBaTzTOyJoV5cKuPYMlbJb9fqsfIkRQS5vZNyY
         I8WIw++AIUADdeI4hQH/ZPp3iYp0CM/QkvFVU0L1AVWCkJKrSRC1EgxB9PquCBIKXMUa
         udH6R0X1X94HheIRX6cBDygv+VqXGQznbt/w0ws6cNTzsaSb8krwLrQ7Khm+l0LXmV9f
         MF6AH8RMEzcKkcWE0g+S6Slz84hgFcZrR1Z/mEMQMN7S9kW110wmUr1z7ubhGEKqRVUX
         r119kxDo6RFWwnq5Nj22rceSxnFAuHivngx6IZACs7Vg7WqP2FI3HxyIWnSEFzieSV5q
         Sw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772164294; x=1772769094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0PJweZewVNU2ErZKkM85OcIFI6YBaIsWA1uVkceuMY=;
        b=g41nm/ly5WeetkeXGGndG42feF/X1w91efqgUxNq6qfPK1fA/29BkTZmig+RHersZS
         4m7hvvBGwjQ0+VY2QT+HOuVhaYyNBRn6SNO3ZJOACVNAUyFgtyxUWQzSGiCBeRN2nwU7
         CZLxoqKWbH2G7mxO91/u7iU7dtfYqapCHL1PJkoWF+jrtCQWgKoo4ZJwWyOTIhHS7iyr
         dUzdxA+Iag/Jv9dDqFFcogURjHtEJVypHfElPK4LP+JhSzPvbFoYV5J++4O7nA1HCfE2
         +DHr0SunD9EEL4Gwwy/s4HvgYctOxpstDNIL6J+4PfXzp+jEoV3kHKo0RPfKGFCZpJ+W
         cF5A==
X-Forwarded-Encrypted: i=1; AJvYcCWv/Eczq9izqcnA60ikkgqWu2fdkuxTnbcIjrd1gIxmbIeVuZTRIWL2eWBnVGWe8MAM/0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr1wDEp5Srfg1gBf1o7yqphlLuniloDu+KCNksGEkfW/Az0c9q
	T1ALWwBnFMBBAbmX9sG9c/tGLqLpSsjVWqdg5Rr/lDn3fjlgrOwuBOSp
X-Gm-Gg: ATEYQzzjifA4LwT6dyFpvgl9xtIJcui6l3Y4JCpyewjUNRXbT7HnxMZVbBN9meDw8Ee
	CIpWPGp/FOVl1X/Wk/9vpF+kTkPBFaxRO2Scj21tl/zj1Np9R3F1IH6teiAUir3eruq9thJLlZV
	f+mmFi8VSl+98qGttr5fz2xS7ZGrN7gAHD2a7QXffUcmrozTFP32amZ17UkIp6+ey5ksmkiguXY
	3aiWaLWVZo4Bcu37iaXIBaSHHVYk2req4a5ms4q5vAz8FMXrfHenMBWg6ace1zohN+IRafn25ZX
	N6+Y/wR06/h5Ie5lpW0ftHFnmsB8dWRZOwV1FuFqBlZMxxafwnmHaX3jhc/RZL+myvLfRJ48wBz
	Ou3HZFHtrnzJCYP3Ii2sGWiyEL1cDl4WCa6Wvz1HGNiCyMpFdl6HqgWOP7c3lsD+P8QhrpwBvxj
	GVFzm7jkqiGJ6Izu91yEocN42qzPVviCeVcqmsUMhHM7dAaamnZkC17toRSeeSCkbQfbh/HA3t+
	9aelDxrU38CPJbb1t2PnkKtvU53IAWImgJZy3fMvPhVI0BxizObu1sbODhESoSEkSbU4sgPm+nH
	9ZECQZFN
X-Received: by 2002:a17:902:ce8c:b0:2a7:d5c0:c659 with SMTP id d9443c01a7336-2ae2e254561mr13844335ad.5.1772164294456;
        Thu, 26 Feb 2026 19:51:34 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:1975:a8f3:d92:f86c:633b:f0ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b4535sm38195645ad.17.2026.02.26.19.51.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Feb 2026 19:51:33 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: lucasseikioshiro@gmail.com
Cc: ayu.chandekar@gmail.com,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	siddharthasthana31@gmail.com,
	valusoutrik@gmail.com
Subject: Re: [GSOC RFC PATCH] builtin/repo: add path.in-worktree field
Date: Fri, 27 Feb 2026 09:21:22 +0530
Message-ID: <20260227035122.5588-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <BEE3B56B-F8E0-43B5-95EA-8506A84CB2EA@gmail.com>
References: <BEE3B56B-F8E0-43B5-95EA-8506A84CB2EA@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I don't think this is small enough to count as a microproject. A
> microproject is something simpler than that. See the microprojects
> page [1] for suggestions. They are more straightforward things that
> have more chances of being accepted quickly. And since having an accepted
> microproject is a mandatory step, you'll probably want it to be merged
> as soon as possible.

My bad, by microproject I meant this : 

> GSoc 2026 Idea : Improve the new git repo command
>
> Getting started: Build Git from source, experiment with git repo info 
> and git repo structure commands, study the implementation in builtin/repo.c,
> review the initial GSoC proposal and discussions, compare functionality
> with git rev-parse and identify gaps, and submit a *micro-patch to 
> demonstrate familiarity with the codebase*.

I guess I misunderstood, I thought a relevant micropatch to the project
idea area ( ie repo.c ) had to be submitted along with a general microproject.

I did submit one code microproject [1] and a doc-fix [2]

> I think that this seems to be easy to do, but the reviewing process
> may take some time, so it would be better if you stick to a
> one of the selected microprojects.

Now since a microproject in the gsoc idea domain is not mandatory ... 
I think it would be okay to start on this ? 
Regardless of it being fully reviewed, I feel like I should do some work
on repo.c before writing a gsoc proposal. That way I can better formulate
a timeline, maybe.

> Yeah, but then we would need to change all the calls to it, using
> the_repository at first. But I really don't know, I'll leave this
> discussion for more experienced people.

Alright.

> You can take a look on how `git rev-parse --is-inside-work-tree` is
> being tested today and use it as a base, since
> `git repo info path.is-inside-work-tree` would return true or false
> in the same situations.

Right, I dont know why I didn't do that, I will do that and send a patch v2

[1] : 20260209172445.39536-1-valusoutrik@gmail.com
[2] : pull.2187.git.git.1770293021383.gitgitgadget@gmail.com
