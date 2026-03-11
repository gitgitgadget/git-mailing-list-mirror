Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89008253F05
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235255; cv=none; b=hC1OnvBB83a3DZxy4nTjIz/oIVTrYQMPh6sf4MwKUELGIJx//D/JsM4o1DKF8wN5pOXziawQPKyYHB/AHv4lyQm5tAIGc63GRXgzEp8u1sTAfNHsORo063ei+ihN8jmd4Ki3xSGhSk0RuynMqmmsPpneUUXiE6+cinH4k7PQ03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235255; c=relaxed/simple;
	bh=CETegSIWedxDvSufYV/xmKOkHRdEJ+GG12RdAwqwLJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SI1D4P6nI1DEmqlGZFoGQZ8t6cIhhhd5Iur2atwps6qGl2gqTh2+ezefVGcBG8aYjb6oYKafMw5au/tnmlpdFm4NKfTo3ucl2sp9d4HPiyiUlbcoVpR1lR+/Av5xn7L3Fc3DXRFfalxG2IooJrM7f50Tf3ASa2PWgpstII81Hi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQ2B4Z2v; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ2B4Z2v"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so5072875a12.3
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 06:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773235253; x=1773840053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tf1XLGXmHn++GvuWKpbSfj5dFDbnUIPcRm7gM4XH+8k=;
        b=BQ2B4Z2vY3s4EXxeMRECt3gcpNBvTT2prXjH9rQbEv41Ddze+CjbykG1ogK7iYiU19
         ZClrfCG4Nso5RIylJfGzLRIY6j5sSa9BPNCE9eLyOprKOtidhPUZVOw3wGKUyXvFy1n2
         /qwWnt0piR6E10vm6boQItUdUBekHKXbmWK3LsdExTF0IthKk1kfYYp6cXiBD8ah9OvQ
         8uKIvJzbGlpF8e61pyq5lyk6yySO+6EaKAxgVs2SzMQDKoUs+EkPKTip7Ra9mfHnj00N
         wvyJSSqCgxD32oVU8wGHDM793VxHyK+dwCtuRPF95NXRd18UdmnKsrkdwUQdZ7d6l06W
         mxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235253; x=1773840053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tf1XLGXmHn++GvuWKpbSfj5dFDbnUIPcRm7gM4XH+8k=;
        b=nPK4t2+Au7+imW3f72E3o9zY5+pfC/ocMhbaLJXF4kruqtDMF6WuFZujEHv0qDpPtS
         H35qlQ0POA6HhB8u3f86XmO1OXUIk4EWrk/iZYE7uEG9Hnfoe/2yPbxV90McwPz6crgM
         ejMvUbmdEdse7XW3brnXvZHKdHmNhpSoAOefTWOI04GJ8dz0GypA6qYi8E4/fjF9UT71
         uVJT5fz/bK3u3CiPV6jwzL+TuWOVDqep6xSWdOJw0CgYoVaBynpb1GLjaoUpPTNDsn7M
         1oh4YFKs7iTYqNGBqthrKR6Otsx9r12GSgxngBfhLk9k9xvmJrqNsnIMjcKkGrEvEitq
         0org==
X-Gm-Message-State: AOJu0YzA8c1I+e2EK3J6Rkw/CD5fjih4P5RUkzZE5d8tbxh2vo2pFJB3
	QccBCxtWzenSoG4Iev8lLvIRkwhpPx8ZWrJ9ZODFO2Iz/TWtJ+bg5cKHo1kqyw==
X-Gm-Gg: ATEYQzzx67PRJCk641qhMjmvGMGcGp2Uwrdfx2OYQcebRitJeA5/nouJdPelwi+BZDS
	h5hNrB3tmZKokpdJZJMdJtMf4rND/NHsYpHy3LV5O62/wac0k/OcNkTK26RrKT0v+S8OuiqqaaX
	zxABGuVKl9u2/tnPHqJ/pRdIGXWYAmVp+fCzT2xN6QJQMPCuBxQVlJKDq0XyuJv7mOZEf0esbJT
	sJ352AusFWsAx9jJgBqgrRDnjpx4BfPPwWDFft0XqCwEQ/rQ52m3xb5RiBNhK68NJ0+TKGDjvZJ
	wp+rdCa4UdkXCePjcxHrn7hkzQnhZuCwurg1GfubGxnK1QJWKv3fC+8VeGHe5vn5smepiZoCIyJ
	8uAOYKuCwud2d6hC/9rBs1tMpbgACsRC7cW2fsgIAn6rfpdOpdsrVXzgxisGxJEyAV0Vbgsw2/2
	VKm7/iXd8rqA0n3bRpDrs+lCoRS8Gb4SPKCdekL4/XGHAQ2o/MGoqbGuenZhjy3ZcXkw==
X-Received: by 2002:a05:6a21:9201:b0:366:14af:9bd1 with SMTP id adf61e73a8af0-398c61a3190mr2684664637.71.1773235253344;
        Wed, 11 Mar 2026 06:20:53 -0700 (PDT)
