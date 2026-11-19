Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795097934;
	b=E8xyu93RfM6Wo7aPTFIWx0EASuRX8kWeh3VPQ2mdixRMQQRd4u+6sTZyiu70lmxcBYDC
	 IpNyclfkaAaGoCHfPVbGzOz9JaDrevyil0ZLbjH1ZddXvhl8Q0FuhOmlqibcwaDypHiA1
	 fkRGAywKld7gXTTM37PNawtm+M8UKNl4EOWKECdpLwaEaA0sZGNAS1XFjoOI1Ax07986z
	 aOCpe0j5P55P1pyi4jq43sGE6EG1JkErc29MHCZm/c4qbiohUl4ZcEl64dgBg2JRg+GSw
	 PE/sXwI7Mxq8CAMAuov3jYhRaJKAPRuoc7mETFYNzvRcdWeH6T09FNLftMJOn3PUwgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097934;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ywXguSjTqGVTahBYfpVWsu6r0a15FiXX6UXlltP3LWs=;
	b=iwYnINWWsuq/WtkcPp9MoTaGORkxKT04IJwqlPnyPGmhfnS05sGOsfcfjBRMPlYU7BRs
	 L6a0QwCvg4wIaKMYPP36GpVOI4dnRtOUP223mboXQP8kmMHRs2uo+0FTRilcyQSYuhnR9
	 CXhQX4Hph2YAISrpFhIaSIy10V4hriaAyOYgQuHRbttNSr1oke149AQOcohhfpl8kWWom
	 2CZefbDPb11CENFemoi8H+KSD/Iro47FvW2GicEy0lvzxz0F2v2RARSa9Uh7bE8uf9QFH
	 XBPozgKKM0P4WAoP+HotcOq3Lfkbz2rJYP439w1Z4BGWLRBKeFs/KZX0wFc7GcZhDlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Qyxi1vv3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F9606A338
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 14:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 071F9606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Qyxi1vv3
ARC-Seal: i=1; a=rsa-sha256; t=1795097921; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VhDp7qxk3WqHyfN6ZzLC9FRAglPiDFbmpZrjEbNg+aOZwGPon1eqkRePQ7H9ScBY9bsh/ijIGJ6FSga1aF624hj/kKR+ANyruGEQAqwYYf3COCIndWPYo9bdyY/vLIiG4AyJifJ01si5Mc8r3IhWF5xcIPpCUzww9jdI7SFXQAo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795097921; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ywXguSjTqGVTahBYfpVWsu6r0a15FiXX6UXlltP3LWs=; 
	b=Y+sq3fi63pJg/q8+U5EyNB7QlzfPPjAT/M62JOBM+vrRUzRSG8a3RwxymRUeP/BzNegfGtAhIB68KT5Wv++VGz3a1Y+jIkbUzVIKiGQNELhtK3sYOoVqbOrKqJ82IULluJVHHsXCMx9uyHrf90QkAdCTjz9eq7PcG6pVr50jgpY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Qyxi1vv3bmeoMilJPApnAfWKK/z12456ht6IFJUB/H/YmEea00QZaWvz/9YJR0QB9kwaS4l4DRxuW4/NbBv0qGbrAyRTAe4//nz8QphPMQZ6i+2i8ZfunvBrrHgzrUSf98ToAvu9KDOJFn9OW8P56KgDoth35YwCESgJ5erAw5M=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=ywXguSjTqGVTahBYfpVWsu6r0a15FiXX6UXlltP3LWs=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795097920148414.8988601498246;
	Thu, 19 Nov 2026 06:18:40 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 3/3] object-file-convert: copy unknown commit headers unchanged
Date: Thu, 19 Nov 2026 16:18:22 +0200
Message-ID: <26080a7a386bdd0ae14725d2e731d1be81774d49.1794932695.git.adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1794932695.git.adrian.ratiu@collabora.com>
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com> <cover.1794932695.git.adrian.ratiu@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a repo with extensions.compatObjectFormat, Git converts commits
to the compat format in two places which disagree about headers they
don't know:

1. When a commit is created with commit_tree_extended(), as
   git-commit(1) does, convert_commit_extra_headers() copies unknown
   headers unchanged.

2. When an existing commit object is converted (git-hash-object(1) -w)
   or when it's read by its compat ID, convert_commit_object() fails
   on them instead.

