Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777A62080CD
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338232; cv=none; b=tEsWJ/M6mmGTCK0vUTXoSuo7fTaDPBKlaX36WQ0jK7xVHjyCWF6awG0JzXt/ZuX8teaxUYuQ3xHtHy87heUdICG65pz0GfUmjWHrvaPJBp9e1bF3wwRam14eFys1p0KRnyBC91aTnsW6dR/As4xZYiLqwbMQXwEcSW0GHBZHhZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338232; c=relaxed/simple;
	bh=m+UwxlM80VSozkaZ+qSkMlCOQqWhms2nVbX69ik+bLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1Jnr5ndi4fxkbRlzt7IgmiWj2XeeQI+cILm51jQxYedPROQAfOqPyQJySBaef2Z6AF72NpkIL3kEKdmnAAoxnrYsPSweh/660YAZAi/BNqf0kePNE3hY+L9VaGNC+2AFKjlSCtCk+0v4oSLZ2P8zpkrKayYCrIdA/sEekEul00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TANB+a7c; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TANB+a7c"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0e135e953so618998785a.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742338229; x=1742943029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9WPnQ6JK8ZckS8BN9r991kDn+vKg9ieiumh/+GF1/R8=;
        b=TANB+a7clYOy4728vtgmjOw1gFc33r4KLHcLMl2njSXuVgZUbeDXF/LKSMR8C1wPbM
         HUJHj0lYMcRAhnWUvVYQG5sxzIDQW4+GsRUgENFzSZyb29G4+cWfT6z+yFukfKvwfBEb
         HWLTRhCDqf9YQSu89cIdlDtiEnIQFeTcabDU0tR+LBxry0TvUhe1hZ/MpgBFlZ+VZh/t
         0aPiMazZDT1rJTJuhltglz4PPGHKpaudyrwVojUYehddZ+aeBgda9VL3dPcm2mEeB1eW
         dY/qixysEQ7oTyaAg8rZeeeH7kSdebAPUGbh4RFXvX5zHJmmV/Lq4DeoDNkHYM3JRjbO
         uf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338229; x=1742943029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WPnQ6JK8ZckS8BN9r991kDn+vKg9ieiumh/+GF1/R8=;
        b=OExIM7E+LpvYKlCQbxigUYAMhJTqjvzhDBZdt9JirdVlYOu1fOqd2clnwQXc1sD7XN
         zSztgLQuCEhE2ewkahCLI5tl37Mq+sJp1YIMwanYr6I4ueGAtyWYgW/iLkRG3T/DE4Qd
         PnlCTN6KvAJ1peQhJCTEsdnHmkl4pGtcHAxEFiieA4CWi6lQavA39Vmmeg3QHOn0XATS
         Q9jEA2TLPUjZb5VQRTY70NgLAzsa7d/pXICIvoKyACj26jxIo3U+EsbENr0v3uV4/DbZ
         k//4qwNbODGwO0tU4Xa64H3cFkI9x5lBHQogVb0OP8V4JT9vXEW34CGic1QE/zvHBrmU
         iTWQ==
X-Gm-Message-State: AOJu0YyoM1FQ/HbeTs6voSgetslXwY2TMdXxMCdj5ku2NAs6bUl7TOHw
	yeeqIlPukqv2hISL6nXWFDSg5t/zxhWuBoPOtPwZ+4SUO/lNOJ/aCSLNw1ue3Q8MjqHqblFAkxC
	oTOg=
X-Gm-Gg: ASbGncvMTHq+8TxhElDsUG2weoLinGY6tAa5m/ngomTgYAgm30Vcak0QFcNvMejP5Sg
	F0ls8PUo7sI5P/5THjXznof4Obx41nYakUrXpHM4G74MpmBsCm2KjT7Op/8idO/DCGnWqjeBfOh
	wsosoX1v9pEaCPPiFaJI48vKj15QyBCfkd6w8GSeMcqeftmY5PoYetZF+yQ3Eo+3Zwivk5fHrZR
	SWGLEDXljLhgdMVe65DCHYyYZG6CUKsGiQNV9RlW/fWKTy2QBiVf9l7edYe73yMf7Nvhjdq+1ez
	QJnGb2Vbcx2gOrxl3uN2ueTZZ7eiE06u0VCEaK1Oa0NIffUXP7GjoenZFMV/TcyLY5tIxsyCXUy
	GPaI5Ol/Wc28Dl5fo
X-Google-Smtp-Source: AGHT+IGgGKqX0M7X0A4I9aPkkcTG/Vy2WI5c3pv3LhtJoxq76C8eeo7Z2JpXvZuQ8KGuMG6MCaggmA==
X-Received: by 2002:a05:622a:1f95:b0:476:8d14:6e7 with SMTP id d75a77b69052e-47708378a0bmr13457691cf.33.1742338229206;
        Tue, 18 Mar 2025 15:50:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb7f3c86sm72077021cf.54.2025.03.18.15.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:50:28 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:50:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v2 4/4] refspec: replace `refspec_item_init()` with
 fetch/push variants
