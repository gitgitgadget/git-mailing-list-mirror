From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/GSoC_v3] branch.c: turn nested if-else logic to table-driven
Date: Mon, 17 Mar 2014 03:54:40 -0400
Message-ID: <CAPig+cRWAr+p=npTh-MKpNy+A6wjLBtN9JB=u=UtVudGLU6TuA@mail.gmail.com>
References: <CAPig+cRF_eQiGugR8TSks5ki375y-5wiQ7HWKyKRudJ5apd4cg@mail.gmail.com>
	<1394950103-2264-1-git-send-email-zhaox383@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>
To: Yao Zhao <zhaox383@umn.edu>
X-From: git-owner@vger.kernel.org Mon Mar 17 08:54:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPSNi-0007si-DJ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 08:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434AbaCQHym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 03:54:42 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:60131 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364AbaCQHyl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 03:54:41 -0400
Received: by mail-yh0-f54.google.com with SMTP id f73so4859899yha.41
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 00:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=zGXUnnZ4zmdj8kyMte+c0Pkhf4sbwL49uAp1iwF1IOg=;
        b=tS8q7I5NHAcJucUwfz6m0HMAMHZ+LrOr/Yq2Qs+YmTe3iuY3at6wpqcgLTIZSrFGeh
         u+w11dv4EinBq0rhM8xLJUHKrqkBiXfLcexDIBURpR6uDGMpl87Qc+jmpd97ufX1jkUi
         FcjzNAsJNmUEzx78yCLhNTuZKKEtBKhwGDo/l0OG1Mj2FWe2AnXSb++0Vwpx2hptSKYO
         o+jb30/l3vylp/9Bfjms1+I+QEdD0Kmi177bNTTsk1GwCvR7RrG07GNo2sGhzyHuN3UB
         gtMp16kfSapODJ9zqUYY9JCoKcNgkzwqN0ruN7+Jba82A4eklD+tJ6+WfgcB7E3OiDoD
         ovKg==
X-Received: by 10.236.61.45 with SMTP id v33mr8184519yhc.20.1395042880596;
 Mon, 17 Mar 2014 00:54:40 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 17 Mar 2014 00:54:40 -0700 (PDT)
In-Reply-To: <1394950103-2264-1-git-send-email-zhaox383@umn.edu>
X-Google-Sender-Auth: GTIep24ObL-tXY3m7-ypAiMiQ1E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244230>

On Sun, Mar 16, 2014 at 2:08 AM, Yao Zhao <zhaox383@umn.edu> wrote:
> Signed-off-by: Yao Zhao <zhaox383@umn.edu>
> ---
>  branch.c | 53 +++++++++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
> Hello Eric,
>
> Thank you and Junio for reviewing my code. It is really helpful to improve my code quality.

Wrap commit message (and preferably commentary) to 65-70 characters.

> This is version 3 of patch. Previous address : http://thread.gmane.org/gmane.comp.version-control.git/243919. I do not use positional initializer because it is not allowed to use variable in it. I don't know if it's ok to use this redundant way to initialize "list".

Thanks for the resubmission. A few comments below, but I don't think
you need to resubmit. What is important is that you have had a taste
of the review process on this project, and the GSoC mentors have had a
chance to observe your abilities and reviewer interaction. A better
use of your time now would be to make your GSoC proposal and converse
with the mentors.

> I cannot find -v flag in documentation you indicated in last email so I use set-prefix to add it into prefix.

Sorry for the confusion. As Junio pointed out [1], I meant the -v
option of "git format-patch", not "git format-email" (which doesn't
exist).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243919/focus=244095

> Now I am working on writing proposal for git project. I am really interested in last one, about improve git_config. I know it's important to get known about git_config first and have read documentation about it. But I am really confused about how to understand code of git_config. When user type in git config in terminal, what is the execute order of functions? How git config influence other git command? Does program read config file every time when they execuate config-related command?

You will get a better response if you ask these questions in a new
email thread rather than re-using this one. Choose a subject for your
email which indicates clearly that you have questions about that
particular GSoC project, address it to the git mailing list, and cc:
the mentors of that project.

