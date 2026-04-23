Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78F35CBCB
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960566; cv=none; b=e5En+lUEiM1ardtzi41vfyFq34v+WJ9GGZe6XRkdRkh+NrASKTAqMaDkOAp3jszdh14HikFDPHT+TVOzLpk3JcKr6jxUkfNpQJ6WlHkaRSabCuRotC3gT/uowyerMW6xSCFb/tR9M8O7uhWW4GRnZPiDNfSJ+dHbkJn7tCgOG0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960566; c=relaxed/simple;
	bh=wFemiJVxHjCKDqtH5KVacSGc6KOpnsu1fZbpi44AaTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTM7Ux53tWXoPI5bs9PfpmnEDpFv5RSNdqA1CDsR36PCKYCE74hPTIOi8ItETXBI+4R1g9doLpNJKxLpArUg38MOhPrIKNCl9Bn9N2/ZpTFj0C7IVTiVZF6LDVvW949p3NyKK0fMQjM8k6uEkfG5WzOj+sfoVr9QylxA+t0ecyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgrrT0D1; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgrrT0D1"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7986e0553bdso65708677b3.2
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776960564; x=1777565364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiDBjLGPkzPNJO+Gb73LIVVALFnQuCFci9rUGjk+4vs=;
        b=UgrrT0D10Tl6c6wO9TieghxDMDq0D9fwsNnM8TmCf3GURyUb3kHHyFjDN6Bcf8Bv51
         WwfxfwprY4K1H05CwIgVdmkzm9rEIpjh7d4rI77xtfOvMnhHJZJUYMkABPwe8MVKkYjR
         Nqtu/dH14DuwHzZRIZFy5d6sJo1S60VaVD1SE5cQpjhXtjyCl1HrCX4TkPjQJ0kUzynd
         kR6gT1ErkOJHuJjG2q6y7rjbsu0fv6a4zXLWZA406j5BNRCDVdU5lBM56GfiAp9ilnY4
         pV7wOOPn+D0nAAveV1UXc5rK2UULe/xOpf2Mq3fbyIZk0qRx8Uhc5Rc5oRBq0TeuI/pm
         aNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960564; x=1777565364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XiDBjLGPkzPNJO+Gb73LIVVALFnQuCFci9rUGjk+4vs=;
        b=mmjLvxkjL+lwQiUpZwn4xdZKRpb1kTe3BNxAKXeFMwEgdC1sFa43m0B228X7wL3Z9X
         zCfSBVBFELJaLKlLWLWrvo44EZiPZ6lnNp2Yd3iaTtLLPCGwcBEsZHeuLjiGc90NYbcU
         EhytELfz6np7V+PeTNbZlIl5esebHujVswC+Cv1RhjBARNSJnv3ns0ebaCYiGNrgHy/W
         OlaYy8zxA7fMxIKsrXcK5EwEXvt2L/dG4ZQ2ZRESk4jwgeZiOZLUeUnq/nyxa5nq5b/Y
         akcbQBRkpysc4WzYglW5peIr5zDQJSW/YODvOSr+kEnM4XXtvrkbrjbwlVx/ux/2NpCo
         MQPw==
X-Gm-Message-State: AOJu0YxYX73mQ+wOskYDoEjpVjtjIKRmOsMWyuGIRZCXVbIgLDBNSqmP
	Y5P0Wdpx0tV0L4D7HCUITO9QZk6uVq6FTObQqcH0vO2XGLF2/mrW4hHTUezQ5EoM
X-Gm-Gg: AeBDieskxx5gudwa831sIMeuMnOP8rMKFXGk7TZJlcWtluBodl1muYXYBDxjlQNv9FV
	fwxlxHsc0cSr5FBqDL3PEkIuYvY77esMU4FQZ/JiljBpsV6AI0tOOxnCt53EA6NaN30lBavN7R2
	LxG8DZYY2aW1XzI+wk9tKO8rq4ShW1q5LZ9yK44Rhvh5po8E9AkhUmWkZQvSmVoZjPeu3a1n13Q
	2BuKxPqv26c1trC2cdozDpw4e1xflq69lKouTWdp+ij7Laf8JH3g8bHrrj17kQtAmFwEiNd1tYM
	pDn4Fro8Kd21+lITclhlOnfoWf8N0laJGe7CSd/RE8eX3QHdgk/5AMQZWrTEOCFLHPdJteoznLe
	3KxtCUMheVRvDDiZ+Nqfy+irYsR9T0nPupseg28mdgPdrYkA0keMyCMNKAbixbiCNOw6Q7GFq4b
	JejegqTj4s+VVwsDz4iUai2/UkiJvOpAuCg6TJOOUE3SkXP4sLa+F2rqZBwnUwqNfdGPZfIQ==
X-Received: by 2002:a05:690c:6987:b0:7bb:11a4:2e70 with SMTP id 00721157ae682-7bb11a43561mr71151787b3.14.1776960564064;
        Thu, 23 Apr 2026 09:09:24 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7baeeaa2cb5sm51083997b3.21.2026.04.23.09.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:09:23 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 0/8] repo_config_values: migrate more globals
Date: Thu, 23 Apr 2026 17:08:24 +0100
Message-ID: <20260423160832.114816-1-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series continues the effort to remove repository-dependent global
configuration state by moving several core.* configuration variables
into struct `repo_config_values`.

This ensures configuration values are tied to the repository from which
they were read, avoiding cross-repository state leakage in processes
handling multiple repositories, while preserving existing behavior.

All affected configuration values are eagerly parsed. Storing them in
repo_config_values preserves current semantics and avoids introducing
lazy parsing into runtime code paths.

This v3 addresses review feedback by explicitly clarifying the reason
these values belong in repo_config_values (eager parsing) and improving
commit message clarity.

Olamide Caleb Bello (8):
  environment: move "trust_ctime" into struct repo_config_values
  environment: move "check_stat" into struct repo_config_values
  environment: move "zlib_compression_level" into repo_config_values
  environment: move "pack_compression_level" into struct repo_config_values
  environment: move "precomposed_unicode" into struct repo_config_values
  env: move "core_sparse_checkout_cone" into repo_config_values
  env: put "sparse_expect_files_outside_of_patterns" in repo_config_values
  env: move "warn_on_object_refname_ambiguity" into repo_config_values
-- 
2.53.0.155.g9f36b15afa

