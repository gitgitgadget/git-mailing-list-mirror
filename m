Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233462;
	b=XAU+fv8uRF1VSiUIdg/w74IdrKaCzc8o1WeIDZUX7U8Ujl9Ypb3K7yTqIjGgiS9PPa1u
	 HQiLYCbEQ7YIqyo9S1MkGOMuwv5ItAK+sPX1LoG5XaseG6lskQ1G4s+7jHup8SO55RIG9
	 pl7//EwGPadWlDfwwC3uU9swzP1MiKs1rBvltdtNdkGl6s+I5Z3xXJHF5iQxgqCmLKTW0
	 uCMEFja5N9NNAr/3bZR3Q1giiQwhRinsAJq+Jke5Ox6gv33l6ceVZyDAuL1HwsVMAj099
	 UgfZPzX3rkxLmKoxdWgRJVx23qUvcq19E2qmP2KrSZ23FESmb1yly/4Sw69ehbx3afA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oQMTWolzwo73s8phra6UAR/AeawSnETL+hGRjFtomsA=;
	b=UiwiPmUvncGik9/4xz9JZA7d3uVVghUXLEQdsXKVwjcSHjQOgG45DF/ZUGyvVkfl/e27
	 i2WmNaaJkyaDYd5SXDDWRDgGxCi169OTSpYa9VkS68/stSPjoE/+pbd6XaNJUEXlrTo72
	 b04Ycaj3bOkLrX7ep8lQTevUko74Ld79jtU1shGpVb7b7PaafHXUbgU829kgNiaegxlMP
	 kAB0WXWyR5V1FcA3tJm5Z9/fDaXCqaIoP+Y0zJRv7BZKBDo4f0TLzJcBFJ3nxyuc5TgjP
	 UFJ2shMqMi5iCvoGZmudjT0Y61fsSE59j764R/G0mgqKUjtIOBvwG72jBT7evbGPFHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="w/QWTrq0";
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712AF606A336
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 00:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 712AF606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w/QWTrq0
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-714d57774d8so529584eaf.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 17:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793233461; x=1793838261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oQMTWolzwo73s8phra6UAR/AeawSnETL+hGRjFtomsA=;
        b=w/QWTrq0CHUdF1zVkWT+oSnW8naWdpqx60VUCP5+Ssta6AglEYJbm/GN8LYtNra+fT
         tS88f7nhS9Vq+16TVflKTvA7ZPDjOooLqVGNuwjhCUWnoTgIu4jwOJFG5K8bjwUfZKQ5
         B3O7su9iMYhQW+UV2vjQ2fKEFhP26P6vYfUBQBrS574fHABiAcm2NHLLC/4z6WmUJ5Lb
         bfZMakv/Dpler5o21Rr6HI6UwrEPNYgoiOgZVvzXCr10C6nuRuVkcBUYRka1Pyqd7pWX
         1if2j3PosY5fAvpsi7SSSjeTAiSJMbwe95tEOqBDQV3MajOblx7p9VxCSWR1BlLJzh0F
         GQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793233461; x=1793838261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oQMTWolzwo73s8phra6UAR/AeawSnETL+hGRjFtomsA=;
        b=YQvffen/XTn2plKGjUKBXVYkr4gkdheWsbEp4x4E4lGmmowOCOlv7AyhHYDpJ1n0MV
         lRQ0jyPa+Dn+cXBZhOb7wgOsMK4CwzYPF5UixNdpIFW5CvWHqjbj6IKhl/lZkdPqUvOK
         xJA3iu1EXLs8PkjvUCwIfNn3zxv9qHaE+4aCxQQIYUwHtZkZZJVgupNekf8LPeLm684g
         9l2qNBMb7OAMq8UwowWjAqn4bV4QxirtEz/npb6NdtoBPLspiHJRcIU/7ttEpDySk5Yc
         +qjUFMp7EE6SiU+oWMJZgjLHbv0bWJLEgRLIXURz8CcCz+gBQkLpT3Dlqu44+08MkZq7
         nIIg==
X-Gm-Message-State: AFq9FYI6iakJEeLhq1XUjn3QZI1UUXWV23CczJ8Bx4iR4XF4dCvfuysC
	yOKLH/JRefaCi5/bq5mzOe5/An4uxQofbFJdZycRpikFFXTfUiAcwTfkX1mvWw==
