Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E162F1F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 07:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeCTH0v (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 03:26:51 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:46297 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbeCTH0u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 03:26:50 -0400
Received: by mail-qt0-f169.google.com with SMTP id h4so573378qtn.13
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 00:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1gV9x9LWbmD/4cQAM+8dAQsJZmA7kGifRKfWS6AGd08=;
        b=NvMACUI7UC7a/RvGLL45HYR6KHznAszZFZM8ty5CWqoyB9WysTsD+P5acY4aEEO73Q
         bzL2hxD/oQN8R9PNUrYqO49GX9a/KptGt5J83HXueMNTtxvIbfjVgtEoIf+pKwshCB+T
         s4SrrfSY5e8hlPtFcdXbwo+5t3b2cbDTxRhdEf4EyESVitsxk7AQzofY2jR7k52aY8eC
         GppB2Mwyv8Bo5YVAV/Vt+gcJu3HTo3Yl3g6Rfy7SL4cdpngOKAf7gER7iVBpM3+wQ1hM
         +iKAvVSAlHGF0ZO5TThmgcfAZQb9g9wuJj5k1dy7UqHk4aji60gwaM0v38yWKN0mzzXG
         hdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1gV9x9LWbmD/4cQAM+8dAQsJZmA7kGifRKfWS6AGd08=;
        b=Hgp6o+tWiQ3CxIUlCpt3c0fs6BU34DW7bvAMxC/LugiIn4U8moXHx3+SlqMpRy1rqw
         hdVdfpq8R8S4ejwYJKRxemEVb4KQfvHSsZtegDJFE2GaGPdGfyvAWKP2ba9ThSeWJQA6
         Dwrah4rDbRm5+Yzp7J/VKbQCvaVml6qORq/2WdCHROuW2xjPBapKXG4BnEfAXyC2PkJd
         FZ/FqUuTJt0RxMvcq0IxiAh421kmbI5bo9uqAuU/ONeU9/dUYKmns4q/6iS5iGP5wGwv
         WLcdf6wM9PIjJQf0WnievGEOguVcyxbPItOhKQW35iQOndA6dIXpRJ9bq7/FAUY6vsDU
         rU9Q==
X-Gm-Message-State: AElRT7G+uB9g/zRmhbl03qnAjDgaj6F8UH80xXk+oO+f0+txZkJhCJLD
        tfTxNxCfNL0Vnp313TWmBaUd1JoO0P442BYoCFA=
X-Google-Smtp-Source: AG47ELullawV2ph2lhw2UEtuV1gRv57FNe1Trp35SQq0nTg5RSNl5n/w5nNETbAQQLTl7HJqp1tXlckR7Ybl/aIkH5k=
X-Received: by 10.200.1.2 with SMTP id e2mr17580431qtg.121.1521530809885; Tue,
 20 Mar 2018 00:26:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Tue, 20 Mar 2018 00:26:49 -0700 (PDT)
In-Reply-To: <20180317222219.4940-3-t.gummerer@gmail.com>
References: <20180317220830.30963-1-t.gummerer@gmail.com> <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180317222219.4940-3-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Mar 2018 03:26:49 -0400
X-Google-Sender-Auth: nl3RcHfR71xbSPFMWhWbASk__Fo
Message-ID: <CAPig+cSsqqn+Wg6DEJRSge9mYqb1_jPXy5ORryrdA6+Omxne1A@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] worktree: be clearer when "add" dwim-ery kicks in
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 6:22 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Currently there is no indication in the "git worktree add" output that
> a new branch was created.  This would be especially useful information
> in the case where the dwim of "git worktree add <path>" kicks in, as the
> user didn't explicitly ask for a new branch, but we create one from
> them.
>
> Print some additional output showing that a branch was created and the
> branch name to help the user.
> [...]
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -318,6 +318,9 @@ static int add_worktree(const char *path, const char *refname,
> +       if (opts->new_branch)
> +               fprintf(stderr, _("creating new branch '%s'"), opts->new_branch);
> +
>         fprintf(stderr, _("worktree HEAD is now at %s"),
>                 find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));

The "creating" message is missing a newline, which results in rather
ugly output:

    creating new branch 'foo'worktree HEAD is now at ...
