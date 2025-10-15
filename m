Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0630FF02
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567351; cv=none; b=s37ExBRVhaxehU3/7LrviHVJp6EkgqK5RN2AbIxZQwfmPQ/mCVMLMI7z54keCWwZrMfPHpHyjM+gJFLHrlwQ5w0Fuy7MKLj3gnkvB0FqkU6Brhre+x4WuKzHq1k9VveQ903VfD1DUFgv+PSwt7XjdyUEUWAQwJQBTTlr8vetUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567351; c=relaxed/simple;
	bh=CplDhxwVfQ1SqQ2tlN8bAuNPpFjW94XBwnJS87RiR4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1wDcwzKw2YduSlvD4K0byG2DNGJjmWsxrg8AZuOqY2lF1S+bi1y+AITgAajdjFUZO+UMeOT1zZVWd/LyU5JP+JHHytt6q0Y5i91q29f78/7tU37D2HoKJd9oDeUEXjYpkeYtbjJxhAqGXz6NaoS9V+672kblYkbHkeIpCPXUo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=oNFQgsXO; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="oNFQgsXO"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78142734156so938697b3.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567349; x=1761172149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/YdnMXnT5CGPC0Ym/WqZlrIV2CtvLqTld8ZeiorrJtE=;
        b=oNFQgsXOImtIgGeaQYw+SPEmhZia/8r/318ofUO0tzzrjQqF5Wotmt4/e3iTScejPw
         B+o5vEoxMjPaihYmypszD6ToeSc2knkMRu5UGXjxZFhv40P+Q+j8p6O9PkofcqaMTXEQ
         /AN2Tt+7TLR7z5DgbjkV8aSOKDZSAMm79CXB5enrkHEnnpjbuef6IkLlobi5KW8FM/Ux
         MfgtbXba75HgzLt2L+jy6toACzVYWrFGd/OMOBmQfvEfh4apnNMk9ythy2/CF/dUonaU
         gmZaU4sDtal/dBIl3bnGSsLwl12m0CZsAf0d6GbHfm5dmWC4h0lpKGvXWEIqSjwo+KKe
         CzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567349; x=1761172149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YdnMXnT5CGPC0Ym/WqZlrIV2CtvLqTld8ZeiorrJtE=;
        b=IqR5BdW9Dy7tLSz6lYy7bwqvT1Onw+pvpy+KjbkjZDe1zYXRFazUqdLM00sbZLdwG5
         7yBbBjE+wMGtaukCI9uRg/zdro2AxSbC4LuTPijtGONY0l+S/SUYvPnmSmBEC8H7lICm
         egohGD5JwBdYJyVrmQUXD9t1SLQ/drn7GFhQCxyIyuolmA9jLN/WOhiOc1qcHvjJiNad
         wRaYoR7Kep3KFz40LefychObeognreISobZc592xsiePgWqwBPzMw3c25esiQjAleCjl
         hcAddyZ23iPuvyilXDn2LZoPzVK3Bu1xnMMw5yJpNpVFLVfBX44DfdFe0Jno7aG0GsEF
         puBQ==
X-Gm-Message-State: AOJu0YwwhIe/DjPJPZXbob9+gvVOlXpCdRJTsfT7WPJiArfNtJCMyhcC
	dMVtQQzfP9eSxEPm2l898Ux6A/kIp0js0Wj6hbYYyMWGlkqpyA4uZXmbhDb0FzWMl7aCp3Dq18l
	56JE2pRy4QA==
