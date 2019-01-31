Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 526A01F453
	for <e@80x24.org>; Thu, 31 Jan 2019 07:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfAaHjc convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 31 Jan 2019 02:39:32 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33825 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfAaHjc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 02:39:32 -0500
Received: by mail-qt1-f194.google.com with SMTP id r14so2526579qtp.1
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 23:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mvd9zhE3g71mzU3zu4zqAgJWstirSxauo7D4egG4JI8=;
        b=guPKjaZtZcA3SgosK53xcv876O7NbWcfIk5tUPFFvDsUfrJMRvKSsb2kfzO9ZH7jPc
         msEhBcBBU8iQnrRpplztck5tSJnlKvzgL7Ar2rS7HTHJxT7pVzhWgIvTfncFoRoNQ5QC
         cvHip75uAa4nYl2nGVCVZt9HhnDEuzLypmVWnEyweQK1rVaF2OGe8JvCLmQTjwZB7Fjh
         7z9LX9e9r5RlC9nqVZhT1R9fCFluwj+uJIg6Xty91tjIC9xPll5NZlxrL8r67hrY/K8Z
         P1cMFC18PT7wFaBHZlQ2qEAIWE2AFZUesy3EjBmZae5UUaiInevlDHLJNVpPrj+CCWlY
         Gj7g==
X-Gm-Message-State: AJcUuke953q4RI4xUpOcsy38sd5t+KjRfsvUBAaaCjscEZAkBO0jCae+
        lTIQ71TV0viZqOnUeB/ctr6IlG9izMhp9Nnfq/oLKZSh
X-Google-Smtp-Source: ALg8bN4V0ydnIxrSv4qkRbE5jqUuWP6iWEP2cZpPa76qM+pmrEYSsJWIKliBqb+4sfu6k4FtE+r0y7M/4djthKfuynE=
X-Received: by 2002:a0c:86c1:: with SMTP id 1mr30674885qvg.6.1548920370878;
 Wed, 30 Jan 2019 23:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190130094831.10420-20-pclouds@gmail.com>
In-Reply-To: <20190130094831.10420-20-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 31 Jan 2019 02:39:19 -0500
Message-ID: <CAPig+cRJJtZv0LcchXhV5FFOnbJTVio9Y_R8hyvGJEAGLsJ69A@mail.gmail.com>
Subject: Re: [PATCH 19/19] doc: promote "git switch"
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 4:50 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> The new command "git switch" is added to avoid the confusion of
> one-command-do-all "git checkout" for new users. They are also helpful
> to avoid ambiguation context.
>
> For these reasons, promote it everywhere possible. This includes
> documentation, suggestions/advice from other commands...
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> @@ -319,7 +319,7 @@ NOTES
>  If you are creating a branch that you want to checkout immediately, it is

s/checkout/switch to/

> -easier to use the git checkout command with its `-b` option to create
> +easier to use the "git switch" command with its `-c` option to create
>  a branch and check it out with a single command.
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> @@ -302,22 +302,22 @@ ref: refs/heads/master
>  Examining an old version without creating a new branch
>  ------------------------------------------------------
>
> -The `git checkout` command normally expects a branch head, but will also
> +The `git switch` command normally expects a branch head, but will also
>  accept an arbitrary commit; for example, you can check out the commit
>  referenced by a tag:

This may need to mention --detach explicitly. Perhaps:

    ...normally expects a branch head, but will also accept
    an arbitrary commit when invoked with --detach;...

> diff --git a/advice.c b/advice.c
> @@ -191,13 +191,16 @@ void NORETURN die_conclude_merge(void)
>  void detach_advice(const char *new_name)
>  {
>         const char *fmt =
> -       _("Note: checking out '%s'.\n\n"
> +       _("Note: checking out '%s'.\n"

Do you also want to adjust this to avoid saying "checking out"?

> +       "\n"
>         "You are in 'detached HEAD' state. You can look around, make experimental\n"
>         "changes and commit them, and you can discard any commits you make in this\n"
> -       "state without impacting any branches by performing another checkout.\n\n"
> +       "state without impacting any branches by performing another checkout.\n"

Ditto: "checkout"?

> +       "\n"
>         "If you want to create a new branch to retain commits you create, you may\n"
> -       "do so (now or later) by using -b with the checkout command again. Example:\n\n"
> -       "  git checkout -b <new-branch-name>\n\n");
> +       "do so (now or later) by using -b with the checkout command again. Example:\n"

s/-b/-c/
s/checkout/switch/

> +       "\n"
> +       "  git switch -c <new-branch-name>\n\n");
> diff --git a/builtin/clone.c b/builtin/clone.c
> @@ -491,7 +491,7 @@ static enum {
>  static const char junk_leave_repo_msg[] =
>  N_("Clone succeeded, but checkout failed.\n"
>     "You can inspect what was checked out with 'git status'\n"
> -   "and retry the checkout with 'git checkout -f HEAD'\n");
> +   "and retry the checkout with 'git switch -f HEAD'\n");

Just wondering if these uses of "checkout" and "checked out" need
adjustment. I don't have any good suggestions, though.

> diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
> @@ -204,7 +204,7 @@ test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not as
>         If you want to create a new branch to retain commits you create, you may
>         do so (now or later) by using -b with the checkout command again. Example:

s/-b/-c/
s/checkout/switch/

> -         git checkout -b <new-branch-name>
> +         git switch -c <new-branch-name>
> @@ -280,7 +280,7 @@ test_expect_success 'describe_detached_head does print SHA-1 ellipsis when asked
>         If you want to create a new branch to retain commits you create, you may
>         do so (now or later) by using -b with the checkout command again. Example:

s/-b/-c/
s/checkout/switch/

> -         git checkout -b <new-branch-name>
> +         git switch -c <new-branch-name>
