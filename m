Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505DE1FF5E3
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250289; cv=none; b=C1tuMzGlWfptbAMICm1D9GBohS2KYQuAxygM7ctXL/wf91U8c448rtl103pbZfS3HGNPTYiEYgTeMml6qVvdK719mWHXFenghweeDyy+KtlAeQ33tTbLimNqDHQLr9oMLmZznAINLeQgav91toPE1cKiFlfb/aBZZqluOd5GVEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250289; c=relaxed/simple;
	bh=J/fpKRrWOxf1jB7S05Ljdr4nv/IjWNF2T4ExhPKYNyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEV7oPhQ+ab+3iWGsHZxRFrXivRIFunRq1Ix9LOWlwePk/RA2oRIRs/G94kbaCnUt1FwRsV7smqLLyLrVV6gHr6efZCf89rmM5NTApOkKZTH9xpEqct+hNoGXX7C3ULo3X0BtGQSFRP8cRgBFcKw81KRVPCHrCC2m9TmTiP/iqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=CIKW+IyR; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CIKW+IyR"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c554d7dc2aso809702285a.3
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742250285; x=1742855085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+jy9e+p5Gp5xwwCIHcn/ZqBEC5y0Nu6I8DbyYonANL8=;
        b=CIKW+IyRFUz3hIjTiw9BY2uinzOn77E1Z0IEA/F9b34KOlT1loNJTKeU7JMpdYpmdZ
         6i1f1qpe+bc9Nc9rzmZkQcXwXJ8la5GFNEsY6pWu2btJRfOnZH6KagNV1kYgEHe49R0s
         2dLIkI5hllGdjAAVak2PMuTBcJl4B29nsLjogyZzqk04+aO5mVHOQDtB5pKz+8zlDkyw
         yjCvezdtKUd2DvZDxJgWhtbVWWPs5qFTq3cy3DqL9fA/YWveSzehj4w/4xP53O5bFKZZ
         CandeMD3gqnDTY5MWnv6Uhl7QWKwzKHt804Ll4sh2cw4FUP5Cs2ZghqJje12COR4CNCy
         No/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250285; x=1742855085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jy9e+p5Gp5xwwCIHcn/ZqBEC5y0Nu6I8DbyYonANL8=;
        b=Ps96agmSeZO6TGjwPacGA+0Y7IVRHN+fcgtdDCodYRiyU8QsPGVCIc419Gzj5WcOvi
         +65ydBlQtLaN/HFIXHMuTiKf0fXzmt+SjWCBfok2+P/Dd3VhklQ3CcC8F8ZMvuZwWrf3
         bt3xpfpFhyt4R3++bbo5U9RqJX5uJ/SoDia8LzPLzpvAgIumVZNyfUe+e9rnHfrYkwO4
         LPMRpJ4+0am91YCTaFIpI9f/vtIukBQiqPqbKYURduT48HpGDN4kAswseW8Bq10/xe4m
         duyhACHB2nvK2IzJzMl+eF5QGeNYN+BrYEL31Jb4FlsXFJ7PuLrF3UhghpKVG/gQj9Ju
         Ignw==
X-Gm-Message-State: AOJu0YyE0S2ep209ylMyUBRk/lbCfYWcePHYSzn+JFk0tMkxEFGeQPnF
	VZpcbti5BFiQlNYeOQlH4cgYyv4PhvTLU7r3c1FKXZC6BVEw8YKJ40AqRqE6BpWKcGDwSsxQKX7
	9sj4=
X-Gm-Gg: ASbGnctlfAfktFnU9UDW6yp/1/n6Nu6/MkxH1WoF+9f7ICmScIwY20O8StqXJnGuAc9
	4FcNpo75oZI/Qzk9t8BYt6WTGTtDAT0JUdIzs/BGZhXky6U2z337nxhalSyLlsaxCoIOlvzk+qU
	dB6Caj1//9/d6T1FvOttewz2lCQdXd3TsyFjvyODyKyCKmNQNvYlcwDPS3zisvyjoduLHx0Agpn
	Ix+g7REt3xBSFldnUj/C1NGCIGnnXZPbBzhZCeyYbFalNDfB8OOX7XA08A0o9C5k7rhSUJ/okX7
	WgoIBvM34aSYQJJwgPWpZAOpwZg7qVw3zurFaYZwchpIMHZerGhahl/dxwVU1Qyl02aQ832Z6tO
	MoYcs8vOGaxeYAbqXu6HcsVMRAT8=
X-Google-Smtp-Source: AGHT+IEplrawv5z8AhredOrXRVgaQvrL5C1EN+wctqInUTdNfKrDSE7Zl3kXueqtxsvTcgCoh+OtyA==
X-Received: by 2002:a05:620a:179e:b0:7c5:6140:734f with SMTP id af79cd13be357-7c57c7d2912mr1939337485a.18.1742250285036;
        Mon, 17 Mar 2025 15:24:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c5201fsm638575685a.23.2025.03.17.15.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:24:44 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:24:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 4/4] refspec: replace `refspec_item_init()` with fetch/push
 variants
Message-ID: <95783265fdfaf09f39bf3a02b4b2877d3cd88cb7.1742250259.git.me@ttaylorr.com>
References: <xmqq5xkdrrhs.fsf@gitster.g>
 <cover.1742250259.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742250259.git.me@ttaylorr.com>

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
2.49.0.rc2.13.g95783265fd
