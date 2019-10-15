Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0CF1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 14:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbfJOO03 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 10:26:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:38765 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732050AbfJOO03 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 10:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571149579;
        bh=2+wpJygTR/6jFK5VmAkjFDPyKlAKBdL08ga5YDLU6wU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ClOdeuRY6blAxYjJfDwCYFFv4wYYVYGU5DVGppC/ASmB18SosJYtgRjFz0SnZRuXz
         liFYqzularuyb8G/tMy+6SMY+Kiv+3eRInF/9FhSJz22sYJTBPGRqLoadgWowPC9VF
         SkXC2H1f0ab1RaxHzqEEfObyRO8izSRO16ZwysA4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6dy-1hr5Aj1BEM-00hbOV; Tue, 15
 Oct 2019 16:26:19 +0200
Date:   Tue, 15 Oct 2019 16:26:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 0/6] sequencer: start running post-commit hook again
In-Reply-To: <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910151624450.46@tvgsbejvaqbjf.bet>
References: <pull.388.git.gitgitgadget@gmail.com> <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rhAKJXM3hWuitlD8VHCJtUMbp82FAxdbCNXt1uTWZv9bXkClnr4
 sRrLW5IuHdTxZeqOAvdoHX1326N3ws0wz8/oTWI8JfmS/YTkDaeX+yXtpdciD3mloE3um9M
 28Vf7D96d4Npwb6zBpzDdZMGTHBNW4VD+SfB+BF/wneLIAlcJUifJsICeyjDrTMw46p17bu
 K0la6pd+7ui9wDZ1HKghg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aI6ih/keW8E=:LTp2FZ3cRUzcZ5/5gRQ4vC
 WOP3hBinZISrDcZG1CkBfPDGI1q9gpzfVNh2CBV06tiTnJOACummrqPvlud06qW6CIkbB+TYp
 8Iz+8qj5yna7LpZp+kjJfgXFNf76aqJyckX5BvKV2RH5fhCIq+Siauf6OUz3UeckmffuuE4ur
 QEbITRrdL5eUqSjgsD22Djgcq55NTRyaeA+acnLY8SaeXyfjHkyzMW3ipWXfn9+D7qLPzrkzx
 tK4adDfgqD57iUZk+h8TuGyoQ6xDQas6O+BJWp0EAo6gGm5lVZ6R5R+XMPuKzkmbe/x+Tgltu
 zvRK9YdoIcNE8qThIWty1aKx9kNAzVsGX69U06Qmll2RtS4QgaOfgeD22jSnW/dK6JbqopwEQ
 tK4qAMZcj+Ws2N/o3/xEWCCnH/mHi+tQ73HQml+UJ2aW7V+AB6l5u6NHxp3Z3eSKWCuftAaQS
 CfFQ1yDtNQiETjSbrrIHpLIVM5RmuDMb3KhB03wG4HqG9QsdpPaGE3gD8TAc1yaoiFDrvMmBt
 R8PmaJhlvSfuNhjTI8foacku114JFP/kjEc9yBwYHuGu4KHxeOmmHTh5vXJKx3xCi2Ek+oNWo
 JC3SozLx0L3/fEmsKqANv9ochxHasM8wqtf0wBU8rg4nn2TkRvykWBbgF8N/AgOq/3LCEV6x/
 eUfb+k3a6PQZ9f10Bae9kOVxProR3itA9TBUZRyTxHTaPuM1uGDaz789kOhNAN00gwzclsO6a
 CAQZBSaPQKaIh6j2Le1Gb28Z/CHgUxdnhFzkDGu8+3wabezWHdym7vs//R9cV7DgfrR3Q9Rsv
 tQ5gCwD4DQlrM0ad6X4Y45skmCnGGG+Sz/9w53M/CPlC9tvckooZAettLNPNRHN7BqR7PUeIG
 QvofAyFv6mgLI87Otz6nFU6V+CzPJGVD8x5hSR5OjSkaAEfsQrw6P6AowwFYELCeW2MUxO2Y1
 svZ/UB2WdrKuYEEHyQyvu6VcTFgkKhmEWE8zOCdofH+ZM2Qeyp1G0h2lSo7bwPVnbW9nIsOAC
 WYMFYzLBwXRXEIWJMSR6K+sYttTGVvGDgoEKrILKJDEjiW6JV3PNor6pSoZVMI6ViJTxm5N93
 weao4/sNcjFBZT+rFDzPZwiktY1a41clP45i0sdmwqcCECv5UWkwlSn+tnk5q8RJfKbwr76i/
 m5/iuo4nX6yzuuanQRiipZ6pO0B/XUD7K8nLm9+pwESjyWaAAgy78b+2fRCmaPH5Un3clLR95
 kNCl4hgtrW2kyTy732X/HEEV/+lMQxKOCTl5bM1WDRYEYA7NE7dV9uvXFFTM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 15 Oct 2019, Phillip Wood via GitGitGadget wrote:

