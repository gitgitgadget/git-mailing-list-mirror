Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C391B3469EB
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723634; cv=none; b=joC1L7jYZQoBKMB2ROeYdebx7pxXfsDXNRRdGr6peRGprVLCvzGOqhe1SnLSjkrM5apZNAdpD1WOdh63+rAFs/WyeTwR3I5MXQ2GiMUJ2l2JoBrGGILMnjl5cNCicRO+lS4iVdjat2rjJ3Ibs6Zb9CWN9bLMsz1obH7azL6/Y5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723634; c=relaxed/simple;
	bh=2k7HhaIYOOs3BXh12x4/laVna60CmztFvFCcmQaKggU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hk044hntq+SqItvBnR2yrQrpenDMy/ovh8BB8KZE5XWFghjh3bHw6oU4NDaa+n/oFDylwYXN9NiazHZN6uHHQO9tlpqEGBXt9Q87+QMC2AOHrDW7wC/i7OxL/qdwKJdXLWnhYrbSaseHQMsLrmltAt2ctlHw6ZQki35zL0OEJdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fvc8RtYr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fvc8RtYr"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b71397df721so351337366b.1
        for <git@vger.kernel.org>; Fri, 21 Nov 2025 03:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723631; x=1764328431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnaAKwk7x7oDqcRXpULbV9nX0QVS5pHyYgmJtTViigs=;
        b=Fvc8RtYrYSo96a4hOp2EO3POcqXBdPeBlGrPxj2xEWAnmYIGCBiNzD3Y2i6J14Bch6
         WsbLVWO9klrfw6D3FCa3NZgRXNB1jUND+Ppu+4cnAh2HC317K/fTUtUqW96Bxlm0XgXV
         d9BL2956pdJusUuBs+kjLOh2IkM+wfClTRmL3r2zdKy674YlW5xygzB9hBZahqPPHlDB
         +AfwoULzXHxrzkm2iciTOfdjCjxie3gPXidlINqzbTcURpqOfeFueXOXrWdnrgagt8fy
         l3+7SHPsARl7LzJyo5RdhGNtUM8U07FcCOFm1BJBBWcr7STlhyNr6UcyXh21cR6TeGlN
         ktxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723631; x=1764328431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UnaAKwk7x7oDqcRXpULbV9nX0QVS5pHyYgmJtTViigs=;
        b=JJY6JzosC+cy9MQhNodiHwxRAcIJcNj2VO1Q9W7K3umQ3ZEt5hXDT2UUh81KeZEHJ5
         ZFXeWvlhyo5oyaDymOAT0jSq4/OepHvBp3766KsP9RotRVqgXbsJyO14DlIcwU4QPUgl
         hcg5uR/Mw2eh2h/vAtoJaBEu1LmUbiHqzP9nvVcGkW4WEn5L++bXSYbDwhyd5MCriq9P
         qwtK8s2E55xhuHVZFNwqHl2xMzJOSLO6/L6/WWpGldoS1m+jSgybxl7kllSA1bTNvTcW
         dkzcCHsR198ktAR2Rlh5fMZ6h8H5gRfUNb76IjeTY7jQb17l5BJg8Yi4l0/i4Iz/nhp0
         gtmQ==
X-Gm-Message-State: AOJu0YxMfBR6v7+7h1gHQAttpFGgRcj3Ty5FIZH56isT1x26kev5+mKo
	QHCbD+8auto2HsQ3Ss9ktSckOcY1LP1hTE5DB8ZQXy9pyy0qI740mq7AeVLmPQ==
X-Gm-Gg: ASbGncsanhydLtNe1SEiU1JhlwLFff6DG+Mf3Gj3QYHHjJJ0obOtVQEqt3J/fC2L9gM
	8jLujQhnmaCnnjMTPAu22yC2tpDJVGFZMwRyFRXi6CbZk7FGcQ5/UMvCZB83Vdh9/OZ3BlVuOUd
	5DFXENMEMQvWjPVk1FH7H+OodIJITJ+6xjCs0Vb2hPZbT0FXTYxWusr8umDwE9+iKHgVGTwF7+2
	V9jClQLyGUZ7ySdCQ3XBjpSsymwYDL4M+AnWUrkd+y+2O+Ai0WV4LapoSaAan+cAnbTHSnnh724
	7WNSVILjE8dxcF2MMgZVmuG3q1Q2SD3mdG9mWIAzP+rKw7BjToxvI/e/f3h5VSClwvwIj4bLcn8
	RqvabYriM+tFQCxVfhw3dkYRY2T5weePncIOrifkXs5gtlsMC5PgJpSivs0/LKzDRWX8LryFo04
	E/S5bjEfbyW8OtgqNDrlw=
X-Google-Smtp-Source: AGHT+IF77P51J0mm0QqxfvoB4a6THX9Im3kpE3UDBz6/zskglB4lOItF5EwIdivv29jPa1h8lGcJBw==
X-Received: by 2002:a17:907:9495:b0:b0e:d477:4972 with SMTP id a640c23a62f3a-b76715dcdcamr166662766b.25.1763723630747;
        Fri, 21 Nov 2025 03:13:50 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:be79:897c:7a92:76c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cf0435sm436206166b.4.2025.11.21.03.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:13:50 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 21 Nov 2025 12:13:46 +0100
