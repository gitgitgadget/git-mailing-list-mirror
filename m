Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385131F424
	for <e@80x24.org>; Tue, 24 Apr 2018 03:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932857AbeDXD6G (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 23:58:06 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44308 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932729AbeDXD6E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 23:58:04 -0400
Received: by mail-qk0-f196.google.com with SMTP id z8so2646089qki.11
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 20:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LwXukD3re4SYsrnzApimb+Pfh3HS+tk9LGEoCJpWyug=;
        b=uTXFX+2zV+hHND6SZSJAy7BIq1W4BQfqqz/0aH2ZkQUZ90huJjK4Eaa4x2/bUStej7
         eT0AocAGWMIGM47qYCnowKQ+qklJZhIB8nrQMWaiGobpG1yNXktrwaztWwSWSmanTOZB
         9I5W8XKCE/vZ7qBDuNPXvc4NYywDI/Ds6wm/zVWjml9FT/19j7GxfcWBEhqvo8luB60B
         P0XNc5QErrQslC45iAe3dDjL9kLJiTEBcQjblROsS2YSPyGLYrhde1R5ccJedtReec53
         SrHa9XTQjo9ojIl+nSb+StxeQNP50jVVChPZN4XyT2OXOj74rkH8KE5BCNPkj1zObfTp
         miRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LwXukD3re4SYsrnzApimb+Pfh3HS+tk9LGEoCJpWyug=;
        b=CJBxOkf+i/NvQ+r7fAb9eJ8CZnmUyPFIWVOazewUbRSv+th1MitECfzU08wfexrfze
         VDGY7TB442tBlpwQNef1kiLZf6HyxDgkSz5W1l2E23TbqxBJM2Zs9XlLHBudQJTl993+
         6U5OtlaZJ4T+IO/CREEgc2ZHM0Nr/JSFwB70ZZgS1EGQjalWUZVbS7XWy2rzLnG27EQb
         njEeEncyjF+SHSvti50xmeaAl/RQqpVLY9Q3kEp0E8w0KcHauyqo29vZ7Upi8mf27jke
         sCJ6ZPdRG+/rhwo97GQETtmoBi4GWualfKy7JmngJqZXCGxvFyGUrw8ktrU7h4NDYrsl
         ZTjw==
X-Gm-Message-State: ALQs6tDhoTCzjDkwAUVBQxhU5Zo+Tze/5vWrOLRoTJUEPe6CTn6XAH8i
        gLCh8hItbWqf/PMLeABPtpEV8WAGrSRrbVMmrb8=
X-Google-Smtp-Source: AB8JxZrsR3e9+j+qZ8IkHg5DQBVEaGSjcuFZLvRkqM3gc7xgh78QWvNDbGk81yXwSsMyBVx9K42fBrYrHXiFs8UJEFc=
X-Received: by 10.55.79.9 with SMTP id d9mr24839834qkb.2.1524542283270; Mon,
 23 Apr 2018 20:58:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 23 Apr 2018 20:58:02 -0700 (PDT)
In-Reply-To: <20180423193848.5159-3-t.gummerer@gmail.com>
References: <20180415202917.4360-1-t.gummerer@gmail.com> <20180423193848.5159-1-t.gummerer@gmail.com>
 <20180423193848.5159-3-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Apr 2018 23:58:02 -0400
X-Google-Sender-Auth: F5jBZOhKpUhFJp_jck4589EgJSs
Message-ID: <CAPig+cSOhdfyn+yJcsM9h3r7Atf4pQCX7pgPOB2hv+OHJ3r1bg@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] worktree: improve message when creating a new worktree
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 3:38 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Currently 'git worktree add' produces output like the following:
>
>     Preparing ../foo (identifier foo)
>     HEAD is now at 26da330922 <title>
>
> The '../foo' is the path where the worktree is created, which the user
> has just given on the command line.  The identifier is an internal
> implementation detail, which is not particularly relevant for the user
> and indeed isn't mentioned explicitly anywhere in the man page.
>
> Instead of this message, print a message that gives the user a bit more
> detail of what exactly 'git worktree' is doing.  There are various dwim
> modes which perform some magic under the hood, which should be
> helpful to users.  Just from the output of the command it is not always
> visible to users what exactly has happened.
>
> Help the users a bit more by modifying the "Preparing ..." message and
> adding some additional information of what 'git worktree add' did under
> the hood, while not displaying the identifier anymore.
>
> Currently this ends up in three different cases:

