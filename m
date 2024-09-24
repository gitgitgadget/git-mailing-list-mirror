Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94038DD1
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199143; cv=none; b=bx47apn5lY2Z9EQelPd/ZDvmsBX10TWZvWEw2OlP6bFk6hyxaeONZU3BAKwkoeazYLFi4Cts2ZSlP+VONRtmDEArCulXGQH0QCHcE7nZ6svbtqiBI99WUG1FMMc9gXrKTJkOXGjtfaU6jJMyAofAhbAdYEjqEekZl1YydUOHnPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199143; c=relaxed/simple;
	bh=419rShZIYyT04h4XXuVTt2qvKMf2faSu+iWL+KMM8+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8RTNlVKPxYnnz51SGcfNzHSIPDZCttPjXPpnogP4qI1okYpfNRgm2RrKW5nOOvk3T16u4N7qRlaI3uvbJqywChqShbEh174CIhQSA1PjWZEKgYlRyUPAdHFvDjHmFxmidCVDskacAvBwT0W0a7aw3EnQVnXYv07zGjl1bIcoKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DgyFuA76; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DgyFuA76"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a9e4fa5aaso5186646276.2
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 10:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727199140; x=1727803940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4pkiQpGV8RxKoYbN/qj8tXlwNVqbWlJfbGiu/CPrKak=;
        b=DgyFuA76oMHp4PcfEG9hC7lEhvwKBJyAFbXk8dhbAXY4lIcGr25ZXUi4BRoWk8yE1O
         xxiQtVtfRF/hU33n+8fg54IKG8ltMmtNR7hSJu1W0aEWGdvg9gHv6XExbA5hUUL5l9DZ
         9A0ksOmNEre1vUkys7SuMi3b8rJeVIcwg+O29UQ82DWBSncSWbk/DaV1lTXP9+KFalXJ
         kSjAao1l5j3CfSx9/k3aoz0/SleoY1aEhIY0Exv6+abmgYCer5LO+d9lt7snxcwalxUl
         PISkgczTDtHxM4aEOZIcd58vDTPQA2pciQ8iF9Do04x0Y2T+dMgzg4saIIVM3ebqKG2Z
         PlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727199140; x=1727803940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pkiQpGV8RxKoYbN/qj8tXlwNVqbWlJfbGiu/CPrKak=;
        b=HU/yl89x0BbzKZ0SSwtg5rXpwd0KXxKDbgfb5/rgHPHt75BI1KfrGQTbPI0HXTjEEn
         m9l7IPB1TTZFBRl8flpCLiV4vAN0NIJASrego3xzX9mq1CtgqPRPkfWKpCX0Sc/mXLvc
         D6FBtf1g73KTWVQwGSnVar/P3PeVd7H2ve4Y/ZiUeHnrgtR9fixKYZESaviB6DVBDr2e
         gH3Uk7cQwd6LqgKuQRjKUfb2CRkkZX6+e32BNcH3jrlSYtXUMry7hDJog+/nGFEL5xsK
         WFD0BAUfMKWzk0+TNj9GKdUur3p08S2LbuHNNCWbjfIRwIPbKn+wGKOaDE+lT2/kzLbd
         J9dw==
X-Gm-Message-State: AOJu0Yzq5FBly+DmL2EZdgnWEvkRTTjcLV2n5zEVK6xlqhDXU6zcooLP
	csX+Xd9GGSVVW0K2l8dpuoyxpl69Mp13UzwdN9ksrPOyL/1SYeTxbGVMJUZjgAGyFO1KuNlfYgB
	fFpk=
X-Google-Smtp-Source: AGHT+IEeyPQyIKWy2SThKYdw5FBcoofZSFw+wuiSFK5Jd0j1kqF2ybXiH4HNPOEL++Ily/WBKy5L6g==
X-Received: by 2002:a05:6902:1249:b0:e24:a37b:c6a0 with SMTP id 3f1490d57ef6-e24a37bc787mr556689276.56.1727199140168;
        Tue, 24 Sep 2024 10:32:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2499b18171sm301710276.27.2024.09.24.10.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 10:32:19 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:32:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/8] finalize_object_file(): implement collision check
Message-ID: <ed9eeef8513e08935c59defafde99956eb62d49a.1727199118.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727199118.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1727199118.git.me@ttaylorr.com>

We've had "FIXME!!! Collision check here ?" in finalize_object_file()
since aac1794132 (Improve sha1 object file writing., 2005-05-03). That
is, when we try to write a file with the same name, we assume the
on-disk contents are the same and blindly throw away the new copy.

