Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8707D2FB
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738210013; cv=none; b=gxyh2WTCDXT+6/Zy+U/2DS7l44lZHwq9dJAFvqx4F8bYULv97Fr6ALeHM/MwSC5qG2nBlDGw4R+rx/pCjzdNHTnIgQUxoKmNF4xIsK6XoKXYIlqhvuBQdeawg9PPtXM01AX2lPLFa3q2e++P00fdWAazPkckAiOms4/fG8M7Z/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738210013; c=relaxed/simple;
	bh=qNjcZDRpsgK0melEBrO3nWr6WvcMd/JYFvdNOs6bLs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a29IQMlU794k0cHKfYOB+qghDOZm5K9KzgH8ZMmF8saZRe2N5YnQiV+VbImjJK583Ji8x8Z7+DFyAClVEAneZjmeFY33xmUF4VFv/7V6uu1AWG9SsVacCyiJuTnsNFOZeKsFdh9bNM+noLjbarxq8YFZg/wxrHdgid3PB2/NKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu1i8bpc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu1i8bpc"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2166360285dso5244785ad.1
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 20:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738210010; x=1738814810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb7mfR9eLI9MX3S8Fmi0snuygFRASRa0K/Dt94u/lS0=;
        b=Cu1i8bpc4SbgdyLZSEa9VzyvzcJghXWQEKvEfeg7LbPNG1C7vdWTFaFuiTSCIa9Ihd
         t01UuJfojBaspnnr/y/RYnNg5A7ksYripMcAVdNOKFa3fy1RxrLYL6A6lAhoegkch3nU
         GkVLvLqeTFMg1UQjaDZMBAasT4dkFQzkmZSKk+qY/R7nU8DnONVZbmEojNjjwSG+989q
         z1a3UgMmAb6sBYh6OUzPgHHnLfdQFGeibaGuFDUzD/jZFWMPdfV4Kt6Yqyyh6eaVy6mv
         K6ZfUd5w3a59qi9ur2CgnZsP+TksxUlxEA4gozbm6iHsuKtWNki3pug9SdZhIyIEi1eI
         +hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738210010; x=1738814810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gb7mfR9eLI9MX3S8Fmi0snuygFRASRa0K/Dt94u/lS0=;
        b=CK/4fBhpwutBO3WAHyrFw36y6/yoboFq1fVIzPy3kQIOUFVCmfi2FgBqmE6pVvIkBI
         NBKzeU/IC+FDfwHNoFmK0lXYs6bs72uy6YMZRoYJiL23owU8oPO0tfwtDwEvW2KFxhoR
         7ofEsZk/ACBp7MZ8l3rS7kM7LlYcZ3Gmemmum1pxx00lniO1VieggAMjMW2FMWwk6DRQ
         Uorj5mSNM2ROtEI3PMs5lPoump9Q1iApoWQr1FcolWWLz/kFAxaz/NNrchFVh9nEvcdS
         ndg6Mz4Vt/PAUDNH+HW6cb9v9ya3a3P0YHxCe21/782mXLcPeiWkHYd6aHSUkxzaYxs+
         DNTw==
X-Gm-Message-State: AOJu0Yx7yOoBQKCG9eCVesGWp4IYuLwGbxfHKbBnufc16/dIghNi7b0J
	YCx8EvkJG9oxIolShvx4PV/7Yenb73GFziQLl01Zm5fYHnW1i9BdpVBNhcl0
X-Gm-Gg: ASbGnct2689KCFI5qCtjE199qVJp/YebAYQrfIp35Ot5Jn9+ABejOVyq3T8rH3dAMN0
	OCHg99W3mi+3R/ohOZWlT+l+yYt/bOvO0a9sxjejedVY3lDoO8LRMOkz0/dBt/1MtxnB08PUUnz
	Q5HHDewZr6fI5S4lk29COTlVL4U8wqU1wD6QiiRzMTjIQUvmgQmNzknJQ1kwnjtgcKEjZJ59nM7
	pla75KWNkbluE4LhRQAUoClqZPbdaywTT2JtodBQBXkT1hftDRIh+5J6TpP1dLnWEik7w==
X-Google-Smtp-Source: AGHT+IFqx6UyZB2r80RkOpCxlwVporks3uclavCEQA3b77MQ41cBiZlZ1+DcnMgwEgeJVHsq5FvNgA==
X-Received: by 2002:a05:6a21:b8a:b0:1ea:e7be:ff27 with SMTP id adf61e73a8af0-1ed7a5b6781mr9495831637.7.1738210010532;
        Wed, 29 Jan 2025 20:06:50 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe6424facsm342820b3a.39.2025.01.29.20.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 20:06:50 -0800 (PST)
Date: Thu, 30 Jan 2025 12:08:22 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 8/8] builtin/fsck: add `git refs verify` child process
Message-ID: <Z5r7NnzvirWEljwV@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5r6ZnLH3Ee8IQnN@ArchLinux>

At now, we have already implemented the ref consistency checks for both
"files-backend" and "packed-backend". Although we would check some
redundant things, it won't cause trouble. So, let's integrate it into
the "git-fsck(1)" command to get feedback from the users. And also by
calling "git refs verify" in "git-fsck(1)", we make sure that the new
added checks don't break.

Introduce a new function "fsck_refs" that initializes and runs a child
process to execute the "git refs verify" command. In order to provide
the user interface create a progress which makes the total task be 1.
It's hard to know how many loose refs we will check now. We might
improve this later.

And we run this function in the first execution sequence of
"git-fsck(1)" because we don't want the existing code of "git-fsck(1)"
which implicitly checks the consistency of refs to die the program.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7a4dcb0716..9a8613d07f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -905,6 +905,34 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	return res;
 }
 
+static void fsck_refs(struct repository *r)
+{
+	struct child_process refs_verify = CHILD_PROCESS_INIT;
+	struct progress *progress = NULL;
+	uint64_t progress_num = 1;
+
+	if (show_progress)
+		progress = start_progress(r, _("Checking ref database"),
+					  progress_num);
+
+	if (verbose)
+		fprintf_ln(stderr, _("Checking ref database"));
+
+	child_process_init(&refs_verify);
+	refs_verify.git_cmd = 1;
+	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
+	if (verbose)
+		strvec_push(&refs_verify.args, "--verbose");
+	if (check_strict)
+		strvec_push(&refs_verify.args, "--strict");
+
+	if (run_command(&refs_verify))
+		errors_found |= ERROR_REFS;
+
+	display_progress(progress, 1);
+	stop_progress(&progress);
+}
+
 static char const * const fsck_usage[] = {
 	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
 	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
@@ -970,6 +998,8 @@ int cmd_fsck(int argc,
 	git_config(git_fsck_config, &fsck_obj_options);
 	prepare_repo_settings(the_repository);
 
+	fsck_refs(the_repository);
+
 	if (connectivity_only) {
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
 		for_each_packed_object(the_repository,
-- 
2.48.1

