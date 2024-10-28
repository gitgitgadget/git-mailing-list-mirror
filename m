Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089731DDC30
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123039; cv=none; b=UVnczJTBrY9iwuHrIMicYL4W0Yxinz2717R84sIfjC3R9vlXoTVMDkW3kDGxLGP0IhLeBRL2j1A9ooNo+KAaLWEKwBNe+1LaVcQSy0804FreC7OZ47A+dumvObZG41Um/VpTcuvoCoW40s1XBFLitSskcVFCiBoacNCb61YITd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123039; c=relaxed/simple;
	bh=YG8mlZ8SDnpplVSwdTcNtTMTQ7yEw2D/xuA540AaOFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gV1wHGfczxT5U4FbNklihVICPu3sBh+K0iBbr6//r1tYWYhjFYAnkH/d8lZTRXcYdx62YhFRSBhUgaaXfllHHpjHXmlV4elwd+gxxAzjughJEXlZ78l6sQbO4JkcTSwoHjgqtHvNrtPv+OdphpbWzzQ0kFzsYRB6RaNDEi8CzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBFiq6xj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBFiq6xj"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso534595266b.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730123035; x=1730727835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRLWMCvziaP1oOWGmB649amlajM49uqxp22hhOUUrJc=;
        b=NBFiq6xjCTtvXtGC71HhaQ3DcpeiVOh6rKhVq/5Oi4biJ1TzsFG6S64Hu11PVdXZ5F
         nfBilubAPtsBqM3RQ8VD/48qFY52j4E3a/z6t4Zd0SsjcOVQ+ZatV9o2xLl+7HvD/HKj
         uBT1hdVtKJHUYF3DMJeFfy7bID7KgpW4ROVWL2Hbtd1BfFHdHEWGXXQHJE5dD4+nDAjx
         9lCw9tfDK5jXRa6fvXOmlXXNbjStKnIkZoHaiSjzUcvITuM0XowlAZs/hWHsbpCYRmAg
         0ADtqKO/5efSdAZAApZ72PuuUvvgdRG3s0sAG1n4C0x8CK1HDwSVLN6UMuHNQtdcwVwi
         KixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123035; x=1730727835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRLWMCvziaP1oOWGmB649amlajM49uqxp22hhOUUrJc=;
        b=HR7NzgNCwnDBu5b8HUtiUVKelVl36Nkyg99BaYUezdaBIT3iRDHTIrpvqjWUaFfqxm
         UYgjpbtnhAaBnAQoEpweijxCO9lYwqWiM9XOFKjVq9Z3R5jl+ii+f/igABkPyEXTx/wp
         SnkJAKUrV9KacJW3bxCFdc834Gw2F25NBG/IPDQwnb6IVxFSOb6Uhy5Lz1sGfu4RIovd
         t3tXFQiczsrbzrBMo8EndTn7GdMxr9QPnx4QL3TaywDFSSU0Em7Fs0ouRD13q8HpbfRR
         yeU9vGRcOvIHq5mYHDDl6jSRAYR4NEBMyzLNnHWYVtTEMf1OWNGBzUObuLEDqCoXpcZP
         ydGw==
X-Gm-Message-State: AOJu0YxC8iWrr+ar5lLXhK+dBv3gbooAFESbY91HMlmplZNp06dMYQvC
	YDeSPK0kfSenoKcSveMP0nI2PEQzStLVqAm9glaWky9g6gorSyaS
X-Google-Smtp-Source: AGHT+IGI4KDGqApdNFWppXA91HG9zBjjr6bonqCYZjwuoJo1lGedflz5idy/YyIGS35BwrvpMa3LkA==
X-Received: by 2002:a17:907:ea4:b0:a9a:123d:3f1a with SMTP id a640c23a62f3a-a9de5ce2676mr891277866b.17.1730123033604;
        Mon, 28 Oct 2024 06:43:53 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2971e8sm376647466b.125.2024.10.28.06.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:43:53 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com
Subject: [PATCH v2 4/8] packfile: pass down repository to `odb_pack_name`
Date: Mon, 28 Oct 2024 14:43:42 +0100
Message-ID: <73ba9945a7b7ec69e4ea29116c473b88e5c2a916.1730122499.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730122499.git.karthik.188@gmail.com>
References: <cover.1730122499.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `odb_pack_name` currently relies on the global variable
`the_repository`. To eliminate global variable usage in `packfile.c`, we
should progressively shift the dependency on the_repository to higher
layers.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fast-import.c    | 8 ++++----
 builtin/index-pack.c     | 4 ++--
 builtin/pack-redundant.c | 4 ++--
 http.c                   | 2 +-
 packfile.c               | 9 ++++-----
 packfile.h               | 3 ++-
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index ffee7d3abd..f4892d7f37 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -806,7 +806,7 @@ static char *keep_pack(const char *curr_index_name)
 	struct strbuf name = STRBUF_INIT;
 	int keep_fd;
 
