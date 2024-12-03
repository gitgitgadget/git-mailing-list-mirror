Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982361F7076
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237054; cv=none; b=pxqLkNQaDoE1BKlAe5ymWd/OSl3ksG9GcGM2Z3/+tIOWX+vILP9QySwkfxXiDV6IWPppCCSNvPvxkNbh0EyXqbv4n7gi/XS5+BL9hyU2QUD/bngP/MWDifkihVFZd7sndwvhtp/M986mPNV+Hv5IcykryFFTR76IogxGnQrs0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237054; c=relaxed/simple;
	bh=BhlE9c1QR6tNBlI+m9RScTWKCxTomwu/H/TL0xvc9CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t67e2ARPR8+i9G99P+l3iHhnvChBTfusRmZWdH0uOFQRE3ohssYRgd6CY1y5dCR48kYZaTDm9dBN6px0CeOU7cd8g0myTgDC+srOs9XbuJOLtKWcgaHGYcgQTe/u1V47sOQrROwcZ6pVswfnYX1yVZX+50YAfJckH3k9lnah4KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Why5qtbD; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Why5qtbD"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so55022281fa.3
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733237051; x=1733841851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhvpA0Cc0L+FbERRIwNQBs1ghpyPYC5FjsMk0VL74mk=;
        b=Why5qtbD81raKs31HuTuy0O+VKajRnUuftzzm0w/GwlxTvJ8TeKQhkAS/ih9m8ECiU
         U7V8jV5ERV4537tlD8H/+nV12+mc019oYg0HvRNsnlBwsPd1XQjNCBPNoQqoZ+R+5pse
         isoG4HOjPDWc3kJvWVeUZl+o3BsevYlmtDF1knXAu22DqSqu//ASlTNrl7cl1bospsEt
         TpdK1R6E0IpK028JvDJD1H9jnEK5vhSQgG60P7+eter78ARnA4ysPjB4pmLaqGfXL7UL
         o6VDpoEUDz95pY1UbizZiFVx8+HZ93bnCADg4aoNG0MLnMAqFVFB/0cqIjuhXuteh5Tg
         Zpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237051; x=1733841851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhvpA0Cc0L+FbERRIwNQBs1ghpyPYC5FjsMk0VL74mk=;
        b=MfCRnC1jHck3+OhFPxVOTxz7WKZc+5JnaqYhYPMbs8rIPU7BkR0DRKqc7bOHSIMoRf
         2GCeqxXsbHiq8jAT7RBONM149ECk+iU5RTaJ81oNIXe5o55KzOc203UDmoXSNdxK+Inx
         4XxMy2eV4zhfJX8mbhpfQ1xMft3F+MWrhtlSoO+xgPLdDs73IlF8+qSMRdIj1mdGdT4f
         VX4T4Iija3yKEcCVsgI0UEYYjWavdh/QnzMzxbwf9j/ij3vL0DNUS+yDv9UMS4DfXZ3X
         EIXVzyMab/Pjcp6fOGdp2kf6U8UtOalPITImq78iVF55EFOr4xfH9C024ROjAFos6I2h
         hD+Q==
X-Gm-Message-State: AOJu0Yw0aFiC23CR8VFMrk78NJag4GdhWRd+B3TOzcx2RghKaLnwtbFz
	YciDigumFcCJUyJNVylNSOLb3dLxMK6mUU6Z7ltLWHyRZd6bE88QQmox8DlP
X-Gm-Gg: ASbGncvyA+yKZaF9In1Du16qLkbdGYGKEbefCTdxv+/tJPQw22M/oOmD85fou7zWLFy
	jAoPoN+vcgTZikxoc3jYEjecxQmua20UOng9sT/gvXU+9XrPy0htWl5hi+EwEoJ1+oT/Fa+MP8L
	EP0mFeYrn1djglBtz9oKmHrPjhm850oHNxOWnV3P3BJs26vrsGVO7YbJDkaOiqi4Hi4f523vuU6
	9TJEzA/ZXuqhY5u9brKulYuIvzz/fjDk0JrrbDXtM1SNCFWQz1Y1TS/i1bNvfkx/IBo
