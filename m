Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB183AE1BB
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521828; cv=none; b=DhiTo67IAZoENqRGpPETY98jDe5yY8+0qCkAWhYekcRH9LNdL+xtRjBrZnQJOv+9RFfAQRW+B1xbtxpUFv+Ux5yLMQupuHH1Mvu2xE8juPNzGw79mPdBdpLyYDB52Y/qph8CVpIamP65/84pKxYnkQqIgGkbYlMx6WgpauOAWPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521828; c=relaxed/simple;
	bh=SCgiYEcguM9cScfCecDfRlgMMOnXVktqrWK85NZFYZw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sGyRqpuAdCRQyXeyERPi3s3WSlU3jOgBhJQTyEeKV0igWytMtBqeyyFOeN04EJTeM02VYUYPZVrDetVYFEhMPr49UeoSNWRp8I9lWcCeJnpLZodjCjH5T/ifuZ3ZMODW9rah/MtSrZ+WMwThUyitJdd9lo+rozSWEB2giucOWwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHtbMXKf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHtbMXKf"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caea3f742bso8810455ad.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521826; x=1787126626; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=THLt5K4lUMElG0T0jTwOfnfhyE1YhQGSYV/qqc0yVxw=;
        b=QHtbMXKfX1AefyfpfD9RXEJHQymqBUmdJR9Epie3FWQZc5sEJhCmgIEHlGA7wrvbTf
         Hr6qZYJ/a+pz3qlz1gUSuhy7YLsrE7KKgeUMuVx8E+DwgBIl8Z0yMsfthIulFktZ6IiW
         7OlmjSAFNcfooWFUjqgUPnjFl3T9diRiBkpgXGLRMD/qVvmOqNXJ+3LqIETz2Tj/+uQi
         wAhgHrYE2pmE104pekf4osBjAwF1DnfCAadlJprjWO/XgxISwLKXbLzm+I9OLkDuTiic
         B3vW/uZdUPcE8O3zKpDJltd006E9l8kMO8n5gR2HiM3uxmd5JFXYw471//DxE9EHDi9d
         nMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521826; x=1787126626;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THLt5K4lUMElG0T0jTwOfnfhyE1YhQGSYV/qqc0yVxw=;
        b=FXDcdsQpD0OkFNIeCXwvnV25M1zgh7iCtHsBWwrm1xiWtsnCahPMA7qWMqLqc5YKdQ
         6tE+C9xYNsM7+TiOF9EkvZXR9ovlrbGAjH5BagPskevx/OCqBQDO16NMaHH1zLFakYN5
         wtvb512qZK/aZkb7RkplP9hvCzsJMG7rAVglGjGT4nx9ZTIEpme1pb20djzYLDAv4Br+
         qpvdsMaOsA0+z3j+zlFjRMPYqb4BoK4gV4L/X942I2UCE7NV3gnwQ2GqDLPYOuYd09SU
         ZB5RRUXsdEm89HxKTeluHR3mO2J65KAA/nkpvjjBObxbrRofBQE7TtNHz/EoPaShJvsO
         zxLg==
X-Gm-Message-State: AOJu0YzJAp9AXcKe+Sg8YCI9N2+1LJKrn1uNDN40rQQ+lnRuAu1JPz0d
	HApNBC7zRPr8c7xd4XV7BYLaskznuyOw1S5cIKEmEkqlMrJ8ZVgKT26J3XodOoQO
X-Gm-Gg: AR+sD12f+O+3x3eDjSjGoEeeiuaeSEgw7567eoqjst5HAjS0J1hvPu0EEr2G32eng8d
	Lpd8sa+Eer8yHgcKKniAY7Ial2+nUYPIQVRPOI8PCn4TIdkAJM9/InVTrqsufoTu/56Z2jt7gvS
	tnTflh8QOydOD2+tntmRB5PoICdo5f183tyYibxCGleHIDJONWZJTu4Sc6VPHz8dlFBlhYNGDc4
	RqqM3bNJ/hIMzp0I6XySzs9ThgGFCeDwGacF1YyXGxVSBB/Ls/pmXwa7PSfpwU4zupBzes3ycG/
	mdsoSWQjyp3thnqol452YNdhbs/GksEFkSDH5PBmJ5cg06i9DSF+/frFJ9Y4JWlL+AHBJCmNXPZ
	/Z8AUBvenX68vPtHWFhlCm8tIfJhTLJ4oYxMdSOJGAQf+hz+7JcDwqdb5K180OqIcYhG7VbPrYO
	GFnT2t+ZD2Ko2GSEKcWpY4rO9o2yYYuuEIulKKirYqCxuwEfy/5vfiqv5Jt6FuwvnN+WpK0pSq
