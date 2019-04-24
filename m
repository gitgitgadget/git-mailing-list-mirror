Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B6B11F453
	for <e@80x24.org>; Wed, 24 Apr 2019 18:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387659AbfDXSPJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 14:15:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38116 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733310AbfDXSPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 14:15:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so6372850wmc.3
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jUYGaAUNdNOjLAiQJoi0xrp5m/3u/0TWEXB/6xfzU5s=;
        b=FS6YtRiCWMtO3jyyUoBXiB/OUfV9F7F4CbbH9oJmAO1mq6w7mSCxVEWRayXvEOyytN
         6KZw+RjLokcIMB1WEQL758EEas+5S5WBMpvHQGttxG6Zp8e62XDYqzE3q4wfmO62Tmhe
         lI1cszMt8L9rGhMrG3s9HEpNOGO0iy+xw9OlwAJWs7K8uzMOak0oSHFGrp9SjmnjXXSQ
         uhdHLVVpTdiIXV+1t8/oKwJGcMiiIYvNcoBrXVHxgwVrU0+ovEftfDPXXZG4wgL/EbHF
         GHsHpSScXYZLxDbqNTEFk7pcQIwbPyDZdRKWRFtMIPP3vvEq0xjozjH/MbZJZBDP044D
         +iPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jUYGaAUNdNOjLAiQJoi0xrp5m/3u/0TWEXB/6xfzU5s=;
        b=WyPHbmoQFCBamE2TzPL3H2D/opOluiOL0KOp9PnLM8i1aD6dyjV1dBEOhgcBWgt0JB
         PvJWQzZAaOgJEU5/5R6VoA9IA0/IrvC7U3xfQVsMlMypgaAx6wJDBWcoN68B0FYOaJwA
         rjnL8iv3+FtSRdq6YonO4ZmCApd59wua8csvrlRjWYYXMIv7gHjnavAZPsn8gQDVCYhp
         +EE0pODn4A0lj6MIzIt0ETGhzMOawobg1VVLEkFMS7GjkbEEtBmmDPri83kVgDtf2+y2
         31y8K/hJUxzJHhCn1X3iCLBgDKDBK1FG6g9seHSLXBOPaR6m5C5dl3DuDEq1QfYgn0Mj
         ujXg==
X-Gm-Message-State: APjAAAWEAWYm0gmXOlhUKjE9GEHeHcl8T9rYiGj6krVmczrBrSx0GQ15
        qzWz7pfDS8OhocIurRb0rbA=
X-Google-Smtp-Source: APXvYqx9S4oYI9Wo0KvAdRm7J3Bn68sBJUJO3Ex6gaIQ2nbkOLdxyXDf9o47z95WDGOWkwPLxyJOtg==
X-Received: by 2002:a1c:7a14:: with SMTP id v20mr295228wmc.152.1556129707128;
        Wed, 24 Apr 2019 11:15:07 -0700 (PDT)
Received: from localhost ([2.25.81.3])
        by smtp.gmail.com with ESMTPSA id g185sm6162811wmf.30.2019.04.24.11.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 11:15:05 -0700 (PDT)
Date:   Wed, 24 Apr 2019 19:15:04 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/4] range-diff: don't remove funcname from inner diff
Message-ID: <20190424181504.GA2068@hank.intra.tgummerer.com>
References: <20190411220532.GG32487@hank.intra.tgummerer.com>
 <20190414210933.20875-1-t.gummerer@gmail.com>
 <20190414210933.20875-3-t.gummerer@gmail.com>
 <CAPig+cSmh1rCTPj0Y=G4OA3TmoGqVBnj95S+KogOgiDtW_0DiQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1904151454010.44@tvgsbejvaqbjf.bet>
 <20190415185627.GB1704@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1904171350310.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904171350310.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/17, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Mon, 15 Apr 2019, Thomas Gummerer wrote:
> > I like declaring this a bug.  We are after all parsing
> > machine-generated output, that does come from git (which is why I
> > neglected the NULL checking in the first place).  If that second "@@"
> > is not there it's definitely a bug somewhere in the diff machinery,
> > I'd say.
> 
> Ah, but you do know about the micro-project I proposed to optionally feed
> an mbox to `range-diff`, right?
> 
> The idea behind my proposal is that this would make it possible to
> generate a range-diff between the patches on public-inbox and the commits
> that actually made it into Junio's `pu`...

I had forgotten about that, and was only looking at what the code
currently does.

> > Note that the "@@" also couldn't come from anywhere else, the diff
> > header has a well defined format and so does the metadata.  The diff
> > itself is prefixed with '<', '>' and '#' in this case, and the commit
> > message is also prefixed with four spaces.  So if this breaks
> > somewhere I'd rather hear about it loudly, than let users potentially
> > get wrong output because we missed something somewhere.
> 
> Agreed. But I could imagine that `die()`ing here would be the more
> appropriate way to holler loudly ;-)

Yup, in the light of the potential microproject, I'm fine with just
'die()'ing here.  If we'd get into this situation right now, there
would probably be a bunch of other tests failing as well, so we might
as well make it a little more future proof.  Thanks.