Message-ID: <f0c323988f274c40a86caa6c7a12ac7c0467ec1b.1742338207.git.me@ttaylorr.com>
References: <xmqq5xkdrrhs.fsf@gitster.g>
 <cover.1742338207.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742338207.git.me@ttaylorr.com>

For similar reasons as in the previous refactoring of `refspec_init()`
into `refspec_init_fetch()` and `refspec_init_push()`, apply the same
refactoring to `refspec_item_init()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/fetch.c |  2 +-
 builtin/pull.c  |  2 +-
 refspec.c       | 22 +++++++++++++++++++---
 refspec.h       |  4 ++--
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 02af505469..9830c09011 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -586,7 +586,7 @@ static struct ref *get_ref_map(struct remote *remote,
 		struct refspec_item tag_refspec;
 
 		/* also fetch all tags */
-		refspec_item_init(&tag_refspec, TAG_REFSPEC, 0);
+		refspec_item_init_push(&tag_refspec, TAG_REFSPEC);
 		get_fetch_map(remote_refs, &tag_refspec, &tail, 0);
 		refspec_item_clear(&tag_refspec);
 	} else if (tags == TAGS_DEFAULT && *autotags) {
diff --git a/builtin/pull.c b/builtin/pull.c
index a68a9955de..a1ebc6ad33 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -738,7 +738,7 @@ static const char *get_tracking_branch(const char *remote, const char *refspec)
 	const char *spec_src;
 	const char *merge_branch;
 
-	if (!refspec_item_init(&spec, refspec, 1))
+	if (!refspec_item_init_fetch(&spec, refspec))
 		die(_("invalid refspec '%s'"), refspec);
 	spec_src = spec.src;
 	if (!*spec_src || !strcmp(spec_src, "HEAD"))
diff --git a/refspec.c b/refspec.c
index 3aeb697505..0775358d96 100644
--- a/refspec.c
+++ b/refspec.c
@@ -153,13 +153,24 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 	return 1;
 }
 
-int refspec_item_init(struct refspec_item *item, const char *refspec, int fetch)
+static int refspec_item_init(struct refspec_item *item, const char *refspec,
+			     int fetch)
 {
 	memset(item, 0, sizeof(*item));
 	item->raw = xstrdup(refspec);
 	return parse_refspec(item, refspec, fetch);
 }
 
+int refspec_item_init_fetch(struct refspec_item *item, const char *refspec)
+{
+	return refspec_item_init(item, refspec, 1);
+}
+
+int refspec_item_init_push(struct refspec_item *item, const char *refspec)
+{
+	return refspec_item_init(item, refspec, 0);
+}
+
 void refspec_item_clear(struct refspec_item *item)
 {
 	FREE_AND_NULL(item->src);
@@ -186,8 +197,13 @@ void refspec_init_push(struct refspec *rs)
 void refspec_append(struct refspec *rs, const char *refspec)
 {
 	struct refspec_item item;
+	int ret;
 
-	if (!refspec_item_init(&item, refspec, rs->fetch))
+	if (rs->fetch)
+		ret = refspec_item_init_fetch(&item, refspec);
+	else
+		ret = refspec_item_init_push(&item, refspec);
+	if (!ret)
 		die(_("invalid refspec '%s'"), refspec);
 
 	ALLOC_GROW(rs->items, rs->nr + 1, rs->alloc);
@@ -233,7 +249,7 @@ void refspec_clear(struct refspec *rs)
 int valid_fetch_refspec(const char *fetch_refspec_str)
 {
 	struct refspec_item refspec;
-	int ret = refspec_item_init(&refspec, fetch_refspec_str, 1);
+	int ret = refspec_item_init_fetch(&refspec, fetch_refspec_str);
 	refspec_item_clear(&refspec);
 	return ret;
 }
diff --git a/refspec.h b/refspec.h
index 614f34554e..8b04f9995e 100644
--- a/refspec.h
+++ b/refspec.h
@@ -47,8 +47,8 @@ struct refspec {
 	unsigned fetch : 1;
 };
 
-int refspec_item_init(struct refspec_item *item, const char *refspec,
-		      int fetch);
+int refspec_item_init_fetch(struct refspec_item *item, const char *refspec);
+int refspec_item_init_push(struct refspec_item *item, const char *refspec);
 void refspec_item_clear(struct refspec_item *item);
 void refspec_init_fetch(struct refspec *rs);
 void refspec_init_push(struct refspec *rs);
-- 
2.49.0.3.gbb7a4a684c.dirty
