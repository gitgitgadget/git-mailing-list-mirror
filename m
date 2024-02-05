Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C939B1EB3B
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173427; cv=none; b=a4FGznR3cDivVi5uCCnqkQ0LlUzhlh98dtvVq5aA6xqdBfZ0LrcFVWk03ASgvcS4Sgq86VfiWOnpH3dxJpnUZhl3vRy6UKm3g14GpjE+LHRe2lGdvxGZiMCb26beAvgsE1I2VMVjXYPPcIHLwbZ6ZrCK+9LHOlZ87tOqwc5p/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173427; c=relaxed/simple;
	bh=K3U1/+JFQlP++DGfuwfnMUyhvqVrOs137dtv6hXAgLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nwlp0LH6rsDX5qqdiWodgExRcVe/IdBUcRGaJbN1NCw18h/8QJ+ms31EFuOWo2LqPrhMIPROLZkDpbne3qoEll0uOYOfIw7h3k4vKyRUkRBuJYQ4+RNjDJVczEuzG9dgpg2lWIy0j2mgObq5DBznkcmM6u6Ex0MTB/hnE+tP8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=K0ZSza5E; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="K0ZSza5E"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-429d7896d35so31064941cf.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 14:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1707173424; x=1707778224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFpPb8ERa49DMDU/lFPWcEhZpkl14sq41lvNAoUJsGY=;
        b=K0ZSza5E1+vuxCA0tm5WbSBAo+NYXEuebDRQ6HbxfngjLjz4kXepCxMjzixqO0Jb6V
         49laBtb/Mrye9RCl7CzQaXggsxQAA5Ju7DCC5LOwnp1ox4THVaR47bkCFvCd2DCjgAfm
         uqdJAToiIpisO2E3VvRMhT0ZiTVglQMvByZ/Adfiu6uK+oInCQpq8ADVEMv6zQKc1Low
         M7mCz9D+lfirob/uRIsuDsQTBImeTOtEdDFh3RCMr/On9D3uwgMBdN+ngtcHksYi91xT
         TzdIChEehSagUDvNcKtLrpyEk5V3raFGdAqAi7Ir2+PwbYEQc+4K8M6kuIHc3LvTG1A7
         Gxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707173424; x=1707778224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFpPb8ERa49DMDU/lFPWcEhZpkl14sq41lvNAoUJsGY=;
        b=aDbV37jIkQ9VuNBSvzNXe0AHW0ofqh+uQ5r86T/hPv8OZGLC+m+TOz1dzfBUE5O7fR
         ecDw+Vc1Xo5+GPKUUmcaF5X7GnjbQva7+N4Hf+iiPBL6ygvOIeOTvwbv7eRglgzmvWYj
         8/4rVZ6vJFA29l2EVzq2KgMUtc5DM/sRR+nyKokzz8vBhQVOW7ns5fJH6tg92lupWaj+
         xhBREvlPtIr0/GLTHmXXMk6bUOzlrU0svSx3l/nv0Bb2k1xBkEnh1q/wI/GT+qARyKq7
         lTg56ff9G/M3SoHKwDLMf7whCryVDZX053j7NWBsbQTfw7uVJn3gB2P5wVN/uZzvkw30
         kD1g==
X-Gm-Message-State: AOJu0Yy+WWNAm5VqFVc99f7sFA6DZnJ+iScmb0d5+JhD0Pyp6ChmUrFQ
	am7TKsQBnZ9UMvKepe+SzE+qq1dAWgBe4al3VY8fnTq+4mF8Q6LX8pXlxsi4JyNh7XF2FzJblc/
	Ds88=
X-Google-Smtp-Source: AGHT+IHsLUTbJtvlJfE0W486FSCIRz5Y6xh+vygV4lh90jMR4+mefHZJubDD5PGWcqe9R+qnwbf+Jg==
X-Received: by 2002:a0c:9e89:0:b0:685:c584:6e8b with SMTP id r9-20020a0c9e89000000b00685c5846e8bmr356621qvd.0.1707173424582;
        Mon, 05 Feb 2024 14:50:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXRVbdTcdTo8NrlGngD9a7nVI5ijHhCGG48uHqszqtFWbVJC3KTQjh1OCBi0l9UDHUDDFmf4HDGmrZn+LWwqng16m8/c9Dcxde4G1ju
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id mh10-20020a056214564a00b0068c87ff82a1sm416445qvb.131.2024.02.05.14.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:50:24 -0800 (PST)
Date: Mon, 5 Feb 2024 17:50:23 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <pk@pks.im>
Subject: [PATCH v2 2/2] pack-objects: enable multi-pack reuse via
 `feature.experimental`