X-Google-Smtp-Source: AGHT+IG+SbzhTzG5fNf0KsbNbFE58BZIU6lbYbyAxUQwAuxgxCGL3Ywmqab6BSTfvpRXwZZU3WMkxA==
X-Received: by 2002:a05:6512:3a8f:b0:53d:eddf:4ee4 with SMTP id 2adb3069b0e04-53e129f4e24mr2045652e87.17.1733237050378;
        Tue, 03 Dec 2024 06:44:10 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de782sm619021466b.56.2024.12.03.06.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:44:09 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v10 04/10] packfile: pass down repository to `odb_pack_name`
Date: Tue,  3 Dec 2024 15:43:58 +0100
Message-ID: <a8588d6086ba48262fc343257b0ff25db8db4c46.1733236936.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733236936.git.karthik.188@gmail.com>
References: <cover.1733236936.git.karthik.188@gmail.com>
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
 builtin/pack-redundant.c | 2 +-
 http.c                   | 2 +-
 packfile.c               | 9 ++++-----
 packfile.h               | 3 ++-
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index da7e2d613b..3ccc4c5722 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -806,7 +806,7 @@ static char *keep_pack(const char *curr_index_name)
 	struct strbuf name = STRBUF_INIT;
 	int keep_fd;
 
-	odb_pack_name(&name, pack_data->hash, "keep");
+	odb_pack_name(pack_data->repo, &name, pack_data->hash, "keep");
 	keep_fd = odb_pack_keep(name.buf);
 	if (keep_fd < 0)
 		die_errno("cannot create keep file");
@@ -814,11 +814,11 @@ static char *keep_pack(const char *curr_index_name)
 	if (close(keep_fd))
 		die_errno("failed to write keep file");
 
-	odb_pack_name(&name, pack_data->hash, "pack");
+	odb_pack_name(pack_data->repo, &name, pack_data->hash, "pack");
 	if (finalize_object_file(pack_data->pack_name, name.buf))
 		die("cannot store pack file");
 
-	odb_pack_name(&name, pack_data->hash, "idx");
+	odb_pack_name(pack_data->repo, &name, pack_data->hash, "idx");
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
index d2c1c4e5ec..bc61990a93 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -690,7 +690,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 	pl = red = pack_list_difference(local_packs, min);
 	while (pl) {
 		printf("%s\n%s\n",
-		       odb_pack_name(&idx_name, pl->pack->hash, "idx"),
+		       odb_pack_name(pl->pack->repo, &idx_name, pl->pack->hash, "idx"),
 		       pl->pack->pack_name);
 		pl = pl->next;
 	}
diff --git a/http.c b/http.c
index 6744e18409..420f1566f0 100644
--- a/http.c
+++ b/http.c
@@ -2581,7 +2581,7 @@ struct http_pack_request *new_direct_http_pack_request(
 
 	preq->url = url;
 
-	odb_pack_name(&preq->tmpfile, packed_git_hash, "pack");
+	odb_pack_name(the_repository, &preq->tmpfile, packed_git_hash, "pack");
 	strbuf_addstr(&preq->tmpfile, ".temp");
 	preq->packfile = fopen(preq->tmpfile.buf, "a");
 	if (!preq->packfile) {
diff --git a/packfile.c b/packfile.c
index c96ebc4c69..1015dac6db 100644
--- a/packfile.c
+++ b/packfile.c
@@ -25,13 +25,12 @@
 #include "pack-revindex.h"
 #include "promisor-remote.h"
 
-char *odb_pack_name(struct strbuf *buf,
-		    const unsigned char *hash,
-		    const char *ext)
+char *odb_pack_name(struct repository *r, struct strbuf *buf,
+		    const unsigned char *hash, const char *ext)
 {
 	strbuf_reset(buf);
-	strbuf_addf(buf, "%s/pack/pack-%s.%s", repo_get_object_directory(the_repository),
-		    hash_to_hex(hash), ext);
+	strbuf_addf(buf, "%s/pack/pack-%s.%s", repo_get_object_directory(r),
+		    hash_to_hex_algop(hash, r->hash_algo), ext);
 	return buf->buf;
 }
 
diff --git a/packfile.h b/packfile.h
index aee69d1a0b..51187f2393 100644
--- a/packfile.h
+++ b/packfile.h
@@ -29,7 +29,8 @@ struct pack_entry {
  *
  * Example: odb_pack_name(out, sha1, "idx") => ".git/objects/pack/pack-1234..idx"
  */
-char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
+char *odb_pack_name(struct repository *r, struct strbuf *buf,
+		    const unsigned char *hash, const char *ext);
 
 /*
  * Return the basename of the packfile, omitting any containing directory
-- 
2.47.1

