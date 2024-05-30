Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408A14387F
	for <git@vger.kernel.org>; Thu, 30 May 2024 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057298; cv=none; b=OBQSwE3L/fy7B2gf8wthvYwCuWRVTDt/nThrm1XlnFQW18feNpnS0wsitOAhc8W9koNm4S8jDA29jeVb5CwJIyQmHh+GncaLP4bVszbxNtv3C99Gm8RezNNiOQl5LMLhH751R9j0IbWG8BFxEGjWFpx3BsuCuIQvW1+9rdujxlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057298; c=relaxed/simple;
	bh=fRaGag7KYdvTweUrQaeEgz5yJRt/3RZ9wzL4BXFVz3g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JupdndGhikmGQmb/MqmkQ+fT/piDVN4oonLTQvl90xr7f3elxTxWOyurKobP5PxgLZUxrWnnfN5doAmitfD1htEzAZbjkB2TZHlX3K+Mb+aUJ48ru9jffPDMyAaZSXHB1LYmXKKzMO81jaITsSUMte4/KgeSmIPOl+x3bkRPhHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqDyBg77; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqDyBg77"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42120fc8d1dso7197325e9.2
        for <git@vger.kernel.org>; Thu, 30 May 2024 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717057294; x=1717662094; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otyCUdQ5630OA1n3Kv2jXIRvqkETG7Cu3OerP6BBMZo=;
        b=gqDyBg77syk6lIpHQr0wvEdECsxAzEXZmpFxd0U2UtMsPONz0oXBn+Ht5LK6WIDoJK
         RNIbQrdgu37jK3YFvRopqvzVX6wBWE0CEPgDsVjl/u1GAlAHPfkeGv/PikYPLySlrgPM
         0K0uECPsHzePlWF9Y19IGXPTJxy1CRbzCyX4djG8X1tEY4+BQ+nEytl6v3fQTxYmiXHG
         /h57t63t2lsudMUxBiAx6xYr38ZJcJEKYJjAr4bVKXYEmI3KB+bwW+/G4Ms1gtKGylB8
         gi+PsToOOIEy4KY1eyvq3HNb0tFrJgWBqo3Fb7jTfmPuJa2R8Po2VP+drzoOCcrbhLEO
         HZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717057294; x=1717662094;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otyCUdQ5630OA1n3Kv2jXIRvqkETG7Cu3OerP6BBMZo=;
        b=CIH9CA38WLqhpvm0DuKvcDzWgkW7XmK7CYgKZG5onukZFwfdbzqpDZVhuZSygmoBl+
         xHoSWqRY9OYn+WNbugT8gz6x3mItFBQCHYVdaq6UgwRbJ2gAfDRIDFuVvqP+YXVx+0sC
         mkgMaEzLBIBcsmdZ9S7N4qhLNRvF0SCrC17lkTuFAzG4UiVZZFJSjg+XY2QWkihBOxjp
         ubdjPD7KhxdYgj8S9Nx3LsJenhY5ePSveF61uVOzjPBUdLNM56LmPyrEX0IjshXHdkOd
         H1mMS2gG48sIa5RCB5emZW7HrxyjAER3Rcx4D6HZo9JC+VVHxxYyml+CbzVJfxrwDhUx
         Gi3w==
X-Gm-Message-State: AOJu0Yy39ygfDlahvx7YFWFrwaUGdImYr4iNKpcpVby4KfHNinDz9LGy
	WT0xHarartr9EV9TkIVJT7ID5URjH/pPtfRuP2O3c0pIvPu2Avr2ofyFlw==
X-Google-Smtp-Source: AGHT+IFIhWx4Wkx0BOZ+BuSw6xy/lHuSTZaODpm67F2FdNweNgeQQXtLMCHkUgrtoZInt8gI8M3M8w==
X-Received: by 2002:a05:600c:470a:b0:41a:e995:b915 with SMTP id 5b1f17b1804b1-421278130cbmr15273325e9.1.1717057293919;
        Thu, 30 May 2024 01:21:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127065ba7sm17690805e9.12.2024.05.30.01.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:21:33 -0700 (PDT)
Message-Id: <beb7073581123c1a9096d466f1ccff7fa68f3a19.1717057290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
References: <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
	<pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 May 2024 08:21:28 +0000
Subject: [PATCH v4 2/4] unbundle: extend verify_bundle_flags to support
 fsck-objects
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

This commit extends `verify_bundle_flags` by adding a new option
`VERIFY_BUNDLE_FSCK_ALWAYS`, which enables checks for broken objects in
`bundle.c:unbundle`. This option is now used as the default for fetches
involving bundles, specifically by `transport.c:fetch_refs_from_bundle`
for direct bundle fetches and by `bundle-uri.c:unbundle_from_file` for
_bundle-uri_ enabled fetches.

Upcoming commits will introduce another option as a replacement that
fits better with fetch operations. `VERIFY_BUNDLE_FSCK_ALWAYS` will be
further used to add "--fsck-objects" support for "git bundle unbundle"
and "git bundle verify".

Reviewed-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 bundle-uri.c | 2 +-
 bundle.c     | 3 +++
 bundle.h     | 1 +
 transport.c  | 2 +-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 65666a11d9c..066ff788104 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -373,7 +373,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	 * the prerequisite commits.
 	 */
 	if ((result = unbundle(r, &header, bundle_fd, NULL,
-			       VERIFY_BUNDLE_QUIET)))
+			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_FSCK_ALWAYS)))
 		return 1;
 
 	/*
diff --git a/bundle.c b/bundle.c
index 95367c2d0a0..26574e74bdd 100644
--- a/bundle.c
+++ b/bundle.c
@@ -625,6 +625,9 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	if (header->filter.choice)
 		strvec_push(&ip.args, "--promisor=from-bundle");
 
+	if (flags & VERIFY_BUNDLE_FSCK_ALWAYS)
+		strvec_push(&ip.args, "--fsck-objects");
+
 	if (extra_index_pack_args) {
 		strvec_pushv(&ip.args, extra_index_pack_args->v);
 		strvec_clear(extra_index_pack_args);
diff --git a/bundle.h b/bundle.h
index 021adbdcbb3..cf23c8615d3 100644
--- a/bundle.h
+++ b/bundle.h
@@ -33,6 +33,7 @@ int create_bundle(struct repository *r, const char *path,
 enum verify_bundle_flags {
 	VERIFY_BUNDLE_VERBOSE = (1 << 0),
 	VERIFY_BUNDLE_QUIET = (1 << 1),
+	VERIFY_BUNDLE_FSCK_ALWAYS = (1 << 2),
 };
 
 int verify_bundle(struct repository *r, struct bundle_header *header,
diff --git a/transport.c b/transport.c
index 0ad04b77fd2..1b3d61ffcec 100644
--- a/transport.c
+++ b/transport.c
@@ -184,7 +184,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
 	ret = unbundle(the_repository, &data->header, data->fd,
-		       &extra_index_pack_args, 0);
+		       &extra_index_pack_args, VERIFY_BUNDLE_FSCK_ALWAYS);
 	transport->hash_algo = data->header.hash_algo;
 	return ret;
 }
-- 
gitgitgadget

