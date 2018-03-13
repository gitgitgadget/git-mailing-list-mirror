Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A06F1FAE2
	for <e@80x24.org>; Tue, 13 Mar 2018 09:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeCMJHS (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 05:07:18 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:38960 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbeCMJHR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 05:07:17 -0400
Received: by mail-wr0-f171.google.com with SMTP id k3so893141wrg.6
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=BLyhFVEJ5V3b1PsC5NpSCo1ZUmKltqzT7ZGtOwi+tbY=;
        b=Ph+JWOmSMkak/seDO9QNwvs0sJwmBRKfXEbnrT7uxG3btOGrMKWM3Ysm+mNGSd2oWr
         2oI3U6L0QF4977RPwfKYvU06erXgBxFmBYT9cB6NmBDErJcvG4W+pbok613gYez+Xwh4
         otAxE6U9TVpoaW/qXmLxIMvEiib8C7LwTeXRkOgNWldjLCpASR7w9GpEWNwLfL2RqzOT
         tpRiPAtrati6FHZPIOjTH9VOOBc6RdWmIJ6mWnwHJMwNjqvtL2sFNly9EZF9bWdGKuAv
         1P7vxR3CXZ4c3mv4Q9Amn/vmdlCzVNGURmZEXHPLwyugsSPWCTag8bI2FqvyhDWsZhKS
         Kluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=BLyhFVEJ5V3b1PsC5NpSCo1ZUmKltqzT7ZGtOwi+tbY=;
        b=R+jTMLl/RaefKp8eGZpgeSp1mJ+UjMTPVEtccANUHxA9IcfL2K9fb+wg6EkwlH5J8e
         3R8p99XFcgEQborZAGBt1Y31CQptWLJiX27hSOHcCWDrNLVfn33pUGk70AURtvFitKfj
         tXTEqyAOVTXVTFy1FGpyYTMh3GhIu4/L0e3rrL/mmQA2aMgYCxY/HnZUbq/3RMSLUIOz
         fjJeSInZya7zeQl0q4qOlrNAYLIzkDYIo6qLiV2uqthZPG+4T9LhrlwvOatHpED0H/se
         lspI7amJ38Wu0Vah0lLsLN/QC5w6t/cXSaIs5CVN+hiL32Wo2vhX0A/3jS8Ib33822iL
         gRfg==
X-Gm-Message-State: AElRT7FVKrsXkiQ47MhOKomTnLrOY7i+UFj4kOfI+B6Oh4KrqRtHkaI0
        tHyWHkO+XR4vK9cuVnmcGntKUvnZ
X-Google-Smtp-Source: AG47ELu/lqZxfgVtP6kB73YaqvrIyk6srcR1FQMxCqzk2T3zOTrL1BnBv79Xira11w3IdJzghgaAIg==
X-Received: by 10.80.244.4 with SMTP id r4mr90470edm.2.1520932036244;
        Tue, 13 Mar 2018 02:07:16 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id t23sm32724edb.54.2018.03.13.02.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 02:07:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michal Novotny <clime@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: allow "~" to be present in a tag name
References: <CANT8FXTF41-4zvqvrEek262D8OZRhA4nsiPguyNTL9mwF1+mkg@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CANT8FXTF41-4zvqvrEek262D8OZRhA4nsiPguyNTL9mwF1+mkg@mail.gmail.com>
Date:   Tue, 13 Mar 2018 10:07:13 +0100
Message-ID: <873714qr7i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 13 2018, Michal Novotny jotted:

> Hello,
>
> currently, if I try to create a tag that has tilde "~"  in name, an
> error is raised. E.g.
>
> $ git tag rpkg-util-1.4~rc1
> fatal: 'rpkg-util-1.4~rc1' is not a valid tag name.
>
> Now, actually it would be very cool if tilde was allowed in a tag name
> because we would like to use it for tagging pre-releases of (not-only
> rpm) packages.
>
> Is there some deep technical reason why tilde cannot be present in a
> tag name? I tried that e.g.

Yes, because a trailing tilde is part of git's rev syntax, see "man
git-rev-parse", or try in any repo:

    git show HEAD
    git show HEAD~2
    git show HEAD^~2

etc.

Although I guess git could learn to disambiguate that form from the tag
you're trying to create.

> git tag rpkg-util-1.4%rc1
>
> but percentage sign does not seem to be particular fitting for
> pre-release marking.
>
> Thank you
> clime
