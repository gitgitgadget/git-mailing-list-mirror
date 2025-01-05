Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8313AD2C
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736085008; cv=none; b=e0Ak30NGox8x9f+XUButBpyPSdn3ALXASUY4fyyQerdkOLsZjI1B/trtbYyYzYuH0a4O+B8575M90RIq7PgZbTL/3C1KSXB9aZIvR8HxtK+8W4eN5ORJQaAUBAXgsLn+qaz40167WOfRRN7iuu6Ec+vPGqzEAVplHoQMUPBFS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736085008; c=relaxed/simple;
	bh=N3JZ9gZIy3ZYKhXHN5BwF0X0C+Uv0ODbUJ9UhSBHZk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FALRvKlY8s+sBKqdi/mldTgyHDo8PIiJSDiZok5zWjksXVehdm92Lbw9EmnPi+bhVoGrf97t0g/bh1fSRTz0yx9QCl6EoRciFZvy9t0ERy4bnbDd0iMwcKYVB16BF1Ah/q82gbq3xAdmBtr3DFgVGbpidagjuKWCOMAsT1a83SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im/+jnPm; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im/+jnPm"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso14281760a91.2
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 05:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736085004; x=1736689804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XrRLwEWQRzDCNpfcICQfK4NfVFOVApWxmXNVi2/Tn5A=;
        b=im/+jnPm45QW/pM4x8J6vdFqiqvK9euQt2L/v7wMx7z8kOFqDu4EhiG58eDT9RuapD
         5oyVyEOzAdCLprwGr7Ss+nrngrEC1w/7UQQmXNhWUz5O3I3M06b8en48e0k2mAwdph3p
         GqYqDRR1h/W5t4E8XFE8LOlv3g6Yd8Ydb9cPfwIxMX+HOyVCc8W03znk9VlFRuw3u5ad
         AdyzuzFhnGOuLFsaOZFlQHuGVupWD33rZXiYozacLlBwHJsrVYexPqs4IKTVWULRFLGJ
         3xpiFYpysuy8t24eHM/fP/7g4opvVWB7G0ksETUVQp1el5JCQS9NN74oBYib0KWZEI4e
         g6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736085004; x=1736689804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrRLwEWQRzDCNpfcICQfK4NfVFOVApWxmXNVi2/Tn5A=;
        b=u/Sradr/CDB6khcuWRdkpSa+GZgSoBkjdgButlDJJ+HNRHlwsIbT/7sSovbha6QxlE
         IO3PI0NA7w2q/vzlixOQVpAesejPatrZJTXVO07bfR6ErnPYmlpT0cGi/6G3WDKyZl3p
         YYCT8XLGxiAIW/r/S/3BU7X/LZwTqWNsgFLxMxPNUYmkWH/JDo7b3NtOlMCrlW4S8F5N
         lCFepfOQd7/bwac8BzgVvEHWgE0I7oAI8YsyD4HWZf7I+2dK9g/hZxeoMXZLcW235Cjx
         feK3Y1W9Y2+zNtt2d1Xn6u8njS84mf8U5apIupoq9sifwdZzSFMU9SNH/sxRLa+b/1GA
         nOkA==
X-Gm-Message-State: AOJu0YwHd7SfutrStenkBjEj/fh3f3tpm3+hOTlkgILN5yPsDNpy+XkK
	xgIku/ncBm9LBBmG4y5339Zg0W1nzlrbyyss878iKeTcux50y78eBhdSPw==
X-Gm-Gg: ASbGncuHxUnkyzSpYZ15bWt5bz/3XQMgcWASBbxqLeCx+zi+qHh94G8AfnniE6r28XS
	YP7rDc4Vp2sgoTiRew8bU12EqskFYgk15ELxbS5Z6yeQbWERDFnHd7/TbjjxiiueaZcq2R4YpTo
	i5UyTWDnqzv4gru30jFQ2IANpC1pXWiLf/TexpezeS2XmSjruWW83pXz32UcymjtYdDZN3T9od/
	Cb+a5xeQIMwFuLPwp0HRdNIKbMmP+l37eE=
