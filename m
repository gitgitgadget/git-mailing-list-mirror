Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C625520A29
	for <e@80x24.org>; Fri, 22 Sep 2017 19:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbdIVTwC (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 15:52:02 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:45432 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbdIVTwB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 15:52:01 -0400
Received: by mail-qt0-f180.google.com with SMTP id t46so2137939qtj.2
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 12:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n3ZZKARqqQF27rS2mrLUUcAXQGL9EJNcksvR/QSOFYg=;
        b=YOl/XHJemIG5i4Eg+evi7kenrPK7iw/P4x0uiQkb5WJfnMPc8SZCF7FZ6TG4tjfgcU
         K9JX7N+tOtmMCNqCVkiZo4wvJcXV/yj6Qt37igK7Pfg37lbCYkz0KRbVJNtUJNQaKFrW
         B0PZ8gek4js8Mx90vkkaYSJfvMdsj3Yu5cvrRoR42BeclDNy4YMp0XGW3+r44ngeKIwd
         T5ofQljjotkQ2QKK3PIo4k2qzlAcC1y5AfeP+6KRMGJARPtOjmAlIdbTL0fsbVaMh/gO
         uJJQgqGnylopKLzQVpinIPhpXAcItALywN44HjNclzpbP2DSjoV18Y2y6ajQEU1gFVyk
         kV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n3ZZKARqqQF27rS2mrLUUcAXQGL9EJNcksvR/QSOFYg=;
        b=kmbBEp6l1iAEa3kFe6JDzY1nFj6j8xUS62yOsI4gKp78lQoyObMrDzMbgJRV0ryC9K
         2FVjqPp5kliQIFwZgYsVUYgSAUuQBdbQapqjWupyYk2frRcdz6UZGGjcEV+vDMp11Xbj
         390Z/U4uUrnGiSNBUArhQGhTZJOnuo45kwDhdIaFS6uU2y6Wl0Nu0zIYZbkPTsWWvMXy
         QBySd/Tg/hK1u2pd6z4cd3PP+Z/41AnjbOQf8KleYa2K1NzImE7YWf2kQYz9ITwMwxTj
         Oxv7xT9qrt6XvzYOJVFlKPWcH9fjvGh3sKmM3TFpkzE4tOZ3GlsJSQB4nwwX1V+nKuXJ
         kVwQ==
X-Gm-Message-State: AHPjjUilCfWtcVkpWemPANH3nTvJ6TaiPBKkuPVvIonbXCzVyTHId9Qf
        V2NZ+Rxo2Ah9QPqfW+Mwkjpu3/BnB9im3m6teh5qubLOdz8=
X-Google-Smtp-Source: AOwi7QCjH//krDghRzzfEfugqZoEGJmGknaylSKa1WxsDGZZb3ny3ccT5hX0GcgtFGOnpLpupxI0yAi1mlthH4yHv10=
X-Received: by 10.200.48.49 with SMTP id f46mr484391qte.260.1506109920700;
 Fri, 22 Sep 2017 12:52:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Fri, 22 Sep 2017 12:52:00 -0700 (PDT)
In-Reply-To: <053ce92e978aff511667669682c9a71830008605.1506081120.git.git@grubix.eu>
References: <cover.1506081120.git.git@grubix.eu> <053ce92e978aff511667669682c9a71830008605.1506081120.git.git@grubix.eu>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 22 Sep 2017 12:52:00 -0700
Message-ID: <CAGZ79kZTeGyNRX59h-Vsw+ZcV9_HOQugz8YN=3H+XxDT0R+iEQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] git-merge: Honor pre-merge hook
To:     Michael J Gruber <git@grubix.eu>,
        Kevin Willford <kewillf@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael J Gruber <git@drmicha.warpmail.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2017 at 5:04 AM, Michael J Gruber <git@grubix.eu> wrote:
> From: Michael J Gruber <git@drmicha.warpmail.net>
>
> git-merge does not honor the pre-commit hook when doing automatic merge
> commits, and for compatibility reasons this is going to stay.
>
> Introduce a pre-merge hook which is called for an automatic merge commit
> just like pre-commit is called for a non-automatic merge commit (or any
> other commit).
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  Documentation/githooks.txt        |  7 +++++++
>  builtin/merge.c                   | 11 +++++++++++
>  templates/hooks--pre-merge.sample | 13 +++++++++++++
>  3 files changed, 31 insertions(+)
>  create mode 100755 templates/hooks--pre-merge.sample
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 1bb4f92d4d..85bedd208c 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -99,6 +99,13 @@ All the 'git commit' hooks are invoked with the environment
>  variable `GIT_EDITOR=:` if the command will not bring up an editor
>  to modify the commit message.
>
> +pre-merge
> +~~~~~~~~~
> +
> +This hook is invoked by 'git merge' when doing an automatic merge
> +commit; it is equivalent to 'pre-commit' for a non-automatic commit
> +for a merge.
> +
>  prepare-commit-msg
>  ~~~~~~~~~~~~~~~~~~
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index ab5ffe85e8..de254d466b 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -769,6 +769,17 @@ static void write_merge_heads(struct commit_list *);
>  static void prepare_to_commit(struct commit_list *remoteheads)
>  {
>         struct strbuf msg = STRBUF_INIT;
> +       const char *index_file = get_index_file();
> +
> +       if (run_commit_hook(0 < option_edit, index_file, "pre-merge", NULL))
> +               abort_commit(remoteheads, NULL);
> +       /*
> +        * Re-read the index as pre-merge hook could have updated it,
> +        * and write it out as a tree.  We must do this before we invoke
> +        * the editor and after we invoke run_status above.
> +        */
> +       discard_cache();
> +       read_cache_from(index_file);

Please see 680ee550d7 (commit: skip discarding the index
if there is no pre-commit hook, 2017-08-14), maybe we can do it similarly.
Dropping and rereading the index may be expensive for large repos.

>         strbuf_addbuf(&msg, &merge_msg);
>         strbuf_addch(&msg, '\n');
>         if (squash)
> diff --git a/templates/hooks--pre-merge.sample b/templates/hooks--pre-merge.sample
> new file mode 100755
> index 0000000000..a6313e6d5c
> --- /dev/null
> +++ b/templates/hooks--pre-merge.sample
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +#
> +# An example hook script to verify what is about to be committed.
> +# Called by "git merge" with no arguments.  The hook should
> +# exit with non-zero status after issuing an appropriate message if

The message goes to stdout or sterr or both?

> +# it wants to stop the commit.

nit: s/commit/merge commit/ maybe?

Thanks,
Stefan