You now enumerate four cases, not three. Perhaps: "There are several
different cases:"

>   - 'git worktree add -b ...' or 'git worktree add <path>', both of
>     which create a new branch, either through the user explicitly
>     requesting it, or through 'git worktree add' implicitly creating
>     it.  This will end up with the following output:
>
>       Preparing worktree (new branch '<branch>')
>       HEAD is now at 26da330922 <title>
>
>   - 'git worktree add -B ...', which may either create a new branch if
>     the branch with the given name does not exist yet, or resets an
>     existing branch to the current HEAD, or the commit-ish given.
>     Depending on which action is taken, we'll end up with the following
>     output:
>
>       Preparing worktree (resetting branch 'next'; was at caa68db14)
>       HEAD is now at 26da330922 <title>

For consistency with the other examples: s/next/<branch>/

>     or:
>
>       Preparing worktree (new branch '<branch>')
>       HEAD is now at 26da330922 <title>
>
>   - 'git worktree add --detach' or 'git worktree add <path>
>     <commit-ish>', both of which create a new worktree with a detached
>     HEAD, for which we will print the following output:
>
>       Preparing worktree (detached HEAD 26da330922)
>       HEAD is now at 26da330922 <title>
>
>   - 'git worktree add <path> <local-branch>', which checks out the
>     branch prints the following output:

s/prints/and prints/

>       Preparing worktree (checking out '<branch>')
>       HEAD is now at 47007d5 <title>

s/<branch>/<local-branch>/ would probably be clearer since you use
<local-branch> in the example command.

> [...]
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -355,6 +353,40 @@ static int add_worktree(const char *path, const char *refname,
> +static void print_preparing_worktree_line(int detach,
> +                                         const char *branch,
> +                                         const char *new_branch,
> +                                         const char *new_branch_force)
> +{
> +       if (new_branch_force) {
> +               struct commit *commit = lookup_commit_reference_by_name(new_branch_force);

Nit: By the time this function is called, 'new_branch' contains the
same value as 'new_branch_force' if "-B" was used. 'new_branch' _is_
the name of the new branch, forced or not, and it's easier to reason
about 'new_branch_force' as a mere boolean indicating whether "force"
is in effect. This suggests that the final argument to this function
should be a boolean (int) named either 'force' or 'force_new_branch',
and that 'new_branch' should be used everywhere the code needs to
reference the new branch name (forced or not).

Not worth a re-roll.

> +               if (!commit)
> +                       printf_ln(_("Preparing worktree (new branch '%s')"), new_branch_force);
> +               else
> +                       printf_ln(_("Preparing worktree (resetting branch '%s'; was at %s)"),
> +                                 new_branch_force,
> +                                 find_unique_abbrev(commit->object.oid.hash,
> +                                                    DEFAULT_ABBREV));
> +       } else if (new_branch) {
> +               printf_ln(_("Preparing worktree (new branch '%s')"), new_branch);
> +       } else {
> +               struct strbuf s = STRBUF_INIT;
> +               if (!detach && !strbuf_check_branch_ref(&s, branch) &&
> +                   ref_exists(s.buf))
> +                       printf_ln(_("Preparing worktree (checking out '%s')"),
> +                                 branch);
> +               else {
> +                       struct commit *commit = lookup_commit_reference_by_name(branch);
> +                       if (!commit)
> +                               die(_("invalid reference: %s"), branch);
> +                       printf_ln(_("Preparing worktree (detached HEAD %s)"),
> +                                 find_unique_abbrev(commit->object.oid.hash,
> +                                                    DEFAULT_ABBREV));
> +               }

It's too bad this final case duplicates so much code from
add_worktree(). Perhaps some future refactoring patch (not part of
this series) can consolidate the code.

> +               strbuf_release(&s);
> +       }
> +}
> @@ -434,6 +466,8 @@ static int add(int ac, const char **av, const char *prefix)
> +       print_preparing_worktree_line(opts.detach, branch, new_branch, new_branch_force);
> +
>         if (new_branch) {
>                 struct child_process cp = CHILD_PROCESS_INIT;
