Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D080186E2C
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250774; cv=none; b=fVmZ0mx94sRPyKV47dt+wVb02gte0ffDrcDnSfRB9uHnD3IuV1gCK/J6Y9tdiT0zytwxPUa8JCkuzswSJN58hL7xyVtNUq+ZJTxTbAU3zpQAe7WtA70Ax9iI7/X1kuNLjlxdDrzFepGlEl4Tj9ydvDJ9hCJB1YGZ+ybprWNeMuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250774; c=relaxed/simple;
	bh=GwcA0vjAVcI/IDF1+5n4yk03Ps6ak4milWhk8cNmXUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWzVIt2qwqBMLiQJnDS558vLZr35xwgkKHl2AMpFtQTSIJVqE+Q7OCosvoZod1Jmfjfc47uRtMsfgvqOPH2wHBVYE8TKJ3XW259ZwVa6stsHiufobb2y3bSd8fN5wy6kyd462MS+fsYsLs2TNeqerwBBdsy43moGRSNVoxsPQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lHYnEzHL; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lHYnEzHL"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-654cf0a069eso882377b3.1
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250772; x=1721855572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BLzkIZ0cCpY2SYOsUQYVtbx1+n9FCTW4/QCpVPJfOX4=;
        b=lHYnEzHLPkslMc2dsu6tyEVv4gvLUrNGu+PqHkPo9Pwiy/FizZZE2Mn0bPTLvFXnYT
         nKfJiRTzY8Pi5hKG295fEUvxf8eXkW7Q3RcugWPGLhvrlsfeMKbfFJYWPq+YJipo3gb/
         ZozERF5HGQrhmJNpsAOFBACZ+ushpN85Cn6nRiKT4IdxZMQzGKNSSuyHve3HK+gcR3Ax
         HIHZB9310DP0VLswMIXYaqo1WvUec1pHQK8m2NO79un3VOhFDARmapITnZQ/53hiocb8
         uF50HUJx5rR1eQL6qXdz9QdZoeQQAn9EN3hZMiwajZt/MaOmbqsnQrczPL6ykDoLniuY
         tf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250772; x=1721855572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLzkIZ0cCpY2SYOsUQYVtbx1+n9FCTW4/QCpVPJfOX4=;
        b=PDWb/OogQQTHirRDi2Y4VkZTKqzisge/h2aebRZ3uczX6I5SzHYbE2REdze9hNYtJx
         W5kag00ZFTVqDUpRS8iyh4Gp6O0SoO8vPxUe8MJ+gYezZkaDw4r9KGvjuSDDRJWX9rA2
         KEURV9dsNL8v8EMmZbKclqsSNmiBU0XGYVCD694Yogbrez4r92Iurv6Ihm9X0c8n4bcs
         SHn0ngkc32Teuuuwdj9kRdMMU2yhxSovkd1eN7+21KE+HmRdVkEu/IdHaYQr+WvYoLaf
         s/IX88S5ZAdWe8ZZzhtfNR0zrYtl+lb7Oubpy3P+Ag3r7csvZOlwd6pp657fv+CciuCR
         v9Tg==
X-Gm-Message-State: AOJu0Yx1MwZzd77al8PJXzxHLGvrM5WKfhJHlh/z5MuB8oCGbviIzNPi
	EgotSF4LV7lABPC9xsIk82iDqPMFm0VbP+d+hEKSmLYxhvvNwu4FFcswC42oY7DVWeTObYrCqZO
	S
X-Google-Smtp-Source: AGHT+IGU8U+ejzQ4LFiQiPUftvuRXe7UwYSEACMWi9x0Suz1lmuArkFm7SblLpPZr1id+FDakX1wbw==
X-Received: by 2002:a0d:f606:0:b0:65f:80bb:e6b2 with SMTP id 00721157ae682-664fe4577aamr34802607b3.14.1721250772231;
        Wed, 17 Jul 2024 14:12:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-666020a9acdsm780187b3.50.2024.07.17.14.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:51 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 18/19] t/t5313-pack-bounds-checks.sh: prepare for
 sub-directories
Message-ID: <814da1916d36173ffb18db64bcce8ea489b7da10.1721250704.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721250704.git.me@ttaylorr.com>

Prepare for sub-directories to appear in $GIT_DIR/objects/pack by
adjusting the copy, remove, and chmod invocations to perform their
behavior recursively.

This prepares us for the new $GIT_DIR/objects/pack/multi-pack-index.d
directory which will be added in a following commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5313-pack-bounds-checks.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index ceaa6700a2..86fc73f9fb 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -7,11 +7,11 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 clear_base () {
 	test_when_finished 'restore_base' &&
-	rm -f $base
+	rm -r -f $base
 }
 
 restore_base () {
-	cp base-backup/* .git/objects/pack/
+	cp -r base-backup/* .git/objects/pack/
 }
 
 do_pack () {
@@ -64,9 +64,9 @@ test_expect_success 'set up base packfile and variables' '
 	git commit -m base &&
 	git repack -ad &&
 	base=$(echo .git/objects/pack/*) &&
-	chmod +w $base &&
+	chmod -R +w $base &&
 	mkdir base-backup &&
-	cp $base base-backup/ &&
+	cp -r $base base-backup/ &&
 	object=$(git rev-parse HEAD:file)
 '
 
-- 
2.46.0.rc0.94.g9b2aff57b3

