Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3015B20D13
	for <e@80x24.org>; Thu,  1 Jun 2017 05:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbdFAFmR (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 01:42:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33489 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdFAFmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 01:42:16 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so6588864pfe.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 22:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GDkh/nbmkffQPLUl5tWIlnOYTJ/ba3/7ej6ynIGLnXE=;
        b=ZhTBECc5DXANO7c6F8JYQF4I9RITS/evTiZe4tTb0O5Xcb9ojLo3Wv+N4qzedKHYFs
         ZZSO4McE4SELubFWTaEynayOmcYVGiRh6DhcfLzTHGPjxSZMRtehf0flmUr1kc5PUueU
         l999LUF3obmtnjiziWPYXVOrF5sHI6loqzRau6OyV3QlNbdlXpqtanI82d/B6gAEx0HP
         +JfQq+mh2sbioLzZacuf1q/Jly/UC24Zm3AsA122Q4f5dH9sAH55JahQJVxwpo9HeEFf
         EfP0o3vjscbKAezNaYtUZG3HGgI+6yYnTevhG24ZWH0SIDL2MWU83haAQ84CBXaXTApS
         jizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GDkh/nbmkffQPLUl5tWIlnOYTJ/ba3/7ej6ynIGLnXE=;
        b=Bctb78rFj1jR8LLj9UB+JhtaHBxjrC86yl0Z2DKuIDzJqAcNa7+SbIKOlAxJPjHexh
         tIOXtoo6QGEpHaMS/TQ6oG28UFJ7QvjySj4Ga12SMDeCmE9MqtQolutIt/920AD8CXio
         u1/5BmexlNTcFvQukiOJ+Q+F8wjQdR1nNsZC65/IBoXyep35fJ0A9ollI8HHOOUFkR3e
         l7ETic5y+NQyZLg659QrOHmaLu8hUvFJj/6A+HhBhM3XQKI3f5pf3MljO7Co/pPCWzn7
         At3bh6dTsNcf004eBcuXii9r7ZAqsKK9Hp6+ZpVDz6xHD/m4QMiGvvKD1z/QQ8WeQlt2
         qdNg==
X-Gm-Message-State: AODbwcBoYsSVJLRRSFcEndyzycB20MlMcrq0Gnk+oRz4UdYu2PCS2xI3
        sADLpEviroUpng==
X-Received: by 10.84.224.2 with SMTP id r2mr7535842plj.19.1496295735296;
        Wed, 31 May 2017 22:42:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id x12sm30365230pgc.47.2017.05.31.22.42.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 22:42:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t0012: test "-h" with builtins
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
        <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
        <xmqqwp8yc255.fsf@gitster.mtv.corp.google.com>
        <20170530060555.ponbsyp4agdo4yau@sigill.intra.peff.net>
        <xmqqshjmc1wm.fsf@gitster.mtv.corp.google.com>
        <20170530061546.tdpuhvq7yk34rvlj@sigill.intra.peff.net>
        <xmqqo9uabhqt.fsf@gitster.mtv.corp.google.com>
        <20170530152756.vs777v6unaxg6otb@sigill.intra.peff.net>
        <xmqqinkg734c.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 01 Jun 2017 14:42:13 +0900
In-Reply-To: <xmqqinkg734c.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 01 Jun 2017 13:17:55 +0900")
Message-ID: <xmqq7f0w6z7u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Heh, I found another ;-)  
>
> 95e98cd9 ("revision.c: use refs_for_each*() instead of
> for_each_*_submodule()", 2017-04-19), which is in the middle of
> Duy's nd/prune-in-worktree series, does this:
> ...
> when jk/consistent-h is merged into it and then "git diff-files -h"
> is run.
>
> I guess anything that calls setup_revisions() from the "git cmd -h"
> bypass need to be prepared with that
>
>   check_help_option(argc, argv, usage, options);
>
> thing.  Which is a bit sad, but I tend to agree with you that
> restructuring to make usage[] of everybody available to git.c
> is probably too noisy for the benefit it would give us.

For now, I will mix this in when queuing the whole thing in 'pu', as
I hate to push out something that does not even work for me to the
general public.

-- >8 --
Subject: [PATCH] diff- and log- family: handle "git cmd -h" early

"git $builtin -h" bypasses the usual repository setup and calls the
cmd_$builtin() function, expecting it to show the help text.

Unfortunately the commands in the log- and the diff- family want to
call into the revisions machinery, which by definition needs to have
a repository already discovered, before they can parse the options.

Handle the "git $builtin -h" special case very early in these
commands to work around potential issues.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/diff-files.c | 3 +++
 builtin/diff-index.c | 3 +++
 builtin/diff-tree.c  | 3 +++
 builtin/rev-list.c   | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 15c61fd8d1..6be1df684a 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -20,6 +20,9 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	int result;
 	unsigned options = 0;
 
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage(diff_files_usage);
+
 	init_revisions(&rev, prefix);
 	gitmodules_config();
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 1af373d002..02dd35ba45 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -17,6 +17,9 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	int i;
 	int result;
 
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage(diff_cache_usage);
+
 	init_revisions(&rev, prefix);
 	gitmodules_config();
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 5ea1c14317..f633b10b08 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -105,6 +105,9 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	struct setup_revision_opt s_r_opt;
 	int read_stdin = 0;
 
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage(diff_tree_usage);
+
 	init_revisions(opt, prefix);
 	gitmodules_config();
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 718c6059c9..b250c515b1 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -277,6 +277,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int use_bitmap_index = 0;
 	const char *show_progress = NULL;
 
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage(rev_list_usage);
+
 	git_config(git_default_config, NULL);
 	init_revisions(&revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
-- 
2.13.0-513-g1c0955652f