One of the reasons we never implemented this is because the files it
moves are all named after the cryptographic hash of their contents
(either loose objects, or packs which have their hash in the name these
days). So we are unlikely to see such a collision by accident. And even
though there are weaknesses in sha1, we assume they are mitigated by our
use of sha1dc.

So while it's a theoretical concern now, it hasn't been a priority.
However, if we start using weaker hashes for pack checksums and names,
this will become a practical concern. So in preparation, let's actually
implement a byte-for-byte collision check.

The new check will cause the write of new differing content to be a
failure, rather than a silent noop, and we'll retain the temporary file
on disk. If there's no collision present, we'll clean up the temporary
file as usual after either rename()-ing or link()-ing it into place.

Note that this may cause some extra computation when the files are in
fact identical, but this should happen rarely.

Loose objects are exempt from this check, and the collision check may be
skipped by calling the _flags variant of this function with the
FOF_SKIP_COLLISION_CHECK bit set. This is done for a couple of reasons:

  - We don't treat the hash of the loose object file's contents as a
    checksum, since the same loose object can be stored using different
    bytes on disk (e.g., when adjusting core.compression, using a
    different version of zlib, etc.).

    This is fundamentally different from cases where
    finalize_object_file() is operating over a file which uses the hash
    value as a checksum of the contents. In other words, a pair of
    identical loose objects can be stored using different bytes on disk,
    and that should not be treated as a collision.

  - We already use the path of the loose object as its hash value /
    object name, so checking for collisions at the content level doesn't
    add anything.

    This is why we do not bother to check the inflated object contents
    for collisions either, since either (a) the object contents have the
    fingerprint of a SHA-1 collision, in which case the collision
    detecting SHA-1 implementation used to hash the contents to give us
    a path would have already rejected it, or (b) the contents are part
    of a colliding pair which does not bear the same fingerprints of
    known collision attacks, in which case we would not have caught it
    anyway.

    So skipping the collision check here does not change for better or
    worse the hardness of loose object writes.

As a small note related to the latter bullet point above, we must teach
the tmp-objdir routines to similarly skip the content-level collision
checks when calling migrate_one() on a loose object file, which we do by
setting the FOF_SKIP_COLLISION_CHECK bit when we are inside of a loose
object shard.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object-file.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++---
 object-file.h |  6 +++++
 tmp-objdir.c  | 26 ++++++++++++++------
 3 files changed, 89 insertions(+), 10 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5a1da577115..b9a3a1f62db 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1932,10 +1932,67 @@ static void write_object_file_prepare_literally(const struct git_hash_algo *algo
 	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
 }
 
+static int check_collision(const char *filename_a, const char *filename_b)
+{
+	char buf_a[4096], buf_b[4096];
+	int fd_a = -1, fd_b = -1;
+	int ret = 0;
+
+	fd_a = open(filename_a, O_RDONLY);
+	if (fd_a < 0) {
+		ret = error_errno(_("unable to open %s"), filename_a);
+		goto out;
+	}
+
+	fd_b = open(filename_b, O_RDONLY);
+	if (fd_b < 0) {
+		ret = error_errno(_("unable to open %s"), filename_b);
+		goto out;
+	}
+
+	while (1) {
+		ssize_t sz_a, sz_b;
+
+		sz_a = read_in_full(fd_a, buf_a, sizeof(buf_a));
+		if (sz_a < 0) {
+			ret = error_errno(_("unable to read %s"), filename_a);
+			goto out;
+		}
+
+		sz_b = read_in_full(fd_b, buf_b, sizeof(buf_b));
+		if (sz_b < 0) {
+			ret = error_errno(_("unable to read %s"), filename_b);
+			goto out;
+		}
+
+		if (sz_a != sz_b || memcmp(buf_a, buf_b, sz_a)) {
+			ret = error(_("files '%s' and '%s' differ in contents"),
+				    filename_a, filename_b);
+			goto out;
+		}
+
+		if (sz_a < sizeof(buf_a))
+			break;
+	}
+
+out:
+	if (fd_a > -1)
+		close(fd_a);
+	if (fd_b > -1)
+		close(fd_b);
+	return ret;
+}
+
 /*
  * Move the just written object into its final resting place.
  */
 int finalize_object_file(const char *tmpfile, const char *filename)
+{
+	return finalize_object_file_flags(tmpfile, filename, 0);
+}
+
+int finalize_object_file_flags(const char *tmpfile, const char *filename,
+			       enum finalize_object_file_flags flags)
 {
 	struct stat st;
 	int ret = 0;
@@ -1974,7 +2031,9 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 			errno = saved_errno;
 			return error_errno(_("unable to write file %s"), filename);
 		}