-	odb_pack_name(&name, pack_data->hash, "keep");
+	odb_pack_name(the_repository, &name, pack_data->hash, "keep");
 	keep_fd = odb_pack_keep(name.buf);
 	if (keep_fd < 0)
 		die_errno("cannot create keep file");
@@ -814,11 +814,11 @@ static char *keep_pack(const char *curr_index_name)
 	if (close(keep_fd))
 		die_errno("failed to write keep file");
 
-	odb_pack_name(&name, pack_data->hash, "pack");
+	odb_pack_name(the_repository, &name, pack_data->hash, "pack");
 	if (finalize_object_file(pack_data->pack_name, name.buf))
 		die("cannot store pack file");
 
-	odb_pack_name(&name, pack_data->hash, "idx");
+	odb_pack_name(the_repository, &name, pack_data->hash, "idx");
 	if (finalize_object_file(curr_index_name, name.buf))
 		die("cannot store index file");
 	free((void *)curr_index_name);
@@ -832,7 +832,7 @@ static void unkeep_all_packs(void)
 
 	for (k = 0; k < pack_id; k++) {
 		struct packed_git *p = all_packs[k];
-		odb_pack_name(&name, p->hash, "keep");
+		odb_pack_name(p->repo, &name, p->hash, "keep");
 		unlink_or_warn(name.buf);
 	}
 	strbuf_release(&name);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index be2f99625e..eaefb41761 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1479,7 +1479,7 @@ static void write_special_file(const char *suffix, const char *msg,
 	if (pack_name)
 		filename = derive_filename(pack_name, "pack", suffix, &name_buf);
 	else
-		filename = odb_pack_name(&name_buf, hash, suffix);
+		filename = odb_pack_name(the_repository, &name_buf, hash, suffix);
 
 	fd = odb_pack_keep(filename);
 	if (fd < 0) {
@@ -1507,7 +1507,7 @@ static void rename_tmp_packfile(const char **final_name,
 {
 	if (!*final_name || strcmp(*final_name, curr_name)) {
 		if (!*final_name)
-			*final_name = odb_pack_name(name, hash, ext);
+			*final_name = odb_pack_name(the_repository, name, hash, ext);
 		if (finalize_object_file(curr_name, *final_name))
 			die(_("unable to rename temporary '*.%s' file to '%s'"),
 			    ext, *final_name);
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index d2c1c4e5ec..7d6c47ffd9 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -589,7 +589,7 @@ static void load_all(void)
 	}
 }
 
-int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED) {
+int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo) {
 	int i; int i_still_use_this = 0; struct pack_list *min = NULL, *red, *pl;
 	struct llist *ignore;
 	struct strbuf idx_name = STRBUF_INIT;
@@ -690,7 +690,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 	pl = red = pack_list_difference(local_packs, min);
 	while (pl) {
 		printf("%s\n%s\n",
-		       odb_pack_name(&idx_name, pl->pack->hash, "idx"),
+		       odb_pack_name(repo, &idx_name, pl->pack->hash, "idx"),
 		       pl->pack->pack_name);
 		pl = pl->next;
 	}
diff --git a/http.c b/http.c
index 7e5be05207..50d8811cea 100644
--- a/http.c
+++ b/http.c
@@ -2579,7 +2579,7 @@ struct http_pack_request *new_direct_http_pack_request(
 
 	preq->url = url;
 
-	odb_pack_name(&preq->tmpfile, packed_git_hash, "pack");
+	odb_pack_name(the_repository, &preq->tmpfile, packed_git_hash, "pack");
 	strbuf_addstr(&preq->tmpfile, ".temp");
 	preq->packfile = fopen(preq->tmpfile.buf, "a");
 	if (!preq->packfile) {
diff --git a/packfile.c b/packfile.c
index cc558f06cc..096a0cd6ba 100644
--- a/packfile.c
+++ b/packfile.c
@@ -25,13 +25,12 @@
 #include "pack-revindex.h"
 #include "promisor-remote.h"
 
-char *odb_pack_name(struct strbuf *buf,
-		    const unsigned char *hash,
-		    const char *ext)
+char *odb_pack_name(struct repository *repo, struct strbuf *buf,
+		    const unsigned char *hash, const char *ext)
 {
 	strbuf_reset(buf);
-	strbuf_addf(buf, "%s/pack/pack-%s.%s", repo_get_object_directory(the_repository),
-		    hash_to_hex(hash), ext);
+	strbuf_addf(buf, "%s/pack/pack-%s.%s", repo_get_object_directory(repo),
+		    hash_to_hex_algop(hash, repo->hash_algo), ext);
 	return buf->buf;
 }
 
diff --git a/packfile.h b/packfile.h
index 344da905c2..48d058699d 100644
--- a/packfile.h
+++ b/packfile.h
@@ -29,7 +29,8 @@ struct pack_entry {
  *
  * Example: odb_pack_name(out, sha1, "idx") => ".git/objects/pack/pack-1234..idx"
  */
-char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
+char *odb_pack_name(struct repository *repo, struct strbuf *buf,
+		    const unsigned char *hash, const char *ext);
 
 /*
  * Return the basename of the packfile, omitting any containing directory
-- 
2.47.0

