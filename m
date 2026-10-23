Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759843;
	b=hxPlO51+y/Oppd8498coGQzqC3R0uRzBuZpYF94CU7dNXsnth5MHYLNt1aqx5ePdVxWi
	 uCBnue5IkbU6oZa8h/3+GjnXZDbZlFVstI2llwQyDxazcZma9MZRX0AvMLuCarGRPjyNV
	 EqDLIWuoUZ1mI5NdfCdwXUJq5y7BKwYKLGjoCOfjkOFiYhiCrqX3YwpQqY6w5mP0Ig0FM
	 wM43V7V8QnnBQbEVd4bj9A625owuE4v2JKSc7APNk8vlODWRjXBPSXyIoKTDf4ey3zrsr
	 NoiycVg7pOtoJTmKjaTj+zEH9J7Eo/sns4m/IZILxuANxpt/N9N1HQLAkNUu4mcnchg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759843;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=HOmv8gKq9gRuzveIPQY643lgfXMgVz4+qNetOC4PSnc=;
	b=mcP3Z8FnSNxv7pnk8SFWb2VU7xRQ6NUnldngcIaRAaNHtBn4EgUgtlaaETPebN/Vjqt/
	 KeVWEyp8DZZezTTd5xvwoGvQ2+kocxcrhDc61yOwuXRSXmJD8Iswwb39cXrjXFDMay4RA
	 mJbHq67fFgoqEo8PbbhXOOwbrz7HjgWMAWqWJ9hpKWAVM8PoeBJhhQ/dHWngvbMWnrH8k
	 /+9ODnbqVRrOZIRKTA1dPBlN5UyQyhylMc6JXJNwon0nc1F3HcxpTSxpSATPL9VLpvz0w
	 1IQWrkSBy3V/x2yrr83prcUz2o6HCt4tZTuoQdK+pRPElV0uwEVyxhh8CZxtVrcR/Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=DkHR4V+r;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=D4XQlgbk;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D38606A335
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03D38606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=DkHR4V+r;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=D4XQlgbk
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 519527A024D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 23 Oct 2026 08:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792759842;
	 x=1792846242; bh=HOmv8gKq9gRuzveIPQY643lgfXMgVz4+qNetOC4PSnc=; b=
	DkHR4V+ryd5RPzN+GmccsU7rdzTe5UEK1o7WUQnlXi+iP49UXNQ8+Tp5ySnhvYwa
	87KKImjuBIltk85zPk7rDBQEFFEb0SjGbG0CineTPfjh8ymZXTWFSEgK5rymSaxy
	vL33rrwZZhhO87o/kGWCJ3aRVCcq4hyP/XL6OBcsOUq/VSnM6o4lE4UKmGnJV2+a
	IajUxF5XqkXYBCi+mN1V/t6DlkrRQ4c5s/Xf89x+2DYDWaOMqENN4o5EExabt0qj
	yJrn1CB8qa/W3f81zg10gni8piK2Pm0qTCrSZBrFSU1azj8/4Y4ScnizeMi4V3fZ
	orHd68H21O/+13xUJyT3/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792759842; x=
	1792846242; bh=HOmv8gKq9gRuzveIPQY643lgfXMgVz4+qNetOC4PSnc=; b=D
	4XQlgbki7OpS1cOR8AHiREAm3AWwqc00Ohrs9FsIkHcsrUws87KZYRyLDv4pYfNq
	YJeDp/1PCfZx6froafjfUF5GDakIkxnBISR3Ix4u+U96dvpyloEHqRgOueu13DJC
	R5vcCXmv3FrIPYLq7pTDwuzPxrCiSrXp+8hkHcW3BtF/qE8etCbUESeOF3PfvcGR
	gAAzH/gk2jGVuUIO888w05NlRj/4LzBujuciBiKcNuzpSi5Vv2yaytsDaHvwYKZv
	NyZvtevfzU21j3hbhdso1SgCupvy9bVpa2IcJBexHWNoozaynCNH+lpTuLGBmxsf
	48pKDY/yM7PpzISaFsnsg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759842; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:iTMK1fl88/AcZHTpIajRc6IiShjGRZNber1i/cUf9otsxFJ
	mpsdw9IpqIpjOXGlJC6HOy1rgJ8SZmRe0BbQ4IodcIfucvyhaHn+kRtwDCN0cos2
	5jMvv/KkUMFmfqdaHvUi/IHvevofO4GRUSCQoXFmsl6Jma+QqFiRZ8mk6Zn9+kYf
	ThyyAmd0Tf6X4GRBU+rWNVoAsGDpfMSP6o7U8uvoU7QR9ieFv8lDSENqHyg644cw
	rj8qlM2rwcRXch+JtYQQisZA+3uq13dOhyhBuFLdR7T6fk0xXEnMlbSUM1R5R2Tm
	93Zu54ZssTinopLZlR8CGywO1C6JHcbIl+ToR2A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:kVl1MSs7eu4XRwJescmOSlmvxWMFpaTzNX0D3nEzYnA=:a3CTJlVhQi5W8zflEl5SNVzBRgECy8jZDTuGYg2hjEg=;
