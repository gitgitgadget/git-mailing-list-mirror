Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F164E1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 15:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437812AbeKWCTo (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:19:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55847 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437788AbeKWCTn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:19:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so9325427wmc.5
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 07:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZHWkDuRV6sy7Dv4W8CK4OCkYRrSM3Zy5BdK3o811TM=;
        b=KyFpBM7JD4IBdD5pe8T+AAWlpog8impdcX4QKf9Q3+7Gpd0QyRSg4ZAN6dK942O6FQ
         RiBLY5y+XbzacOJEmdDrRnRUTVMxUq1cvRkon+QvqyHm0cILFa9NPdg9M2LVp94cITKK
         K4tbJKTMjNtt4UOYhi9rrOz5dvXTVzFavXoibHTD2ZcbORCCjPpfLSA56v4DeOipF1z9
         OIbLfuk7SCyx/MFDlkJSHtSY6kndKFLu9j/NoZlSzDEwe2C6BFtpxCw+4I/4nt0InGmC
         YWNqh6TuImEJ6u0mzV/QO1r0EHfMOBAom622IdBxYHEZcxHAPg8Zy9oJ7hFB60S4XZlt
         xf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZHWkDuRV6sy7Dv4W8CK4OCkYRrSM3Zy5BdK3o811TM=;
        b=cK3YrxsKABGrpp0O503P7OKzIrMknWDcOBx4Z62mDoYHmV7R+0RelyWjp1Rka23FKZ
         ZH4BgDav7jsUuFAXNH4x6fdjg1D2134zATxroi2oDI1bsvDXoJk51qPEku8xtskyKtfu
         hd0xac52UpHb9xfgL8dtp1wSFvVUYCwEweRPM+Tgz5dipX0KGbN72AFcLoNVe1pU5s8l
         arIOxau8sTKstmWwJO7VQF9kU8IsdEasg4gmSBgcfquSxVLjr1x1afup1M5JdzOG01Hw
         6ppTuuBXEnjOzSsxhByefEGx7UVR5ftH62xPiIhXgFg17mzt8t+ZlYliDKHkoRMiFepA
         WdLA==
X-Gm-Message-State: AGRZ1gJ3o/E4L1x52Lnkj9BQ40Su5YPngMMAHqm0uQ/J4FWR6QPrj7r6
        ugrvdjQ8xoRR4V/xXKr5rX7ZnG0KK+4=
X-Google-Smtp-Source: AFSGD/Xev7m7XFdlAYzs05QEQvrqGSy7uTa+86qV8VKp6fUflzzSHq4GVkT9UGF/uDuPxOu3gl4mFg==
X-Received: by 2002:a1c:a017:: with SMTP id j23mr10657594wme.40.1542901189076;
        Thu, 22 Nov 2018 07:39:49 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a17sm7329389wrs.58.2018.11.22.07.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 07:39:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/10] commit-graph write: emit a percentage for all progress
Date:   Thu, 22 Nov 2018 15:39:22 +0000
Message-Id: <20181122153922.16912-11-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181122132823.9883-1-avarab@gmail.com>
References: <20181122132823.9883-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "Annotating commit graph" progress output to show a
completion percentage. I added this in 7b0f229222 ("commit-graph
write: add progress output", 2018-09-17) and evidently didn't notice
how easy it was to add a completion percentage.

Now for e.g. linux.git we'll emit:

    ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph among packed objects: 100% (6365442/6365442), done.
    Annotating commit graph: 100% (2391666/2391666), done.
    Computing commit graph generation numbers: 100% (797222/797222), done.
    Writing out commit graph in 4 passes: 100% (3188888/3188888), done.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 80f201adf4..6c6edc679b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -660,10 +660,17 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
 	struct commit *commit;
 	struct progress *progress = NULL;
 	int j = 0;
+	/*
+	 * We loop over the OIDs N times to close the graph
+	 * below. This number must be kept in sync with the number of
+	 * passes.
+	 */
+	const int oid_passes = 3;
 
 	if (report_progress)
 		progress = start_delayed_progress(
-			_("Annotating commit graph"), 0);
+			_("Annotating commit graph"),
+			oid_passes * oids->nr);
 	for (i = 0; i < oids->nr; i++) {
 		display_progress(progress, ++j);
 		commit = lookup_commit(the_repository, &oids->list[i]);
-- 
2.20.0.rc0.387.gc7a69e6b6c

