Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1BB41F404
	for <e@80x24.org>; Sat,  8 Sep 2018 00:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbeIHExP (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 00:53:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39003 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725734AbeIHExP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 00:53:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so7731230pff.6
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 17:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nXSDE5F4ND8EbflS4uM32T/Pv3QgT1kspAGFMbAhqTc=;
        b=nq85Jb8GCSYSJ4p+LbzkD1TsHDRHTM/uZ6BAcFOQuJpD2b/jDGIxahLLOFdGJoHqTh
         Ch7NRHdSOFm/hbiNjIIA/B+x8hZ3aldLd+kjar+Vf2tW2NpwR13stVM80ud+7Ul6u4rK
         65LqeHd/TdIiIJ3Eh7YGMWE+fcfPD1oavR3zD6mWNZCvCnx8wHc+z2yg6YM2HSqBMHep
         m7xDOKgfaXR3M4HWRU+BfKkRMG1VK6trF/y/fiRNNIj+hv85vgzQQqhRwCC9cYwrWxS1
         IXwp/1P7Ug5r/9IRTUJWOaOLrG1sX1RFUFDZ7qdYnoThaV7ejKV/r6VLmGBClKMHn9lu
         BdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nXSDE5F4ND8EbflS4uM32T/Pv3QgT1kspAGFMbAhqTc=;
        b=JQ4L5PW5H34uxvfgN2r4IzB2aqT2QyHJSVPaqOkuIyZHpfoTF/2nwZemNr2nKIuMfO
         SxMUgxTuQNWlRBzkq5VoxkGuKqW6nXdSC7l9JAtV22Wx0a/aUK2/mJvo8ZSKk7d+lkUw
         pR3qiM1EyvtBxrsl2Tm/nBWRoWg45IB03sem/tNb2PZNUudtKM3tBkcQ5nhsWPp0qP5B
         sICoAmCx+ZmNw+HTeNjSDVvLtmnluQEtKQT3TBm8RFzNQDUqVbiPLRZTIYRxP7I7cg3X
         U9eQKYQGEItq44sUV+qUeVn6xwchAl9l3404ZeVmo7/6AZoCiax+ePSaVwFRVrpSlVV7
         OL2w==
X-Gm-Message-State: APzg51C2oUZkueZpkH2aUxPRCFJ0H9/ITwgBupo7yRnU0IgLMNbaNIQx
        glGqHHc+2IQVVDFL3zLaqh4=
X-Google-Smtp-Source: ANB0VdZaipYSkqj18AIlFk28Ag3pi58aRGmYlLtpdh9Igt0LNhoywVo9H8aPf/Xd9nL8yn4OOl7rmw==
X-Received: by 2002:a63:ef10:: with SMTP id u16-v6mr10746158pgh.269.1536365388929;
        Fri, 07 Sep 2018 17:09:48 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d12-v6sm11181470pfn.118.2018.09.07.17.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 17:09:48 -0700 (PDT)
Date:   Fri, 7 Sep 2018 17:09:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     allan.jensen@qt.io, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Revert "Merge branch 'sb/submodule-core-worktree'" (was Re:
 Old submodules broken in 2.19rc1 and 2.19rc2)
Message-ID: <20180908000946.GA225427@aiede.svl.corp.google.com>
References: <2659750.rG6xLiZASK@twilight>
 <CAGZ79kaVQ0T=acpviOoD+8XVxYsefNkO7c5d+d0Wc0iCbr2Evw@mail.gmail.com>
 <20180907223515.GD103699@aiede.svl.corp.google.com>
 <CAGZ79kZvuGEPOSTUqT+y6nxs6W5qaP-BbHT_WQQE7+n=RVNsrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZvuGEPOSTUqT+y6nxs6W5qaP-BbHT_WQQE7+n=RVNsrw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject: Revert "Merge branch 'sb/submodule-core-worktree'"

This reverts commit 7e25437d35a70791b345872af202eabfb3e1a8bc, reversing
changes made to 00624d608cc69bd62801c93e74d1ea7a7ddd6598.

v2.19.0-rc0~165^2~1 (submodule: ensure core.worktree is set after
update, 2018-06-18) assumes an "absorbed" submodule layout, where the
submodule's Git directory is in the superproject's .git/modules/
directory and .git in the submodule worktree is a .git file pointing
there.  In particular, it uses $GIT_DIR/modules/$name to find the
submodule to find out whether it already has core.worktree set, and it
uses connect_work_tree_and_git_dir if not, resulting in

	fatal: could not open sub/.git for writing

The context behind that patch: v2.19.0-rc0~165^2~2 (submodule: unset
core.worktree if no working tree is present, 2018-06-12) unsets
core.worktree when running commands like "git checkout
--recurse-submodules" to switch to a branch without the submodule.  If
a user then uses "git checkout --no-recurse-submodules" to switch back
to a branch with the submodule and runs "git submodule update", this
patch is needed to ensure that commands using the submodule directly
are aware of the path to the worktree.

It is late in the release cycle, so revert the whole 3-patch series.
We can try again later for 2.20.

Reported-by: Allan Sandfeld Jensen <allan.jensen@qt.io>
Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Stefan Beller wrote:
> Jonathan Nieder wrote:

>> I think we
>> should revert e98317508c0 in "master" (for 2.19) and keep making use
>> of that 'second try' in "next" (for 2.20).
>
> Actually I'd rather revert the whole topic leading up to
> 7e25437d35a (Merge branch 'sb/submodule-core-worktree', 2018-07-18)
> as the last patch in there doesn't work well without e98317508c0 IIRC.
>
> And having only the first patch would bring an inconsistent state as
> then different commands behave differently w.r.t. setting core.worktree.

Like this (generated using "git revert -m1)?

 builtin/submodule--helper.c | 26 --------------------------
 git-submodule.sh            |  5 -----
 submodule.c                 | 14 --------------
 submodule.h                 |  2 --
 t/lib-submodule-update.sh   |  5 ++---
 t/t7400-submodule-basic.sh  |  5 -----
 6 files changed, 2 insertions(+), 55 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b56028ba9d..f6fb8991f3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1123,8 +1123,6 @@ static void deinit_submodule(const char *path, const char *prefix,
 		if (!(flags & OPT_QUIET))
 			printf(format, displaypath);
 
-		submodule_unset_core_worktree(sub);
-
 		strbuf_release(&sb_rm);
 	}
 
@@ -2005,29 +2003,6 @@ static int check_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int connect_gitdir_workingtree(int argc, const char **argv, const char *prefix)
-{
-	struct strbuf sb = STRBUF_INIT;
-	const char *name, *path;
-	char *sm_gitdir;
-
-	if (argc != 3)
-		BUG("submodule--helper connect-gitdir-workingtree <name> <path>");
-
-	name = argv[1];
-	path = argv[2];
-
-	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
-	sm_gitdir = absolute_pathdup(sb.buf);
-
-	connect_work_tree_and_git_dir(path, sm_gitdir, 0);
-
-	strbuf_release(&sb);
-	free(sm_gitdir);
-
-	return 0;
-}
-
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2041,7 +2016,6 @@ static struct cmd_struct commands[] = {
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
 	{"update-clone", update_clone, 0},
-	{"connect-gitdir-workingtree", connect_gitdir_workingtree, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index f7fd80345c..1cb2c0a31b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -580,11 +580,6 @@ cmd_update()
 			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
 		fi
 
-		if ! $(git config -f "$(git rev-parse --git-common-dir)/modules/$name/config" core.worktree) 2>/dev/null
-		then
-			git submodule--helper connect-gitdir-workingtree "$name" "$sm_path"
-		fi
-
 		if test "$subsha1" != "$sha1" || test -n "$force"
 		then
 			subforce=$force
diff --git a/submodule.c b/submodule.c
index 50cbf5f13e..a2b266fbfa 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1534,18 +1534,6 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	return ret;
 }
 
-void submodule_unset_core_worktree(const struct submodule *sub)
-{
-	char *config_path = xstrfmt("%s/modules/%s/config",
-				    get_git_common_dir(), sub->name);
-
-	if (git_config_set_in_file_gently(config_path, "core.worktree", NULL))
-		warning(_("Could not unset core.worktree setting in submodule '%s'"),
-			  sub->path);
-
-	free(config_path);
-}
-
 static const char *get_super_prefix_or_empty(void)
 {
 	const char *s = get_super_prefix();
@@ -1711,8 +1699,6 @@ int submodule_move_head(const char *path,
 
 			if (is_empty_dir(path))
 				rmdir_or_warn(path);
-
-			submodule_unset_core_worktree(sub);
 		}
 	}
 out:
diff --git a/submodule.h b/submodule.h
index 7d476cefa7..e452919aa4 100644
--- a/submodule.h
+++ b/submodule.h
@@ -127,8 +127,6 @@ int submodule_move_head(const char *path,
 			const char *new_head,
 			unsigned flags);
 
-void submodule_unset_core_worktree(const struct submodule *sub);
-
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
  * a submodule by clearing any repo-specific environment variables, but
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 5b56b23166..016391723c 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -235,7 +235,7 @@ reset_work_tree_to_interested () {
 	then
 		mkdir -p submodule_update/.git/modules/sub1/modules &&
 		cp -r submodule_update_repo/.git/modules/sub1/modules/sub2 submodule_update/.git/modules/sub1/modules/sub2
-		# core.worktree is unset for sub2 as it is not checked out
+		GIT_WORK_TREE=. git -C submodule_update/.git/modules/sub1/modules/sub2 config --unset core.worktree
 	fi &&
 	# indicate we are interested in the submodule:
 	git -C submodule_update config submodule.sub1.url "bogus" &&
@@ -709,8 +709,7 @@ test_submodule_recursing_with_args_common() {
 			git branch -t remove_sub1 origin/remove_sub1 &&
 			$command remove_sub1 &&
 			test_superproject_content origin/remove_sub1 &&
-			! test -e sub1 &&
-			test_must_fail git config -f .git/modules/sub1/config core.worktree
+			! test -e sub1
 		)
 	'
 	# ... absorbing a .git directory along the way.
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 7d3d984210..c0ffc1022a 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -984,11 +984,6 @@ test_expect_success 'submodule deinit should remove the whole submodule section
 	rmdir init
 '
 
-test_expect_success 'submodule deinit should unset core.worktree' '
-	test_path_is_file .git/modules/example/config &&
-	test_must_fail git config -f .git/modules/example/config core.worktree
-'
-
 test_expect_success 'submodule deinit from subdirectory' '
 	git submodule update --init &&
 	git config submodule.example.foo bar &&
-- 
2.19.0.rc2.392.g5ba43deb5a

