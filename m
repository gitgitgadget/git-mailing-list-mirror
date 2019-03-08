Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391A320248
	for <e@80x24.org>; Fri,  8 Mar 2019 10:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfCHKRU (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 05:17:20 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42532 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCHKRT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 05:17:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id n74so13823819pfi.9
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 02:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8+hrCLPwMuEWUnmtnOmiyaJCoWmR0PrxySnTqoy+DgM=;
        b=RYxpWtqMHezrPEz0TL3WssmpVxbsTriUCysfcNhRvsD++35EEa9T15VPDsvPuzk3Z+
         FBNa9/eEFYOnVjHBM5iSlP/ECKWt+p2G0blcneEDr0ZaojmbOcLYnOt7zhYdRDyaxRet
         SzTPk6wbFTfkopScFUJo5qhtZ72vQTQwUXwFZQ3Xbp3ZjIpOT7+NJrcbNVGo3g0WJccv
         HqkfRVByhfwugko5kSZ5OoXXvdjBgj4Cvqy25FE2uQrQkKjLhzNQpfFrBGOfymiusMcQ
         XjhSp317IPwNutcPQlCLqJNxxGEQH1clo6R9CyQQIiIus7MSu5qIO0YHJyI6IWAU6ESx
         P+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+hrCLPwMuEWUnmtnOmiyaJCoWmR0PrxySnTqoy+DgM=;
        b=eCAFEn0sA24MlSMXr3S6Cv8+L28btnLWIPniGxmMw9mYK6DpBl90WTCuBnH4IREIPu
         N2pU9wA0vfU/fQ7pxiofaQUWP/+pUFthEhJ9tYVHPCNQZpxNyxPAXIFyIeaNerjhmPtI
         G7HK+yCRd1EWqZzpmbkPwEwcAQqcnSwidKxbq0vVQZ2/67o1oPPgXQiMqPjErbuGvmFk
         n7PI79zhU/W2N+YcUWFd8y5+HKl7IxuX5DV/THuk4Y+YPBXp+8A6mAWnTZ2D8Y1/S2hQ
         ZWs97O1906ZLV/y5SW+2ZQTCPaZbZ6U2OCw96l3FsHOfUJJ0Ma6xjXtlqjn+WC2jG/ME
         jglw==
X-Gm-Message-State: APjAAAVR+nG2vFaPP/gcQgtnVNALr0Tkpxt3jaxgACSzYi4FWeLDst/T
        K7bCE+7GW2n7AHTxCzto+oSn0jFp
X-Google-Smtp-Source: APXvYqzrCEQGMkzr4LnkS+sOlGCoAEc9jgbSndh/OzwdPVZspcn5B+i0gxrI4JuXUARLn8J18igQ1A==
X-Received: by 2002:a17:902:4464:: with SMTP id k91mr18057971pld.287.1552040238848;
        Fri, 08 Mar 2019 02:17:18 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id k74sm13189260pfb.172.2019.03.08.02.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 02:17:18 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 17:17:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 03/11] restore: make pathspec mandatory
Date:   Fri,  8 Mar 2019 17:16:47 +0700
Message-Id: <20190308101655.9767-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308101655.9767-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git restore" without arguments does not make much sense when
it's about restoring files (what files now?). We could default to
either

    git restore .

or

    git restore :/

Neither is intuitive. Make the user always give pathspec, force the
user to think the scope of restore they want because this is a
destructive operation.

"git restore -p" without pathspec is an exception to this
because it really is a separate mode. It will be treated as running
patch mode on the whole worktree.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 838343d6aa..c52ce13d2a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -61,6 +61,7 @@ struct checkout_opts {
 	int accept_pathspec;
 	int switch_branch_doing_nothing_is_ok;
 	int only_merge_on_switching_branches;
+	int empty_pathspec_ok;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -1427,6 +1428,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			die(_("reference is not a tree: %s"), opts->from_treeish);
 	}
 
+	if (opts->accept_pathspec && !opts->empty_pathspec_ok && !argc &&
+	    !opts->patch_mode)	/* patch mode is special */
+		die(_("pathspec is required"));
+
 	if (argc) {
 		parse_pathspec(&opts->pathspec, 0,
 			       opts->patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
@@ -1511,6 +1516,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.accept_ref = 1;
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
+	opts.empty_pathspec_ok = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1570,6 +1576,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.accept_ref = 0;
 	opts.accept_pathspec = 1;
+	opts.empty_pathspec_ok = 0;
 
 	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.rc1.337.gdf7f8d0522

