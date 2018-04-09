Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DACB61F404
	for <e@80x24.org>; Mon,  9 Apr 2018 00:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754880AbeDIAXe (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 20:23:34 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45753 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754794AbeDIAXd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:33 -0400
Received: by mail-qt0-f195.google.com with SMTP id f8so7390295qtg.12
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 17:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=QMjZPeTNYDP5mw0xMzCMYOaobE8qtlUXaz5V+lIHMQY=;
        b=iz746UDdKuOdKS1wEdsmvnBR1GerbkJGCaC1/TpI6FlGfxWSxqAaWuh6gk5Gcnjepw
         E3D2fs8oE47LuoOgHxT5k6lcR6P2LQROETLQEGUHBC2+9KX6/2u1yci4FxxVf6Wu1omd
         HNio/RWs4JdNNyxzDbYj1zDroYMfMOY2+Z1DXEoKdXR6a2bTicNAg3vcu6LuS9Yq7Gyb
         iM84EcpqKWbYtsswOLQooLB5KEqoEt+NLtyC9ZIXGgbRgbDpk8O1pnCjLiGZOEv+Orga
         zRSrptM8SZMPMphwQVtkKbxpb7T+NyLvTNVkTfv3NYqMXnZLcGwECITUFaYfKgKUz70w
         OlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=QMjZPeTNYDP5mw0xMzCMYOaobE8qtlUXaz5V+lIHMQY=;
        b=kbz/VdONVe1EfvPR2hKMejtNxdJ8GPqqcGnyCoQK0SwaeBAzHUVpSsLIIVHRzSdNO6
         neu3sOhqPuaMb0GWpHplyTPkoHDAqDzShOb6e/u2xpxY6TvjFDxtS1oDVMEHMzE1QxHY
         6UW6/0zD+ywcLVbLsTYAXbaAOsV23LskgjybQa4TY6z9a3s3q60++wnm2b2G0HURYeeM
         BRDLHmCN3GvFMvPG7LFTIMbcrJMsEHR3y8/+s79qHiMOGhxqy6VBYvE3VM62TPwRKCdR
         oo3ipnpixQzG45OZ4xAtlIcktM69qJEL6P2m5/zC28mt1RLEqH7XxXiudg7Qe9TFKRSo
         bhZQ==
X-Gm-Message-State: ALQs6tBQtZl9H0+HSPeLt7EwFPrzTiTOUnrybL705misEljvkFksMzee
        7b/3/bXhq6HyK2GUJJod0gL0io53f1PlRA0E7dM=
X-Google-Smtp-Source: AIpwx4/MC80urfQySudL4spnmjXqxh3eRc5zzCS9UKeGhSWkMEOaSMKXWxx59xOoKjx/vCN3fK8dCRbNfu4Su667Lg8=
X-Received: by 10.200.69.131 with SMTP id l3mr7417092qtn.50.1523233412060;
 Sun, 08 Apr 2018 17:23:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 8 Apr 2018 17:23:31 -0700 (PDT)
In-Reply-To: <20180401131138.GE2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com> <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180331151804.30380-7-t.gummerer@gmail.com> <20180401131138.GE2629@hank>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 8 Apr 2018 20:23:31 -0400
X-Google-Sender-Auth: -5hD8hKXxDbBUTvffRvCenCBYR4
Message-ID: <CAPig+cRYgLwLZnXeOc2VWBmh8j_AxSGmf2x-DJ1kAbY3BzsAPQ@mail.gmail.com>
Subject: Re: [PATCH v6 6.5/6] fixup! worktree: teach "add" to check out
 existing branches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 1, 2018 at 9:11 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> So while playing with it a bit more I found one case where the new UI
> is not ideal and a bit confusing.  Namely when the new check out dwim
> kicks in, but there is already a file/directory at the path we're
> giving to 'git worktree add'.
>
> In that case something like the following would be printed:
>
>     $ g worktree add ../next
>     Checking out branch 'next'
>     fatal: '../next' already exists
>
> Instead I think we'd just want the error without the "Checking out
> branch" message, which is what this fixup here does.

Doesn't the same UI "problem" exist when it creates a new branch?

    $ git worktree add ../dwim
    Creating branch 'dwim'
    fatal: '../dwim' already exists

As you mention below, we don't (yet) clean up the newly-created branch
upon failure, so we can't suppress the "Creating branch" message as
you suppress the "Checking out branch" message above (since the user
needs to know that the new branch exists).

This is making me wonder if "Checking out branch" is perhaps the wrong
terminology. What if it said something like this instead:

    $ git worktree add ../next
    Preparing worktree (branch 'next' <= 'origin/next')
    fatal: '../next' already exists

    $ git worktree add ../gobble
    Preparing worktree (new branch 'gobble')
    fatal: '../gobble' already exists

This way, we don't need the special case added by this "fixup!" patch.
(I'm not wedded to the "Preparing" message but just used it as an
example; better suggestions welcome.)

> One thing that gets a bit strange is that the "Checking out branch"
> message and the "Creating branch" messages are printed from different
> places.  But without doing quite some refactoring I don't think
> there's a good way to do that, and I think having the UI do the right
> thing is more important.

The implementation is getting rather ugly, though, especially with
these messages being printed by different bits of code like this.
worktree.c:add_worktree() was supposed to be the low-level worker; it
wasn't intended for it to take on UI duties like this "fixup!" makes
it do. UI should be handled by worktree.c:add().

Taking the above "Preparing..." idea into consideration, then it
should be possible to sidestep this implementation ugliness, I would
think.

> One thing I also noticed is that if a branch is created by 'git
> worktree add', but we fail, we never clean up that branch again, which
> I'm not sure is ideal.  As a pre-existing problem I'd like to keep
> fixing that out of the scope of this series though (at least after
> this series the user would get some output showing that this happened,
> even when the branch is not set up to track a remote), so I'd like to
> keep fixing that out of the scope of this series.

Nice idea, but outside the scope of this series, as you mention.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -27,6 +27,7 @@ struct add_opts {
>         int keep_locked;
> +       int checkout_existing_branch;
>  };
> @@ -316,6 +317,8 @@ static int add_worktree(const char *path, const char *refname,
> +       if (opts->checkout_existing_branch)
> +                 fprintf_ln(stderr, _("Checking out branch '%s'"), refname);
>         if (opts->checkout) {

I'd have expected to see the "if (opts->checkout_existing_branch)
fprintf_ln(...)" inside the following "if (opts->checkout)"
conditional, though, as noted above, I'm not entirely happy about
worktree.c:add_worktree() taking on UI duties.

>                 cp.argv = NULL;
>                 argv_array_clear(&cp.args);