X-Gm-Gg: ASbGncvZstl9PayaSwe2kj+YP5bVa86trFXzNYXR9exo18TMthrTm3Atnb6QdyIKYrx
	2GF0rM8OPdvzjxDEJvNDpQirA67bM4ADyKr6q4BqEvXtPOiGTQ/nMPjiP+dMe+VW2/UXjcw5Yw5
	NVp24fO70RanOn02wa3rSsT8hUg6oDaFR5EEx72lTDtW7+jL+7tNUx0gbaiY/IXdM79KUhYI+td
	ESET4V7LxkZsXkw3rs0RwgPFt2OYE1WfomNLLsdYmHl7oo3PwG1EpupzrEIiiR7UaGIKgjOPhrh
	m10DhKnnoxYDPRHwOsv2Dqb56gDM/MyGpWYpBm0Wd/H0XHdTDldLnkC3MI7uVOKLQnhn/YLXfWz
	fqQUHyUaE3ado6075dSPInTAZsDWhnWKiECSmLh33sV535GY65mwBhw8vMNpcW6EMQFmoPfGXyS
	q4XuyAFhZvP92K8kMyktFEdL2KyfbPwDDacoBc30z5SyN28B1ykikpNkIxfn08o82VBKwBYPu6i
	ii31L0AfFC2CDOjpw==
X-Google-Smtp-Source: AGHT+IHLZYuRcEizAm36eXUznxfEC54UXSyMhNYh6E1A2Hocwy5Xs6WI55Rr2iOyMmsbySFVumYOsg==
X-Received: by 2002:a05:690c:368e:b0:781:7c2d:7629 with SMTP id 00721157ae682-7817c2d91fcmr23971707b3.46.1760567349318;
        Wed, 15 Oct 2025 15:29:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78292c12895sm2594807b3.33.2025.10.15.15.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:09 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:29:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 37/49] builtin/repack.c: pass `repack_write_midx_opts` to
 `midx_included_packs`
Message-ID: <668f4edc9e935f468f5630c74c7d4744a30b476d.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

Instead of passing individual parameters (in this case, "existing",
"names", and "geometry") to `midx_included_packs()`, pass a pointer to a
`repack_write_midx_opts` structure instead.

Besides reducing the number of parameters necessary to call the
`midx_included_packs` function, this refactoring sets us up nicely to
inline the call to `midx_included_packs()` into
`write_midx_included_packs()`, thus making the caller (in this case,
`cmd_repack()`) oblivious to the set of packs being written into the
MIDX.

In order to do this, `repack_write_midx_opts` has to keep track of the
set of existing packs, so add an additional field to point to that set.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 271c869268..a518a2b2f3 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -108,6 +108,7 @@ static int repack_config(const char *var, const char *value,
 }
 
 struct repack_write_midx_opts {
+	struct existing_packs *existing;
 	struct string_list *include;
 	struct pack_geometry *geometry;
 	struct string_list *names;
@@ -188,10 +189,11 @@ static int midx_has_unknown_packs(struct string_list *include,
 }
 
 static void midx_included_packs(struct string_list *include,
-				struct existing_packs *existing,
-				struct string_list *names,
-				struct pack_geometry *geometry)
+				struct repack_write_midx_opts *opts)
 {
+	struct existing_packs *existing = opts->existing;
+	struct pack_geometry *geometry = opts->geometry;
+	struct string_list *names = opts->names;
 	struct string_list_item *item;
 	struct strbuf buf = STRBUF_INIT;
 
@@ -242,7 +244,7 @@ static void midx_included_packs(struct string_list *include,
 		}
 	}
 
-	if (midx_must_contain_cruft ||
+	if (opts->midx_must_contain_cruft ||
 	    midx_has_unknown_packs(include, geometry, existing)) {
 		/*
 		 * If there are one or more unknown pack(s) present (see
@@ -994,6 +996,7 @@ int cmd_repack(int argc,
 	if (write_midx) {
 		struct string_list include = STRING_LIST_INIT_DUP;
 		struct repack_write_midx_opts opts = {
+			.existing = &existing,
 			.include = &include,
 			.geometry = &geometry,
 			.names = &names,
@@ -1003,7 +1006,7 @@ int cmd_repack(int argc,
 			.write_bitmaps = write_bitmaps > 0,
 			.midx_must_contain_cruft = midx_must_contain_cruft
 		};
-		midx_included_packs(&include, &existing, &names, &geometry);
+		midx_included_packs(&include, &opts);
 
 		ret = write_midx_included_packs(&opts);
 
-- 
2.51.0.540.ga7423965ad8

