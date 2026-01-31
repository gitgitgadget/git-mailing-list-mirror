Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E671366054
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769892926; cv=none; b=sdXNVp9RTOsRw+PuD5IaCxYKWOkZKs6+YYSTZIsk1Hiahcnv4lhOwXQurHXs7EcX1V/VWxQogQwfOglDfBjQVc+b1tvJ2ncqAVL3pBjeiZfgvgO7d93mUQIeg6NLuhfHa0CdHgBwDxdzosArK2EetEZb88j5zUWem7UGvMRU1SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769892926; c=relaxed/simple;
	bh=GiaGhFGOGw0K8El/yNhsjcmAuOHA+a+No2E020e/V+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyvXpb35cm5FUXvsWYrdvKsQHoapuKspGLt3f1NoJ5gsZWu5SLSzO8WvgEGPiFeQ7+kPNJyeZ4Qlmftyl0IrzbtWcgKHrOAjQ9ZXerR7A9vXuuekiIyR9RghXPPhbCa9PikCVf1nOk/hOM/gFNXu4rV4kb039tQZR/8lTh4UQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqzJJZdo; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqzJJZdo"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-382f9930e54so36265101fa.1
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 12:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769892923; x=1770497723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZakMIOswgtQ6qJTKUhTj31EygDl+l47eTU2/jpHuIQ8=;
        b=HqzJJZdoMYe90psKprupwaN6trg8tQ2GXIE5cMC0o9KLRPYEHVUYII8n+oHqwTL4uN
         P0Du4am6a62zYgZ1Pb6vhkOTU1R3yb2H+gOQ48YGMGGKuytKNlt/Bl1YH6Sx+adgznJk
         D6vM0U732aUVikRxIsuLLVeD8h0mJ9IVgBA4mAQzoaomt/ufQcqsQ3bePbZye88WaiTw
         n+3T9DzO+fO915j/MIll2i5JHgdcEhjMf5m0BuuxakeoWfaNVkyjvFx6DWPyymq6IuJ6
         kik90NhIlZyelz9NJ5H6wigUUsOAQ7GD4TkZeGhHZwP572V0j5itPrnWqOj0VKVAwMTY
         DbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769892923; x=1770497723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZakMIOswgtQ6qJTKUhTj31EygDl+l47eTU2/jpHuIQ8=;
        b=mftZld1Yi5jjxdXI61X948gyaxx80Wn9knmGhBHt6ha4AkwPZ999pzwG92FSvPi7i/
         FY8hhwCFXNZQk84bxWWdHm/FJ4KHDBy8nogJ4ouGgbTJMDAM51CqK8LY4+bNvW41KwCa
         ZWsQl9qmwe2hdR/dt68Il0dzfYWuroc1GZXAbM9q7yg0EZWJ7T2gK52VM3gOWk5cB8jD
         29t/fryeKnxVB8Y0n3qSnvG4CVkk5CVgxZwEUq+A8XjuelsYrGkfRJ4FISTYxeXcuK12
         9io9Hc9fkCEbkdfEfyldT1PFRKz78ZowVEChsWjO5qirU35rWdztOPCmw88nI4kTo+/4
         CWVA==
X-Gm-Message-State: AOJu0YyyJZk3s+FpucOKCYf2iHFETAEhZlbIS07CbRe+thwod+soxkkf
	0lWm2pqRzV9Ph8lhj4bRxEm5naAm7TyuO/uZaokOgtl/XVzrrTJcRtLk
X-Gm-Gg: AZuq6aJWsrqR0nitmflFhmvtyuPQEzEjglUARvkNPfweMuL6n8bz9UfPNA7GVBNfE4r
	042dl5cvuuT1L32LgGTQYe8PMLN0ojyaW12h2k3aagDcXpN9YlkkI7jQipus2HUcaIRLBZNrkMj
	bEvT0+G6LwSznMK/Zkvb8rGSBqc53/sPES/dSqcjwTUz+gQYFIE0h+7wCTw7LzuJIaW/AMCs4TK
	qSY3igt1zdEOAKAudcnhpSBEr6M4N4HV875M99EFNCoeEQjOs4cnCCmkkvbwXdZyudtuOAkBrmz
	oJ6QxK8cphp3YrekCz9Udv9IFKulyl//962zSh5ACBDPs/Iltueh6QLeP8THtaDe+YcY0umEgDx
	yUeaLhsOBYKtcGkV7KMBdAjWTqno3BxRXIu650u86L1Ptos8E06tW/o2/WihacAMIpRiOKJwqpJ
	RDQL7WeuKDgYHeKU1LLfNzHv8ArcU3u+DN5JRBCZcxUDpnNyHNW68FazOklosjhckY2vNoAu8=
X-Received: by 2002:a2e:a7cf:0:b0:382:4fcd:66a3 with SMTP id 38308e7fff4ca-386465e6806mr27412391fa.12.1769892922413;
        Sat, 31 Jan 2026 12:55:22 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625fbff42sm23537381fa.45.2026.01.31.12.55.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 12:55:21 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Date: Sat, 31 Jan 2026 21:55:21 +0100
Message-ID: <20260131205521.11876-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131202232.9213-1-haraldnordgren@gmail.com>
References: <20260131202232.9213-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Doesn't repo_default_branch_name() do the right thing without being
> noisy at all even in a repository without that configured, as the
> function will fall back to the built-in default?  While I do not
> think of a workflow in which a handy access to the value the
> function gives would be so useful that it deserves a short-hand, it
> would be a reasonable candidate of what to be called "@{default}",
> if it proves useful, I would think.

After looking a this, this is hard-coded. Not showing what is relevant for
each repo that exists:

```
char *repo_default_branch_name(struct repository *r, int quiet)
{
  const char *config_key = "init.defaultbranch";
  const char *config_display_key = "init.defaultBranch";
  char *ret = NULL, *full_ref;
  const char *env = getenv("GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME");

  if (env && *env)
    ret = xstrdup(env);
  if (!ret && repo_config_get_string(r, config_key, &ret) < 0)
    die(_("could not retrieve `%s`"), config_display_key);

  if (!ret) {
#ifdef WITH_BREAKING_CHANGES
    ret = xstrdup("main");
#else
    ret = xstrdup("master");
```


Harald
