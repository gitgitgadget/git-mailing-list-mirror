Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7852027C
	for <e@80x24.org>; Sun, 16 Jul 2017 21:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbdGPVOO (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 17:14:14 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34993 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbdGPVON (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 17:14:13 -0400
Received: by mail-qk0-f178.google.com with SMTP id p73so44633226qka.2
        for <git@vger.kernel.org>; Sun, 16 Jul 2017 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fgblBORsRtdRSX0vbtXa3cxktiiJz2DDTh25lY1TVOo=;
        b=SBAgk/yKVvNineAcZKdp50kn8osM1r/gV+zFCAKLj0HArgSMKwnTDxOYadHy40xkeH
         vXf72qRZEF6urqGXiiFoi/osBVDblLmgfQfQUKxroFHs8ldTbDQLEZdrpEgqFz6LrV9P
         tRwy/GiEMHUaA6kRd4Djq5I2cEBIUeKrTgSvXsv4lKbhUkB72nvzZQyQnkE/jeVCZISp
         +gOFkyuJpUEPYR0P2ViE1UcMe6vC4u5Fbn7cxDDKynfZCUoiCTRldmUEtA+2TQqNzBKo
         upUpMi9otWRyKVHWl7kTZFv0qWon+LGGiWERjoixkdeZM3bLxOwqJpAt62ZEEG0hWyoX
         l+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fgblBORsRtdRSX0vbtXa3cxktiiJz2DDTh25lY1TVOo=;
        b=gSjre4Q2nUJHpQtYwxjPy2Dr2YM+EgdXLo7xyMsTPCczonb4rm1c5viEL6593HaRUW
         bkQWrxBDJsNx8uJju639re6TyHLVjjU/tT+0a8sjuAKJ3/LdpVXbd3S743L44mSx1O64
         JZNSSbHBkExCox2JbLePWbu3IRNdtmA9O8wPHpDNPFLapZs0D6TeCKZ28jSnm4djqoOu
         bM5yuuNm3ZvnbRuil2BmRmjmnWUq2wUlffq2VePH/dDsar/bG5z/UVZe3ErHgoA6W0+m
         lfUxMCsWFTToudYzxJVAbjeNLUhmicNhFVhixK5z1TYrI3mB2n7OGHSyZ21p6/kgTQiP
         io+g==
X-Gm-Message-State: AIVw112YgreA2uSSavru3IGpd1UAyK0kMKHsvW4GR+4xlDOL5BUBmMZK
        /Igiq4/V37DQkB6raBU1iZZCnrCfrt8Zm68=
X-Received: by 10.55.167.211 with SMTP id q202mr25268739qke.77.1500239652323;
 Sun, 16 Jul 2017 14:14:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.31.54 with HTTP; Sun, 16 Jul 2017 14:13:51 -0700 (PDT)
In-Reply-To: <CAJo=hJv36tYuxHuso7NrPkfE9hApGfn=iP8g_8+MeM8L91h09g@mail.gmail.com>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <CAMy9T_GsgDewHhe1heH7t2qPZuE3XQOKzoxc50-fLmOqm=6ZzQ@mail.gmail.com> <CAJo=hJv36tYuxHuso7NrPkfE9hApGfn=iP8g_8+MeM8L91h09g@mail.gmail.com>
From:   Dave Borowitz <dborowitz@google.com>
Date:   Sun, 16 Jul 2017 17:13:51 -0400
Message-ID: <CAD0k6qSpNTWkn-97nQQ1DJrh=sd3dppTXytfbafqj-eVsWDTFg@mail.gmail.com>
Subject: Re: reftable: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2017 at 3:43 PM, Shawn Pearce <spearce@spearce.org> wrote:
> True... but... in my "android" example repository we have 866,456 live
> refs. A block size of 64k needs only 443 blocks, and a 12k index, to
> get the file to compress to 28M (vs. 62M packed-refs).
>
> Index records are averaging 28 bytes per block. That gives us room for
> about 1955 blocks, or 4,574,700 refs before the index block exceeds
> 64k.

That's only a 5x increase over the current number of refs in this
android repo. I would not be so sure this repo doesn't grow another 5x
in the next few years. Especially as the other optimizations for
working with large repos start to be applied, so it won't be
prohibitively painful to work with such a repo.

Are we ok with increasing the block size when this eventually happens?
(At least I think that's what we would have to do, I haven't been
following closely the discussion on scaling limits.)
