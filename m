Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866371FB3
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097359; cv=none; b=FMt8JgbEVUi7clqdWHwXyJVAFA2sM0Z3R96+26DwzRH2Qu2XWV5Ebr63grek1gwgPpgX7aMgbOYtkKWtpAePBYVxneib3RsV7H7UNOdHNnKMDqD0j9o+TtEYh9pwYFABhZMJEWFoFumj3HED//wJBP6g/hlR2Fnvh4dZDVzbJgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097359; c=relaxed/simple;
	bh=6makS8yGn6fuubWqP8POIkvuyGcbB50rAe/IvoK+UG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6SrGIkCJ57OmcjpA8qMK0RD8zg0KH+hOOqMmVoJm7ljyYoFIhzXUsShS6fAkv9myhyfeCig5jv4fEjwNz0huQSde7WMs+0NmDZ87HD1tMTgZNCbc9b9HD0UCRgrGrWWDCzBqrSDKXmAWlpmg8eZK3P6ruZcljK/2893nqVc9Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=EyL52DAd; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="EyL52DAd"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-77636fb28f6so7957817b3.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097356; x=1759702156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qGa4QGjeTI9Xf5ZL3NAG5RyRzOOxNxKP0ZTK30FR2h8=;
        b=EyL52DAdw71+Wpdwb8H/iaW4uKqOMeFlCotVEDAJWmX+8co7LakanLCD4TdqjpLNkW
         vB294q6VJ0CXUSy1+subWXLCJBq6GA8Nv2rJyZ5YGPV97S9RknwgYe3MjXD8Dokfhgb/
         iGg+yFWMU4ItXw3cdaaLNPTNghPvKlBvRDDlRMsoXJ/fJi+UA+u+ZyXtN2dp0cIqVx8R
         fpV6O+38ta3+d0E7dN78L97pBfCaJnZ9Lw9XCB+1CeDIi1zN+ZkWd85i5YHUmqVbU2wV
         Up4HrKRlt4Bw3DmZyDdhnr1ynkkZlcdVLZrJPJkxpLT1uTvMddZwEuD+m1pgZnsgIQm4
         aPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097356; x=1759702156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGa4QGjeTI9Xf5ZL3NAG5RyRzOOxNxKP0ZTK30FR2h8=;
        b=uHKRSDDyGtdfDcWevTzpQGWMDXtFDPRMz96VZnWUmf5ilP0R5dygiMV0tqH8ptO6Ny
         yqk8XML5Q6O9cvGFMRAdp6UrynRibapKne7Sp/SaSQzYHRc1eVoGE4ituQzn+tQafYqe
         3xeeSVZ7UKcHlPWG06k9k6J8lo0bDZ9i+co/sZzUp80pak/aKXDv7CcB1ewPtwMmNmcB
         Cn5rkF+QuYW2XAlDJ9adz17rzZCukjHJ1X4IinqlOR/jKsSqTdCttFANkLFR5V5sFk/G
         nN24TDWTkEbM8GkRY16LiTFOQGobBXjjCRFIyLqaJMelzLreWJIcCGnOnfVpNX3aHKZV
         y93A==
X-Gm-Message-State: AOJu0YzGOERH0F9Mhah1ypn9v3rJ+GCYHX89RVygoCCWxgYJHXDmNOxk
	Jd78cKc6eZWHUKE7LR3mFe80JzhjtdIHXk42SMK2XFH85YlKisOtyX0sWNDA4d/GRFIVyYZ3Yfv
	oqxItlMxTlXdo
X-Gm-Gg: ASbGncvWw//5URarsE+qoWfyAi6avapUe3WcQUR6tX/j0ibaKcy6TlGh0GAeHMhxhHb
	eojpigPqnizwP/bMpp8beXsCF0xlWDqepbj4Y0F9BnL05ReDauDBjDz/FAcI63WJq6+H9H8g2Hu
	2TN0AJhyMvyDlA2N/IkhuTEvisdowZ1+0qpUWQGtxiCs91OBaL52In0L2WC6QhuPV1taLnneOcY
	HCrto5/ClOaqLX0kax/ZK+7zTQno6V/OU6OeMuMaoXFmXSgBr96RkIsIkNk/OntvepPVxhrm1OJ
	s7fsVAwViwsoc2n/Nyvyeo4E43H3d37TtF9pkAB6iwDQ9DurogVamLBYKQ29Hk7Pb9ITbnFBBSj
	+HpoT52rm8ggkhrFoPm0ECaKWb8WEHAP6tR+Uj9afUYn62wBv6MckR4bgfTTNFEasGa5RqgYzH1
	uKYJoop2O7Pc8b6jClZYvHtzwPqg==
X-Google-Smtp-Source: AGHT+IEnYONAQIZBDGW2cQybccDER6dMdDH5pk0zhkbhC8TnxGi520Z7Tk27QJ5ox1YKtkWqOeI9fw==
X-Received: by 2002:a05:690c:60c2:b0:764:6afc:1fc with SMTP id 00721157ae682-7646afc097bmr151992877b3.14.1759097356369;
        Sun, 28 Sep 2025 15:09:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6361e985da6sm2640677d50.8.2025.09.28.15.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:09:16 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:09:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 32/49] builtin/repack.c: extract opts struct for
 'write_midx_included_packs()'