> When I converted the sequencer to avoid forking git commit i forgot abou=
t
> the post-commit hook. These patches are based on
> pw/rebase-i-show-HEAD-to-reword, otherwise the new test fails as that br=
anch
> changes the number of commits we make.
>
> Thanks to Dscho & Junio for their comments on V1. I've made the followin=
g
> changes:
>
> Patches 1-3 These are new patches in response to Dscho's request to set
> $EDITOR in a subshell. There were ~80 other tests that weren't doing tha=
t
> and they are fixed in these patches. Patch 2 contains the main action,
> unfortunately due to a combination of having to remove the trailing ' &&=
'
> from the last line moved into the subshell and re-wrapping some lines du=
e to
> the increased indentation --color-moved and --color-moved-ws are of limi=
ted
> use when viewing this patch.
>
> Patch 4 (was 1) Unchanged
>
> Patch 5 (was 2) I've moved the function definition to commit.c rather th=
an
> sequencer.c as suggested. I've also removed an unused struct argv_array =
from
> run_prepare_commit_msg_hook() (There wasn't a compiler warning as it was
> still calling argv_array_clear() at the end of the function) and reworde=
d
> the commit message.
>
> Patch 6 (was 3) I've tided up the test and removed the wrapper function =
for
> running the post-commit hook as suggested.

I had a look over the patches, too, and all looks good to me.

Thank you so much!
Dscho

