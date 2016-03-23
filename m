From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] add option -n (--no-checkout) to git-worktree add
Date: Wed, 23 Mar 2016 11:49:33 -0400
Message-ID: <CAPig+cR3gQyqaVUeCN0OUAHDOmjYsDQ4LM3O0wj2f3jotchsDg@mail.gmail.com>
References: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ray Zhang <zhanglei002@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 16:49:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ail2R-0005bO-74
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 16:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729AbcCWPtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 11:49:35 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33903 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755705AbcCWPte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 11:49:34 -0400
Received: by mail-vk0-f54.google.com with SMTP id e185so24666121vkb.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Cb4t67FuQ8wHPWt1tyW6zdA4GrVpD5R2JMJ6YRbFiw4=;
        b=m93n6o/G3zcnOZPVoRpM0s5bSLBfFvXgZCeuFUzgaKWb7r6kVQOZIa3ltGw0ooZMlV
         HKK2nERAmzsSB2uWi6oIsYXPr/ZU0acXYzAdv9YtxS2k6/B7g73RvsrggVKYcwXkdIfQ
         glZVVwTAnf/DIPAvtBMpE0USWPwybm8PMrm0WqS/reK66AqNy4GJJrgJUxU/zLoa+JZl
         RHwWdyQ0GvIc++KaupR/oG6FFY+rzo/dEtLSFULMgF4dqRjssDENXKZhj7SP5rF4gadG
         jHF/vNlqGogzDvhleC5w3NOiixoZhe0nqvKCFnyTQP/sbhJKtaWD0DEP9znMc3yVqFbI
         oJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Cb4t67FuQ8wHPWt1tyW6zdA4GrVpD5R2JMJ6YRbFiw4=;
        b=mDNNq7b7TZBSJcwL0zx464Bv45ov7KhJg65bQbulm8hkQBfhdSicEdewgEyk6HPG4Y
         fd/DpFFkUQTjSEsbdEeEF2lw4C4X22bvuHfATAccdGtnDB0NDSQpsBN+yklUfHV/dwfi
         bWTo/Z/5ktASA6YLs87bwWvI4boxfJQLLQyktJ5MErCz50WfI+zeYahdq+dvWw8/iZdu
         +SUZb4jH76YDjSBQGIUykAy/++zB6lmqiESxo9I21Qp9nLejpKWy6ScfBMvTe0Tt8Gec
         uHafBNtggL96Lx5cxIXetlhf+exCYxTOJfk3ghC5zO2quIqrPLhqTp6YeR6Sb3Che3CX
         +iZg==
X-Gm-Message-State: AD7BkJJvocTzLSxrqsxri4e72YG+3HBY0hGdCy4TGmwAWjHrxGI8Gz9OZlTyNANt91bIJVbYuyn0iWeOk/japg==
X-Received: by 10.31.8.142 with SMTP id 136mr2032224vki.14.1458748173187; Wed,
 23 Mar 2016 08:49:33 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Wed, 23 Mar 2016 08:49:33 -0700 (PDT)
In-Reply-To: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: k9Y-v68bYEE5fUHqNSsx9vi5Ci8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289661>

On Wed, Mar 23, 2016 at 11:08 AM, Ray Zhang <zhanglei002@gmail.com> wrote:
> add option -n (--no-checkout) to git-worktree add

Alternate:

    worktree: add: introduce --no-checkout option

> By adding option -n, we can make some customizations before checkout, like sparse checkout, etc.

This parallels git-clone's --no-checkout. Okay.

Typically, one would not squat on a short option (-n) when first
introducing a feature and would only add the short equivalent after
the option proved popular, however, in this case, as git-clone
supports -n, I suppose finger muscle-memory is a consideration.

By the way, please wrap the commit message at 70-72 characters or so.

> Signed-off-by: Ray Zhang <zhanglei002@gmail.com>
> ---
>  builtin/worktree.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

This change needs corresponding documentation
(Documentation/git-worktree.txt) and test (t/t2025-worktree-add.sh)
updates.

Thanks.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 38b5609..14ca3d9 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -21,6 +21,7 @@ static const char * const worktree_usage[] = {
>  struct add_opts {
>         int force;
>         int detach;
> +       int no_checkout;
>         const char *new_branch;
>         int force_new_branch;
>  };
> @@ -284,11 +285,13 @@ static int add_worktree(const char *path, const char *refname,
>         if (ret)
>                 goto done;
>
> -       cp.argv = NULL;
> -       argv_array_clear(&cp.args);
> -       argv_array_pushl(&cp.args, "reset", "--hard", NULL);
> -       cp.env = child_env.argv;
> -       ret = run_command(&cp);
> +       if (!opts->no_checkout) {
> +               cp.argv = NULL;
> +               argv_array_clear(&cp.args);
> +               argv_array_pushl(&cp.args, "reset", "--hard", NULL);
> +               cp.env = child_env.argv;
> +               ret = run_command(&cp);
> +       }
>         if (!ret) {
>                 is_junk = 0;
>                 free(junk_work_tree);
> @@ -320,6 +323,7 @@ static int add(int ac, const char **av, const char *prefix)
>                 OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
>                            N_("create or reset a branch")),
>                 OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
> +               OPT_BOOL('n', "no-checkout", &opts.no_checkout, N_("don't create a checkout")),
>                 OPT_END()
>         };
