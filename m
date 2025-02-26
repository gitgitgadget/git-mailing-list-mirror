Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8E384A2B
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577827; cv=none; b=GE/qPrNMheZbvpGppGuzJcWF/u9/K6XHhThJOdET2rcRA05IVNAZqGGdo9lhRoLxpIeni+rXNPWSwUo7+/gDZConF2t05nDPbekhLcvykpngUh6elq6YI6Tj98TbMbo++EjJ5Sfq1v6wYEosPxWf5w+XcSJUMgfwCwk3zXQUHsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577827; c=relaxed/simple;
	bh=oFTBlsy9IjXJjInJlm+ScXwZ/9yKwBDQlYoGLLEiTdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3Ec1zMxL32HYPV14NJ0HQTwMV7MEEgj70f5rxuB23tqUwwRLczrUaM1wluftiqJDGGHFQPRUKawM/fD7HOAmS2/Tc0E/lyY6Eujxtp3vNbd+WcCvRDieMrXmhZZQpQI6cX5qefyCckP8qKosNirAoEnb8ca41ogRhtfgi4vlMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgJonDfI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgJonDfI"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22185cddbffso15320285ad.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 05:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740577824; x=1741182624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LfOeXxaMjNG0QOGpu6hUW3RzudpGpSVGY8SDb+OpIVA=;
        b=LgJonDfI/dH9p3M/wBeu1bqhmytZYYKJvsxQoCWeo9V2gZfZZ2U66c2xNljyj83gm1
         LetOWU0dHJhTBai4eSpYWfVODmkLXQEYS7QlHqcX0oNIyBrnvORx0MGNMPk/VdgITkgB
         UQDe9G10Eav116FYcVG0JnQM5ZXKFrkBusEMmXGlG+rR2ehgXQW7FHdzH4QZfTUKO+r8
         KE9jzrofadX5WiwSZIYGX1rq1aRcgJua1tjDYf9UFIy8UgGmzZbj3x1nlRFkE5S/70ju
         1cEZFEGO6LNyeWgUGuVuYka6YPNVtdlksNrmAc6KuoeNi8qbl0fV/7SHQxAahnTFi9LX
         2mWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740577824; x=1741182624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfOeXxaMjNG0QOGpu6hUW3RzudpGpSVGY8SDb+OpIVA=;
        b=f2t5rigHjJyo5qUu08XuRQ5gwtvxQB/vmFf4JkQq7WNJhSInPit98MnBwOR5yWmRLT
         e5HKntA7VbpGVdQbBmHT/KDbvPm4egAFabLTVNrBmJ5Lsr5FUKJxRtucEFaIUqvoyS6X
         Rowui2bTsjP2ZP6v8tQ7QXBMDqifh3e0ctd3wdkntIdHXvUzVEN/kSumiOgjVIcB+O1Z
         Mj9ynGRsyCzYEOsKZzIOWxkELwNCdM+xNb9hMC3iN4Ps3P7/a0vTFIeq9UD31Zv6vrwv
         K8J0ErL31H1RC7oT0g++R+Ks26JDLX5SRzYDvZb9sk3VTE+vFJ+qM3SfOziltsUn6Aw/
         LwhA==
X-Gm-Message-State: AOJu0YyVtrVZNDNS6YAs5x8REs00THauWvl7aXSbtlx06lpUrGcFBka4
	EC4/aH4Rc7FlNaWJpSBG2/hIuw1JbV9BjVEZUkptqfE53O4CQYdUatfCzw==
X-Gm-Gg: ASbGncvZ5tuoRtFh6CsXCaDDalKtDmdXCkKSlar1+tBea8FdJtQAdmjzUISYrzg0ybK
	/h4zdZBuFQHlu372CYjIYeeXJOcP/Bl5DOWtpCW5vRyup6Q6fhRmgi1SodCI3v9npbHQUS7prFS
	iF7dNwEZgMrB/E7jh/y+h1l3dM5yJnFc3q2MRYVLH2Vqp4V1EZ1TUv3pEtvm67DI888s2cv/HYk
	wG7f4Fj110rbPr3knsUK6Imc5mqzDfPzpukftuRfznmoAjxMjjnzwtzkeQTvnoJc24YG7gOC7s/
	c3tA2PzPcwVFcBZrrxkeDg==