X-Google-Smtp-Source: AGHT+IGJK+Ss79dkjKxStjzbPMccKL7+P9PktVURccumjRo00ckRigKB0w0mrzSfsEJEneYTkMjXcQ==
X-Received: by 2002:a17:90b:2745:b0:2ee:3cc1:793a with SMTP id 98e67ed59e1d1-2f452ec37aemr84079291a91.29.1736085004171;
        Sun, 05 Jan 2025 05:50:04 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f4fbcsm275786505ad.174.2025.01.05.05.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 05:50:03 -0800 (PST)
Date: Sun, 5 Jan 2025 21:49:59 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/10] packed-backend: add "packed-refs" entry consistency
 check
Message-ID: <Z3qOB2_zrDHOh-Gx@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qNUizvHJLgMx1y@ArchLinux>

"packed-backend.c::next_record" will parse the ref entry to check the
consistency. This function has already checked the following things:

1. Parse the main line of the ref entry, if the oid is not correct. It
   will die the program. And then it will check whether the next
   character of the oid is space. Then it will check whether the refname
   is correct.
2. If the next line starts with '^', it will continue to parse the oid
   of the peeled oid content and check whether the last character is
   '\n'.

We can iterate each line by using the "packed_fsck_ref_unterminated_line"
function. Then, create a new fsck message "badPackedRefEntry(ERROR)" to
report to the user when something is wrong.

Create two new functions "packed_fsck_ref_main_line" and
"packed_fsck_ref_peeled_line" for case 1 and case 2 respectively. Last,
update the unit test to exercise the code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |   3 +
 fsck.h                        |   1 +
 refs/packed-backend.c         | 105 +++++++++++++++++++++++++++++++++-
 t/t0602-reffiles-fsck.sh      |  40 +++++++++++++
 4 files changed, 148 insertions(+), 1 deletion(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 34375a3143..2a7ec7592e 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
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
index 026ad1d537..4fca304b72 100644
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
index f6142a4402..6e521a9f87 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1822,7 +1822,96 @@ static int packed_fsck_ref_header(struct fsck_options *o, const char *start, con
 	return 0;
 }
 
+static int packed_fsck_ref_peeled_line(struct fsck_options *o,
+				       struct ref_store *ref_store, int line_number,
+				       const char *start, const char *eol)
+{
+	struct strbuf peeled_entry = STRBUF_INIT;
+	struct fsck_ref_report report = { 0 };
+	struct object_id peeled;
+	const char *p;
+	int ret = 0;
+
+	strbuf_addf(&peeled_entry, "packed-refs line %d", line_number);
+	report.path = peeled_entry.buf;
+
+	start++;
+	if (parse_oid_hex_algop(start, &peeled, &p, ref_store->repo->hash_algo)) {
+		ret |= fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				       "'%.*s' has invalid peeled oid",
+				       (int)(eol - start), start);
+		goto cleanup;
+	}
+
+	if (p != eol) {
+		ret |= fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				       "has trailing garbage after peeled oid '%.*s'",
+				       (int)(eol - p), p);
+		goto cleanup;
+	}
+
+cleanup:
+	strbuf_release(&peeled_entry);
+	return ret;
+}
+
+static int packed_fsck_ref_main_line(struct fsck_options *o,
+				     struct ref_store *ref_store, int line_number,
+				     const char *start, const char *eol)
+{
+	struct strbuf packed_entry = STRBUF_INIT;
+	struct fsck_ref_report report = { 0 };
+	struct strbuf refname = STRBUF_INIT;
+	struct object_id oid;
+	const char *p;
+	int ret = 0;
+
+	strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
+	report.path = packed_entry.buf;
+
+	if (parse_oid_hex_algop(start, &oid, &p, ref_store->repo->hash_algo)) {
+		ret |= fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				       "'%.*s' has invalid oid",
+				       (int)(eol - start), start);
+		goto cleanup;
+	}
+
+	if (p == eol || !isspace(*p)) {
+		ret |= fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				       "has no space after oid '%s' but with '%.*s'",
+				       oid_to_hex(&oid), (int)(eol - p), p);
+		goto cleanup;
+	}
+
+	p++;
+	strbuf_add(&refname, p, eol - p);
+	if (refname_contains_null(refname)) {
+		ret |= fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				       "refname '%s' contains NULL binaries",
+				       refname.buf);
+		goto cleanup;
+	}
+
+	if (check_refname_format(refname.buf, 0)) {
+		ret |= fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_REF_NAME,
+				       "has bad refname '%s'", refname.buf);
+		goto cleanup;
+	}
+
+cleanup:
+	strbuf_release(&packed_entry);
+	strbuf_release(&refname);
+	return ret;
+}
+
 static int packed_fsck_ref_content(struct fsck_options *o,
+				   struct ref_store *ref_store,
 				   const char *start, const char *eof)
 {
 	int line_number = 1;
@@ -1844,6 +1933,20 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 				       "missing header line");
 	}
 
