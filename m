Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D371F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 10:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfJOKZn (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 06:25:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37218 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbfJOKZh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 06:25:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id p14so23149934wro.4
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZAczrY0RMfLqoAl0e/TLHcwhEDTh3E4CS7ZZCKRgsFs=;
        b=fba0TllWC7oY3spHRALowgLtF1WQRQDWRy5TZOxMuRHvrpx5Ento0G/SmrxjUlUDyM
         AgD+jVoTpAc4b+M/B9Tc/TfNeVnVLswUdCjJ/ISxMmngkhaIAOUPHBYhkvSNM+Wnf3VY
         SCskFIiSWGjvxMlk9/Wn3F6+JQUkiqXW7gXAIgJN1DGiVRkx4EPE/d4orDpZmifvhESi
         MfWvS7trEW1S4lj26YHU1KhOHFmMKJIItYu1bEZP0IhUWco7skjjkObFlAx6sYh8/g+s
         Uv1RPNA4tOlwOAAHE6BzuKjU+VwlycXSzVj8WZYipG6KcLh7dn/dM5ia2+JMh34x3407
         GAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZAczrY0RMfLqoAl0e/TLHcwhEDTh3E4CS7ZZCKRgsFs=;
        b=guInR2/iZ+1Tu0C3304Ki4WKrDmejNfYG8gxSkgru5gKBiOgTUHY15ioEnGVX+81OT
         sR8lUSHHWFaqC7lx73dXGVjuM6ftNlHn0+FtXrOAkmP9cPADHoqxJ9iBBb2oPo6AEu+7
         hzmlwotz4riI/BEXoHmdpSVBBW8b/wujgcJEP2Zq2Iifp6Rp2GlUfzz205shJwdIBuOt
         nZGtNWl6qw7ghnpifLV2fXUo7iUiYSbiTwnqwKFvFXChjwTeLk7lA/Utan+6HGRucsqg
         ByQP7227vf+muGaApHkXTGjSlpcvoH9ZqwXUpEftc4rS+sWi9TUJqjw2iMZtgRSVACC5
         U9zg==
X-Gm-Message-State: APjAAAUP20+8VW3ZRhgbjEyTdv+vBJnKLSTmJadFFUjNOH5SxVjdZEs9
        RKEPu5GGqBo6SorgsIjfcie0XGo5
X-Google-Smtp-Source: APXvYqwbzl+kFPRJxBLaG3YBw1hQBNDTppQj8a7JIrKnEkt1DKz6++Ru874tMEsOxFM5n46pzpyRRA==
X-Received: by 2002:a5d:630f:: with SMTP id i15mr7032791wru.226.1571135134540;
        Tue, 15 Oct 2019 03:25:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm25684863wro.14.2019.10.15.03.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 03:25:33 -0700 (PDT)
Message-Id: <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
In-Reply-To: <pull.388.git.gitgitgadget@gmail.com>
References: <pull.388.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 10:25:26 +0000
Subject: [PATCH v2 0/6] sequencer: start running post-commit hook again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I converted the sequencer to avoid forking git commit i forgot about
the post-commit hook. These patches are based on
pw/rebase-i-show-HEAD-to-reword, otherwise the new test fails as that branch
changes the number of commits we make.

Thanks to Dscho & Junio for their comments on V1. I've made the following
changes:

Patches 1-3 These are new patches in response to Dscho's request to set
$EDITOR in a subshell. There were ~80 other tests that weren't doing that
and they are fixed in these patches. Patch 2 contains the main action,
unfortunately due to a combination of having to remove the trailing ' &&'
from the last line moved into the subshell and re-wrapping some lines due to
the increased indentation --color-moved and --color-moved-ws are of limited
use when viewing this patch.

Patch 4 (was 1) Unchanged

Patch 5 (was 2) I've moved the function definition to commit.c rather than
sequencer.c as suggested. I've also removed an unused struct argv_array from
run_prepare_commit_msg_hook() (There wasn't a compiler warning as it was
still calling argv_array_clear() at the end of the function) and reworded
the commit message.

Patch 6 (was 3) I've tided up the test and removed the wrapper function for
running the post-commit hook as suggested.

Phillip Wood (6):
  t3404: remove unnecessary subshell
  t3404: set $EDITOR in subshell
  t3404: remove uneeded calls to set_fake_editor
  sequencer.h fix placement of #endif
  move run_commit_hook() to libgit and use it there
  sequencer: run post-commit hook

 builtin/commit.c              |  22 --
 commit.c                      |  24 ++
 sequencer.c                   |  24 +-
 sequencer.h                   |   3 +-
 t/lib-rebase.sh               |  28 ++
 t/t3404-rebase-interactive.sh | 596 +++++++++++++++++++++-------------
 6 files changed, 432 insertions(+), 265 deletions(-)


base-commit: b0a3186140dbc7bd64cbc6ef733386a0f1eb6a4d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-388%2Fphillipwood%2Fwip%2Frebase-commit-hooks-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-388/phillipwood/wip/rebase-commit-hooks-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/388

Range-diff vs v1:

 -:  ---------- > 1:  b9689e85e5 t3404: remove unnecessary subshell
 -:  ---------- > 2:  96432cd0f0 t3404: set $EDITOR in subshell
 -:  ---------- > 3:  09857dee78 t3404: remove uneeded calls to set_fake_editor
 1:  7305f8d8e8 = 4:  0eac3ede02 sequencer.h fix placement of #endif
 2:  420ecf442c ! 5:  f394a0e163 sequencer: use run_commit_hook()
     @@ -1,9 +1,11 @@
      Author: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     -    sequencer: use run_commit_hook()
     +    move run_commit_hook() to libgit and use it there
      
     -    This simplifies the implementation of run_prepare_commit_msg_hook() and
     -    will be used in the next commit.
     +    This function was declared in commit.h but was implemented in
     +    builtin/commit.c so was not part of libgit. Move it to libgit so we can
     +    use it in the sequencer. This simplifies the implementation of
     +    run_prepare_commit_msg_hook() and will be used in the next commit.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ -40,25 +42,22 @@
       {
       	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
      
     - diff --git a/commit.h b/commit.h
     - --- a/commit.h
     - +++ b/commit.h
     + diff --git a/commit.c b/commit.c
     + --- a/commit.c
     + +++ b/commit.c
      @@
     - int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
     - int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
     + #include "advice.h"
     + #include "refs.h"
     + #include "commit-reach.h"
     ++#include "run-command.h"
     + 
     + static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
       
     --LAST_ARG_MUST_BE_NULL
     --int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
     --
     - #endif /* COMMIT_H */
     -
     - diff --git a/sequencer.c b/sequencer.c
     - --- a/sequencer.c
     - +++ b/sequencer.c
      @@
     - 	run_rewrite_hook(&old_head->object.oid, new_head);
     + 	}
     + 	return boc ? len - boc : len - cutoff;
       }
     - 
     ++
      +int run_commit_hook(int editor_is_used, const char *index_file,
      +		    const char *name, ...)
      +{
     @@ -81,12 +80,15 @@
      +
      +	return ret;
      +}
     -+
     - static int run_prepare_commit_msg_hook(struct repository *r,
     +
     + diff --git a/sequencer.c b/sequencer.c
     + --- a/sequencer.c
     + +++ b/sequencer.c
     +@@
       				       struct strbuf *msg,
       				       const char *commit)
       {
     - 	struct argv_array hook_env = ARGV_ARRAY_INIT;
     +-	struct argv_array hook_env = ARGV_ARRAY_INIT;
      -	int ret;
      -	const char *name;
      +	int ret = 0;
     @@ -114,18 +116,7 @@
      +	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
      +			    arg1, arg2, NULL))
       		ret = error(_("'prepare-commit-msg' hook failed"));
     -+
     - 	argv_array_clear(&hook_env);
     +-	argv_array_clear(&hook_env);
       
       	return ret;
     -
     - diff --git a/sequencer.h b/sequencer.h
     - --- a/sequencer.h
     - +++ b/sequencer.h
     -@@
     - void sequencer_post_commit_cleanup(struct repository *r);
     - int sequencer_get_last_command(struct repository* r,
     - 			       enum replay_action *action);
     -+LAST_ARG_MUST_BE_NULL
     -+int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
     - #endif /* SEQUENCER_H */
     + }
 3:  acaa086a48 ! 6:  67a711754e sequencer: run post-commit hook
     @@ -10,52 +10,18 @@
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     - diff --git a/builtin/commit.c b/builtin/commit.c
     - --- a/builtin/commit.c
     - +++ b/builtin/commit.c
     -@@
     - 
     - 	repo_rerere(the_repository, 0);
     - 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
     --	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
     -+	run_post_commit_hook(use_editor, get_index_file());
     - 	if (amend && !no_post_rewrite) {
     - 		commit_post_rewrite(the_repository, current_head, &oid);
     - 	}
     -
       diff --git a/sequencer.c b/sequencer.c
       --- a/sequencer.c
       +++ b/sequencer.c
     -@@
     - 	return ret;
     - }
     - 
     -+void run_post_commit_hook(int editor_is_used, const char *index_file) {
     -+	run_commit_hook(editor_is_used, index_file, "post-commit", NULL);
     -+}
     -+
     - static const char implicit_ident_advice_noconfig[] =
     - N_("Your name and email address were configured automatically based\n"
     - "on your username and hostname. Please check that they are accurate.\n"
      @@
       		goto out;
       	}
       
     -+	run_post_commit_hook(0, r->index_file);
     ++	run_commit_hook(0, r->index_file, "post-commit", NULL);
       	if (flags & AMEND_MSG)
       		commit_post_rewrite(r, current_head, oid);
       
      
     - diff --git a/sequencer.h b/sequencer.h
     - --- a/sequencer.h
     - +++ b/sequencer.h
     -@@
     - 			       enum replay_action *action);
     - LAST_ARG_MUST_BE_NULL
     - int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
     -+void run_post_commit_hook(int editor_is_used, const char *index_file);
     - #endif /* SEQUENCER_H */
     -
       diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
       --- a/t/t3404-rebase-interactive.sh
       +++ b/t/t3404-rebase-interactive.sh
     @@ -64,20 +30,24 @@
       '
       
      +test_expect_success 'post-commit hook is called' '
     -+	test_when_finished "rm -f .git/hooks/post-commit commits" &&
     ++	test_when_finished "rm -f .git/hooks/post-commit" &&
     ++	>actual &&
      +	mkdir -p .git/hooks &&
      +	write_script .git/hooks/post-commit <<-\EOS &&
     -+	git rev-parse HEAD >>commits
     ++	git rev-parse HEAD >>actual
      +	EOS
     -+	set_fake_editor &&
     -+	FAKE_LINES="edit 4 1 reword 2 fixup 3" git rebase -i A E &&
     -+	echo x>file3 &&
     -+	git add file3 &&
     -+	FAKE_COMMIT_MESSAGE=edited git rebase --continue &&
     -+	# rev-list does not support -g --reverse
     -+	git rev-list --no-walk=unsorted HEAD@{5} HEAD@{4} HEAD@{3} HEAD@{2} \
     -+		HEAD@{1} HEAD >expected &&
     -+	test_cmp expected commits
     ++	(
     ++		set_fake_editor &&
     ++		FAKE_LINES="edit 4 1 reword 2 fixup 3" git rebase -i A E &&
     ++		echo x>file3 &&
     ++		git add file3 &&
     ++		FAKE_COMMIT_MESSAGE=edited git rebase --continue
     ++	) &&
     ++	git rev-parse HEAD@{5} HEAD@{4} HEAD@{3} HEAD@{2} HEAD@{1} HEAD \
     ++		>expect &&
     ++	test_cmp expect actual
      +'
      +
     - test_done
     + # This must be the last test in this file
     + test_expect_success '$EDITOR and friends are unchanged' '
     + 	test_editor_unchanged

-- 
gitgitgadget