X-ME-Sender: <xms:IljbatsWU0gjvJrCYCNkICA3i7_NMsU1sa24vftxAWDTswp1cDhXoQ>
    <xme:IljbataRbRRTehMQNAJ5G8tCf2S7cz9Bg0gR3Gh2WM4NAbLAGUofZO0aumQlKlrND
    lbJczaQqFreulw65xW325FsEDgBvVJWZzeWAcZuiUU7PSY5I5zfQw>
X-ME-Received: <xmr:IljbambHF6VQRqxVA5feVROAu-IpP76W4V4e8dZnH8QNMk9zAv-aYU8qG44C9BH-ja3hOw>
X-ME-Proxy-Cause: dmFkZTEZWmY0Qmse88D2CTZhoi8Qx0ylXXKu6tAIs+BgXtqVGgxd/BqeTscGyUMn+xFilD
    dbRwCxMug0rRp6s2RoHecdj9ea5hmWM3L0vQAhPjkBlnRMmj4SG+wUEhQrwSSuqtYxqSMC
    m0DRlT9dFvfAw6sGkgKQCvfsTOB64d/ziRgeOvb//JwOSbc/YIHWTXEF+8OhqYrYvtRrzq
    zE7xBm+kNci6V80J9kphE1a+aIP4j5lXX++BQuYnY6ASX3lpSXvU862yeG9TYukAXi3HGA
    UpXkLszIvdbN24fmOyyIJRzRCJfv7/ZJ3cqGbKu2PvQsXxJGlHHRMZ823g3aWBbaY1FNSi
    lwFl1UPR69AKyGHXDSSxWs4Y+s9AvGbIH9P8khwbvhdRW8Lw3RkZKN5uqnDQjayWP1tOvn
    UvTKIs6lxudhDoAjeJ00rtPNnCc/gSpgUOu68Ev6znc67ENB++PmuI/Ya+UGE2z8TKE3Zm
    JwGH7WQ4LOrNClCwO3qQwqiFwGGdZGbAMqgqqbmPPlvp7+gFNsRLoHLoUrsQXB1IrrTa28
    UucjOGJJi8EK4uN5KTzIkw7DZpk5J7f7tYtO2zasgbYm3zuMIpiQmAOwhfYYIacWDMyxAN
    SM/jZ1n5+3sPkToT+Oap189eQojdneJFtsC9P6gz7m4eok8QxHA+LrxQBo/g
