Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0BE91F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeDQSqv (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:46:51 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:36094 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752570AbeDQSqu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:46:50 -0400
Received: by mail-qt0-f173.google.com with SMTP id q13so4984797qtl.3
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 11:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nO0P9VVZu7wo24D7qvR6tUXOa2SrqOQWdkfZ1Y5B1u8=;
        b=ddpC1VUY0SDJWFe8ByXBmddkGZuSKnYnBmVSTB0OyWGwJCEkE0x06rmYe3IBS+3kva
         kI/cOrP9ebLnbKrpNBVcKPmvAY10bURISptjVckGJOiNkfi2yLwKq0Ejd4DzDz20ZavU
         ykf3yVWrE8/GcDsjE7w7e0iaGfNLsTHrUCapY17xhKEZlsgasw5bXpjmtEoDhAVY16QH
         bzTPOUflQdNo054uiPMCFWpzTmiOgE7FpWKO2m7pI8vEk/jf+j4KUqxIYSuYW5be9QX2
         YyTbNBUaoZiOBzpC2t1RXSRQ4XQ3dCahxG47OedHrSPu76PqQ6IHFQnEKjo/J2sX0h3b
         Ugaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nO0P9VVZu7wo24D7qvR6tUXOa2SrqOQWdkfZ1Y5B1u8=;
        b=B00/QUerHs+SVHQOPokoCrHVpnN4aPKEg/IMjFx5okUH1YV5yn74xpq47FE5sC7LjB
         y9o4m6xr8bEmutlC/X/g8RY5ycmXw0g6iZHxLvCYNDFiAj1LgbtxgDBoToTlQGlxc5Yt
         uHR1pWqcWsQl13JCrI3UOrRc8geNcrPDxdOrbxVTjtdrGWFWk2EVaf5wLmBLAb/lPvqL
         lAVErxuOIoic7PPuZiJJ04YIEilz9MTrQmnlCiACu4/Cn+8cOFMuW2mvUBf4VVLdcbr3
         ko1a2jGFJnov72rSpz4iypEtw3hJwoDhjPxL9O+3VNokgWa5IV9u6p2B5LjqkRbgPgnT
         k9Jg==
X-Gm-Message-State: ALQs6tDSeYYGbeJk4QBnDeiF4p8QlrTax1iKIduz3Pmr+5MxoW3khK54
        kpwzr3k3sPEqlmdskJ92w/QA6Uu7ShfpSsgpQTQ=
X-Google-Smtp-Source: AIpwx4/qjXDsbOlDCqTSiSzDoLt4zPrhG+Ach3UYDaRwbfcs/032OR3EiiVBsuDn855T9vyd/2/IxsFVyLsG+MoqG5Q=
X-Received: by 10.237.38.164 with SMTP id q33mr3478064qtd.165.1523990809752;
 Tue, 17 Apr 2018 11:46:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Tue, 17 Apr 2018 11:46:49 -0700 (PDT)
In-Reply-To: <20180417181939.247898-1-sbeller@google.com>
References: <CAPig+cSHmxtsz2NNAFvbqXRFKE87ZVyUYpRigjgXE5p8LcR09A@mail.gmail.com>
 <20180417181939.247898-1-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Apr 2018 14:46:49 -0400
X-Google-Sender-Auth: SZcCpJS1PUEY-NhaPNprFk5xs9k
Message-ID: <CAPig+cTgoD-GvpoBQ6tcGX4T2XhuKccJAZ40P76vxVD_PfEc9A@mail.gmail.com>
Subject: Re: [PATCH] worktree: accept -f as short for --force for removal
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 2:19 PM, Stefan Beller <sbeller@google.com> wrote:
> The force flag is very common in many commands and is commonly
> abbreviated with '-f', so add that to worktree removal, too by using
> OPT__FORCE instead of a self cooked OPT_BOOL for force.

The missing bit of this sentence:

    ...self cooked OPT_BOOL for force which forgets '-f'.

> While at it, add the PARSE_OPT_NOCOMPLETE flag to the force command line
> option as forcing a removal may lose files.
>
> The short form of "-f" is already documented in the man page,
> so we do not have to adjust the docs.

Makes sense. A possible rewrite (of the entire commit message):

    worktree: remove: recognize -f as short for --force

    Many commands support a --force option, frequently abbreviated as
    -f, however, "git worktree remove"'s hand-rolled OPT_BOOL forgets
    to recognize the short form, despite git-worktree.txt documenting
    -f as supported. Replace OPT_BOOL with OPT__FORCE, which provides
    -f for free, and makes 'remove' consistent with 'add' option
    parsing (which also specifies the PARSE_OPT_NOCOMPLETE flag).

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>

The patch itself looks good. Thanks. With or without the above rewrite
or minor adjustment, this patch is:

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
