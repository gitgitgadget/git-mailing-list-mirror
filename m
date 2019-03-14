Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEFFD20248
	for <e@80x24.org>; Thu, 14 Mar 2019 12:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfCNMe7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 08:34:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36514 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfCNMe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 08:34:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so1104427wrd.3
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Ajg8uPzBwMOafmb9oiC8siydAC2vaAyiWSb6jbnWfY=;
        b=ndcUAxc7qmLHmxe3kbLBpaAmtiE1Hjt/k/CxP8sgA4gQ2XkvijGtlraQFhUn8FgjLm
         boBFTG0RwZlWSAR89T6FzzD+DSGMw1F7Tppw73svN2tS55zMndpjr2EHSOrAWnvCynSV
         rXSFNb6JplKyY3yyNVHjDyAgaeWOkW68M/LXlcFdewKE5e2CTvQmZiF9HQDk7E5+KEc1
         QrInJJqiu0Zba+iEhVzFuaQ6+JDBraQqQCsDWxcAPN/LjEMItTLpGtXz8EpZYG/NIVVz
         xvx6aeqc2lLshyxue+6gE6NQLhfIyT7jzz+brtqRakJLSAqYuW3hXcjSm5yxkw/8ys3g
         pFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Ajg8uPzBwMOafmb9oiC8siydAC2vaAyiWSb6jbnWfY=;
        b=VM7I7znpRDMdPlcM0Ey2RQduTsvXhD7OatbCGc5Mg+IHvyiILXzIgVtoCjTwVFHElW
         agBZr4fOBbO9r8+BybaAgf5Ewg6IA6WnvXcLkHTKdPfiqdfz8VU4v9XyIDFiXYp9HDB7
         5lpTX7gueLQCsRIYOys1rVxVyXnx1M1pufl5F+vqBOgh/QI6teohZIcP4IDkbFrokfRM
         O6kQ3XV6lTiHvnsUkwUNg5VCLgGtU1C74EMvljiGGVTYtTpXJKECt9FAlRq9hH/QLxq8
         j33Bv4CdQ4oBGgSoGUDcUeghqD8LFD3RC6Lovi3NM7DB84wIn9HTVeu3sokF1WeBDCv5
         2wvQ==
X-Gm-Message-State: APjAAAXcPla8XTBI910XLm/t6bnKVfsGMgAAJWlEy9q7GGgH+dxEIb+8
        X9V19hXjMpsBn2Vh8XjpSVOTSEprLpI=
X-Google-Smtp-Source: APXvYqw8kVlNxUMV7xJ8LaYh6ZFOpe2sFoYFoXz7R1/59CCv8/VTkxoKjY3F4J/gNso9b4aBmIEMEQ==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr2901318wrj.16.1552566896699;
        Thu, 14 Mar 2019 05:34:56 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p6sm42374095wre.63.2019.03.14.05.34.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 05:34:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/7] gc: refactor a "call me once" pattern
Date:   Thu, 14 Mar 2019 13:34:35 +0100
Message-Id: <20190314123439.4347-4-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190313235439.30439-1-avarab@gmail.com>
References: <20190313235439.30439-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an idiom we're using to ensure that gc_before_repack() only
does work once (see 62aad1849f ("gc --auto: do not lock refs in the
background", 2014-05-25)) to be more obvious.

Nothing except this function cares about the "pack_refs" and
"prune_reflogs" variables, so let's not leave the reader wondering if
they're being zero'd out for later use somewhere else.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 733bd7bdf4..ae716a00d4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -489,14 +489,20 @@ static int report_last_gc_error(void)
 
 static void gc_before_repack(void)
 {
+	/*
+	 * We may be called twice, as both the pre- and
+	 * post-daemonized phases will call us, but running these
+	 * commands more than once is pointless and wasteful.
+	 */
+	static int done = 0;
+	if (done++)
+		return;
+
 	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
 		die(FAILED_RUN, pack_refs_cmd.argv[0]);
 
 	if (prune_reflogs && run_command_v_opt(reflog.argv, RUN_GIT_CMD))
 		die(FAILED_RUN, reflog.argv[0]);
-
-	pack_refs = 0;
-	prune_reflogs = 0;
 }
 
 int cmd_gc(int argc, const char **argv, const char *prefix)
-- 
2.21.0.360.g471c308f928

