Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C19E81F404
	for <e@80x24.org>; Mon, 12 Mar 2018 23:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeCLXIw (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 19:08:52 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:46240 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeCLXIv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 19:08:51 -0400
Received: by mail-wr0-f182.google.com with SMTP id m12so17393014wrm.13
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SEHAi4k13Emf6RK9o7e6BkdSg7MAkbgky+mpr7drzgY=;
        b=S5BpNqrzADthK03LD8/XbB8YbjP53xFSV0bAOVsMcHLGXhLS6++3vGUkiwAPEmf08g
         Q1NJC50i9bcvWMBBTb8wmnmD/p5e5HWhrFpudBNvFDyVZGHiDYH/ugWYPlwhFPEWMnc2
         rSO+h6NaS0/cOPKweFSAgQrL74AZY+JNvr1gQzQL5PcUdmnn9T7kcDYst/nWW+AXsVJC
         t2s6p5HZ5G+pxynodS5iIZGGaup9smUAHOMfWl/rLDg8DmtenQ56mG7jyHP9IYX8R5gi
         qjJRcV309BlGCFL0+03KdaCXgqdvMeHRVeLMQMK1H0cEo1uFI71F4FahqOaj6d0wFiJI
         9Lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SEHAi4k13Emf6RK9o7e6BkdSg7MAkbgky+mpr7drzgY=;
        b=B6ahMV5grxJPK8Z984lMIhcSz4gMG7YgEm3aZim1d5kwqdgwLtjubrjfIU7k6TJXMy
         WPh61DPakdeVoXLG15GDBbN0dyL1nve+lgN7Gbe1xqhLBPvdXncAr7fNoWncTSoN0HV/
         fHn0OfdUwlgEE2IdVId/1AM+j6znXViptCKx75PYqfrug/Vh/GwlD99qntq73V8pfcra
         luREeF9ohqGYs0ewatI0dqdG3SpTtOmCNTwCwHk+jXKn1bpBXehp2KBkaO81E7X2ZGrT
         oDMz6sqIHlYvs9yprIRDOIF8yyQb6MqQYQb8ZGIgHLnadt83e6UxZJAjW9u1vV1wh8nZ
         7oJw==
X-Gm-Message-State: AElRT7Fxl743g2yBiTXTsqlNmDDaEwLfqUNFtu9GhIZNTLzgFJKgvoi/
        5vEyffAjOufzMgl77q3HFK62U8NuFeKoGWl8biE/6g==
X-Google-Smtp-Source: AG47ELvENWcH0jMZi6dnW3oWPF1LcwoVuCjp58IXDmoM2iRXAh0f3gwBV1G8Ey1HQb0MBVlULk9gsWX2yV1sSic0W4c=
X-Received: by 10.28.191.90 with SMTP id p87mr6371116wmf.145.1520896130188;
 Mon, 12 Mar 2018 16:08:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.195.200 with HTTP; Mon, 12 Mar 2018 16:08:29 -0700 (PDT)
In-Reply-To: <20180312213521.GB58506@aiede.svl.corp.google.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
 <20180312184734.GA58506@aiede.svl.corp.google.com> <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
 <20180312213521.GB58506@aiede.svl.corp.google.com>
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Mon, 12 Mar 2018 16:08:29 -0700
Message-ID: <CAE1pOi3jbLyZ7zgCO5J_BrQurrxZvm5RH+ZjXTTBf4MMmVOduA@mail.gmail.com>
Subject: Re: Opinions on changing add/add conflict resolution?
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 12, 2018 at 2:35 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Interesting.  I would be tempted to resolve this inconsistency the
> other way: by doing a half-hearted two-way merge (e.g. by picking one
> of the two versions of the colliding file) and marking the path as
> conflicted in the index.  That way it's more similar to edit/edit,
> too.

If work is going to be done in this area, would it be possible to
include making auto-merging (in general) optional? Preferably,
configurable by file (or glob) but I'd already be happy with a global
setting to opt out.

I keep running into bugs caused by Git's automatic merging. (And I
don't see how this could be improved without teaching Git the
specifics of various file types.) It's especially hard when rebasing
large numbers of commits. The bug is introduced early on but I will
not notice anything is wrong until late in the rebase.

(Since I seem to keep asking for things that turn out to already have
been implemented ... if this is already possible please just point me
to the right setting and consider me a happy camper. :-) )