X-ME-Proxy: <xmx:IljbapULw1a7H_OJKI_74FTbD6LlTtaFbF8HFQx1a64fStWohCqKYw>
    <xmx:Iljbat3B9LF4U6EcdnbJpp2mFQbO9oYqRCkhG3Pc8UZpsdHpDcI83w>
    <xmx:IljbagYGysqVixf30MsxgELiqfSzFd9vvytxneVeeLGGx4vhjw2u4A>
    <xmx:Iljbagr-9KmAyw5Hr3sU1y7FbM6Tr4eET-jIBvCss4qNhWp1wYWjFw>
    <xmx:IljbakdqFQ-iiZxC46lGc435QvC5Og2ZMOkS2xxzu6v-mArFabfMg-u7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0e4b69bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 23 Oct 2026 12:50:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 14:50:19 +0200
Subject: [PATCH 2/7] rerere: stop using `the_repository` in internal
 helpers
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-pks-rerere-wo-the-repository-v1-2-b6ac0c2e4b81@pks.im>
References: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
In-Reply-To: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Most of the static helpers in "rerere.c" still rely on `the_repository`
even though their callers already have a `struct repository` available.
Thread the repository through those helpers so that we can get rid of
references to that global variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 rerere.c | 69 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/rerere.c b/rerere.c
index 356111838c..c568bd5e89 100644
--- a/rerere.c
+++ b/rerere.c
@@ -129,13 +129,13 @@ static int is_rr_file(const char *name, const char *filename, int *variant)
 	return 1;
 }
 
-static void scan_rerere_dir(struct rerere_dir *rr_dir)
+static void scan_rerere_dir(struct repository *r, struct rerere_dir *rr_dir)
 {
 	struct dirent *de;
 	char *path;
 	DIR *dir;
 
-	path = repo_git_path(the_repository, "rr-cache/%s", rr_dir->name);
+	path = repo_git_path(r, "rr-cache/%s", rr_dir->name);
 	dir = opendir(path);
 	free(path);
 	if (!dir)
@@ -154,7 +154,7 @@ static void scan_rerere_dir(struct rerere_dir *rr_dir)
 	closedir(dir);
 }
 
-static struct rerere_dir *find_rerere_dir(const char *hex)
+static struct rerere_dir *find_rerere_dir(struct repository *r, const char *hex)
 {
 	struct rerere_dir *rr_dir;
 
@@ -166,7 +166,7 @@ static struct rerere_dir *find_rerere_dir(const char *hex)
 		rr_dir->status_alloc = 0;
 		strmap_put(&rerere_dirs, hex, rr_dir);
 
-		scan_rerere_dir(rr_dir);
+		scan_rerere_dir(r, rr_dir);
 	}
 	return rr_dir;
 }
@@ -181,17 +181,17 @@ static int has_rerere_resolution(const struct rerere_id *id)
 	return ((id->collection->status[variant] & both) == both);
 }
 
-static struct rerere_id *new_rerere_id_hex(char *hex)
+static struct rerere_id *new_rerere_id_hex(struct repository *r, char *hex)
 {
 	struct rerere_id *id = xmalloc(sizeof(*id));
-	id->collection = find_rerere_dir(hex);
+	id->collection = find_rerere_dir(r, hex);
 	id->variant = -1; /* not known yet */
 	return id;
 }
 
-static struct rerere_id *new_rerere_id(unsigned char *hash)
+static struct rerere_id *new_rerere_id(struct repository *r, unsigned char *hash)
 {
-	return new_rerere_id_hex(hash_to_hex(hash));
+	return new_rerere_id_hex(r, hash_to_hex(hash));
 }
 
 /*
@@ -213,7 +213,7 @@ static void read_rr(struct repository *r, struct string_list *rr)
 		unsigned char hash[GIT_MAX_RAWSZ];
 		struct rerere_id *id;
 		int variant;
-		const unsigned hexsz = the_hash_algo->hexsz;
+		const unsigned hexsz = r->hash_algo->hexsz;
 
 		/* There has to be the hash, tab, path and then NUL */
 		if (buf.len < hexsz + 2 || get_hash_hex(buf.buf, hash))
