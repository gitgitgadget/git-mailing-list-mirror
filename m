Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C037C1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 16:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933523AbeARQZ7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 11:25:59 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40860 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932219AbeARQZw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 11:25:52 -0500
Received: by mail-wm0-f66.google.com with SMTP id v123so24149470wmd.5
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 08:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n4Hsvha7LPsk5n8BFfHTOHttMZE8rlpvh85k9498IJk=;
        b=iMPaIv0L8u/tOyNzs2uPP15eK+3sV3xZHmqD/2jjqCwJHig/YYmueFKKAAjtsHZ79a
         8Y9Kpnq4FYram5p2tp5w18dxEMH3xAxhBudX2iWqZt/TiGyKglS0crC3lGzpkNIvgDMZ
         nTbDxF24pUtSYXyas0wvO2X+RFDDPWvADN1/9MwIuAACUKW1b5F+XFFfRRIIkmkqa78h
         PWvZatz4gTy0kAjiDi7rvqWGrrCHrLx6P8TmqhVC7dwqThiF0lnd9CUq/X8aKak6Sm8S
         3bgd4gBs5vW07HR6SZber15TaBtHDdJUe/cTTv/gbLtRTyX5Z6m4k7TF3QlGtsi3um6M
         rmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n4Hsvha7LPsk5n8BFfHTOHttMZE8rlpvh85k9498IJk=;
        b=KLuBUEColwSVC1YjnIU0y8RlNzaqScPQRvbGxc96rHD/wmcAiIwBHGlf/Nfxr1x4z2
         V66tq6UvgySzq5ZZG0ufLQRhkJF/H0tMmV+AC8ls38nHnc+pVNf4bUN9C9OzW/Bv3Bb4
         9zvlTIfSCM/4cE2kCLUSbk8pzb3FAG1GloYNwohmv+Bggs1ugDQBuHY72CeKnNS118Jq
         ZafAUgFWk5OwLkBNxKm1uKdP7kkFlbb9FJNABWuqbDDcsx60sdlM1a5olgZcxxLO8ylM
         koCfLp8akte5W+ui1cGpGSOUuw6DD1QGNZG7kFthOt7YSFzd0PqaFPQ2SF94bvsuf0+2
         XHcA==
X-Gm-Message-State: AKwxytdpqoSiokIRtBef7RPE5N/OeIOjpHunVL0W9ioUoabioxOgnEwf
        xp9D6VhmcRHDI5V5vRmIABb2PKSII/YgtEPUbTmd5w==
X-Google-Smtp-Source: ACJfBot03haeYmZBOVRijcotl2O3lrfX0yyvsFq/oFl7/NqEZUDYlzWi+O/mr9icb4afE7axNyfLpDfoIkyVyW4SwzI=
X-Received: by 10.80.165.21 with SMTP id y21mr9020242edb.148.1516292750792;
 Thu, 18 Jan 2018 08:25:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.212.44 with HTTP; Thu, 18 Jan 2018 08:25:30 -0800 (PST)
In-Reply-To: <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Jan 2018 08:25:30 -0800
Message-ID: <CA+P7+xozcQD2xuys6mh8MsfcYZ_nb2c9yxhDxkc7FTN2SfoofQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to reset the revision
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 7:35 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> This commit implements the commands to label, and to reset to, given
> revisions. The syntax is:
>
>         label <name>
>         reset <name>
>
> As a convenience shortcut, also to improve readability of the generated
> todo list, a third command is introduced: bud. It simply resets to the
> "onto" revision, i.e. the commit onto which we currently rebase.
>

The code looks good, but I'm a little wary of adding bud which
hard-codes a specific label. I suppose it does grant a bit of
readability to the resulting script... ? It doesn't seem that
important compared to use using "reset onto"? At least when
documenting this it should be made clear that the "onto" label is
special.

Thanks,
Jake.
