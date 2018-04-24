Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9F41F424
	for <e@80x24.org>; Tue, 24 Apr 2018 03:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932827AbeDXD0n (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 23:26:43 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:35643 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932776AbeDXD0m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 23:26:42 -0400
Received: by mail-qt0-f178.google.com with SMTP id s2-v6so20306733qti.2
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 20:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sAo9kbI8PEey0FBrR6hAjiZsQnesTehrHRw9GVw0Rso=;
        b=kNvZOujRudkNntDMuFOvQZRDpdL6Kz1j0vkccyok99ZIos52ZVMWyFNsUVvjRhSzsc
         jTwJ3AOmQM5KBF1pPrpnMkdM4TIpO7HkEJPiBdtBhykVgC3cFd5BrYtIaV82lbdgGbi/
         c84Q7+NBVpy4F+l/bvpDVnR60OPkgEiSBVruvuXmNNktDkaD1gbduz15Dx8W0ILub/DT
         SVSpLzxpgXO/zCv5btVk60iR0KOUFVNH7Ag5ppRkT7Nf09JgRrZm7+t6RlJhTwQIOiSM
         BfE5Ko6ga6p2EtEM5lKI2Zvd3G3DpgocHfKW9NJxhHdFZTQE4U4mwmFsfLiHPumUvP8N
         b5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sAo9kbI8PEey0FBrR6hAjiZsQnesTehrHRw9GVw0Rso=;
        b=GniZqUcACMEeli5egmhYpcCunbwTGWBxaqMVkvIFRKWA3cOpXHYOMgSsLoviWvHUA4
         e/T3uRTV138EyIVie9buDgvYX3wj+xG4tuGiCpkVIuCw77XNkcYeqouT7UvPmbABiOIl
         kU8gSL9nHmckGp/ftRLLFjbuPMcy+iMirDPSqNohiYpjtcpOANwDDAzghSOPEQ4WAQlN
         1YfkSrir78EnSbJRs3xfkYTJXeeGZiGNwonmXamYOgkPkW6EQ6eH1TQ6tWtLKrhm+5pa
         lab/+b0deXohCVUxcsPtHNGQamXH0TWNLsNnmJPX5cMTN6jZPzjXo0636I6ZknLP9jyB
         nSDA==
X-Gm-Message-State: ALQs6tAO4KsTsvv8fzTvob+dCRVF4k4aTGgLdUTfXDAcOAlv38Z4O3Mp
        KThNAX5P2jTm+W4zN0/E1kYJs50iQTy/3DaoGRo=
X-Google-Smtp-Source: AB8JxZpGOZ4/SFqfdRjv1UwxCJzIQ5xQ34wIKyjGISZWPE3ShRi4pshPR2OsB8MYUQPAzijvRV8lYr+MLunRnJkWSr4=
X-Received: by 2002:aed:26a4:: with SMTP id q33-v6mr25289849qtd.165.1524540401824;
 Mon, 23 Apr 2018 20:26:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 23 Apr 2018 20:26:41 -0700 (PDT)
In-Reply-To: <20180423193848.5159-2-t.gummerer@gmail.com>
References: <20180415202917.4360-1-t.gummerer@gmail.com> <20180423193848.5159-1-t.gummerer@gmail.com>
 <20180423193848.5159-2-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Apr 2018 23:26:41 -0400
X-Google-Sender-Auth: iBaU4P-Rfz9TAHCzxq_U3IlQEcY
Message-ID: <CAPig+cSH1ouZBU9BT64vL5vBz4cD+UFCoFH4fZyf8JrM7dKe5Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] worktree: remove extra members from struct add_opts
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
> There are two members of 'struct add_opts', which are only used inside
> the 'add()' function, but being part of 'struct add_opts' they are
> needlessly also passed to the 'add_worktree' function.
>
> Make them local to the 'add()' function to make it clearer where they
> are used.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -27,8 +27,6 @@ struct add_opts {
>         int keep_locked;
> -       const char *new_branch;
> -       int force_new_branch;
>  };
> @@ -395,33 +394,32 @@ static int add(int ac, const char **av, const char *prefix)
> -       if (ac < 2 && !opts.new_branch && !opts.detach) {
> +       if (ac < 2 && !new_branch && !opts.detach) {
>                 int n;
>                 const char *s = worktree_basename(path, &n);
> -               opts.new_branch = xstrndup(s, n);
> +               new_branch = xstrndup(s, n);

Sorry for not noticing this earlier, but when 'new_branch' was part of
'opts', this leaked xstrndup'd string was covered by the UNLEAK(opts)
at the end of the function. However, now that 'new_branch' is a
standalone variable, it needs its own UNLEAK().