X-Received: by 2002:a17:902:ef0a:b0:2d3:104b:1acf with SMTP id d9443c01a7336-2d345352b8cmr38769445ad.8.1786521825883;
        Wed, 12 Aug 2026 01:03:45 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.71.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3522019d3sm2904845ad.56.2026.08.12.01.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:03:44 -0700 (PDT)
Message-Id: <aefdbe2bdfe7509e1660aa55e46bbdb79ddf619c.1786521801.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 08:03:19 +0000
Subject: [PATCH v3 11/12] bisect: check get_terms return at all call sites
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Six callers of get_terms() silently discard its return value. When
get_terms fails (missing or truncated BISECT_TERMS file), the term
strings remain NULL or empty, causing confusing downstream
behavior: commands like "bisect next" or "bisect run" proceed with
empty term strings, producing nonsensical ref names (refs/bisect/
with no suffix) and misleading error messages.

Let's not discard the return value, but handle an error with the same
message `bisect_terms()` already uses when reading the terms failed.

Pointed out by Coverity.

There is one slight complication here: One caller _needs_ the return
value to indicate an error when the `BISECT_TERMS` file is absent, all
the other call sites are totally okay with a "missing" `BISECT_TERMS`
file. To address that, extend the function signature of `get_terms()` to
indicate which behavior the caller wants.

Assisted-by: Claude Opus 4.6
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 69ab7ea248..ceb60b0626 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -485,7 +485,7 @@ static int bisect_next_check(const struct bisect_terms *terms,
 	return decide_next(terms, current_term, !state.nr_good, !state.nr_bad);
 }
 
-static int get_terms(struct bisect_terms *terms)
+static int get_terms(struct bisect_terms *terms, int file_missing_is_ok)
 {
 	struct strbuf str = STRBUF_INIT;
 	FILE *fp = NULL;
@@ -493,7 +493,7 @@ static int get_terms(struct bisect_terms *terms)
 
 	fp = fopen(git_path_bisect_terms(), "r");
 	if (!fp) {
-		res = -1;
+		res = file_missing_is_ok ? 0 : -1;
 		goto finish;
 	}
 
@@ -519,7 +519,7 @@ finish:
 
 static int bisect_terms(struct bisect_terms *terms, const char *option)
 {
-	if (get_terms(terms))
+	if (get_terms(terms, 0))
 		return error(_("no terms defined"));
 
 	if (!option) {
@@ -1057,7 +1057,8 @@ static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
 	rev = word_end + strspn(word_end, " \t");
 	*word_end = '\0'; /* NUL-terminate the word */
 
-	get_terms(terms);
+	if (get_terms(terms, 1))
+		return error(_("no terms defined"));
 	if (check_and_set_terms(terms, p))
 		return -1;
 
@@ -1383,7 +1384,8 @@ static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
 	if (argc)
 		return error(_("'%s' requires 0 arguments"),
 			     "git bisect next");
-	get_terms(&terms);
+	if (get_terms(&terms, 1))
+		return error(_("no terms defined"));
 	res = bisect_next(&terms, prefix);
 	free_terms(&terms);
 	return res;
@@ -1417,7 +1419,8 @@ static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUS
 	struct bisect_terms terms = { 0 };
 
 	set_terms(&terms, "bad", "good");
-	get_terms(&terms);
+	if (get_terms(&terms, 1))
+		return error(_("no terms defined"));
 	res = bisect_skip(&terms, argc, argv);
 	free_terms(&terms);
 	return res;
@@ -1429,7 +1432,8 @@ static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix
 	int res;
 	struct bisect_terms terms = { 0 };
 
-	get_terms(&terms);
+	if (get_terms(&terms, 1))
+		return error(_("no terms defined"));
 	res = bisect_visualize(&terms, argc, argv);
 	free_terms(&terms);
 	return res;
@@ -1443,7 +1447,8 @@ static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
 
 	if (!argc)
 		return error(_("'%s' failed: no command provided."), "git bisect run");
-	get_terms(&terms);
+	if (get_terms(&terms, 1))
+		return error(_("no terms defined"));
 	res = bisect_run(&terms, argc, argv);
 	free_terms(&terms);
 	return res;
@@ -1482,7 +1487,8 @@ int cmd_bisect(int argc,
 			usage_with_options(git_bisect_usage, options);
 
 		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
+		if (get_terms(&terms, 1))
+			return error(_("no terms defined"));
 		if (check_and_set_terms(&terms, argv[0]) ||
 		    !one_of(argv[0], terms.term_good, terms.term_bad, NULL))
 			usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
-- 
gitgitgadget

