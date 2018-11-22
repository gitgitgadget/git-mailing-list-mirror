Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F2E1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 15:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437801AbeKWCTi (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:19:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33698 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437788AbeKWCTh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:19:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so4053534wrr.0
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 07:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fd3KrzfrUOAKSqPW9KqzCSydlac5ROxV0toEQxp/SmA=;
        b=q6qiHWZ2K896pyNbmML3CCLB1nrcR65SaOwKurJxGZGd+GwJe1dLD5RXHL40olCWPm
         WEFNoyiiLCsjK3H+wsVom0cIg61XRu5dtgSM/uek2jBC2UJmEsi21AnxwVvEQ/4OkHID
         SgvulDUzL4fsGny351ydaaV7WDeUfDA0dZ3/wlW+cMbcG8E7L/p42FE17l9e0qAZmI+z
         ku75cPK6B8tv3R/DwwNK4wmDVVyFW4JgzBmY8VAWHfrLNNKI1XEI1OiiAEklqPom+7B8
         pgNGrIxifk2dXCjUNJxdA+MS6aduP+KBMLBWTO+tyDvHweQSB9eSyclDAkk/1uR3P1Vf
         CyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fd3KrzfrUOAKSqPW9KqzCSydlac5ROxV0toEQxp/SmA=;
        b=rioOYs+LVm0HPFz04gNb4FQX7uJWHoEcxNKLtY9nOP1ZSFlOKt5YQrLrccSrAV3DYF
         +6Hcx1n5LeuCarom66ugFe4DCMwDOg96Ue67w1kysn7CkUzRTxCVJc8vpCjBg8UxqY1Z
         Bd72cucKJSHua/+2/al30dGbjhTc14l8AUoOxKXIwWpYmg1Oc+9+QUnfzZKntmcKClWP
         IOarZjfLBITXmOMJ6nS0vITUfBxzO//Qp6AFa9/GCVCecIg9vyizEmK8iBSMGraYkP4G
         ud/XuSAI4q6r35X1YkV11cXv1Sqzr9jWsCOS7Mn/17FxxHdBmLcrMK0VeHn0WHV44T6T
         lRVQ==
X-Gm-Message-State: AA+aEWbWaVoEG/dtvWsQInoOZ0KTgsWf2yU1MTHpyesxrubQvfkUG699
        l/3+9lxxTC0PE5AVxR5CbBE1d4EMH7w=
X-Google-Smtp-Source: AFSGD/Wq7mkuk247VJ/ZOVPR2Aj/3AX6P/17BaUy+LjAzJORegCfXevWnCh0PAkF4g48h7qo/UT8Eg==
X-Received: by 2002:adf:f550:: with SMTP id j16mr10003869wrp.258.1542901183014;
        Thu, 22 Nov 2018 07:39:43 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a17sm7329389wrs.58.2018.11.22.07.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 07:39:42 -0800 (PST)
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
Subject: [PATCH v4 06/10] commit-graph write: show progress for object search
Date:   Thu, 22 Nov 2018 15:39:18 +0000
Message-Id: <20181122153922.16912-7-avarab@gmail.com>
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

Show the percentage progress for the "Finding commits for commit
graph" phase for the common case where we're operating on all packs in
the repository, as "commit-graph write" or "gc" will do.

Before we'd emit on e.g. linux.git with "commit-graph write":

    Finding commits for commit graph: 6365442, done.
    [...]

And now:

    Finding commits for commit graph: 100% (6365442/6365442), done.
    [...]

Since the commit graph only includes those commits that are packed
(via for_each_packed_object(...)) the approximate_object_count()
returns the actual number of objects we're going to process.

Still, it is possible due to a race with "gc" or another process
maintaining packs that the number of objects we're going to process is
lower than what approximate_object_count() reported. In that case we
don't want to stop the progress bar short of 100%. So let's make sure
it snaps to 100% at the end.

The inverse case is also possible and more likely. I.e. that a new
pack has been added between approximate_object_count() and
for_each_packed_object(). In that case the percentage will go beyond
100%, and we'll do nothing to snap it back to 100% at the end.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 3de65bc2e9..42d8365f0d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -781,12 +781,14 @@ void write_commit_graph(const char *obj_dir,
 	struct progress *progress = NULL;
 	uint64_t progress_cnt = 0;
 	struct strbuf progress_title = STRBUF_INIT;
+	unsigned long approx_nr_objects;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
 
 	oids.nr = 0;
-	oids.alloc = approximate_object_count() / 32;
+	approx_nr_objects = approximate_object_count();
+	oids.alloc = approx_nr_objects / 32;
 	oids.progress = NULL;
 	oids.progress_done = 0;
 
@@ -866,8 +868,11 @@ void write_commit_graph(const char *obj_dir,
 	if (!pack_indexes && !commit_hex) {
 		if (report_progress)
 			oids.progress = start_delayed_progress(
-				_("Finding commits for commit graph"), 0);
+				_("Finding commits for commit graph"),
+				approx_nr_objects);
 		for_each_packed_object(add_packed_commits, &oids, 0);
+		if (oids.progress_done < approx_nr_objects)
+			display_progress(oids.progress, approx_nr_objects);
 		stop_progress(&oids.progress);
 	}
 
-- 
2.20.0.rc0.387.gc7a69e6b6c