+	while (start < eof) {
+		ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
+		ret |= packed_fsck_ref_main_line(o, ref_store, line_number, start, eol);
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
 	/*
 	 * If there is anything wrong during the parsing of the "packed-refs"
 	 * file, we should not check the object of the refs.
@@ -1900,7 +2003,7 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	ret = packed_fsck_ref_content(o, packed_ref_content.buf,
+	ret = packed_fsck_ref_content(o, ref_store, packed_ref_content.buf,
 				      packed_ref_content.buf + packed_ref_content.len);
 
 cleanup:
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 6c729e749a..7e8b329425 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -690,4 +690,44 @@ test_expect_success 'packed-refs header should be checked' '
 	done
 '
 
+test_expect_success 'packed-refs content should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	cd repo &&
+	test_commit default &&
+	git branch branch-1 &&
+	git branch branch-2 &&
+	git tag -a annotated-tag-1 -m tag-1 &&
+	git tag -a annotated-tag-2 -m tag-2 &&
+
+	branch_1_oid=$(git rev-parse branch-1) &&
+	branch_2_oid=$(git rev-parse branch-2) &&
+	tag_1_oid=$(git rev-parse annotated-tag-1) &&
+	tag_2_oid=$(git rev-parse annotated-tag-2) &&
+	tag_1_peeled_oid=$(git rev-parse annotated-tag-1^{}) &&
+	tag_2_peeled_oid=$(git rev-parse annotated-tag-2^{}) &&
+	short_oid=$(printf "%s" $tag_1_peeled_oid | cut -c 1-4) &&
+
+	printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
+	printf "%s\n" "$short_oid refs/heads/branch-1" >>.git/packed-refs &&
+	printf "%sx\n" "$branch_1_oid" >>.git/packed-refs &&
+	printf "%s   refs/heads/bad-branch\n" "$branch_2_oid" >>.git/packed-refs &&
+	printf "%s refs/heads/branch.\n" "$branch_2_oid" >>.git/packed-refs &&
+	printf "%s refs/tags/annotated-tag-3\n" "$tag_1_oid" >>.git/packed-refs &&
+	printf "^%s\n" "$short_oid" >>.git/packed-refs &&
+	printf "%s refs/tags/annotated-tag-4.\n" "$tag_2_oid" >>.git/packed-refs &&
+	printf "^%s garbage\n" "$tag_2_peeled_oid" >>.git/packed-refs &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: packed-refs line 2: badPackedRefEntry: '\''$short_oid refs/heads/branch-1'\'' has invalid oid
+	error: packed-refs line 3: badPackedRefEntry: has no space after oid '\''$branch_1_oid'\'' but with '\''x'\''
+	error: packed-refs line 4: badRefName: has bad refname '\''  refs/heads/bad-branch'\''
+	error: packed-refs line 5: badRefName: has bad refname '\''refs/heads/branch.'\''
+	error: packed-refs line 7: badPackedRefEntry: '\''$short_oid'\'' has invalid peeled oid
+	error: packed-refs line 8: badRefName: has bad refname '\''refs/tags/annotated-tag-4.'\''
+	error: packed-refs line 9: badPackedRefEntry: has trailing garbage after peeled oid '\'' garbage'\''
+	EOF
+	test_cmp expect err
+'
+
 test_done
-- 
2.47.1