@@ -231,7 +231,7 @@ static void read_rr(struct repository *r, struct string_list *rr)
 		if (*(path++) != '\t')
 			die(_("corrupt MERGE_RR"));
 		buf.buf[hexsz] = '\0';
-		id = new_rerere_id_hex(buf.buf);
+		id = new_rerere_id_hex(r, buf.buf);
 		id->variant = variant;
 		/*
 		 * make sure id->collection->status has enough space
@@ -411,13 +411,14 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
  * Return 1 if conflict hunks are found, 0 if there are no conflict
  * hunks and -1 if an error occurred.
  */
-static int handle_path(unsigned char *hash, struct rerere_io *io, int marker_size)
+static int handle_path(struct repository *r,
+		       unsigned char *hash, struct rerere_io *io, int marker_size)
 {
 	struct git_hash_ctx ctx;
 	struct strbuf buf = STRBUF_INIT, out = STRBUF_INIT;
 	int has_conflicts = 0;
 	if (hash)
-		git_hash_init(&ctx, the_hash_algo);
+		git_hash_init(&ctx, r->hash_algo);
 
 	while (!io->getline(&buf, io)) {
 		if (is_conflict_marker_line(buf.buf, buf.len, marker_size) == '<') {
@@ -466,7 +467,7 @@ static int handle_file(struct index_state *istate,
 		}
 	}
 
-	has_conflicts = handle_path(hash, (struct rerere_io *)&io, marker_size);
+	has_conflicts = handle_path(istate->repo, hash, (struct rerere_io *)&io, marker_size);
 
 	fclose(io.input);
 	if (io.io.wrerror)
@@ -746,7 +747,7 @@ static void do_rerere_one_path(struct index_state *istate,
 			const char *postimage =
 				rerere_path(istate->repo, &buf, id, "postimage");
 
-			if (copy_file(the_repository,
+			if (copy_file(istate->repo,
 				      postimage,
 				      path, 0666)) {
 				if (!had_postimage)
@@ -853,11 +854,11 @@ static int do_plain_rerere(struct repository *r,
 		if (ret < 1)
 			continue;
 
-		id = new_rerere_id(hash);
+		id = new_rerere_id(r, hash);
 		string_list_insert(rr, path)->util = id;
 
 		/* Ensure that the directory exists. */
-		safe_create_dir_in_gitdir(the_repository, rerere_path(r, &buf, id, NULL));
+		safe_create_dir_in_gitdir(r, rerere_path(r, &buf, id, NULL));
 	}
 
 	for (i = 0; i < rr->nr; i++)
@@ -872,18 +873,17 @@ static int do_plain_rerere(struct repository *r,
 	return write_rr(rr, fd);
 }
 
-static void git_rerere_config(void)
+static void git_rerere_config(struct repository *r)
 {
-	repo_config_get_bool(the_repository, "rerere.enabled", &rerere_enabled);
-	repo_config_get_bool(the_repository, "rerere.autoupdate", &rerere_autoupdate);
-	repo_config_get_int(the_repository, "rerere.locktimeout",
-			    &rerere_lock_timeout_ms);
-	repo_config(the_repository, git_default_config, NULL);
+	repo_config_get_bool(r, "rerere.enabled", &rerere_enabled);
+	repo_config_get_bool(r, "rerere.autoupdate", &rerere_autoupdate);
+	repo_config_get_int(r, "rerere.locktimeout", &rerere_lock_timeout_ms);
+	repo_config(r, git_default_config, NULL);
 }
 
 static GIT_PATH_FUNC(git_path_rr_cache, "rr-cache")
 
-static int is_rerere_enabled(void)
+static int is_rerere_enabled(struct repository *r)
 {
 	int rr_cache_exists;
 
@@ -895,7 +895,7 @@ static int is_rerere_enabled(void)
 		return rr_cache_exists;
 
 	if (!rr_cache_exists &&
-	    safe_create_dir_in_gitdir(the_repository, git_path_rr_cache()))
+	    safe_create_dir_in_gitdir(r, git_path_rr_cache()))
 		die(_("could not create directory '%s'"), git_path_rr_cache());
 	return 1;
 }
@@ -904,8 +904,8 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 {
 	int fd;
 
-	git_rerere_config();
-	if (!is_rerere_enabled())
+	git_rerere_config(r);
+	if (!is_rerere_enabled(r))
 		return -1;
 
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
@@ -1017,7 +1017,7 @@ static int handle_cache(struct index_state *istate,
 			break;
 		i = ce_stage(ce) - 1;
 		if (!mmfile[i].ptr) {
-			mmfile[i].ptr = odb_read_object(the_repository->objects,
+			mmfile[i].ptr = odb_read_object(istate->repo->objects,
 							&ce->oid, &type, &size);
 			if (!mmfile[i].ptr)
 				die(_("unable to read %s"),
@@ -1053,7 +1053,8 @@ static int handle_cache(struct index_state *istate,
 	 * Grab the conflict ID and optionally write the original
 	 * contents with conflict markers out.
 	 */
-	has_conflicts = handle_path(hash, (struct rerere_io *)&io, marker_size);
+	has_conflicts = handle_path(istate->repo, hash,
+				    (struct rerere_io *)&io, marker_size);
 	strbuf_release(&io.input);
 	if (io.io.output)
 		fclose(io.io.output);
@@ -1080,7 +1081,7 @@ static int rerere_forget_one_path(struct index_state *istate,
 		return error(_("could not parse conflict hunks in '%s'"), path);
 
 	/* Nuke the recorded resolution for the conflict */
-	id = new_rerere_id(hash);
+	id = new_rerere_id(istate->repo, hash);
 
 	for (id->variant = 0;
 	     id->variant < id->collection->status_nr;
@@ -1295,7 +1296,7 @@ bool rerere_gc_needed(struct repository *r, size_t limit)
 		    !is_rr_cache_dirname(e->d_name))
 			continue;
 
-		id.collection = find_rerere_dir(e->d_name);
+		id.collection = find_rerere_dir(r, e->d_name);
 		for (id.variant = 0;
 		     id.variant < id.collection->status_nr;
 		     id.variant++) {
@@ -1332,8 +1333,8 @@ void rerere_gc(struct repository *r, struct string_list *rr, int flags)
 		return;
 
 	rerere_gc_cutoffs(r, &cutoff_resolve, &cutoff_noresolve);
-	repo_config(the_repository, git_default_config, NULL);
-	dir = opendir(repo_git_path_replace(the_repository, &buf, "rr-cache"));
+	repo_config(r, git_default_config, NULL);
+	dir = opendir(repo_git_path_replace(r, &buf, "rr-cache"));
 	if (!dir)
 		die_errno(_("unable to open rr-cache directory"));
 	/* Collect stale conflict IDs ... */
@@ -1345,7 +1346,7 @@ void rerere_gc(struct repository *r, struct string_list *rr, int flags)
 		if (!is_rr_cache_dirname(e->d_name))
 			continue; /* or should we remove e->d_name? */
 
-		rr_dir = find_rerere_dir(e->d_name);
+		rr_dir = find_rerere_dir(r, e->d_name);
 
 		now_empty = 1;
 		for (id.variant = 0, id.collection = rr_dir;
@@ -1362,7 +1363,7 @@ void rerere_gc(struct repository *r, struct string_list *rr, int flags)
 
 	/* ... and then remove the empty directories */
 	for (i = 0; i < to_remove.nr; i++)
-		rmdir(repo_git_path_replace(the_repository, &buf,
+		rmdir(repo_git_path_replace(r, &buf,
 					    "rr-cache/%s", to_remove.items[i].string));
 
 	string_list_clear(&to_remove, 0);

-- 
2.56.0.307.g5fe7bd680c.dirty