> Thank you,
>
> Yao
>
> diff --git a/branch.c b/branch.c
> index 723a36b..1df30c7 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -53,7 +53,33 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>         int remote_is_branch = starts_with(remote, "refs/heads/");
>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
> -
> +       struct print_list {
> +               const char *print_str;
> +               const char *arg2;
> +               const char *arg3;
> +       } ;
> +       struct print_list target;

This should be 'const struct print_list *target'. There is no need to
copy the entire structure (below) just to access its members.

> +       struct print_list list[2][2][2];
> +       list[0][0][0].print_str = N_("Branch %s set up to track local ref %s.");
> +       list[0][0][0].arg2 = remote;
> +       list[0][0][1].print_str = N_("Branch %s set up to track local ref %s by rebasing.");
> +       list[0][0][1].arg2 = remote;
> +       list[0][1][0].print_str = N_("Branch %s set up to track remote ref %s.");
> +       list[0][1][0].arg2 = remote;
> +       list[0][1][1].print_str = N_("Branch %s set up to track remote ref %s by rebasing.");
> +       list[0][1][1].arg2 = remote;
> +       list[1][0][0].print_str = N_("Branch %s set up to track local branch %s.");
> +       list[1][0][0].arg2 =shortname;
> +       list[1][0][1].print_str = N_("Branch %s set up to track local branch %s by rebasing.");
> +       list[1][0][1].arg2 = shortname;
> +       list[1][1][0].print_str = N_("Branch %s set up to track remote branch %s from %s.");
> +       list[1][1][0].arg2 = shortname;
> +       list[1][1][0].arg3 = origin;
> +       list[1][1][1].print_str = N_("Branch %s set up to track remote branch %s from %s by rebasing.");
> +       list[1][1][1].arg2 = shortname;
> +       list[1][1][1].arg3 = origin;

Since this is not in an initializer table, you would normally use _()
rather than N_() (and you don't have to use _() in the printf_ln()
invocation).

It disturbs me to see that .arg3 does not get initialized in most of
these cases, yet it is accessed below by printf_ln(). Code analysis
tools are likely to complain about accessing an uninitialized value.

One way you could put this into the initializer would be to use a
constant expression to indicate which variable to pass to printf_ln().
Something like this:

    struct print_list {
        const char *print_str;
        int use_shortname;
        int use_origin;
    } print_list[][2][2] = {
        N_("Branch %s ..."), 0, 0,
        ...
        N_("Branch %s ..."), 1, 0,
        ...
    }

    printf_ln(_(target->print_str), local,
        target->use_shortname ? shortname : remote,
        target->use_origin ? origin : NULL);

To make it clearer, use named constants rather than 0 and 1.

NOTE: I am *not* suggesting that you resubmit with this change. It's
getting ugly and bordering on being too complex and difficult to read.
As noted above, your time is probably better spent working on your
GSoC proposal.

>         if (remote_is_branch
>             && !strcmp(local, shortname)
>             && !origin) {
> @@ -77,29 +103,8 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>         strbuf_release(&key);
>
>         if (flag & BRANCH_CONFIG_VERBOSE) {
> -               if (remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote branch %s from %s by rebasing.") :
> -                                 _("Branch %s set up to track remote branch %s from %s."),
> -                                 local, shortname, origin);
> -               else if (remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local branch %s by rebasing.") :
> -                                 _("Branch %s set up to track local branch %s."),
> -                                 local, shortname);
> -               else if (!remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote ref %s by rebasing.") :
> -                                 _("Branch %s set up to track remote ref %s."),
> -                                 local, remote);
> -               else if (!remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local ref %s by rebasing.") :
> -                                 _("Branch %s set up to track local ref %s."),
> -                                 local, remote);
> -               else
> -                       die("BUG: impossible combination of %d and %p",
> -                           remote_is_branch, origin);
> +                       target = list[!!remote_is_branch][!!origin][!!rebasing];

With the suggestion above of making 'target' a pointer to the struct,
this would become:

    target = &list[...][...][...];

> +                       printf_ln (_(target.print_str), local, target.arg2, target.arg3);

Style: whitespace: printf_ln(...)

And this would become:

    printf_ln(_(target->print_str), local, target->arg2, target->arg3);

>         }
>  }
>
> --
> 1.8.3.2