X-Gm-Gg: AYBFou0hAaVDPPL0hSWMP96vVzSuyFqCZRSnvG07oPQno+IHbV3yPyqzo+3ntow3Ozl
	CjcfkAxcXvumqoBOqdzdzHK5gfocNzrqg6e0fWLhwka5GWC+EambD9n97eMWdmCb744ngAZssKQ
	GxzDnBdhTXlNLRto8UrOa9aF+coP+dfgsBd9YP235RRWJsfjT6BTbYY4KC+ja1jkdfh07gkW3BA
	YiXIxfOrVO0V7upqp00hZ7vZqXiGhia3kjFbMikAeccq+r8jZ2cWPeJ/1qubJYqGHnV/jlt1RRg
	kVCi6xfCHooe9abOI5mobva4z6HNbbUHBqp+T+8qaniAdfUAhcSD2yiLsr4cj+RSfYGv49vKNlo
	64PKH/GRBKj3jZ4jskGKDYw+g0oEyD7RDBcZ3xpxtpVSqUkDQ6J5cu+IIYqDpTY6GxI9RAlcGfd
	9JDG61n9rhA8saEkF9M5miaL5A0YaBbHRL82ETeiEFBcm+poyFQvOq1rHq0KH66iW4DN/1VMDdY
	zgW7cadi/fbfPRImADOOGX1tC6A0v9+68tuhyZBIUq/VDG/XzYVCItH1LcxdhJFzgrGkmGE3iir
	+sl3kihwjC4h2dx15sg6Mir8wEodjlppUdcgktNRtzCNNy4AZNDXz9pSdVR3wyWrP2iwQQ==
X-Received: by 2002:a05:6820:f014:b0:70d:a1df:7dec with SMTP id 006d021491bc7-713ef23f1camr2224823eaf.32.1793233461231;
        Wed, 28 Oct 2026 17:24:21 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7142bb7942fsm2976439eaf.5.2026.10.28.17.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:24:20 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/4] loose: lift loose object index writing logic into helper
Date: Wed, 28 Oct 2026 19:24:12 -0500
Message-ID: <20261029002413.3291184-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261029002413.3291184-1-jltobler@gmail.com>
References: <20261022234007.3081825-1-jltobler@gmail.com>
 <20261029002413.3291184-1-jltobler@gmail.com>
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

Writing the in-memory loose object map to a "loose-object-idx" file is
handled via `repo_write_loose_object_map()`, which always writes the map
into the primary object directory. In a subsequent commit, a separate
"loose-object-idx" file is staged prior to commit and must be
constructed from a loose object map not attached to the primary loose
object source.

Extract the logic for writing a loose object index file into a separate
`loose_object_map_write()` helper function that allows callers to
explicitly specify both the loose object map as well as the file
descriptor to write the entries to.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 loose.c | 69 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/loose.c b/loose.c
index 5f72c644f9..f2e111c25e 100644
--- a/loose.c
+++ b/loose.c
@@ -146,25 +146,17 @@ int repo_read_loose_object_map(struct repository *repo)
 	return 0;
 }
 
-int repo_write_loose_object_map(struct repository *repo)
+static int loose_object_map_write(struct repository *repo,
+				  struct loose_object_map *loose_map, int fd)
 {
-	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
-	kh_oid_map_t *map = files->dirs->loose->map->to_compat;
-	struct lock_file lock;
-	int fd;
+	kh_oid_map_t *map = loose_map->to_compat;
+	struct strbuf buf = STRBUF_INIT;
 	khiter_t iter;
-	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
-
-	if (!should_use_loose_object_map(repo))
-		return 0;
+	int ret = -1;
 
-	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
-	fd = repo_hold_lock_file_for_update_timeout(repo, &lock, path.buf,
-						    LOCK_DIE_ON_ERROR,
-						    LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS);
 	iter = kh_begin(map);
 	if (write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
-		goto errout;
+		goto out;
 
 	for (; iter != kh_end(map); iter++) {
 		if (kh_exist(map, iter)) {
@@ -173,24 +165,53 @@ int repo_write_loose_object_map(struct repository *repo)
 				continue;
 			strbuf_addf(&buf, "%s %s\n", oid_to_hex(&kh_key(map, iter)), oid_to_hex(kh_value(map, iter)));
 			if (write_in_full(fd, buf.buf, buf.len) < 0)
-				goto errout;
+				goto out;
 			strbuf_reset(&buf);
 		}
 	}
+
+	ret = 0;
+
+out:
 	strbuf_release(&buf);
+
+	return ret;
+}
+
+int repo_write_loose_object_map(struct repository *repo)
+{
+	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
+	struct strbuf path = STRBUF_INIT;
+	struct lock_file lock;
+	int ret;
+	int fd;
+
+	if (!should_use_loose_object_map(repo))
+		return 0;
+
+	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
+	fd = repo_hold_lock_file_for_update_timeout(repo, &lock, path.buf,
+						    LOCK_DIE_ON_ERROR,
+						    LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS);
+
+	if (loose_object_map_write(repo, files->dirs->loose->map, fd) < 0) {
+		ret = error_errno(_("unable to write %s"),
+				  get_lock_file_path(&lock));
+		goto out;
+	}
+
 	if (commit_lock_file(&lock) < 0) {
-		error_errno(_("could not write loose object index %s"), path.buf);
-		strbuf_release(&path);
-		return -1;
+		ret = error_errno(_("unable to write %s"), path.buf);
+		goto out;
 	}
-	strbuf_release(&path);
-	return 0;
-errout:
+
+	ret = 0;
+
+out:
 	rollback_lock_file(&lock);
-	strbuf_release(&buf);
-	error_errno(_("failed to write loose object index %s"), path.buf);
 	strbuf_release(&path);
-	return -1;
+
+	return ret;
 }
 
 static int write_one_object(struct odb_source_loose *loose,
-- 
2.56.0.173.gf57c9a7388