Message-ID: <3b7e204a40609264898971bf3522428696553ce0.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

The function 'write_midx_included_packs()', which is responsible for
writing a new MIDX with a given set of included packs, currently takes a
list of six arguments.

In order to extract this function out of the builtin, we have to pass
in a few additional parameters, like 'midx_must_contain_cruft' and
'packdir', which are currently declared as static variables within the
builtin/repack.c compilation unit.

Instead of adding additional parameters to `write_midx_included_packs()`
extract out an "opts" struct that names these parameters, and pass a
pointer to that, making it less cumbersome to add additional parameters.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 52 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 5a1f1cb562..e4b8aa2c6f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -107,6 +107,17 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
+struct repack_write_midx_opts {
+	struct string_list *include;
+	struct pack_geometry *geometry;
+	struct string_list *names;
+	const char *refs_snapshot;
+	const char *packdir;
+	int show_progress;
+	int write_bitmaps;
+	int midx_must_contain_cruft;
+};
+
 static int midx_has_unknown_packs(char **midx_pack_names,
 				  size_t midx_pack_names_nr,
 				  struct string_list *include,
@@ -290,19 +301,15 @@ static void midx_included_packs(struct string_list *include,
 	strbuf_release(&buf);
 }
 
-static int write_midx_included_packs(struct string_list *include,
-				     struct pack_geometry *geometry,
-				     struct string_list *names,
-				     const char *refs_snapshot,
-				     int show_progress, int write_bitmaps)
+static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
-	struct packed_git *preferred = pack_geometry_preferred_pack(geometry);
+	struct packed_git *preferred = pack_geometry_preferred_pack(opts->geometry);
 	FILE *in;
 	int ret;
 
-	if (!include->nr)
+	if (!opts->include->nr)
 		return 0;
 
 	cmd.in = -1;
@@ -311,18 +318,18 @@ static int write_midx_included_packs(struct string_list *include,
 	strvec_push(&cmd.args, "multi-pack-index");
 	strvec_pushl(&cmd.args, "write", "--stdin-packs", NULL);
 
-	if (show_progress)
+	if (opts->show_progress)
 		strvec_push(&cmd.args, "--progress");
 	else
 		strvec_push(&cmd.args, "--no-progress");
 
-	if (write_bitmaps)
+	if (opts->write_bitmaps)
 		strvec_push(&cmd.args, "--bitmap");
 
 	if (preferred)
 		strvec_pushf(&cmd.args, "--preferred-pack=%s",
 			     pack_basename(preferred));
-	else if (names->nr) {
+	else if (opts->names->nr) {
 		/* The largest pack was repacked, meaning that either
 		 * one or two packs exist depending on whether the
 		 * repository has a cruft pack or not.
@@ -335,7 +342,7 @@ static int write_midx_included_packs(struct string_list *include,
 		 * `--max-pack-size` was given, but any one of them
 		 * will suffice, so pick the first one.)
 		 */
-		for_each_string_list_item(item, names) {
+		for_each_string_list_item(item, opts->names) {
 			struct generated_pack *pack = item->util;
 			if (generated_pack_has_ext(pack, ".mtimes"))
 				continue;
@@ -355,15 +362,16 @@ static int write_midx_included_packs(struct string_list *include,
 		;
 	}
 
-	if (refs_snapshot)
-		strvec_pushf(&cmd.args, "--refs-snapshot=%s", refs_snapshot);
+	if (opts->refs_snapshot)
+		strvec_pushf(&cmd.args, "--refs-snapshot=%s",
+			     opts->refs_snapshot);
 
 	ret = start_command(&cmd);
 	if (ret)
 		return ret;
 
 	in = xfdopen(cmd.in, "w");
-	for_each_string_list_item(item, include)
+	for_each_string_list_item(item, opts->include)
 		fprintf(in, "%s\n", item->string);
 	fclose(in);
 
@@ -1001,15 +1009,23 @@ int cmd_repack(int argc,
 
 	if (write_midx) {
 		struct string_list include = STRING_LIST_INIT_DUP;
+		struct repack_write_midx_opts opts = {
+			.include = &include,
+			.geometry = &geometry,
+			.names = &names,
+			.refs_snapshot = refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
+			.packdir = packdir,
+			.show_progress = show_progress,
+			.write_bitmaps = write_bitmaps > 0,
+			.midx_must_contain_cruft = midx_must_contain_cruft
+		};
 		midx_included_packs(&include, &existing, midx_pack_names,
 				    midx_pack_names_nr, &names, &geometry);
 
-		ret = write_midx_included_packs(&include, &geometry, &names,
-						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
-						show_progress, write_bitmaps > 0);
+		ret = write_midx_included_packs(&opts);
 
 		if (!ret && write_bitmaps)
-			remove_redundant_bitmaps(&include, packdir);
+			remove_redundant_bitmaps(&include, opts.packdir);
 
 		string_list_clear(&include, 0);
 
-- 
2.51.0.243.g16eca91f2c0