X-Google-Smtp-Source: AGHT+IHFp3sfrZRUj7LL3WWt7hCmSEQZZS2QaErMBXlknm/DNQNNrRTnoxcXa+gFVxaUt+J1ACALRg==
X-Received: by 2002:a05:6a00:8219:b0:72a:83ec:b1cb with SMTP id d2e1a72fcca58-73413f844bamr36715419b3a.0.1740577824435;
        Wed, 26 Feb 2025 05:50:24 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a81ed1bsm3525371b3a.142.2025.02.26.05.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:50:23 -0800 (PST)
Date: Wed, 26 Feb 2025 21:50:32 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 7/9] packed-backend: add "packed-refs" entry consistency
 check
Message-ID: <Z78cKDRtgYykccPH@ArchLinux>
References: <Z78bmBSrDR20GY6g@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78bmBSrDR20GY6g@ArchLinux>

"packed-backend.c::next_record" will parse the ref entry to check the
consistency. This function has already checked the following things:

1. Parse the main line of the ref entry to inspect whether the oid is
   not correct. Then, check whether the next character is oid. Then
   check the refname.
2. If the next line starts with '^', it would continue to parse the
   peeled oid and check whether the last character is '\n'.

As we decide to implement the ref consistency check for "packed-refs",
let's port these two checks and update the test to exercise the code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.adoc |   3 +
 fsck.h                         |   1 +
 refs/packed-backend.c          | 122 ++++++++++++++++++++++++++++++++-
 t/t0602-reffiles-fsck.sh       |  44 ++++++++++++
 4 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 11906f90fd..02a7bf0503 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -16,6 +16,9 @@
 `badObjectSha1`::
 	(ERROR) An object has a bad sha1.
 
+`badPackedRefEntry`::
+	(ERROR) The "packed-refs" file contains an invalid entry.
+
 `badPackedRefHeader`::
 	(ERROR) The "packed-refs" file contains an invalid
 	header.
diff --git a/fsck.h b/fsck.h
index 67e3c97bc0..14d70f6653 100644
--- a/fsck.h
+++ b/fsck.h
@@ -30,6 +30,7 @@ enum fsck_msg_type {
 	FUNC(BAD_EMAIL, ERROR) \
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
+	FUNC(BAD_PACKED_REF_ENTRY, ERROR) \
 	FUNC(BAD_PACKED_REF_HEADER, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
 	FUNC(BAD_REF_CONTENT, ERROR) \
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 6e7d08c565..8c410fca77 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1812,9 +1812,114 @@ static int packed_fsck_ref_header(struct fsck_options *o,
 	return 0;
 }
 
+static int packed_fsck_ref_peeled_line(struct fsck_options *o,
+				       struct ref_store *ref_store,
+				       unsigned long line_number,
+				       const char *start, const char *eol)
+{
+	struct strbuf packed_entry = STRBUF_INIT;
+	struct fsck_ref_report report = { 0 };
+	struct object_id peeled;
+	const char *p;
+	int ret = 0;
+
+	/*
+	 * Skip the '^' and parse the peeled oid.
+	 */
+	start++;
+	if (parse_oid_hex_algop(start, &peeled, &p, ref_store->repo->hash_algo)) {
+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+		report.path = packed_entry.buf;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				      "'%.*s' has invalid peeled oid",
+				      (int)(eol - start), start);
+		goto cleanup;
+	}
+
+	if (p != eol) {
+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+		report.path = packed_entry.buf;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				      "has trailing garbage after peeled oid '%.*s'",
+				      (int)(eol - p), p);
+		goto cleanup;
+	}
+
+cleanup:
+	strbuf_release(&packed_entry);
+	return ret;
+}
+
+static int packed_fsck_ref_main_line(struct fsck_options *o,
+				     struct ref_store *ref_store,
+				     unsigned long line_number,
+				     struct strbuf *refname,
+				     const char *start, const char *eol)
+{
+	struct strbuf packed_entry = STRBUF_INIT;
+	struct fsck_ref_report report = { 0 };
+	struct object_id oid;
+	const char *p;
+	int ret = 0;
+
+	if (parse_oid_hex_algop(start, &oid, &p, ref_store->repo->hash_algo)) {
+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+		report.path = packed_entry.buf;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				      "'%.*s' has invalid oid",
+				      (int)(eol - start), start);
+		goto cleanup;
+	}
+
+	if (p == eol || !isspace(*p)) {
+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+		report.path = packed_entry.buf;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				      "has no space after oid '%s' but with '%.*s'",
+				      oid_to_hex(&oid), (int)(eol - p), p);
+		goto cleanup;
+	}
+
+	p++;
+	strbuf_reset(refname);
+	strbuf_add(refname, p, eol - p);
+	if (refname_contains_nul(refname)) {
+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+		report.path = packed_entry.buf;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				      "refname '%s' contains NULL binaries",
+				      refname->buf);
+	}
+
+	if (check_refname_format(refname->buf, 0)) {
+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+		report.path = packed_entry.buf;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_REF_NAME,
+				      "has bad refname '%s'", refname->buf);
+	}
+
+cleanup:
+	strbuf_release(&packed_entry);
+	return ret;
+}
+
 static int packed_fsck_ref_content(struct fsck_options *o,
+				   struct ref_store *ref_store,
 				   const char *start, const char *eof)
 {
+	struct strbuf refname = STRBUF_INIT;
 	unsigned long line_number = 1;
 	const char *eol;
 	int ret = 0;
@@ -1827,6 +1932,21 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 		line_number++;
 	}
 
