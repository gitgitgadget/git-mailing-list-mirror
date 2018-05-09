Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFEE51F424
	for <e@80x24.org>; Wed,  9 May 2018 23:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965964AbeEIXse (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 19:48:34 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:42110 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966011AbeEIXsT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 19:48:19 -0400
Received: by mail-pf0-f177.google.com with SMTP id p14-v6so138849pfh.9
        for <git@vger.kernel.org>; Wed, 09 May 2018 16:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9dguN/N7ERTgVI1noJj5LCPf74CuzREPYjEIHodwlf0=;
        b=TT1mmaYtFqOmjJTa/oF3P9GVzMRD7ks3Ytqa26rw782D6WYIRT4WkF+2HkX+ByOnDK
         gVCpnmaTatM9RL0eliidrt/j06dIiitNTVeY96BeNQujAMD/BAQjjaarhyFilS03xhXg
         gPI5gmhWGVZJa8Jq8Nrc3ewGHdpwHpoKzw9Aonh8Q/WlXNKWsgI4ubKmkSP0MtQkRdjH
         zdQWm+/j7kYbl1aapyU//uhsXDtiVBtWBrDw+tFAliU2NFNVD6DVM9LHMhBTYc/vFqYW
         SPLCTLUXvbvOTkG+Lf3r9W6qO5dBfJMXAOE2At6xHZp3viL0uEPGiQjpMgvgRlAcXJzc
         aqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dguN/N7ERTgVI1noJj5LCPf74CuzREPYjEIHodwlf0=;
        b=h4e77mfnaYR5nyehGnArDP3DidFViRqNa6Jtno16KXGNDK2m/H6/a6nD0m5qgwclDm
         iJf4HWH52GdyZxypj33/dysl+aGuyqPPFWJNlnJxlgtowJFRQt7Ae/ghB1JoGhEfRVAD
         DkSU8gxkH5FrhecbbyTSqwnhSZmKoV6P9DmRUq4Q95L/N1OJRzc5jsf/ejTemNYZe1iA
         HWGQqtMEh1uBRWYx8LwE/BOlPINVmx/ZTEHOKYBps6CVhMGykl/sT+KXc+5735jN+Crx
         FKkLKFIl24EOtyOwdBPLck80OFdtHQu0RtARQu7tGP+ttZpwWLY3LJU5Ph+e2vZASN+C
         vppw==
X-Gm-Message-State: ALQs6tAsxkY+eLw+6ZelVja3aGmAqEshzLQSp2Jlr7B6dHuaJtBQTs/4
        UPiuOHgQScSYHzdjPBRVfsFP5wYPZSKGCw==
X-Google-Smtp-Source: AB8JxZr0zfq4dG4PUqb6NLvkYQa5R8JiHf3AOmNAG38rqA+B755ip0HhS/ojeYj6OuX5BN5dzANZQQ==
X-Received: by 2002:a63:6197:: with SMTP id v145-v6mr37964887pgb.35.1525909698119;
        Wed, 09 May 2018 16:48:18 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:eccb:c00:cd8f:fd73])
        by smtp.gmail.com with ESMTPSA id c21sm31372746pfb.116.2018.05.09.16.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 May 2018 16:48:16 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 9 May 2018 16:48:15 -0700
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>, phillip.wood@talktalk.net,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 5/7] builtin/grep.c: add '--column' option to
 'git-grep(1)'
Message-ID: <20180509234815.GA68889@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1525831201.git.me@ttaylorr.com>
 <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com>
 <CACsJy8DLthWhxH6a7zwCvdirkuntanHasXZwfdADeo7iV8X79w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DLthWhxH6a7zwCvdirkuntanHasXZwfdADeo7iV8X79w@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 09, 2018 at 06:17:20PM +0200, Duy Nguyen wrote:
> On Wed, May 9, 2018 at 4:13 AM, Taylor Blau <me@ttaylorr.com> wrote:
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 5f32d2ce84..f9f516dfc4 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -829,6 +829,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
> >                             GREP_PATTERN_TYPE_PCRE),
> >                 OPT_GROUP(""),
> >                 OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
> > +               OPT_BOOL(0, "column", &opt.columnnum, N_("show column number of first match")),
>
> Two things to consider:
>
> - do we ever want columnar output in git-grep? Something like "git
> grep --column -l" could make sense (if you don't have very large
> worktree). --column is currently used for column output in git-branch,
> git-tag and git-status, which makes me think maybe we should reserve
> "--column" for that purpose and use another name here, even if we
> don't ever want column output in git-grep, for consistency.

I think that this is a valid concern. I had a similar thought when
adding 'git config --color' (as a new type specifier) that we might be
squatting on '--color' and instead opted for '[--type=<type>]'.

I don't feel that the tradeoff between '--column' as a good name and the
concern that we _might_ want to output in a columnar format in 'git
grep' someday warrants the change.

> - If this is to help git-jump only and rarely manually specified on
> command line, you could add the flag PARSE_OPT_NOCOMPLETE to hide it
> from "git grep --<tab>" completion. You would need to use OPT_BOOL_F()
> instead of OPT_BOOL() in order to add extra flags.

I believe that this option is worth auto-completing. Its primarily
motivated for use within 'git-jump', but I feel as if it would be
useful for other callers, as well.

Thanks,
Taylor
