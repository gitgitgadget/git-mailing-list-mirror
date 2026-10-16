Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1A3BCD26
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186652; cv=none; b=Le9rC7+7EjEWmOi/cZ2pi2qoHIbRW60PFMX0jc8zgDrbqGl6jPW3qPRDaJS9KHYRVvuJPxV4bUGRHhvhDA9yAbgg3iHpZpm+WJsRMx9+UUPSkmb46go4dPinxDerq42SgWC9idgVddk/9vKWY1kxwY6HxeoAUjzxOp3aCiM6fLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186652; c=relaxed/simple;
	bh=3i+9SQJWtpkKGrSyCM2RoDtth62zEif/Cff7nVmaUug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXhtIzkbWikO0UN38X2YDokoRTA/OcQgDdSi//Ukdlyq8Nypa1Pu3wZReX1wj2XjpPG06HgwJ+xdRi3F5sVILLuOaEuZLVAWqJ+dc+R2rohyjYlh8PQApqtsjI94Scw6rNAwa5EjwQP2U1znfikw+HfNyioWZbB+5ep72Fz8ucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJp6Ge/Q; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJp6Ge/Q"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-81ba09a5d23so188736a34.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792186649; x=1792791449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9XABZq0Ng24cqCwSe44YEuAdjKVvWaINI5H7fTB73JQ=;
        b=RJp6Ge/QwjasqGx0jFBwS9xIPKjJ4MYtLGOCRBpTJWF8RUS8NYNumixhPYVpoj+820
         +NS3qy6iagfjvCU6DDPXt4vS1UGiMAt9D8qBvOV3vDiqWkzk5JrCOcJCdwjNnKkQiNUX
         WgNK7DRIcHi0KPvu2IgA4QD5jQNhIk5BeBMy0yLt6aoIePBb52LCs+pAC9RqpLCcOEqf
         UVosaKDwyfHle8gowbA4z7Tp4xFKmVuplCcYrBYx6fGdu5nqhiftCA6eaAtfeeG/wPRS
         2DnWANFVwc11gppo2JozOL0fM0ViC7v1YFoyLbc3+wUfzbfx42BSI97Oj6vU9y1xv1eI
         VnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186649; x=1792791449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9XABZq0Ng24cqCwSe44YEuAdjKVvWaINI5H7fTB73JQ=;
        b=iR1afjU5/i6q4ELfpeK24w0/jRHcsOsHSad3xKTk65n2ovixjddMlRj0OyaQEpa34z
         8d4cOkI5PzZ9KzrpmD5yRC4SQ7GzWMWIoT7Ytp8Up2SxFC92G7i9+XOvZ0ah2ZNXw8bf
         F8+cKRNk76bLFjukGe5hLsCcaFqbimUyavkRb2BqKMNYXTfnB99+lt6U5mMtV7uDYq7P
         kiHBD3ijSjzDFlBZ3OE1iD3eCNTLQZxkRkvITzKWQ4qE/2M8B/ouxaS5do3RuOUR7e7+
         7WoGSBqvk9I/6rQBugK/uIlpQd34eP+Iupm7y5Zd+HRx6wDTApDk5TWx2MSPQx7H+l+9
         vL6A==
X-Gm-Message-State: AFq9FYJ94OiIZ0pu4WOelwv2BBcKZVTspnLCKU6ObCPao3g4fz1iMMRL
	f8s4DXCcEU+Pz6gXQJzvQMh2nzW5LftY/3XiU5OiJIf9ggrFrsWKxp0JM34CrQ==
X-Gm-Gg: AYBFou2IYhhbwps1LBBgK2q6JRTA2DYWiGOQLGCapNG4RE3wakzRw+EwDLaYZW70urS
	HdrWZpXLLtUvn2A46s9DoqTQcyxLZvB9cey6MCVJg6W/AVkKkzAeVHWzoVFhyI4DMn/PxlzvpM0
	2yFvEYF/c02ymWbJLGJjo9w4vOiHJwJWBZURXGBjKOK8Nmxy89Lkyx9seeTjsXKS6cNQBWLZTTt
	rl9nwaR5f7k65NhRTxC5t8ISxMAq34+ri9VxeG6rhCX9RjXm2H+pWQxmFsETm1pk4F9vv6og/v8
	dVAra1toUUQfLtxnUIPZpOg4LAKm8DpcRyhrnmgGBcb0EmZJuPl3fdVRTpxj6Bx38aa/NeLhfR8
	muPe3q/JqON+eNl9LgENjMd7eHzsb6j9WBeqy4JKY5+VA9833P+22iH4sZ8yBHu3AiQ92aiOvD8
	C+BzTtLQc06WlYmW2fZa9LngqeSaiAY85avdeZW5ofI8CbsFUaGVOIZexmnkkJtVb2ym2KH3RvF
	XPc39+BAqGp70LvrWTUIXuXxW3mN6edJw7VkQ==
