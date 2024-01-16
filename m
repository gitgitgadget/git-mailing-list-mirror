Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8531DA44
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431830; cv=none; b=qDsiJrJYbct0BxSFWM6Z7olGDW6xMQgqlNUSRPoXCOnfXY1bxD+mOX6+nlic/6TUjW0RQ2Nnh+pBLBzMnh/Ni+pzUHeKapteZnvzkkJEicdT0i6TxM7mUUDPdswZUnMAMg5xLoLsq7s9KOlfVwFYiLIr6h/ZpyLCWpnxDV1I6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431830; c=relaxed/simple;
	bh=Vkm8GFA5IsM4OFbUT7OBnaxxOSwiEhEYn3S/Nkg/6w0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=o4iaLvFKoe5xph4r+oFAAHo636Mnljuqd0uTAeKDVRqkMfmnw/Q4RN3VmgRenDHTa73IWdJD17uhtLKQv+skoayaP3srB19FNixX8v/+s/zoydoYMNmmZsw1AKXnvpK3cHqeG2beMTfLn6sxeO3SQWqHckty77DtBQzieanBW6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Ko4NbEvc; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ko4NbEvc"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-598a2cb5a7cso2496963eaf.2
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 11:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705431828; x=1706036628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5y6tfjIRR/4K6z7XhoFX+rJJnhMR7vn9YFoXm4eFKj4=;
        b=Ko4NbEvc+Jv5LK/is9bHua7HuJA6mGqguGs1buDEHhQK6B9QVWgHdMZfQ8W2J/C9hM
         yiJ9oYyqy6IKbgpNowTfimH1hYykZDjZ1J7gPqF3BhR51MqrGxsN0wnJ6NZPdiMaGajW
         EsVdgn3MV7EZqorL/59TEBBqfW1Eale0aYRqT9KuJVJ3DB1hrHUXzJ1R+z1T7wZEdQYv
         meFdXLnksXgQ9kJwrTjkpcEZ2KDq/LY6CYjtUqsusOAcaBQy0NMiOLW21fE6fGl1XNNk
         9QIdlJ3eCPylXL4FqZ1mbzziaIATf9j1wxCcBiHo7Wo1lSQkDyyFohJko6a1JfZTUtSX
         ocHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431828; x=1706036628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5y6tfjIRR/4K6z7XhoFX+rJJnhMR7vn9YFoXm4eFKj4=;
        b=w9ADW3fYhJZwSfr4dlK/jzFO3NF/cEhirBf6luR1t3PKk/0+icSga09NEbzCFbeZGF
         k1oDCIPAKblsf5e1QdInN0PBMlL6dVlFM6EpX3OHGLusDM6sMKViNrLyNzNgul/lCssF
         8oY9048js/ju91W0oLURPNF9ZZJpNywwtHdtnHVq7ouaUxpwMtKcAfLyx7pytVlB7AZM
         wM2IDG56OtIP27219zFzZZ+RvYSYOqEdzhyo60P9eEVSnihmW2LgGtoCsgiOjfS9VTBK
         dzgiecjq8UO9qc05BMn0mlehod38Cf30DrXlT7dhcmiZ0O2U1a1aI4csOxg6KvtMYt0e
         gC8w==
X-Gm-Message-State: AOJu0YwhQDKY/bsgHcQ1h2B1jxA5SG0rcMP59SkxZ3acJj/LsRKZHtZU
	Ez1PmlyC9GZ3ZIiVX1NSAbjm1WPNh6PpnumGj78ATQeZCUv5xQ==
X-Google-Smtp-Source: AGHT+IF5iEEpsh6rp8snWVy0Xcfuz0AC4lUOeGJarO+YnwxnJrGzDRcx5kLnD9l2X6aGZXD1wedhHA==
X-Received: by 2002:a05:6359:6b89:b0:175:a79e:21b3 with SMTP id ta9-20020a0563596b8900b00175a79e21b3mr5207736rwb.13.1705431828023;
        Tue, 16 Jan 2024 11:03:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id fd10-20020a05622a4d0a00b00429d3257dd6sm3929000qtb.45.2024.01.16.11.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 11:03:47 -0800 (PST)
Date: Tue, 16 Jan 2024 14:03:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] pack-objects: enable multi-pack reuse via
 `feature.experimental`
Message-ID: <a2d0af562a5d0a4052c94f87c1d71639ff0b87f2.1705431816.git.me@ttaylorr.com>
References: <cover.1705431816.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1705431816.git.me@ttaylorr.com>

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
index 5f18486f64..b92881b0a3 100644
--- a/repository.h
+++ b/repository.h
@@ -36,6 +36,7 @@ struct repo_settings {
 	int sparse_index;
 	int pack_read_reverse_index;
 	int pack_use_bitmap_boundary_traversal;
+	int pack_use_multi_pack_reuse;
 
 	/*
 	 * Does this repository have core.useReplaceRefs=true (on by
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index b53e821bc0..ccc8735db6 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -57,6 +57,22 @@ test_expect_success 'preferred pack is reused for single-pack reuse' '
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
2.43.0.334.gd4dbce1db5.dirty
