Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 181E91F462
	for <e@80x24.org>; Wed,  5 Jun 2019 12:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfFEMWj (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 08:22:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39000 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfFEMWi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 08:22:38 -0400
Received: by mail-io1-f68.google.com with SMTP id r185so20020063iod.6
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 05:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUSCinmgKSTRVeGoYKAoo07pqKuv8f+Wl76nWpJ31ho=;
        b=UZZ6yrLqIaMnSpt7kMiZbSmvZbe47PQYGvOEomYhQVSC6hISH+9sgWh7W22qx6oxRE
         3rsCqc/j6yPQt1tjactpFxeyblUw8AQpbNM1UFCfasjZ4Rd7iXpQFst4DbHSQP7TpXCl
         g0OGs8gcc43Zkk3/OyVIa/gE8tqd5WUm0j1Txkx+Xg/O5a4worPeqz6eUc2ysvXmx29K
         Akh2RuLiZlkZv4szfdbsHpNYcLiTEgIkDY6OsFgC2aROLZKKnVhIIlRmHvg85yJsyK7T
         TPkdBX+A5BFDLfkRWMV59rkBK6BPQffGfCgVvUFydNalGVILb0ywmhwxfG2/DC8FAAYt
         zWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUSCinmgKSTRVeGoYKAoo07pqKuv8f+Wl76nWpJ31ho=;
        b=CbbW3boprvY2zBIJ8gyLiiQ1MLnuykkueJFw9UTQpC2dmpOdmF+WxHnlOp9Oj+YRTC
         +IhY4hw8ClsPom4jWq1rx3gUxNow66/nFEXablmxOaxMpIBSm1R/cHleCYl2BU3H+5+G
         eW4PZGisQCEWicRTQaC5/qvE/smji0d9jsdfDykGTvEThaiPhI6PKOHv0bp+4igTGOPS
         lUOcAPDZLnRJJXTtVCSCTOLgkNRxHsj1jfAntIVNPCHd6AVEwh6a2KYlAYQz0FulcfFc
         858OWXfHJ/h4Xrt3UwJdSn+Y4ifxdGZxyjri56RFy1u6UNT0mcafKSzp5JNsg29rDwMz
         TWIg==
X-Gm-Message-State: APjAAAXQpLWBZQkRfDXHxu+Y/R7hxeRQbf4xd98DskfCdzapKkNB1sDn
        d6Qnu6jTxHJja+5WWLblOP0dAVdt9Ivq6qALW4k=
X-Google-Smtp-Source: APXvYqzH1eoViTj1FEoKzr2PshYMogYXMEWVFuOOAHyQVvLn1GoneeguRpvtiFezkaqrP+iQjQbuVwyiQrA3QMHfkkk=
X-Received: by 2002:a6b:fa04:: with SMTP id p4mr6321233ioh.273.1559737357872;
 Wed, 05 Jun 2019 05:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190604021330.16130-1-felipe.contreras@gmail.com>
 <nycvar.QRO.7.76.6.1906051005060.1775@tvgsbejvaqbjf.bet> <20190605112713.GA14027@sigill.intra.peff.net>
In-Reply-To: <20190605112713.GA14027@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Jun 2019 19:22:11 +0700
Message-ID: <CACsJy8DKWoerME5BykVmihyX2eX10YTO0BNyVc7MGjwp_Shg2Q@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/5] Fix fetch regression with transport helpers
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 5, 2019 at 6:27 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jun 05, 2019 at 10:12:12AM +0200, Johannes Schindelin wrote:
>
> > This fails on macOS, in t5601, both in our osx-clang and osx-gcc jobs, as
> > well as in the StaticAnalysis job. For details, see
> > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=10206
>
> Hmm. I'm having a hard time seeing why (and I can't seem to reproduce it
> locally on a case-insensitive HFS+ filesystem under Linux).
>
> In particular, if the problem is here:
>
> > expecting success:
> >       grep X icasefs/warning &&
> >       grep x icasefs/warning &&
> >       test_i18ngrep "the following paths have collided" icasefs/warning
> >
> > ++ grep X icasefs/warning
> > error: last command exited with $?=1
> > not ok 99 - colliding file detection
>
> then that implies it has to do with the checkout phase, which Felipe's
> patch doesn't touch. Later in the log we see the actual file contents
> (I'm confused as to how this gets here; it looks like debugging bits
> that were added after the main script?):
>
>   2019-06-05T07:58:37.7961890Z Cloning into 'bogus'...
>   2019-06-05T07:58:37.7962430Z done.
>   2019-06-05T07:58:37.7963360Z warning: the following paths have collided (e.g. case-sensitive paths
>   2019-06-05T07:58:37.7964300Z on a case-insensitive filesystem) and only one from the same
>   2019-06-05T07:58:37.7964880Z colliding group is in the working tree:
>   2019-06-05T07:58:37.7965290Z
>   2019-06-05T07:58:37.7966250Z   'x'
>
> whereas a succeeding test expects us to mention both 'x' and 'X'.
>
> So we _did_ find the collision, but somehow 'X' was not reported.
> Looking at the code, I'm not even sure how that could happen. Given that
> this process does involve looking at stat data, it makes me wonder if

It does use stat data in mark_colliding_entries() if core.checkStat is
false. I think on MacOS it's actually true.

I vaguely recall seeing just one 'x' once. I think last time I had a
problem with truncating st_ino, but that should be fixed in e66ceca94b
(clone: fix colliding file detection on APFS, 2018-11-20). So no idea
how this happens again.

> there could be some raciness involved. But again, I'm scratching my head
> as to how exactly, and I couldn't reproduce it under load or with some
> carefully inserted sleep() calls.
-- 
Duy
