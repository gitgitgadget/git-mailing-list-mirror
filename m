Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B4B1F424
	for <e@80x24.org>; Wed,  4 Apr 2018 07:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbeDDH5O (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 03:57:14 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41165 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeDDH5N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 03:57:13 -0400
Received: by mail-qt0-f193.google.com with SMTP id d3so18836392qth.8
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 00:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=owyKBmyOdNEKbY5JkPgGH4tEyjTp3AK7/LRvQKpN5S4=;
        b=JHFtaJ4ii59f2UTJbk/CC7uZ+jj0xY5i1Wu0jFVeofZj6qURhVEeXtaoA/AyZCd597
         yMU3fplY0/oOiwurl5DWabQx6UQujsG/FwY5NX2rTbjdtHVEe9trmbTiXMgLhv2B3U9S
         FKirK4/ri0dptUnXLumbfE33DJ9vPEgUEIXUOcoY56ARWS2p21IqMjdiigRXAmyS9kVo
         ds20NU492bM1AOsq3YWxcpPBZL4wIzdSjTmiHgetI2z+N8dHvoLts/xfyi54pO6jgtz+
         FMfICMp0li6mFKE2mIMG/YO9FM8LMN1V4jcqkYIsT2qkIP3ufDpQiLXk89/o/rCVbYV3
         pMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=owyKBmyOdNEKbY5JkPgGH4tEyjTp3AK7/LRvQKpN5S4=;
        b=JkpM3/zLDHlb/uXJFWCDRQX7EooX/Dh8GKn7D04GjJsls0C3DoxtCyNIKPGVdRpMpH
         jIleM9ct9z9sTRUp8BafpRLg3BrBrydUCcMe9lMne/Jfdg/2ls4ie1VaMc7W+8wRrRs7
         T6qzQYsbeaf/qr29p4D9RfysMsfxgvfIh2kfZWAu0XWvXXM8hsWMnckMadYq7/iqy9yJ
         swPc1d2DdSwvSO757sSu/Dmotd1mavI+6KUyJi1iDAFk5EtSSF6vStEMOnPoQ4amxEi4
         YzJfPe0CIC4Pw9mnREHiR3Uo63XADFvm+oNoGOhLQjiR+P3AAn2ln/dnDQ5FW3i608tP
         yp4A==
X-Gm-Message-State: ALQs6tB51N2FAbDtU4bOdImIVASniE3rSwJ1reYg4+xA+rxmkmuZeNHH
        lioCDOMJvp+Hn6br8XgUddqFaRwt3EgjaXHUQ9Q=
X-Google-Smtp-Source: AIpwx4+Ylb1xwHI6TvG2YactKwfryO2FpoEjQqrU2omdUGrJeWyhBP23RZy6XO4XFx/kDpdIPUMLH6Ypo0Sk5D9+ZeE=
X-Received: by 10.200.80.78 with SMTP id h14mr25927509qtm.154.1522828632557;
 Wed, 04 Apr 2018 00:57:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Wed, 4 Apr 2018 00:57:12 -0700 (PDT)
In-Reply-To: <20180404060743.39278-2-me@ttaylorr.com>
References: <20180328234719.595-1-me@ttaylorr.com> <20180404060743.39278-1-me@ttaylorr.com>
 <20180404060743.39278-2-me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Apr 2018 03:57:12 -0400
X-Google-Sender-Auth: IrrCMmn9GWg0HuxwW2mvieAi7Qo
Message-ID: <CAPig+cRNSYz_guBS9yNEXdAbfG+FWtvnzwsWRu0DRe0N_VkiOQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] builtin/config.c: treat type specifiers singularly
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 4, 2018 at 2:07 AM, Taylor Blau <me@ttaylorr.com> wrote:
> [...]
> In fact, `git config` will not accept multiple type specifiers at a
> time, as indicated by:
>
>   $ git config --int --bool some.section
>   error: only one type at a time.
>
> This patch uses `OPT_SET_INT` to prefer the _last_ mentioned type
> specifier, so that the above command would instead be valid, and a
> synonym of:
>
>   $ git config --bool some.section
>
> This change is motivated by two urges: (1) it does not make sense to
> represent a singular type specifier internally as a bitset, only to
> complain when there are multiple bits in the set. `OPT_SET_INT` is more
> well-suited to this task than `OPT_BIT` is. (2) a future patch will
> introduce `--type=<type>`, and we would like not to complain in the
> following situation:
>
>   $ git config --int --type=int

I can understand "last wins" for related options such as "--verbose
--quiet" or "--verbose=1 --verbose=2", but I have a lot of trouble
buying the "last wins" argument in this context where there is no
semantic relationship between, say, --bool and --expiry-date.
Specifying conflicting options together is likely to be unintentional,
thus reporting it as an error seems sensible, so I'm not convinced
that patch's removal of that error is a good idea.

I understand that you're doing this to avoid complaining about "--int
--type=int", but exactly how that case is supported should be an
implementation detail; it doesn't need to bleed into the UI as an
unnecessary and not-well-justified loosening of an age-old
restriction. There are other ways to support "--int --type=int"
without "last wins". Also, do we really need to support "--int
--type=int"? Is that an expected use-case?