Subject: [PATCH v8 2/3] fetch: fix non-conflicting tags not being committed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-fix-tags-not-fetching-v8-2-23b53a8a8334@gmail.com>
References: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
In-Reply-To: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com, sunshine@sunshineco.com, 
 David Bohman <debohman@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4724; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=2k7HhaIYOOs3BXh12x4/laVna60CmztFvFCcmQaKggU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkgSWuC3ncz93KT7JVtAUufQCO0/Pajamn/s
 cgFkJr0j0+OCIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpIElrAAoJED7VnySO
 Rox/vyQL/jp3Wg6xYOHYqUgUweBFwH+eiJ3t8kZZXDyalBWpo0M9hfDB2tHsuefubFDhOyq5tdq
 yIGWKW6qOCDZ6+tgiltb1zCxBcWDqplpIr9jqHm8nyKxdWDVL9ozV++ikuYsDFk3calAHlmz+31
 n2zJaBgXvI4e2sCNWUuicYeK6B5To1gA76maw8445piPwpsQAIFLewQUCuzZ+nweNj+ki+Fij6X
 n0Nt9l0bGirAqZX61+9dlQcU4Lut+TuENmJeh2dvdWmYgnUm2Hr1WIa5dvEgLv5R4LlMKmQeOQn
 dGeEhR+adw0P3MXyk+Rv6bnjr9uTwqkkXBiTfnhSTwKhZiwz+66XGeKRSGxYVUQ5OTBlZ2cOUzq
 YR55NK/1eCNSulfLrDzGzKvQAyn5E3YyORmtJJaCgOnCsT3CxGseA6OyZjbGaDa6Xjt2ou52u95
 Fl0Kt+kk2KiKX9P6muYkfEOoOB8V/Xm+sUPxs1rNGd1fg9MeJ5N+48chtcJUyBBCKrLjGLgkyu8
 ns=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The commit 0e358de64a (fetch: use batched reference updates, 2025-05-19)
updated the 'git-fetch(1)' command to use batched updates. This batches
updates to gain performance improvements. When fetching references, each
update is added to the transaction. Finally, when committing, individual
updates are allowed to fail with reason, while the transaction itself
succeeds.

One scenario which was missed here, was fetching tags. When fetching
conflicting tags, the `fetch_and_consume_refs()` function returns '1',
which skipped committing the transaction and directly jumped to the
cleanup section. This mean that no updates were applied. This also
extends to backfilling tags which is done when fetching specific
refspecs which contains tags in their history.

Fix this by committing the transaction when we have an error code and
not using an atomic transaction. This ensures other references are
applied even when some updates fail.

The cleanup section is reached with `retcode` set in several scenarios:

   - `truncate_fetch_head()`, `open_fetch_head()` and `prune_refs()` set
     `retcode` before the transaction is created, so no commit is
     attempted.

   - `fetch_and_consume_refs()` and `backfill_tags()` are the primary
     cases this fix targets, both setting a positive `retcode` to
     trigger the committing of the transaction.

This simplifies error handling and ensures future modifications to
`do_fetch()` don't need special handling for batched updates.

Add tests to check for this regression. While here, add a missing
cleanup from previous test.

Reported-by: David Bohman <debohman@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c  |  8 ++++++++
 t/t5510-fetch.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f90179040b..b19fa8e966 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1957,6 +1957,14 @@ static int do_fetch(struct transport *transport,
 	}
 
 cleanup:
+	/*
+	 * When using batched updates, we want to commit the non-rejected
+	 * updates and also handle the rejections.
+	 */
+	if (retcode && !atomic_fetch && transaction)
+		commit_ref_transaction(&transaction, false,
+				       transport->remote->name, &err);
+
 	if (retcode) {
 		if (err.len) {
 			error("%s", err.buf);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index b7059cccaa..4b113d7c27 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1552,6 +1552,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensiti
 '
 
 test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with lock' '
+	test_when_finished rm -rf base repo &&
 	(
 		git init --ref-format=reftable base &&
 		cd base &&
@@ -1577,6 +1578,67 @@ test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with loc
 	)
 '
 
+test_expect_success 'fetch --tags fetches existing tags' '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	git -C base commit --allow-empty -m "empty-commit" &&
+
+	git clone --bare base repo &&
+
+	git -C base tag tag-1 &&
+	git -C repo for-each-ref >out &&
+	test_grep ! "tag-1" out &&
+	git -C repo fetch --tags &&
+	git -C repo for-each-ref >out &&
+	test_grep "tag-1" out
+'
+
+test_expect_success 'fetch --tags fetches non-conflicting tags' '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	git -C base commit --allow-empty -m "empty-commit" &&
+	git -C base tag tag-1 &&
+
+	git clone --bare base repo &&
+
+	git -C base tag tag-2 &&
+	git -C repo for-each-ref >out &&
+	test_grep ! "tag-2" out &&
+
+	git -C base commit --allow-empty -m "second empty-commit" &&
+	git -C base tag -f tag-1 &&
+
+	test_must_fail git -C repo fetch --tags 2>out &&
+	test_grep "tag-1  (would clobber existing tag)" out &&
+	git -C repo for-each-ref >out &&
+	test_grep "tag-2" out
+'
+
+test_expect_success "backfill tags when providing a refspec" '
+	test_when_finished rm -rf source target &&
+
+	git init source &&
+	git -C source commit --allow-empty --message common &&
+	git clone file://"$(pwd)"/source target &&
+	(
+	    cd source &&
+	    test_commit history &&
+	    test_commit fetch-me
+	) &&
+
+	# The "history" tag is backfilled eventhough we requested
+	# to only fetch HEAD
+	git -C target fetch origin HEAD:branch &&
+	git -C target tag -l >actual &&
+	cat >expect <<-\EOF &&
+	fetch-me
+	history
+	EOF
+	test_cmp expect actual
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.51.2