X-Received: by 2002:a05:6830:83ab:b0:81f:acdd:bd0c with SMTP id 46e09a7af769-844fe39ec31mr892647a34.12.1792186649593;
        Fri, 16 Oct 2026 14:37:29 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-844d2ffbf71sm834395a34.4.2026.10.16.14.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 14:37:29 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/4] pack-write: lift and expose index-pack report parsing
Date: Fri, 16 Oct 2026 16:37:14 -0500
Message-ID: <20261016213716.593278-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261016213716.593278-1-jltobler@gmail.com>
References: <20261016022901.3838402-1-jltobler@gmail.com>
 <20261016213716.593278-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once git-index-pack(1) finishes writing a packfile, it reports the
hexadecimal name of that packfile on stdout prefixed with either "pack"
or "keep" depending on whether a ".keep" file was also created alongside
it. Callers that are required to manage the lifecycle of ".keep" files
parse this report via `index_pack_lockfile()`, which provides the path
to the temporary ".keep" file.

In a subsequent commit, the "files" ODB transaction begins creating the
pack lockfiles during transaction commit instead of eagerly staging them
in the transaction quarantine directory with the packfile. Extract the
generic parsing logic for the git-index-pack(1) output into
`read_index_pack_report()` in preparation for recording the names of
newly written packfiles.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 pack-write.c | 56 ++++++++++++++++++++++++++++++++++++++--------------
 pack.h       | 10 ++++++++++
 2 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index b1311c9923..2ed33448ba 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -469,11 +469,16 @@ void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
 	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
 
-char *index_pack_lockfile(struct odb_source *source, int ip_out,
-			  int *is_well_formed)
+int read_index_pack_report(struct repository *repo, int ip_out,
+			   struct strbuf *pack_name, int *is_keep)
 {
+	const int len = repo->hash_algo->hexsz + 6;
 	char packname[GIT_MAX_HEXSZ + 6];
-	const int len = source->odb->repo->hash_algo->hexsz + 6;
+	int is_keep_ignored;
+	const char *name;
+
+	if (!is_keep)
+		is_keep = &is_keep_ignored;
 
 	/*
 	 * The first thing we expect from index-pack's output is
@@ -482,24 +487,45 @@ char *index_pack_lockfile(struct odb_source *source, int ip_out,
 	 * bytes of prefix, `hexsz` bytes of name, and a trailing newline. A
 	 * "keep" prefix tells us that index-pack has also created the
 	 * corresponding ".keep" file.
-	 *
-	 * In the "keep" case, we need it to remove the corresponding ".keep"
-	 * file later on. If we don't get that then tough luck with it.
 	 */
-	if (read_in_full(ip_out, packname, len) == len && packname[len-1] == '\n') {
-		const char *name;
+	if (read_in_full(ip_out, packname, len) != len || packname[len - 1] != '\n')
+		return -1;
+
+	packname[len - 1] = 0;
+	if (skip_prefix(packname, "pack\t", &name))
+		*is_keep = 0;
+	else if (skip_prefix(packname, "keep\t", &name))
+		*is_keep = 1;
+	else
+		return -1;
+
+	strbuf_addstr(pack_name, name);
+
+	return 0;
+}
 
+char *index_pack_lockfile(struct odb_source *source, int ip_out,
+			  int *is_well_formed)
+{
+	struct strbuf pack_name = STRBUF_INIT;
+	char *lockfile = NULL;
+	int is_keep = 0;
+
+	if (read_index_pack_report(source->odb->repo, ip_out, &pack_name, &is_keep)) {
 		if (is_well_formed)
-			*is_well_formed = 1;
-		packname[len-1] = 0;
-		if (skip_prefix(packname, "keep\t", &name))
-			return xstrfmt("%s/pack/pack-%s.keep",
-				       source->path, name);
+			*is_well_formed = 0;
 		return NULL;
 	}
+
 	if (is_well_formed)
-		*is_well_formed = 0;
-	return NULL;
+		*is_well_formed = 1;
+
+	/* If there is no ".keep" file, then there is no lockfile to return. */
+	if (is_keep)
+		lockfile = xstrfmt("%s/pack/pack-%s.keep", source->path, pack_name.buf);
+
+	strbuf_release(&pack_name);
+	return lockfile;
 }
 
 /*
diff --git a/pack.h b/pack.h
index ada506b5c5..2f2ce97c11 100644
--- a/pack.h
+++ b/pack.h
@@ -106,6 +106,16 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
 void fixup_pack_header_footer(const struct git_hash_algo *, int,
 			      unsigned char *, const char *, uint32_t,
 			      unsigned char *, off_t);
+
+/*
+ * Read the report that git-index-pack(1) writes to its standard output after
+ * the packfile is written. The hexadecimal name of the packfile is appended to
+ * `pack_name` and, if `is_keep` is non-NULL, it is set to indicate whether a
+ * ".keep" file was written. Return 0 on success and a negative error code on
+ * failure.
+ */
+int read_index_pack_report(struct repository *repo, int ip_out,
+			   struct strbuf *pack_name, int *is_keep);
 char *index_pack_lockfile(struct odb_source *source, int fd,
 			  int *is_well_formed);
 
-- 
2.56.0.173.gf57c9a7388

