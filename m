Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A0367F23
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777461116; cv=none; b=bke6VTL5AExtDNtJ52DfEHVwQYXhJ9yhLjHKNUDAFnSkNERFPZk5BcOUqJUxDb2wXTI5UZouB98Dj4EFGkh1HKaaDwEHf/+hkvdoJnTtP/mKTYlYsaBwT9Zh005aNkT69dJk/YkZoW/gSjuNfeQnTGfDr0qMvO6ndCRHSOgY118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777461116; c=relaxed/simple;
	bh=B0WcZXVUeitF3JZ5tn/xAoUYP3wn+NouWMURvx8dn0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyOWkyemWKNFEVQ6vwEdCOKlnWWQozO99NvudeVuOVws+LJAYeUzqwxfyMnf5M3kl4vL/Dc2+pv3uoV5sOiP/xIVBi4+5+zzroGL3dgrR+hhwlbDefEJgusRbsGxezW1QiM0E3U3IDBLhqnQLZJFgz00BIddNlAUXI3/Vq3L1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGLkcDmL; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGLkcDmL"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59e4a04f059so15423663e87.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777461114; x=1778065914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXYT4NxpTG6GihV5iR9POaPSUDy60oOpNAC8F8QK9Ac=;
        b=PGLkcDmLMdWmy4t08dq0uxBrnln783XhxqXDXEw43jFKfV1qqwTWN6jcpTWYtLeCfb
         Pqf8NS5ye8sOSRgVp8kvIC9vbJL4n71Ns287x1dRYyuoHw2KwL79LQyrBEbCDGkBTiiP
         8Ys+Y4uF5GGwyEfK6qugAoux+S1KKU5Y2WrDDMOgwuA3wRYxENHz9IFoLi8/D8BY3IDb
         W/zvdw2RnU6wI3kL/yYNUgegXTHzWtWxyctx+i5HeZS3OqXl7HyPjuRBqzqX1nWvTjds
         ejulsFW4Cz6haJ8TmyvwAEtzJJBYnpshetxnjge/uOtgOKFKR8RctAqlwaG8HsIkJwXh
         JSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777461114; x=1778065914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PXYT4NxpTG6GihV5iR9POaPSUDy60oOpNAC8F8QK9Ac=;
        b=hLeIF8HLomjjtRSoLN4eQdg/jiszhpeXKgSS680Gls1q64ZdEPiK3eNcz1UOOO0uA4
         9/P9FlOkYWctAvJxKbVywKA8yMhpBou4S95gzc6+k/nV2UKBaEsb5QnEYCcV8WD0sWo4
         Y0G4kVXRyzBCTe5pxaaGuRMVnud7BW6mHhKmHmuG4w7SFuEsqMxUBjBqbwrkAEbHU7cP
         JOdB5PszERrvqi2Cmnsb0mQVJGUgLL/kHMtF7dgYi5Za0rvrIHfHV4CwXxNudyghVdp+
         oOTSeLSpMtFZIS5oZi+MbnQb8sJ94irZrPSPvyZg+OFPeA6XFc1w7YWXbJMGgG4O2P17
         vNgw==
X-Forwarded-Encrypted: i=1; AFNElJ/FQHbRmQYCkwXnfyz8cshcuFR9gWRUHF8JDTpMl6d7RFkYeU0uA9yMFS14kwNf5PbHrV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnCXNB3RTfEh6UfZmVwhWdNoPpIZAFylLY/9iqpBnCZyAMI0FL
	aa01CDjg/o7dcHPWF+5WocPxJLPmHcxW86b0wdoUrg3hpAhADmSYkOYJ
X-Gm-Gg: AeBDieuDo0iF8qtCJ4zoY+E4R8+K79G0N1xfCfwIaY1RomVaPNIsiBBYv3Gm8X7DYqa
	4yuQ0j34mF1m55I4WRVYvEQV+EkKQJnXWwA3ntuW5UB4o3FHCHEPDM/jJQjkjwq75gOo/dxe7gj
	P5ONT4+TOwcQQ52WjCvXfKTLQK4CztJE4tOOFA6MoFidS+dCTfMyYeGAA8EMjiPo0+lm7aSODuM
	1LB2fQEXWMGc9b98X6lnpL1MczpTkhMAlE4hHeglVOeDWjiawDAxQYu80eHo3DQfVMLbNh48lWK
	WNgGEKCAmnGT4SWv3MPBVAVK4COQqxf9MNarsQ803re9dVmeHsjoPsLGsWJTYMT4+pHUpS9Rjab
	iRn9zJ8l+TPn8q/Om2Wm0cfM3zq9pCRsEmMj0/6ghTi/2ej2QB4bG51z3+X3e0GJE76e5FWOzmp
	1gkkJXMyXiV7D3sVr11CtPxlV/xlgKS9dqfYmEDnyButjSwqykJPAez0K8FkAco/HXprfcpuOxC
	JyUjFS05LU8fxTXHpZm0MUranqEGFrMeNs=
X-Received: by 2002:a05:6512:2203:b0:5a3:cc81:efdb with SMTP id 2adb3069b0e04-5a7466234c2mr2757935e87.21.1777461113382;
        Wed, 29 Apr 2026 04:11:53 -0700 (PDT)
Received: from Mac.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a74a762906sm451071e87.55.2026.04.29.04.11.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Apr 2026 04:11:52 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: [PATCH] checkout: add --autostash option for branch switching
Date: Wed, 29 Apr 2026 13:11:52 +0200
Message-ID: <20260429111152.40619-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <3170928a-e05e-42cc-b15e-56e0fa479066@gmail.com>
References: <3170928a-e05e-42cc-b15e-56e0fa479066@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> That all sounds good and the range-diff below looks as I would expect it
> to. I've left some suggestions for possible future work on patch 5 but I
> think this is ready to be merged as-is.
> 
> Thanks for working on it

Thank you too!


Harald
