Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C742FE566
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820476; cv=none; b=IQlqcHnN8BqpestVnxa4wk6hPHnf3J1Vqqrd91MSBpvXEXfNrAsRf6LUyZOts7+Pf/v9c7ySDHeMVT7C+3FttUFDmRF2EjEIDrtQtPXiyT5IhP+4ifeRSxEyF0wLvnosfdw+YBpcWfy8Nb+wo1Peyzw26cqFeD0gyjRIqby9O1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820476; c=relaxed/simple;
	bh=PIMP94spSA7EeJ5pI0eZ4AQcCwfBREVC4o07bDAtdXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UB1A2/B7NCfKykde8nXYS25A9qoWoRJusg93l9wxXySlkL2I20EebI5uwOsmPBvxaHI6BnXpS3Qz9wK149IexbxEDEUy6qQRqfh5VubsRWVKVV1ueeRzvc5PGXtRh17nI/k6CiN7EBRvtFeJa/O60Yq7NIbb21CpRV1aDWcB9wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=OORFr2xJ; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="OORFr2xJ"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-650158138d9so906630d50.3
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774820474; x=1775425274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yiYKre/E+7vvVqzT+0qb0WFFF6HRQFwgEp2GtMXjT8=;
        b=OORFr2xJvD+/n8/i4veGff/Q8HI8g7TB0xBOAvqEMw/oWZ4oG+QrwC/wV8gFm+NHCD
         hwhNuua1J5f7WQkEMoHEGHfgnxb4gPro5LiyD5S/6Z/xq0v6VhwLyg1uUsMVd6wfXyVv
         LyYkR+L6CzKwPSPkmx3Rn7qOScPZH5SqmtJMi8tUTRG8ykOSCqhy/BL/st7EEy8/z0Z5
         NDj1GCCdfcpjwTuGBCPLviKzXb3CrooY14YEzFf2uwyDiULisvHab0thc4Ag1BorVf9H
         6ssSEH+72B6ymDkNqyxGau8xTSNDJHZJvDmAG9sDdz9rNWBS5VmnIZ+vWE4toUlFvtS5
         dvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774820474; x=1775425274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yiYKre/E+7vvVqzT+0qb0WFFF6HRQFwgEp2GtMXjT8=;
        b=mtwTn830w2JKn9QScrzSKb7DdEeP11gE43ax6b4o0KLUdZtQx2KVG9b884vlpsc2oS
         u9htYbf8VGYlU+7rP/omxezdoDR/LL8kpEcZosmXwDwhF2fb76Iz/eiJQn+L2PIoDj3B
         j7YUF964kmN1YczBPho5bViLczNEvuEDF5A8whzSd0JhbZO+PB+zAIQoWeEKJh2RIfTs
         gKvJUFRiv8VaNMnU4lUCnSTe7TvchnW81RAXhOKaOKuP62FGgNmocw8efVfkUjiGenHp
         RggTsVFflterXF4XVNoOstNPI+iJ1J5lCNFh/Oux+RXvXAPrEm1YShrx+wIHWjpoYZrm
         3s2w==
X-Gm-Message-State: AOJu0Yy3P8lDjICHixcvf8rn23YycnYUP9wjV7nCDWBkgsJ1x+ZMPkc3
	lgxGrQoV9kjZPxY1oBUaHqNm3fQaLaGrveZHWnc1LAl+HSW4OnoV0vfByUiTaVnNtfH+eCd+/FX
	WDRvPSmhwNBF2
X-Gm-Gg: ATEYQzxfPSCs+Yy3JmAHFI2KpJTMBKom5swEEGrGCwJ7Ue7POxpSb0btrDRKk6cOSRB
	dcEz1z1iCvuh4dYcijl6W6V2qIvXz6guuUEDhGHC2RdhHlP2xK3CRbg1/YAb7lMcJdc4liCQdzz
	i4uTZExoHP8VkTbU2W8JM2oC4PiTFA6KO+dy+rLEO3ylfvBGYVVlQzIc3P7wTq5x8okwWtyTt5m
	mZMgliz4E19HSoJskP3Abxa7iZOSx7Hg2urWQ1TLtRrY7uXUO8HUZJVkfYiMboLWFppORT8BHpW
	X2vb4q9bLhHn70ZU5NOQAuLrxDx4Ddwl298aizcwkkTkBhyrAQLvPNyW1bpuvjwL2OIV5/K/Jfk
	Z8SztseeP+tw5xh0SNpERQNA5MYNc9tK7xHfc1N1K8QXzLPOZDOODTScu+wAHtr4pIhIaqftnrj
	KfTRR8vOK19WZBK1drF/SVVXW7JbkzIcClG7QamsYw3kqXfamIiAHzDYKjdkgI9JW6xcJALExtm
	cJyQ+1lbYovj/xLx8PX6+l+llYcvw==
X-Received: by 2002:a05:690c:c15c:b0:79c:3750:48a3 with SMTP id 00721157ae682-79c37504f2cmr74280687b3.53.1774820474600;
        Sun, 29 Mar 2026 14:41:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb71384dasm27182147b3.3.2026.03.29.14.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:41:14 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:41:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 09/16] repack-midx: factor out `repack_prepare_midx_command()`
Message-ID: <5c9fea0fc788a883903f1dafe4965bc23d018f91.1774820449.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774820449.git.me@ttaylorr.com>

The `write_midx_included_packs()` function assembles and executes a
`git multi-pack-index write` command, constructing the argument list
inline.

Future commits will introduce additional callers that need to construct
similar `git multi-pack-index` commands (for both `write` and `compact`
subcommands), so extract the common portions of the command setup into a
reusable `repack_prepare_midx_command()` helper.

The extracted helper sets `git_cmd`, pushes the `multi-pack-index`
subcommand and verb, and handles `--progress`/`--no-progress` and
`--bitmap` flags. The remaining arguments that are specific to the
`write` subcommand (such as `--stdin-packs`) are left to the caller.

No functional changes are included in this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack-midx.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/repack-midx.c b/repack-midx.c
index 0682b80c427..83151d4734a 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -275,6 +275,23 @@ static void remove_redundant_bitmaps(struct string_list *include,
 	strbuf_release(&path);
 }
 
+static void repack_prepare_midx_command(struct child_process *cmd,
+					struct repack_write_midx_opts *opts,
+					const char *verb)
+{
+	cmd->git_cmd = 1;
+
+	strvec_pushl(&cmd->args, "multi-pack-index", verb, NULL);
+
+	if (opts->show_progress)
+		strvec_push(&cmd->args, "--progress");
+	else
+		strvec_push(&cmd->args, "--no-progress");
+
+	if (opts->write_bitmaps)
+		strvec_push(&cmd->args, "--bitmap");
+}
+
 int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -289,18 +306,9 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
 		goto done;
 
 	cmd.in = -1;
-	cmd.git_cmd = 1;
 
-	strvec_push(&cmd.args, "multi-pack-index");
-	strvec_pushl(&cmd.args, "write", "--stdin-packs", NULL);
-
-	if (opts->show_progress)
-		strvec_push(&cmd.args, "--progress");
-	else
-		strvec_push(&cmd.args, "--no-progress");
-
-	if (opts->write_bitmaps)
-		strvec_push(&cmd.args, "--bitmap");
+	repack_prepare_midx_command(&cmd, opts, "write");
+	strvec_push(&cmd.args, "--stdin-packs");
 
 	if (preferred)
 		strvec_pushf(&cmd.args, "--preferred-pack=%s",
-- 
2.53.0.729.g817728289e1.dirty

