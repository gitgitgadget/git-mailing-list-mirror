Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 938421F403
	for <e@80x24.org>; Sun, 17 Jun 2018 18:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933850AbeFQSqd (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 14:46:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:37977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933374AbeFQSqc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 14:46:32 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfjJY-1fpbUc3XSW-00NEGe; Sun, 17
 Jun 2018 20:46:26 +0200
Date:   Sun, 17 Jun 2018 20:46:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>, ch <cr@onlinehome.de>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] sequencer: do not squash 'reword' commits when we
 hit conflicts
In-Reply-To: <20180617053703.19856-1-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806172046090.77@tvgsbejvaqbjf.bet>
References: <CAPig+cRKxpNrTNSEgB66LBxcJk1b24ViR=T-fkqo07wxMFywpQ@mail.gmail.com> <20180617053703.19856-1-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zneeGQokzvPDL7DolAM4eJSgQRVg4qFKIwXMwQwJ6Pn8BEqDmJx
 +A80tHZ44G8Kvr1GLghos0g725r58FKgs+ITpNweGURQ1HSMaDrhkdKg+4fRHLWRdaJLY7O
 7vBhBLSkzGtqJ5TlBTZ8O9Bf6SHYcq0InR9oo0uGWXUleWHGME059V1g3r6AxRRTem9I0vR
 JMYiv717G4kcTqhMoaG/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dN65M4gS4qo=:MUTMKNDiDi6veutLiizfSM
 BLbrH+hmXFQfoUFbiuE6buT4AYY+nBvmTQMLnN/Z3aOQG/glxzm5pwUVEggRotA7WK5mDdYhG
 ZTlLtWZT2uSp/JveVZLmtRdk5O4iMczmB6tE3FdgJnB1ocB68id8y+5Rg5UruL090tAyhqwKT
 /3pRituIyO63gvIVy6nVbkjEcl2JgRtGuGdRHYKreKodrV93PWRaGFioQkBn7ULxsBvBquNps
 5mzQfxqLMbAn0b0hrkohi3r/jLPNlpgvPwTcYsY8efOf7w13yewrkWLvrAZHwYoobbuRDG0H4
 tUpFVdWYZ9m+zRiNZkH0jLGoRUnBtrxdxQ+rskqUSu6xewQV5fuy7SoCrxBYJf6UGuQM3A8NV
 EhUz+HqjkqDRLjUvBw95iw1umnLKuABnaaM+sy5xaaua/KmdMlgKszaC3/9XONsWJpp5FyI5d
 F+2S8ZvtM+O8INra5n34a46kz75KJbd3PO9aWDZfQ3QVwFr2ANDhb0jI2iuSF/P3Zd6NGR+wO
 TulDlW3e0R/r0OrQ0f9eM5LhzfeDgJ4nnxQm2p31veeZrWZAinS/fiDnfJJ1bzPVfdJ8bHFvs
 /AYxkVd2WYML3Tr7Q+lOKuvZ2jbPmLcoCZ5sG9+clGWMPHiA8XIymjnL+9tkU3+Oo7ocXlxhJ
 6FnKCDSvE6+1rGhXsKTsPNngEopSr3xfWyTSuV/W7W/WpnmaYByx+sZE0lS1zhPAwY3XvMLG6
 NbjrnQ7vdmrUvAAZVkNoKMToMD+lZLXyzoI4/mC0f1XF2Go3yTVLx48IY4yhQZSZkaoIMsoVJ
 sM8rQ0a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 16 Jun 2018, Elijah Newren wrote:

> Ever since commit 18633e1a22 ("rebase -i: use the rebase--helper builtin",
> 2017-02-09), when a commit marked as 'reword' in an interactive rebase
> has conflicts and fails to apply, when the rebase is resumed that commit
> will be squashed into its parent with its commit message taken.
> 
> The issue can be understood better by looking at commit 56dc3ab04b
> ("sequencer (rebase -i): implement the 'edit' command", 2017-01-02), which
> introduced error_with_patch() for the edit command.  For the edit command,
> it needs to stop the rebase whether or not the patch applies cleanly.  If
> the patch does apply cleanly, then when it resumes it knows it needs to
> amend all changes into the previous commit.  If it does not apply cleanly,
> then the changes should not be amended.  Thus, it passes !res (success of
> applying the 'edit' commit) to error_with_patch() for the to_amend flag.
> 
> The problematic line of code actually came from commit 04efc8b57c
> ("sequencer (rebase -i): implement the 'reword' command", 2017-01-02).
> Note that to get to this point in the code:
>   * !!res (i.e. patch application failed)
>   * item->command < TODO_SQUASH
>   * item->command != TODO_EDIT
>   * !is_fixup(item->command) [i.e. not squash or fixup]
> So that means this can only be a failed patch application that is either a
> pick, revert, or reword.  For any of those cases we want a new commit, so
> we should not set the to_amend flag.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> Differences since v1 (Thanks to Eric Sunshine for the suggestions):
>   * Add test_when_finished "reset_rebase" calls
>   * Remove unnecessary word from description of test
> 
>  sequencer.c              |  2 +-
>  t/t3423-rebase-reword.sh | 48 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 1 deletion(-)
>  create mode 100755 t/t3423-rebase-reword.sh
> 
> diff --git a/sequencer.c b/sequencer.c
> index cca968043e..9e6d1ee368 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3217,7 +3217,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  			} else if (res && is_rebase_i(opts) && item->commit)
>  				return res | error_with_patch(item->commit,
>  					item->arg, item->arg_len, opts, res,
> -					item->command == TODO_REWORD);
> +					0);

I agree that this is the correct bug fix. ACK!

Thanks,
Dscho
