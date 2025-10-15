Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F185730F94B
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567337; cv=none; b=KZLvUeTDhluZ/psbyTcSF8r0Ac2z6vEGpde+ls4cBbaMhZ/U7SyE320+ZKLP1hFwAI9uDBOzvN298ZwCB01qB7A76yqkS4iyd3h3XBTva+JwTKSWc3ItS8oPeOjmfn5T+oDoRYP6PskmZNvknoX9p2wK95Pbfbe/1eT/X+TXGrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567337; c=relaxed/simple;
	bh=joowb36e3eEoeH2OtCvtB+9zI/wO2hcqQk9Ut6c6UKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5USDMnO+9uuRUmVUs7wtC5SUUUq6vLZn+pQGMFVxShc5FPqkcA/RA7PAlOkSWUBUnW5nJkHEmKUp9KHULyjM/2AGcKFT+NyYDtqVggSZmX3wFQ57vBacGehMx7g4efhIsQKL+pQpfTEQs3oCNEDddnzsKIITJFM7K1XKJvLVuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DFCsuZf3; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DFCsuZf3"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-63497c2a27dso144055d50.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567335; x=1761172135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3Rvr0A79RxM7IUHOTVR6ki03g7pu/F/TQCt+dHcK/w=;
        b=DFCsuZf33+uujRrr2C0urRVw4mf2rVntmQmjcTCc7HkpcYIUl1Gccl0Le2/ObDnsHy
         w1+u52pAwan5r40ZUKNggQhem1oX+vI9IXEGT5H1hyOEgvkA8bCtQCyMWWHP451Hp5jj
         rvZGC5R0K3OPBU7Ostgtd2KGM+ypoMNtY4YbTbuk2xEbpjW40Au5YO0loFiz+DrQUm5D
         DkByQa8XrvHa3xU8kXkvURCY4xO0D3o90eZZGR2/dgPLo8t9smgxLqbpO+/8IVQFlVJB
         n18H7M45eMAwYWTOnzPPoljIPGvk0glHBd7OO1g0VABe4UEaQZN2rEtLp2yqnEBThP1x
         SzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567335; x=1761172135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3Rvr0A79RxM7IUHOTVR6ki03g7pu/F/TQCt+dHcK/w=;
        b=JOIoDegTTvLZR2abDd9DlVbVyomKMyFBdfL2x36dPOnrTGUpOWBSGCLuRLucwSMaZo
         dsmvlSGHMwYrMWLBPE2qq7jVPWcnSN9X6Nv1DirW5+VMhsNyW0MV99BVLtIWheHJDaXL
         CgUYOjKQQKDnH1CQXfq5A2k7MbOa7ekSEF+Nr+ekzelJ+5cvrpLgIU9SzRFmx41W/JoH
         Q2zmunsQLoSJ+7vo5bGpzgcokSdbRxeHHXxOUyRojgRNGs8dhjAUqKC6eckB5oiybmRR
         iFKoUI82Pc6q4i52oScqDnW86JtNY0+TeFYUi6wM6SF0JblkfC/hFdrcUEPq8AlFCLFT
         044A==
X-Gm-Message-State: AOJu0Yy6UOt5s+NqAb3WcS5BPcpwPnyoYynSqtNy0qWQVCRzj8VBr7Rz
	IbCFhA/Wub/0PgIfsEfkRN8DrdyhtCrLvMEM+solm5i/9/rILo+ovV5MdXoZ5F97OnoKgWmYPil
	H9z1flJwInet3
X-Gm-Gg: ASbGncsIRvcueOYeZ1WOkL6KkTp7JWICf/3Gr0RAk/p/Ng9UDrfvdkZMs9bVnlziRca
	ILn2H7VVW+i6OlqGPDKmyqebdxbW9+4Lt4T+aSd4TzMFe/wSriVI0CDPcMhOn2ar83OXYZKZIuT
	7YSAA75UXjOby5HiRgm5ZvrgGVnsvc74xqN0gEczoapd4gMNAOk+4/E5945gpNFqggqYy7sc74c
	ACV5Ow+XOoWSPBouFhnMOdJb+qk1nso4kOou2DH6zyIz4f5uhdyOn02L4Wp7+72bUQDfr7otiRy
	tSZGaIqbx6Kxe/sUBbgo2RjrNLxh3FIgXwVkVciPTzZVeCvtynEGBVWwVn4a9yT2/17EpUXI5wt
	4I8x2APOwMA/NANXcMqs11JUOVYpUoEGtqVrQfGnvUBPHbyXIZ2hnZ6NIpJttLbjXldUq/QTlcA
	KJ/n4LB9kNI1GAvN4FtFpn3lIj/tHLRPGO4OA2ei0EgfSDL0cKFPNuDAwPwSxoLwAUM3+1VfpD4
	/PFT3X0/aHNjs8Llw==
X-Google-Smtp-Source: AGHT+IFWxfGvZqH5b0olr1siplxnsTo3T8M6kKAokojxHRJVWd4s6y66z8WXAluHFgZZpQG61+ttkg==
X-Received: by 2002:a05:690c:b86:b0:781:20e0:5a77 with SMTP id 00721157ae682-78124f5f79fmr199124577b3.62.1760567334768;
        Wed, 15 Oct 2025 15:28:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-782934f7d0esm2569857b3.53.2025.10.15.15.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:54 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 32/49] builtin/repack.c: extract opts struct for
 'write_midx_included_packs()'
Message-ID: <077f06c935ad268186cd9162fcef82fdc2a76b81.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

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
index 7713721826..1a79d1d834 100644
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
2.51.0.540.ga7423965ad8