So git-hash-object(1) refuses such a commit, while "git commit --amend"
records a compat ID for it that can't be read back:
   "Failed to convert object from sha256 to sha1".

The rejection was added in 08a45903cb (object-file-convert: convert
commits that embed signed tags, 2023-10-01). Git can't know what an
unknown header holds. It might hold an object ID that needs
converting, so convert_commit_object() rejects all of them.

Some tools rely on such headers though. Jujutsu, for example, writes
a "change-id" header in every commit, so none of its commits can be
converted.

Make convert_commit_object() copy unknown headers and their
continuation lines unchanged, just like convert_commit_extra_headers(),
so both give the same compat object.

The author, committer, encoding and gpgsig headers were already copied
the same, so their separate cases are no longer needed.

The "tree ", "parent " and "mergetag " cases only matched a line with
something after the space. That didn't matter while all other lines
were rejected, but they would now be copied. For a "mergetag " line
whose tag starts on the next line, the object ID in the tag would be
copied unconverted, even though Git reads that header as a mergetag and
convert_commit_extra_headers() refuses to convert it.

Match these headers by their key alone instead, the way
read_commit_extra_header_lines() does. Such a line with an empty or bad
value is then rejected, as before. A "tree", "parent" or "mergetag"
line without a space is not one of these headers to Git, so it is
copied like any other unknown header, which is also what
convert_commit_extra_headers() does.

