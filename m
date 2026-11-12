Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.105
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794513555;
	b=QpyDU3udz0OKoyHaF9ONgNhSe3oOhdd/WKlfDX22h20H+JYdu10KjLnNSV+QPs7qCqG4
	 BrsjBHJ/qdGaTw+pKmQncfOvrOahOybeMAeSPfEDbze5TGyBXiUlWEc5eeAIBl7ClEcsT
	 1HXSb3qFc5VZxi+Oo/eHa2MD+uFH0Qs//XdLXQ+4fPzVJYiMIBW3ixr8elUPH5Z17GInO
	 GJHOJ/3C/Qu6mFHQKg+kQtou9UZ9I5QpX46YS/MycMF1u+MMtgal9Xf90xp6bCMTFBi3M
	 8D8+mSF10n7UAduU9i5J964KbBXoYxI/YCP6ItlYkkJxwwppJypVvGKo/rc90Quuzcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513555;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oRIuW2kw3/GoDtdRB9opaYa4pn9bLcW6hVxEILYVzls=;
	b=i7G4Gygue5G5fU2pPIDXx67ia2AbanrA/MbN1lj+PXxqRlM9/dc8MLAVe94y0vjCW7ww
	 r8J0F928Xb1Xx20LK7QQYSWui4sf/EA8z/YbXN6bRFbdT1WGX7TusZUmrJPfzCrQ6EZGK
	 HdTMBB2CpYjj+kgarvU/IsztjSSBX+SylsquWYIJA1P97cYJi02QsM/mvxgrKkcM9MJ3G
	 rgPk8JL9fZjMVdqRXYgzvWq8xFMTIBMBATp0bBpx4c76qVza+nQpd/Mt6+z8ngJAvYivR
	 yuBPuUHtYF5+wNyZ/8VkSXQ5NMmsaVctAA3d6Cv74ob+n1oZ7w+WOdUC0v4eMDBXeLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=YwW3cAZ1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.105
Received: from sender5-pp-e105.zoho.com (sender5-pp-e105.zoho.com [165.173.182.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53E606A32A
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 19:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F53E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=YwW3cAZ1
ARC-Seal: i=1; a=rsa-sha256; t=1794513541; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O+llB4xGfs7fJxJZCvLDgynDtTCCDg9KJax1EdU81ST0O/NnvNs/di4hsUyQJNzWi8Ckal/Rzj58D+QDDRO11yq1DYBrZF42QU01Rowwz/+zNinC2zq/X3WbmKhv5w1vyNd65qFs3SmzfnR+RN36tFpy/lJPlHLhkSAK7DwtRwI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794513541; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oRIuW2kw3/GoDtdRB9opaYa4pn9bLcW6hVxEILYVzls=; 
	b=kjUOILftWucPwfzctSAno/RzEy/MCWX+97/cq4hY8g7ZlwrsnqKhQTkF9Ajv7T5hBVVXDJwnMuDlUbX+qOMtmipYu6Vz9C/hr8EjQvaGCB5GVyXiMlEYQo7nwZKWCEFv4s1Izc3qSBZFkB7xJQtZER+94Yx0QZB7NX47AVazAjE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=YwW3cAZ1HXzJJvLeh+/m1gSUQV/+wuG+8GfBQB00fj4PwQMUZe24GgK+7TukH7Emp/LCS93UmvY5/4qWESIBsKAIAoOB7n83tU45Co1mxCY5W3ylOTEqtB+PfuoigFGTE4XKjZXVxD2gBAVsfxb55VH6MehgUMkcvoQWyTUdz7s=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=oRIuW2kw3/GoDtdRB9opaYa4pn9bLcW6hVxEILYVzls=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794513540403781.5922149363381;
	Thu, 12 Nov 2026 11:59:00 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Emily Shaffer <emilyshaffer@google.com>,
	Josh Steadmon <steadmon@google.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 3/3] object-file-convert: copy unknown commit headers unchanged
Date: Thu, 12 Nov 2026 21:57:40 +0200
Message-ID: <20261112195740.2834341-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
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
   "git commit" does, convert_commit_extra_headers() copies unknown
   headers unchanged.

2. When an existing commit object is converted (git hash-object -w)
   or when it's read by its compat id, convert_commit_object() fails
   on them instead.

So git hash-object refuses such a commit, while git commit --amend
records a compat id for it that can't be read back:
   "Failed to convert object from sha256 to sha1".

The rejection was added in 08a45903cb (object-file-convert: convert
commits that embed signed tags, 2023-10-01). Git can't know what an
unknown header holds. It might hold an object id that needs
converting, so convert_commit_object() rejects all of them.

Some tools rely on such headers though. Jujutsu, for example, writes
a "change-id" header in every commit, so none of its commits can be
converted.

Make convert_commit_object() copy unknown headers and their
continuation lines unchanged, just like convert_commit_extra_headers()
so both give the same compat object.

The author, committer, encoding and gpgsig headers were already copied
the same, so their separate cases are no longer needed.

A "tree", "parent" or "mergetag" line with nothing after the keyword
used to be rejected as unknown and is now copied as well. Such a
commit is malformed in both formats anyway.

Alternatives considered:

 - Reject unknown headers in convert_commit_extra_headers() too.
   Both paths would then agree, but commits from tools that add
   their own headers could not be used in a compat repo.

 - Copy only headers known to hold no object ids. Every tool would
   first need to get its headers added to that list.

The test writes a commit with an unknown header with "git hash-object",
amends it with "git commit", and checks that both commits map to the
same objects in the SHA-1 and the SHA-256 repo.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 object-file-convert.c         | 21 +++++++++++----------
 t/t1016-compatObjectFormat.sh | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index 63ee18630b..1a0f98c9ff 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -223,17 +223,18 @@ static int convert_commit_object(struct repository *repo,
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
+			 * Copy all other headers unchanged. author, committer, encoding and gpgsig
+			 * hold no object ids. For unknown headers we can't tell, so copy them too,
+			 * like convert_commit_extra_headers() does when the commit is written. Both
+			 * must give the same compat object.
+			 *
+			 * This means that a header holding object ids is copied without converting
+			 * them. Any such header added to Git needs its own case above, like parent
+			 * or mergetag, and the same conversion in convert_commit_extra_headers().
+			 */
+			strbuf_add(out, bufptr, (eol - bufptr) + 1);
 		}
 		/* Consume any trailing continuation lines */
 		bufptr = eol + 1;
diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 9cafcee509..fde092a017 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -187,6 +187,22 @@ do
 		eval signedtag3_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag3) &&
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
+	test_expect_success "amend a $hash commit with an unknown header" '
+		git checkout unknownheader &&
+		git commit --amend -m "Amend a commit with an unknown header" &&
+		git cat-file commit HEAD >actual &&
+		test_grep "^x-unknown one$" actual &&
+		oid=$(git rev-parse HEAD) &&
+		eval unknownheader2_${hash}_oid=$oid
+	'
 
 	test_expect_success 'rev-parse maps oid of object borrowed from alternate' '
 		for repo in alt borrow
@@ -298,6 +314,8 @@ compare_oids 'blob' more "$more_sha1_oid" "$more_sha256_oid"
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