-		/* FIXME!!! Collision check here ? */
+		if (!(flags & FOF_SKIP_COLLISION_CHECK) &&
+		    check_collision(tmpfile, filename))
+				return -1;
 		unlink_or_warn(tmpfile);
 	}
 
@@ -2228,7 +2287,8 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 			warning_errno(_("failed utime() on %s"), tmp_file.buf);
 	}
 
-	return finalize_object_file(tmp_file.buf, filename.buf);
+	return finalize_object_file_flags(tmp_file.buf, filename.buf,
+					  FOF_SKIP_COLLISION_CHECK);
 }
 
 static int freshen_loose_object(const struct object_id *oid)
@@ -2350,7 +2410,8 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 		strbuf_release(&dir);
 	}
 
-	err = finalize_object_file(tmp_file.buf, filename.buf);
+	err = finalize_object_file_flags(tmp_file.buf, filename.buf,
+					 FOF_SKIP_COLLISION_CHECK);
 	if (!err && compat)
 		err = repo_add_loose_object_map(the_repository, oid, &compat_oid);
 cleanup:
diff --git a/object-file.h b/object-file.h
index d6414610f80..81b30d269c8 100644
--- a/object-file.h
+++ b/object-file.h
@@ -117,7 +117,13 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
  */
 int stream_object_signature(struct repository *r, const struct object_id *oid);
 
+enum finalize_object_file_flags {
+	FOF_SKIP_COLLISION_CHECK = 1,
+};
+
 int finalize_object_file(const char *tmpfile, const char *filename);
+int finalize_object_file_flags(const char *tmpfile, const char *filename,
+			       enum finalize_object_file_flags flags);
 
 /* Helper to check and "touch" a file */
 int check_and_freshen_file(const char *fn, int freshen);
diff --git a/tmp-objdir.c b/tmp-objdir.c
index c2fb9f91930..9da0071cba8 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -206,9 +206,11 @@ static int read_dir_paths(struct string_list *out, const char *path)
 	return 0;
 }
 
-static int migrate_paths(struct strbuf *src, struct strbuf *dst);
+static int migrate_paths(struct strbuf *src, struct strbuf *dst,
+			 enum finalize_object_file_flags flags);
 
-static int migrate_one(struct strbuf *src, struct strbuf *dst)
+static int migrate_one(struct strbuf *src, struct strbuf *dst,
+		       enum finalize_object_file_flags flags)
 {
 	struct stat st;
 
@@ -220,12 +222,18 @@ static int migrate_one(struct strbuf *src, struct strbuf *dst)
 				return -1;
 		} else if (errno != EEXIST)
 			return -1;
-		return migrate_paths(src, dst);
+		return migrate_paths(src, dst, flags);
 	}
-	return finalize_object_file(src->buf, dst->buf);
+	return finalize_object_file_flags(src->buf, dst->buf, flags);
 }
 
-static int migrate_paths(struct strbuf *src, struct strbuf *dst)
+static int is_loose_object_shard(const char *name)
+{
+	return strlen(name) == 2 && isxdigit(name[0]) && isxdigit(name[1]);
+}
+
+static int migrate_paths(struct strbuf *src, struct strbuf *dst,
+			 enum finalize_object_file_flags flags)
 {
 	size_t src_len = src->len, dst_len = dst->len;
 	struct string_list paths = STRING_LIST_INIT_DUP;
@@ -239,11 +247,15 @@ static int migrate_paths(struct strbuf *src, struct strbuf *dst)
 
 	for (i = 0; i < paths.nr; i++) {
 		const char *name = paths.items[i].string;
+		enum finalize_object_file_flags flags_copy = flags;
 
 		strbuf_addf(src, "/%s", name);
 		strbuf_addf(dst, "/%s", name);
 
-		ret |= migrate_one(src, dst);
+		if (is_loose_object_shard(name))
+			flags_copy |= FOF_SKIP_COLLISION_CHECK;
+
+		ret |= migrate_one(src, dst, flags_copy);
 
 		strbuf_setlen(src, src_len);
 		strbuf_setlen(dst, dst_len);
@@ -271,7 +283,7 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	strbuf_addbuf(&src, &t->path);
 	strbuf_addstr(&dst, repo_get_object_directory(the_repository));
 
-	ret = migrate_paths(&src, &dst);
+	ret = migrate_paths(&src, &dst, 0);
 
 	strbuf_release(&src);
 	strbuf_release(&dst);
-- 
2.46.2.636.g4b83dd05e9f