>
> Phillip Wood (6):
>   t3404: remove unnecessary subshell
>   t3404: set $EDITOR in subshell
>   t3404: remove uneeded calls to set_fake_editor
>   sequencer.h fix placement of #endif
>   move run_commit_hook() to libgit and use it there
>   sequencer: run post-commit hook
>
>  builtin/commit.c              |  22 --
>  commit.c                      |  24 ++
>  sequencer.c                   |  24 +-
>  sequencer.h                   |   3 +-
>  t/lib-rebase.sh               |  28 ++
>  t/t3404-rebase-interactive.sh | 596 +++++++++++++++++++++-------------
>  6 files changed, 432 insertions(+), 265 deletions(-)
>
>
> base-commit: b0a3186140dbc7bd64cbc6ef733386a0f1eb6a4d
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-388%2F=
phillipwood%2Fwip%2Frebase-commit-hooks-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-388/phill=
ipwood/wip/rebase-commit-hooks-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/388
>
> Range-diff vs v1:
>
>  -:  ---------- > 1:  b9689e85e5 t3404: remove unnecessary subshell
>  -:  ---------- > 2:  96432cd0f0 t3404: set $EDITOR in subshell
>  -:  ---------- > 3:  09857dee78 t3404: remove uneeded calls to set_fake=
_editor
>  1:  7305f8d8e8 =3D 4:  0eac3ede02 sequencer.h fix placement of #endif
>  2:  420ecf442c ! 5:  f394a0e163 sequencer: use run_commit_hook()
>      @@ -1,9 +1,11 @@
>       Author: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>      -    sequencer: use run_commit_hook()
>      +    move run_commit_hook() to libgit and use it there
>
>      -    This simplifies the implementation of run_prepare_commit_msg_h=
ook() and
>      -    will be used in the next commit.
>      +    This function was declared in commit.h but was implemented in
>      +    builtin/commit.c so was not part of libgit. Move it to libgit =
so we can
>      +    use it in the sequencer. This simplifies the implementation of
>      +    run_prepare_commit_msg_hook() and will be used in the next com=
mit.
>
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>      @@ -40,25 +42,22 @@
>        {
>        	const char *argv_gc_auto[] =3D {"gc", "--auto", NULL};
>
>      - diff --git a/commit.h b/commit.h
>      - --- a/commit.h
>      - +++ b/commit.h
>      + diff --git a/commit.c b/commit.c
>      + --- a/commit.c
>      + +++ b/commit.c
>       @@
>      - int compare_commits_by_commit_date(const void *a_, const void *b_=
, void *unused);
>      - int compare_commits_by_gen_then_commit_date(const void *a_, const=
 void *b_, void *unused);
>      + #include "advice.h"
>      + #include "refs.h"
>      + #include "commit-reach.h"
>      ++#include "run-command.h"
>      +
>      + static struct commit_extra_header *read_commit_extra_header_lines=
(const char *buf, size_t len, const char **);
>
>      --LAST_ARG_MUST_BE_NULL
>      --int run_commit_hook(int editor_is_used, const char *index_file, c=
onst char *name, ...);
>      --
>      - #endif /* COMMIT_H */
>      -
>      - diff --git a/sequencer.c b/sequencer.c
>      - --- a/sequencer.c
>      - +++ b/sequencer.c
>       @@
>      - 	run_rewrite_hook(&old_head->object.oid, new_head);
>      + 	}
>      + 	return boc ? len - boc : len - cutoff;
>        }
>      -
>      ++
>       +int run_commit_hook(int editor_is_used, const char *index_file,
>       +		    const char *name, ...)
>       +{
>      @@ -81,12 +80,15 @@
>       +
>       +	return ret;
>       +}
>      -+
>      - static int run_prepare_commit_msg_hook(struct repository *r,
>      +
>      + diff --git a/sequencer.c b/sequencer.c
>      + --- a/sequencer.c
>      + +++ b/sequencer.c
>      +@@
>        				       struct strbuf *msg,
>        				       const char *commit)
>        {
>      - 	struct argv_array hook_env =3D ARGV_ARRAY_INIT;
>      +-	struct argv_array hook_env =3D ARGV_ARRAY_INIT;
>       -	int ret;
>       -	const char *name;
>       +	int ret =3D 0;
>      @@ -114,18 +116,7 @@
>       +	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name=
,
>       +			    arg1, arg2, NULL))
>        		ret =3D error(_("'prepare-commit-msg' hook failed"));
>      -+
>      - 	argv_array_clear(&hook_env);
>      +-	argv_array_clear(&hook_env);
>
>        	return ret;
>      -
>      - diff --git a/sequencer.h b/sequencer.h
>      - --- a/sequencer.h
>      - +++ b/sequencer.h
>      -@@
>      - void sequencer_post_commit_cleanup(struct repository *r);
>      - int sequencer_get_last_command(struct repository* r,
>      - 			       enum replay_action *action);
>      -+LAST_ARG_MUST_BE_NULL
>      -+int run_commit_hook(int editor_is_used, const char *index_file, c=
onst char *name, ...);
>      - #endif /* SEQUENCER_H */
>      + }
>  3:  acaa086a48 ! 6:  67a711754e sequencer: run post-commit hook
>      @@ -10,52 +10,18 @@
>
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>      - diff --git a/builtin/commit.c b/builtin/commit.c
>      - --- a/builtin/commit.c
>      - +++ b/builtin/commit.c
>      -@@
>      -
>      - 	repo_rerere(the_repository, 0);
>      - 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>      --	run_commit_hook(use_editor, get_index_file(), "post-commit", NUL=
L);
>      -+	run_post_commit_hook(use_editor, get_index_file());
>      - 	if (amend && !no_post_rewrite) {
>      - 		commit_post_rewrite(the_repository, current_head, &oid);
>      - 	}
>      -
>        diff --git a/sequencer.c b/sequencer.c
>        --- a/sequencer.c
>        +++ b/sequencer.c
>      -@@
>      - 	return ret;
>      - }
>      -
>      -+void run_post_commit_hook(int editor_is_used, const char *index_f=
ile) {
>      -+	run_commit_hook(editor_is_used, index_file, "post-commit", NULL)=
;
>      -+}
>      -+
>      - static const char implicit_ident_advice_noconfig[] =3D
>      - N_("Your name and email address were configured automatically bas=
ed\n"
>      - "on your username and hostname. Please check that they are accura=
te.\n"
>       @@
>        		goto out;
>        	}
>
>      -+	run_post_commit_hook(0, r->index_file);
>      ++	run_commit_hook(0, r->index_file, "post-commit", NULL);
>        	if (flags & AMEND_MSG)
>        		commit_post_rewrite(r, current_head, oid);
>
>
>      - diff --git a/sequencer.h b/sequencer.h
>      - --- a/sequencer.h
>      - +++ b/sequencer.h
>      -@@
>      - 			       enum replay_action *action);
>      - LAST_ARG_MUST_BE_NULL
>      - int run_commit_hook(int editor_is_used, const char *index_file, c=
onst char *name, ...);
>      -+void run_post_commit_hook(int editor_is_used, const char *index_f=
ile);
>      - #endif /* SEQUENCER_H */
>      -
>        diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-inter=
active.sh
>        --- a/t/t3404-rebase-interactive.sh
>        +++ b/t/t3404-rebase-interactive.sh
>      @@ -64,20 +30,24 @@
>        '
>
>       +test_expect_success 'post-commit hook is called' '
>      -+	test_when_finished "rm -f .git/hooks/post-commit commits" &&
>      ++	test_when_finished "rm -f .git/hooks/post-commit" &&
>      ++	>actual &&
>       +	mkdir -p .git/hooks &&
>       +	write_script .git/hooks/post-commit <<-\EOS &&
>      -+	git rev-parse HEAD >>commits
>      ++	git rev-parse HEAD >>actual
>       +	EOS
>      -+	set_fake_editor &&
>      -+	FAKE_LINES=3D"edit 4 1 reword 2 fixup 3" git rebase -i A E &&
>      -+	echo x>file3 &&
>      -+	git add file3 &&
>      -+	FAKE_COMMIT_MESSAGE=3Dedited git rebase --continue &&
>      -+	# rev-list does not support -g --reverse
>      -+	git rev-list --no-walk=3Dunsorted HEAD@{5} HEAD@{4} HEAD@{3} HEA=
D@{2} \
>      -+		HEAD@{1} HEAD >expected &&
>      -+	test_cmp expected commits
>      ++	(
>      ++		set_fake_editor &&
>      ++		FAKE_LINES=3D"edit 4 1 reword 2 fixup 3" git rebase -i A E &&
>      ++		echo x>file3 &&
>      ++		git add file3 &&
>      ++		FAKE_COMMIT_MESSAGE=3Dedited git rebase --continue
>      ++	) &&
>      ++	git rev-parse HEAD@{5} HEAD@{4} HEAD@{3} HEAD@{2} HEAD@{1} HEAD =
\
>      ++		>expect &&
>      ++	test_cmp expect actual
>       +'
>       +
>      - test_done
>      + # This must be the last test in this file
>      + test_expect_success '$EDITOR and friends are unchanged' '
>      + 	test_editor_unchanged
>
> --
> gitgitgadget
>