Message-ID: <683ffd154e02b98a7a17c6200613e35183963823.1707173415.git.me@ttaylorr.com>
References: <cover.1705431816.git.me@ttaylorr.com>
 <cover.1707173415.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1707173415.git.me@ttaylorr.com>

Now that multi-pack reuse is supported, enable it via the
feature.experimental configuration in addition to the classic
`pack.allowPackReuse`.

This will allow more users to experiment with the new behavior who might
not otherwise be aware of the existing `pack.allowPackReuse`
configuration option.

The enum with values NO_PACK_REUSE, SINGLE_PACK_REUSE, and
MULTI_PACK_REUSE is defined statically in builtin/pack-objects.c's
compilation unit. We could hoist that enum into a scope visible from the
repository_settings struct, and then use that enum value in
pack-objects. Instead, define a single int that indicates what
pack-objects's default value should be to avoid additional unnecessary
code movement.

Though `feature.experimental` implies `pack.allowPackReuse=multi`, this
can still be overridden by explicitly setting the latter configuration
to either "single" or "false". Tests covering all of these cases are
showin t5332.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/feature.txt |  3 +++
 builtin/pack-objects.c           |  2 ++
 repo-settings.c                  |  1 +
 repository.h                     |  1 +
 t/t5332-multi-pack-reuse.sh      | 16 ++++++++++++++++
 5 files changed, 23 insertions(+)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index bf9546fca4..f061b64b74 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -17,6 +17,9 @@ skipping more commits at a time, reducing the number of round trips.
 +
 * `pack.useBitmapBoundaryTraversal=true` may improve bitmap traversal times by
 walking fewer objects.
++
+* `pack.allowPackReuse=multi` may improve the time it takes to create a pack by
+reusing objects from multiple packs instead of just one.
 
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d8c2128a97..329aeac804 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4396,6 +4396,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		prepare_repo_settings(the_repository);
 		if (sparse < 0)
 			sparse = the_repository->settings.pack_use_sparse;
+		if (the_repository->settings.pack_use_multi_pack_reuse)
+			allow_pack_reuse = MULTI_PACK_REUSE;
 	}
 
 	reset_pack_idx_option(&pack_idx_opts);
diff --git a/repo-settings.c b/repo-settings.c
index 30cd478762..a0b590bc6c 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -43,6 +43,7 @@ void prepare_repo_settings(struct repository *r)
 	if (experimental) {
 		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
 		r->settings.pack_use_bitmap_boundary_traversal = 1;
+		r->settings.pack_use_multi_pack_reuse = 1;
 	}
 	if (manyfiles) {
 		r->settings.index_version = 4;
diff --git a/repository.h b/repository.h
index 7a250a6605..21949c5a17 100644
--- a/repository.h
+++ b/repository.h
@@ -39,6 +39,7 @@ struct repo_settings {
 	int sparse_index;
 	int pack_read_reverse_index;
 	int pack_use_bitmap_boundary_traversal;
+	int pack_use_multi_pack_reuse;
 
 	/*
 	 * Does this repository have core.useReplaceRefs=true (on by
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index d516062f84..b925a81d37 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -58,6 +58,22 @@ test_expect_success 'preferred pack is reused for single-pack reuse' '
 	test_pack_objects_reused_all 3 1
 '
 
+test_expect_success 'multi-pack reuse is disabled by default' '
+	test_pack_objects_reused_all 3 1
+'
+
+test_expect_success 'feature.experimental implies multi-pack reuse' '
+	test_config feature.experimental true &&
+
+	test_pack_objects_reused_all 6 2
+'
+
+test_expect_success 'multi-pack reuse can be disabled with feature.experimental' '
+	test_config feature.experimental true &&
+	test_config pack.allowPackReuse single &&
+
+	test_pack_objects_reused_all 3 1
+'
 
 test_expect_success 'enable multi-pack reuse' '
 	git config pack.allowPackReuse multi
-- 
2.43.0.524.g683ffd154e