Alternatives considered:

 - Reject unknown headers in convert_commit_extra_headers() too.
   Both paths would then agree, but commits from tools that add
   their own headers could not be used in a compat repo.

 - Copy only headers known to hold no object IDs. Every tool would
   first need to get its headers added to that list.

 - Convert values that look like object IDs. Any other hex string
   could be taken for one, and Git shouldn't interpret headers it
   doesn't know.

 - Also reject lines that don't look like "<key> <value>". This would
   make the two paths disagree again, because
   convert_commit_extra_headers() copies such lines, so
   "git commit --amend" would record compat IDs that can't be read
   back.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 object-file-convert.c         | 35 ++++++++++++++++++++++-------------
 t/t1016-compatObjectFormat.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index 63ee18630b..ae21eedc3d 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -167,7 +167,7 @@ static int convert_commit_object(struct repository *repo,
 		if (!eol)
 			return error(_("bad %s in commit"), "line");
 
-		if (((bufptr + 5) < eol) && !memcmp(bufptr, "tree ", 5))
+		if (((bufptr + 5) <= eol) && !memcmp(bufptr, "tree ", 5))
 		{
 			if (((bufptr + tree_entry_len) != eol) ||
 			    parse_oid_hex_algop(bufptr + 5, &oid, &p, from) ||
@@ -179,7 +179,7 @@ static int convert_commit_object(struct repository *repo,
 					     "tree", oid_to_hex(&oid));
 			strbuf_addf(out, "tree %s\n", oid_to_hex(&mapped_oid));
 		}
-		else if (((bufptr + 7) < eol) && !memcmp(bufptr, "parent ", 7))
+		else if (((bufptr + 7) <= eol) && !memcmp(bufptr, "parent ", 7))
 		{
 			if (((bufptr + parent_entry_len) != eol) ||
 			    parse_oid_hex_algop(bufptr + 7, &oid, &p, from) ||
@@ -192,7 +192,7 @@ static int convert_commit_object(struct repository *repo,
 
 			strbuf_addf(out, "parent %s\n", oid_to_hex(&mapped_oid));
 		}
-		else if (((bufptr + 9) < eol) && !memcmp(bufptr, "mergetag ", 9))
+		else if (((bufptr + 9) <= eol) && !memcmp(bufptr, "mergetag ", 9))
 		{
 			struct strbuf tag = STRBUF_INIT, new_tag = STRBUF_INIT;
 
@@ -223,17 +223,26 @@ static int convert_commit_object(struct repository *repo,
 			strbuf_release(&tag);
 			strbuf_release(&new_tag);
 		}
-		else if (((bufptr + 7) < tail) && !memcmp(bufptr, "author ", 7))
-			strbuf_add(out, bufptr, (eol - bufptr) + 1);
-		else if (((bufptr + 10) < tail) && !memcmp(bufptr, "committer ", 10))
-			strbuf_add(out, bufptr, (eol - bufptr) + 1);
-		else if (((bufptr + 9) < tail) && !memcmp(bufptr, "encoding ", 9))
-			strbuf_add(out, bufptr, (eol - bufptr) + 1);
-		else if (((bufptr + 6) < tail) && !memcmp(bufptr, "gpgsig", 6))
-			strbuf_add(out, bufptr, (eol - bufptr) + 1);
 		else {
-			/* Unknown line fail it might embed an oid */
-			return -1;
+			/*
+			 * Copy all other headers unchanged. author, committer,
+			 * encoding and gpgsig hold no object IDs. For unknown
+			 * headers we can't tell, so copy them too, like
+			 * convert_commit_extra_headers() does when the commit
+			 * is written. Both must give the same compat object.
+			 *
+			 * This means that a header holding object IDs is
+			 * copied without converting them. Any such header added
+			 * to Git needs its own case above, like parent or
+			 * mergetag, and the same conversion in
+			 * convert_commit_extra_headers().
+			 *
+			 * The cases above match a header by its key alone, as
+			 * read_commit_extra_header_lines() does, so that e.g. a
+			 * "mergetag " line with nothing after the space is
+			 * still handled as a mergetag instead of being copied.
+			 */
+			strbuf_add(out, bufptr, (eol - bufptr) + 1);
 		}
 		/* Consume any trailing continuation lines */
 		bufptr = eol + 1;
diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 9cafcee509..fdb882c686 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -188,6 +188,38 @@ do
 		eval signedtag4_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag4)
 	'
 
+	test_expect_success "create a $hash commit with an unknown header" '
+		git cat-file commit $(commit2_oid $hash) >../${hash}_commit2 &&
+		awk "{ print } /^committer / { print \"x-unknown one\"; print \" two\" }" \
+			<../${hash}_commit2 >../${hash}_unknownheader &&
+		oid=$(git hash-object -t commit -w ../${hash}_unknownheader) &&
+		eval unknownheader_${hash}_oid=$oid &&
+		git branch unknownheader $oid
+	'
+
+	test_expect_success "amend a $hash commit with an unknown header" '
+		git checkout unknownheader &&
+		git commit --amend -m "Amend a commit with an unknown header" &&
+		git cat-file commit HEAD >actual &&
+		test_grep "^x-unknown one$" actual &&
+		oid=$(git rev-parse HEAD) &&
+		eval unknownheader2_${hash}_oid=$oid
+	'
+
+	test_expect_success "reject a $hash commit with an empty mergetag line" '
+		git cat-file tag committag >../${hash}_committag &&
+		{
+			sed -n "/^committer /q;p" ../${hash}_commit2 &&
+			grep "^committer " ../${hash}_commit2 &&
+			echo "mergetag " &&
+			sed "s/^/ /" ../${hash}_committag &&
+			echo &&
+			echo message
+		} >../${hash}_emptymergetag &&
+		test_must_fail git hash-object -t commit -w ../${hash}_emptymergetag 2>err &&
+		test_grep "Failed to convert object" err
+	'
+
 	test_expect_success 'rev-parse maps oid of object borrowed from alternate' '
 		for repo in alt borrow
 		do
@@ -298,6 +330,8 @@ compare_oids 'blob' more "$more_sha1_oid" "$more_sha256_oid"
 compare_oids 'blob' another "$another_sha1_oid" "$another_sha256_oid"
 compare_oids 'tree' tree2 "$tree2_sha1_oid" "$tree2_sha256_oid"
 compare_oids 'commit' commit2 "$commit2_sha1_oid" "$commit2_sha256_oid"
+compare_oids 'commit' unknownheader "$unknownheader_sha1_oid" "$unknownheader_sha256_oid"
+compare_oids 'commit' unknownheader2 "$unknownheader2_sha1_oid" "$unknownheader2_sha256_oid"
 compare_oids GPG2 'tag' signedtag2 "$signedtag2_sha1_oid" "$signedtag2_sha256_oid"
 compare_oids GPG2 'commit' signedcommit2 "$signedcommit2_sha1_oid" "$signedcommit2_sha256_oid"
 compare_oids GPG2 'commit' signedcommit3 "$signedcommit3_sha1_oid" "$signedcommit3_sha256_oid"
-- 
2.56.1

