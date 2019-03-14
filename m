Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FCCE20248
	for <e@80x24.org>; Thu, 14 Mar 2019 21:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfCNVsE (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 17:48:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53830 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfCNVsC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 17:48:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id e74so4573637wmg.3
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 14:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=az/n15HTlzAVklvmNwJJSBsLR/HQZUHIqjvJa6Id0Y4=;
        b=KdJPZJePB+Ktmt5s3PBVlb4JC8tkQkiXPNHhrS9UsU7uQnEh5+j6LpZOJAKQlsLdU/
         Utpa1ofr4YS67VgZUHsqoICt9YdS2TpPe2wsPFjQLSuOyudnVgnWaLeCT8zL8OM6nBMg
         OskQp7UMSHx66ivNGmP1RhHS3Z8Tiay6SnbeMX7aMZqwTk9rzI7ZtYZCiesKJKH5yMdK
         erLrnZqFriiqqpogzxt5bstRrThdOhWwmVyw1YmAucUvR+GVFK2XmdSW4BImnQwhFYNQ
         jkDH6meIic4wJyIfN3bZV+ltxc9bF8SZrfZmSLFpJvP71VSZ6KOiDEUl+UnBPbXLRWM5
         VncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=az/n15HTlzAVklvmNwJJSBsLR/HQZUHIqjvJa6Id0Y4=;
        b=ouHh6MRQ4ZHfH4+ncNvElGqarGqzYCvaK8ZUfuQZa6Uu0yaLTB3Lh1F77UJwwrsy5m
         BDpHPL35q0ZlYIEPZgOrL/lSleuwJY/XFtwajY15I+GBkv6Tjtf34XFmIeaLPapfOWdw
         2iN9a+wYbY9KPju9055UC8mYRTmEwbqU6j/GgjEf/cWgfLQ+srOzm9dHSSxkJxa460f5
         Uea9cU3zoxcu2qjm6sPMpkFsv9d2JeLq2eKYYq+95FWLnROf/xdRdWazHZ+pdmMunI65
         UxQ28J0bBZjj3pLcj9TBx0VwdY6+/NISx0o4nNqFWLXStE0y7DV1GuyzKae3i4nkFTKr
         SdJw==
X-Gm-Message-State: APjAAAXGr7Ijhvq8Yi8Ms4/Yo3TJxt5uvrfiYSz0hoYKyXRomqqRBa22
        D+A5FwXpS4J5s5Zslvaw7eqVklb4M7M=
X-Google-Smtp-Source: APXvYqymVexcOJKY8+MvsbXwbQgioQaXevW+z8gz0rt3Eh89udbymmD+fFYiGBkCtwoJdFtUWsiehg==
X-Received: by 2002:a1c:9e97:: with SMTP id h145mr340939wme.147.1552600080192;
        Thu, 14 Mar 2019 14:48:00 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h137sm194348wmg.41.2019.03.14.14.47.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 14:47:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/8] commit-graph verify: detect inability to read the graph
Date:   Thu, 14 Mar 2019 22:47:38 +0100
Message-Id: <20190314214740.23360-7-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190221223753.20070-1-avarab@gmail.com>
References: <20190221223753.20070-1-avarab@gmail.com>
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

