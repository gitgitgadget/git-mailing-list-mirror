Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9E420357
	for <e@80x24.org>; Fri, 14 Jul 2017 15:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbdGNPbf (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 11:31:35 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:34846 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754076AbdGNPbe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 11:31:34 -0400
Received: by mail-ua0-f176.google.com with SMTP id j53so53876055uaa.2
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BinITEI+4QrgIjWFWKcm6RQcXvtHRsJhsD9mKzvQc2o=;
        b=SBxwNXr8BOw/pcySkdWTOEwMEbvkhCNROa/VrrQNsHoAErkk2qJosGKz/KrD5gfk1h
         f2DLLqtB1E+bWfzB7TanO4YVnVu1klWRSPTwpSB3ABE4Abv9UAidVTwFzkYuJxD2J90x
         aGzWFVdSMN3wOgwaXDDgrHPg+DY9vWwEgSbaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BinITEI+4QrgIjWFWKcm6RQcXvtHRsJhsD9mKzvQc2o=;
        b=NwpO0NDA62f8Fh+9JvDaOMDD1Fd920sZCkOUmgH4gSbyXEJ4ojp3d3TvfRO+uxqlct
         bGgMZCR9Cv7Ri0e2X2pyJqmxWnzyElnR6i7DDAUQg47SYc/NpvQZCiKrDMdRzW2rLxGT
         IEQQcnlaaUO8QWuECfr+1bUyGy1zc95pcrV/FSf4auQGKWo8PTiBrCxHu/ALIOKtixYF
         kE7X6WMTz01oE4Tcj33AqZglkhhc0qq8Zl5eob+95ycX5EcXisHUFPDLRdlTaDvzcyRW
         ZT+zfqoYMzX5rh/Ox2dRNeJhSHvH7IM28DNjUTWOlz3WD9f/gDLuGX1IlzFW/ntoUASQ
         +bog==
X-Gm-Message-State: AIVw113WXP+V3mIv/18sItTOAmh1T+QGDTuDBvy2v1R8diuNUzFKAwFV
        T4xox9m+VOQhj8fBHZjdWZkl7AMISTlM
X-Received: by 10.176.27.81 with SMTP id n17mr6005122uai.58.1500046293319;
 Fri, 14 Jul 2017 08:31:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.137.4 with HTTP; Fri, 14 Jul 2017 08:31:12 -0700 (PDT)
In-Reply-To: <CAD0k6qRdq7n=LM7TFJYKvC4uiMMCus8kff-Lm28GiC_G-Feb2Q@mail.gmail.com>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net> <CAJo=hJts=wY4vBaLsOtoH8+LBFK_drBhHMxPvKoQcqtpOfJOog@mail.gmail.com>
 <CAD0k6qRdq7n=LM7TFJYKvC4uiMMCus8kff-Lm28GiC_G-Feb2Q@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Fri, 14 Jul 2017 08:31:12 -0700
Message-ID: <CAJo=hJupQAgYsJfeDhtVDtqoA30OpGiuR5o=ZnuRK3CaGo+ZeQ@mail.gmail.com>
Subject: Re: reftable: new ref storage format
To:     Dave Borowitz <dborowitz@google.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 7:27 AM, Dave Borowitz <dborowitz@google.com> wrote:
> On Thu, Jul 13, 2017 at 8:11 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> In another (Gerrit Code Review), we disable reflogs for
>> the insane refs/changes/ namespace, as nearly every reference is
>> created once, and never modified.
>
> Apologies for the tangent, but this is not true in the most recent
> Gerrit implementation. We update refs/changes/CD/ABCD/1 and
> refs/changes/CD/ABCD/meta in a single BatchRefUpdate, and we set a
> reflog message on the BatchRefUpdate instance, which updates the
> reflog for all refs in the batch. The reflog message on /meta is
> important, and arguably it's useful to be able to correlate that with
> the reflog on /1.
>
> If you think storing reflogs on patch set refs is going to be a
> problem wrt on-disk storage, we should discuss this offline :)

Reflog storage is a problem for Gerrit. It was a problem in early 2009
when servers had a lot less changes. Its going to be even more of a
problem now. Sounds like we have to support reflogs in reftable, or
something like it.