+	while (start < eof) {
+		ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
+		ret |= packed_fsck_ref_main_line(o, ref_store, line_number, &refname, start, eol);
+		start = eol + 1;
+		line_number++;
+		if (start < eof && *start == '^') {
+			ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
+			ret |= packed_fsck_ref_peeled_line(o, ref_store, line_number,
+							   start, eol);
+			start = eol + 1;
+			line_number++;
+		}
+	}
+
+	strbuf_release(&refname);
 	return ret;
 }
 
@@ -1884,7 +2004,7 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	ret = packed_fsck_ref_content(o, packed_ref_content.buf,
+	ret = packed_fsck_ref_content(o, ref_store, packed_ref_content.buf,
 				      packed_ref_content.buf + packed_ref_content.len);
 
 cleanup:
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 74d876984d..a88c792ce1 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -699,4 +699,48 @@ test_expect_success 'packed-refs unknown traits should not be reported' '
 	)
 '
 
+test_expect_success 'packed-refs content should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+		git branch branch-1 &&
+		git branch branch-2 &&
+		git tag -a annotated-tag-1 -m tag-1 &&
+		git tag -a annotated-tag-2 -m tag-2 &&
+
+		branch_1_oid=$(git rev-parse branch-1) &&
+		branch_2_oid=$(git rev-parse branch-2) &&
+		tag_1_oid=$(git rev-parse annotated-tag-1) &&
+		tag_2_oid=$(git rev-parse annotated-tag-2) &&
+		tag_1_peeled_oid=$(git rev-parse annotated-tag-1^{}) &&
+		tag_2_peeled_oid=$(git rev-parse annotated-tag-2^{}) &&
+		short_oid=$(printf "%s" $tag_1_peeled_oid | cut -c 1-4) &&
+
+		cat >.git/packed-refs <<-EOF &&
+		# pack-refs with: peeled fully-peeled sorted
+		$short_oid refs/heads/branch-1
+		${branch_1_oid}x
+		$branch_2_oid   refs/heads/bad-branch
+		$branch_2_oid refs/heads/branch.
+		$tag_1_oid refs/tags/annotated-tag-3
+		^$short_oid
+		$tag_2_oid refs/tags/annotated-tag-4.
+		^$tag_2_peeled_oid garbage
+		EOF
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs line 2: badPackedRefEntry: '\''$short_oid refs/heads/branch-1'\'' has invalid oid
+		error: packed-refs line 3: badPackedRefEntry: has no space after oid '\''$branch_1_oid'\'' but with '\''x'\''
+		error: packed-refs line 4: badRefName: has bad refname '\''  refs/heads/bad-branch'\''
+		error: packed-refs line 5: badRefName: has bad refname '\''refs/heads/branch.'\''
+		error: packed-refs line 7: badPackedRefEntry: '\''$short_oid'\'' has invalid peeled oid
+		error: packed-refs line 8: badRefName: has bad refname '\''refs/tags/annotated-tag-4.'\''
+		error: packed-refs line 9: badPackedRefEntry: has trailing garbage after peeled oid '\'' garbage'\''
+		EOF
+		test_cmp expect err
+	)
+'
+
 test_done
-- 
2.48.1

