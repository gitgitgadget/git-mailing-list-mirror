Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150C51F6C1
	for <e@80x24.org>; Sun, 14 Aug 2016 11:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934250AbcHNLot (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 07:44:49 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35909 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934200AbcHNLoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 07:44:46 -0400
Received: by mail-wm0-f52.google.com with SMTP id q128so48853690wma.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 04:44:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m3pE4R7X+3Ewf1tzFSK5ERQG7S1Jp7xgI2UUHaem4XU=;
        b=ZvUVmSwMGSfcSade4RFxTq+Duzu29MnftKx7Mn0UxwkhfpvR7lggso2pC4jKp2r+4J
         weZpovuL7WhpkyMIpR2LtIkd4Im81jb6GlJZc0UJjU23WOzoyGQl8PWe2LyLL6bldNbX
         ggGrZMKerH2q5K6q0ornhKAnrzKULTZ5Q2rFfASKqNRLXDvjJmSKN4DGvS4Q6Z46dciY
         Y0pbaOP/RItxxD2l41ViwaO6pkoJVAFgiUEpT8av/sxvcQLsSmg1OisUnvQmURyWhQ4D
         BFab1xWtKoBIg3t9o+K0Nk3yMBWrHqCo2gFvkDIa6QUicolYM+3RAgSmaHRN96BhIuTw
         mZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m3pE4R7X+3Ewf1tzFSK5ERQG7S1Jp7xgI2UUHaem4XU=;
        b=VYR24DbE3pZC29a1rKWwCl7IuDcV1yvI8JaGSKWF+X3iwbnMG+EPPtJJEfGXdx0uJj
         6YDE0JJMnc6tUN49Bfl02g5qZCFIDsMKv7YlyNI+A3qRCJbtBS4eL3Wvu6iRS7COKoRn
         AP85+gQ4I9TsSUJAKEgobKrnBuF9/CX5NUf7iBFobUWis3tlYl/J4NZXCA8956GRVajl
         P0Ahmy/7TPadQL04OY1+Gn1bm8332JZEqFMh1TN5qwVe7LOyxciqYYZzcMattQdrKEsH
         TV4pJHa5U6K2MlhkEm3Fkew6+8pYSsgnJF3sUMI2xFwFvNlRVnnMfCZIima5AiQvuaS7
         aJGQ==
X-Gm-Message-State: AEkooutSka5OVlnX6uCUYVgKYlWk0pUjACy6li1tveofp8BsX5UvX0M6QtTJUIp4bMQ1LUguwryNEB3A+0vElg==
X-Received: by 10.194.126.135 with SMTP id my7mr10367267wjb.78.1471175084072;
 Sun, 14 Aug 2016 04:44:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Sun, 14 Aug 2016 04:44:43 -0700 (PDT)
In-Reply-To: <09d485df-7d14-97f8-9db9-e3db7512bd68@nokia.com>
References: <09d485df-7d14-97f8-9db9-e3db7512bd68@nokia.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Sun, 14 Aug 2016 13:44:43 +0200
Message-ID: <CAP8UFD04Z7JpoAA1kXkYFk5LD-GngbUDkbnpCEc3DNDXUgetEA@mail.gmail.com>
Subject: Re: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
To:	Stephen Morton <stephen.morton@nokia.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Stephen,

On Wed, Aug 10, 2016 at 9:21 PM, Stephen Morton
<stephen.morton@nokia.com> wrote:
>
> Formatting on previous email was terrible, plus the diff wasn't performed
> against origin. Re-sending.

Thanks for working on this...

> (Finally getting back to this.)
>
> Something like the diff below, then Johannes?

...but please try to send a real patch.

There is https://github.com/git/git/blob/master/Documentation/SubmittingPatches
and also SubmitGit that can help you do that.

> (I intentionally print the '--continue' hint even in the case whereit's last
> of n commits that fails.)
>
>
> Stephen
>
>
> ~/ws/extern/git (maint *%>) > git diff @{u}
> diff --git a/sequencer.c b/sequencer.c
> index c6362d6..e0071aa 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -154,7 +154,7 @@ static void free_message(struct commit *commit, struct
> commit_message *msg)
>         unuse_commit_buffer(commit, msg->message);
>  }
>
> -static void print_advice(int show_hint, struct replay_opts *opts)
> +static void print_advice(int show_hint, int multiple_commits, struct
> replay_opts *opts)

Here multiple_commits is not the last argument...

>  {
>         char *msg = getenv("GIT_CHERRY_PICK_HELP");
>
> @@ -174,9 +174,14 @@ static void print_advice(int show_hint, struct
> replay_opts *opts)
>                         advise(_("after resolving the conflicts, mark the
> corrected paths\n"
>                                  "with 'git add <paths>' or 'git rm
> <paths>'"));
>                 else
> -                       advise(_("after resolving the conflicts, mark the
> corrected paths\n"
> -                                "with 'git add <paths>' or 'git rm
> <paths>'\n"
> -                                "and commit the result with 'git
> commit'"));
> +                        if  (multiple_commits)
> +                               advise(_("after resolving the conflicts,
> mark the corrected paths with 'git add <paths>' or 'git rm <paths>'\n"
> +                                        "then continue with 'git %s
> --continue'\n"
> +                                        "or cancel with 'git %s --abort'"
> ), action_name(opts), action_name(opts));
> +                        else
> +                                advise(_("after resolving the conflicts,
> mark the corrected paths\n"
> +                                        "with 'git add <paths>' or 'git rm
> <paths>'\n"
> +                                        "and commit the result with 'git
> commit'"));
>         }
>  }
>
> @@ -440,7 +445,7 @@ static int allow_empty(struct replay_opts *opts, struct
> commit *commit)
>                 return 1;
>  }
>
> -static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
> +static int do_pick_commit(struct commit *commit, struct replay_opts *opts,
> int multiple_commits)

... but here multiple_commits is the last argument.
It would be better if it was more consistent.

>  {
>         unsigned char head[20];
>         struct commit *base, *next, *parent;
> @@ -595,7 +600,7 @@ static int do_pick_commit(struct commit *commit, struct
> replay_opts *opts)
>                       : _("could not apply %s... %s"),
>                       find_unique_abbrev(commit->object.oid.hash,
> DEFAULT_ABBREV),
>                       msg.subject);
> -               print_advice(res == 1, opts);
> +               print_advice(res == 1, multiple_commits, opts);
>                 rerere(opts->allow_rerere_auto);
>                 goto leave;
>         }
> @@ -959,6 +964,7 @@ static int pick_commits(struct commit_list *todo_list,
> struct replay_opts *opts)
>  {
>         struct commit_list *cur;
>         int res;
> +    int multiple_commits = (todo_list->next) != NULL;

Why not "last_commit" instead of "multiple_commits"?

Thanks,
Christian.
