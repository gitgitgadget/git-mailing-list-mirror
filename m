Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D4120248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfCQMvZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:51:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37847 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:51:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so9506762pgq.4
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TaB0rRjXzv8q0j9rMHimxWEr2S0tWZZxFcy/If3Gr/I=;
        b=cKu+PUugbvQBw3tRzfMg0Nf+Os55/h8DpXDDgeMEkhVGNe2nFIJqrfUvIfPvn3gT8W
         G3mYV4aWBSvY38leY49veew64qldiR+zWwJHz2g6qLoE17Bw71VvuPbgEusu3Ap1p1ex
         S2pNg54McsTsCmj+y5XWAUheBLZGBn0pjsSZKhhBHmBPzQC+y8sO1B7sVpfNUd5ZjkpX
         Kw1SHt5U24Dt80kKkRczkr1dXnivb56K1L+gAgp8A/ud0ZvwQbdhzDHOW9WqrZXl4OrX
         9XT4EUw3dT/gZq/Fz2paNdyH7/2Q5RoghDdGyRxYTjHLItXclMqW0CLj9DIrxx3eyjU+
         ciYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TaB0rRjXzv8q0j9rMHimxWEr2S0tWZZxFcy/If3Gr/I=;
        b=afB4jMtNm1mkvR0E3+PiRk2x4Zob47gjzOo+gdJKzrymTyAwl71iKalShRhvB/Ow0q
         jPu8hzjKCxDAPyH8Lo8JmWVwBm/6rZLxT+WsThsVy2141UAed115WvJLv11uQAjKo0mZ
         icR5r8R7xE4LlJi5xemzXjO+HcpMy1bWjEgMqhAzSnWCO4Xd8khYTeOYT1WVXxtnp2b7
         gukRsBNiR1NmzckgNYOb552kk68c6oCEeisMMpk/GYNGQ8EKS5DtMgtbLu/Bi+fEDm/s
         6wm/MSYnXMIk6qd23RgApqn0Pbvl84Vsec34j4WsYnMUSRrmB4DAoI7+6i6bFWhNzPuT
         POfw==
X-Gm-Message-State: APjAAAUo1crC1a/uDNvG7jUpxs3Jn6IiTQ5WuQOGRnwx2Wo86HYe5M73
        79YI77sNyufqC0nvGeNQvOu1PezD
X-Google-Smtp-Source: APXvYqzdmitMpivwLsfWLDo/3eB7RfopTIo0vMXSEE047b/qXfvplNreff08cahEehURL0ukkFXypg==
X-Received: by 2002:a62:6d81:: with SMTP id i123mr13894393pfc.235.1552827084496;
        Sun, 17 Mar 2019 05:51:24 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id i21sm981522pfa.14.2019.03.17.05.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:51:23 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:51:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 17/26] switch: reject "do nothing" case
Date:   Sun, 17 Mar 2019 19:49:17 +0700
Message-Id: <20190317124926.17137-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git checkout" can be executed without any arguments. What it does is
not exactly great: it switches from HEAD to HEAD and shows worktree
modification as a side effect.

Make switch reject this case. Just use "git status" if you want
that side effect. For switch, you have to either

- really switch a branch
- (explicitly) detach from the current branch
- create a new branch

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2c4cab6406..73b7373414 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -55,6 +55,7 @@ struct checkout_opts {
 	int no_dwim_new_local_branch;
 	int discard_changes;
 	int accept_pathspec;
+	int switch_branch_doing_nothing_is_ok;
 
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
@@ -1338,6 +1339,12 @@ static int checkout_branch(struct checkout_opts *opts,
 		die(_("Cannot switch branch to a non-commit '%s'"),
 		    new_branch_info->name);
 
+	if (!opts->switch_branch_doing_nothing_is_ok &&
+	    !new_branch_info->name &&
+	    !opts->new_branch &&
+	    !opts->force_detach)
+		die(_("missing branch or commit argument"));
+
 	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
 		int flag;
@@ -1593,6 +1600,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
+	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.accept_pathspec = 1;
 
 	options = parse_options_dup(checkout_options);
@@ -1624,6 +1632,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
 	opts.accept_pathspec = 0;
+	opts.switch_branch_doing_nothing_is_ok = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.548.gd3c7d92dc2