Received: from d.iiitdmj.ac.in ([14.139.241.214])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf92fe7sm2281441a12.21.2026.03.11.06.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 06:20:52 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH v2 0/2] avoid unnecessary strbuf_split*() and strbuf-by-value usage
Date: Wed, 11 Mar 2026 13:20:39 +0000
Message-ID: <20260311132041.12044-1-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio's "do not overuse strbuf_split*()" series calls out remaining
uses of strbuf_split*() as leftover bits for others to continue.
This series picks up two of them.

write_worktree_linking_files() takes two struct strbuf parameters by
value even though it only needs plain path strings.

parse_combine_filter() in list-objects-filter-options.c uses
strbuf_split_str() to split a combine: filter spec at '+'.  An array
of strbufs is unnecessary; walking the string directly with
strchrnul() is simpler and cleaner.

Changes since v1:

 * Patch 1/2: no changes.

 * Patch 2/2: Incorporate review feedback from Jeff King.
   - Use strchrnul() instead of strchr() so the loop needs no
     separate "found separator?" branch or strlen() fallback.
   - Drop the unnecessary (size_t) cast on the length expression.
   - Always exclude '+' from the sub-spec via end - p, removing the
     incorrect conditional stripping.  A trailing '+' now causes the
     while (*p) condition to fail cleanly on the next iteration
     rather than passing an empty string to the parser.
   - Remove the test that expected an error on trailing '+', since
     that behavior was incorrect.

Deveshi Dwivedi (2):
  worktree: do not pass strbuf by value
  list-objects-filter-options: avoid strbuf_split_str()

 builtin/worktree.c                  |  2 +-
 list-objects-filter-options.c       | 35 +++++++++++++----------------
 t/t6112-rev-list-filters-objects.sh |  4 ----
 worktree.c                          | 22 +++++++++---------
 worktree.h                          |  2 +-
 5 files changed, 28 insertions(+), 37 deletions(-)

Range-diff against v1:
1:  ee6b7d1e6a = 1:  ee6b7d1e6a worktree: do not pass strbuf by value
2:  386aed0adf ! 2:  c04ddaeb95 list-objects-filter-options: avoid strbuf_split_str()
    @@ Commit message
         parse_combine_subfilter(), only read the string content of the strbuf
         they receive.
     
    -    Walk the input string directly with strchr() to find each '+'.  Copy
    -    each sub-spec into a temporary buffer and strip the '+' only when
    -    another sub-spec follows.  Change the helpers to take const char *
    -    instead of struct strbuf *.
    +    Walk the input string directly with strchrnul() to find each '+'.
    +    strchrnul() returns a pointer to the terminating '\0' when the
    +    delimiter is not found, so no separate "found separator?" branch is
    +    needed.  Copy each sub-spec into a temporary buffer using end - p,
    +    which naturally excludes the '+', so the separator is always stripped
    +    cleanly.  A trailing '+' causes the outer while (*p) test to fail on
    +    the next iteration rather than passing an empty string to the parser.
    +    Change the helpers to take const char * instead of struct strbuf *.
    +
    +    The test that expected an error on a trailing '+' is removed, since
    +    that behavior was incorrect.
     
         Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
     
    @@ list-objects-filter-options.c: static int parse_combine_filter(
     -		result = parse_combine_subfilter(
     -			filter_options, subspecs[sub], errbuf);
     +	while (*p && !result) {
    -+		const char *sep = strchr(p, '+');
    -+		size_t len = sep ? (size_t)(sep - p + 1) : strlen(p);
    -+		char *sub = xmemdupz(p, len);
    -+
    -+		/* strip '+' separator, but only when more sub-specs follow */
    -+		if (sep && *(sep + 1))
    -+			sub[len - 1] = '\0';
    ++		const char *end = strchrnul(p, '+');
    ++		char *sub = xmemdupz(p, end - p);
     +
     +		result = parse_combine_subfilter(filter_options, sub, errbuf);
     +		free(sub);
    -+		if (!sep)
    ++		if (!*end)
     +			break;
    -+		p = sep + 1;
    ++		p = end + 1;
      	}
      
      	filter_options->choice = LOFC_COMBINE;
    @@ list-objects-filter-options.c: static int parse_combine_filter(
      	if (result)
      		list_objects_filter_release(filter_options);
      	return result;
    +
    + ## t/t6112-rev-list-filters-objects.sh ##
    +@@ t/t6112-rev-list-filters-objects.sh: test_expect_success 'combine:... with non-encoded reserved chars' '
    + 		"must escape char in sub-filter-spec: .\~."
    + '
    + 
    +-test_expect_success 'validate err msg for "combine:<valid-filter>+"' '
    +-	expect_invalid_filter_spec combine:tree:2+ "expected .tree:<depth>."
    +-'
    +-
    + test_expect_success 'combine:... with edge-case hex digits: Ff Aa 0 9' '
    + 	git -C r3 rev-list --objects --filter="combine:tree:2+bl%6Fb:n%6fne" \
    + 		HEAD >actual &&
-- 
2.52.0.230.gd8af7cadaa

