Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155F220248
	for <e@80x24.org>; Mon, 25 Mar 2019 12:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfCYMI5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 08:08:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53357 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfCYMIz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 08:08:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so8625773wmj.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 05:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=az/n15HTlzAVklvmNwJJSBsLR/HQZUHIqjvJa6Id0Y4=;
        b=T9MyKmGSt/LHsYRlf1nz5N/P5C5Bn7GdlJCq8IeDWd98ofGxZ2DFz+0hTheu2iA1dU
         U3Vy4cqQwCykJ3I0KZr6uIxp3zUNxRYGe8AyfGV+OBd7lt+clVHYix3TyLkW5WKmJrqZ
         JkOyonn/Bw+uZIc0qB6+JnKFPD3cjIakFTBjgb+ojorp20BZWqsYTTjExVgd4vNQuDz8
         1+C6w3oFPaEuXe66xJrHRTHVIegI0/zTkiIhLQdyZeEzYxmMoShHef9UmvjNx6aRiwa/
         DokO6yUMK9a0gIbLnyJ9cJhAQcJB2P4OmhxzzVQP+Uu0IOcma6zsbto3wUVGmROIGzg5
         Ylsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=az/n15HTlzAVklvmNwJJSBsLR/HQZUHIqjvJa6Id0Y4=;
        b=sUTTSHa99FMHgYcd1x2NsK675sBhj2Cp98v3rBoUqOhiJk65NgTDlGEFP2btNzC3lE
         y8IDCAZe2IQT62rjiSgpzbI4Ia+R/RtLfBWe/WVOexwlrR33OsfPKMpZ1D4ASuYzltbA
         23XGGdqd5TNTf8IsfBLxXb5ehNaXqf+oN5pOzqvMgSUpNoq4KhWbPsXyJCyWBFwBd3m3
         m+Tv2YN5N/mj3amaNBO0o67GbvMDNzTi4oG8a3/FZhl7ENF9LzfdptIb4kyyNvOBiwXM
         Wg8bD5ta1zgJ5BcA3swDu2YtuClHM7/gV5mNcIbM0KqF50jvYrfNh76yX2VeUcwHG2RH
         lECA==
X-Gm-Message-State: APjAAAXCpPY2QUG+PYKQ4IE77M1iPK1H6rUNLFHSAW/XVt14QFBxEw1F
        hmWcjkUnAgBHxnDhsMSCxCySMsA0FF0=
X-Google-Smtp-Source: APXvYqzxr5Vfd/2n/VbLqltIjE6LXT3nMBZpwTWqF8lhD3iCUGcQZ+3iuRBmaaFp1Wk4b7glbu1isw==
X-Received: by 2002:a1c:7311:: with SMTP id d17mr1487895wmb.115.1553515732934;
        Mon, 25 Mar 2019 05:08:52 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n188sm15339464wme.13.2019.03.25.05.08.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 05:08:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/8] commit-graph verify: detect inability to read the graph
Date:   Mon, 25 Mar 2019 13:08:32 +0100
Message-Id: <20190325120834.15529-7-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314214740.23360-1-avarab@gmail.com>
References: <20190314214740.23360-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "commit-graph verify" to error on open() failures other than
ENOENT. As noted in the third paragraph of 283e68c72f ("commit-graph:
add 'verify' subcommand", 2018-06-27) and the test it added it's
intentional that "commit-graph verify" doesn't error out when the file
doesn't exist.

But let's not be overly promiscuous in what we accept. If we can't
read the file for other reasons, e.g. permission errors, bad file
descriptor etc. we'd like to report an error to the user.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c  | 4 +++-
 t/t5318-commit-graph.sh | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 8196fdbe9c..537fdfd0f0 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -62,8 +62,10 @@ static int graph_verify(int argc, const char **argv)
 
 	graph_name = get_commit_graph_filename(opts.obj_dir);
 	open_ok = open_commit_graph(graph_name, &fd, &st);
-	if (!open_ok)
+	if (!open_ok && errno == ENOENT)
 		return 0;
+	if (!open_ok)
+		die_errno(_("Could not open commit-graph '%s'"), graph_name);
 	graph = load_commit_graph_one_fd_st(fd, &st);
 	FREE_AND_NULL(graph_name);
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 71d775e313..1cb0355c7e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -400,6 +400,12 @@ corrupt_graph_and_verify() {
 
 }
 
+test_expect_success POSIXPERM,SANITY 'detect permission problem' '
+	corrupt_graph_setup &&
+	chmod 000 $objdir/info/commit-graph &&
+	corrupt_graph_verify "Could not open"
+'
+
 test_expect_success 'detect too small' '
 	corrupt_graph_setup &&
 	echo "a small graph" >$objdir/info/commit-graph &&
-- 
2.21.0.360.g471c308f928

