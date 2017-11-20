Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8948420A40
	for <e@80x24.org>; Mon, 20 Nov 2017 17:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbdKTRR7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 12:17:59 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:45787 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbdKTRR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 12:17:58 -0500
Received: by mail-io0-f178.google.com with SMTP id z74so16480289iof.12
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 09:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LAXSX+u8e1DyWZpxAOlGhEmE4ENT47S4Gjn5m220UJs=;
        b=qYoW3/mbhSKyaxmJCNgowCfrkSkLK6fhGkGzLysszInikGplaZiqyb/hwS9qVwgPUg
         vlrQQsxxUVnX2ppgaAiwJQJxNS5UyslsqqVeviMOzsYmKXIrnaXuFTWH8THVe4t1AHKK
         EJUsVW6kr/c9jmghJ2FHnpXeoV3qiA3NMUzYr8QFPDj01DrjvtqhGDjJWSHGeqjEyn5H
         2+1IyWDvMRVMT1m1YAam3Cfiwqi+MtEDP/pIuAqL1iM9rrO/mdm4w1bbqPP2nlk3XJKt
         /QnifoPR0/GW60/xbRTZ/fHaSUGCcaExUyXSP91rEs7U+cM+h7FxR4ulWRUPXs4QYe5+
         3+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LAXSX+u8e1DyWZpxAOlGhEmE4ENT47S4Gjn5m220UJs=;
        b=EIDC09Khcr78zgflFk9OX5d9HZtN7guRSWOzMyDoNP9no+WUlqkZf+coRvTqbfZLD6
         PrHSUVakgWpAs8y87Kpt3OIq7QMfnEDP4QGy0H8z92tPZAlolDJNEVmLTREBSQP5NUIJ
         pH+kW/jOfddm5Gtr8SII/UopZqM/9rimOOKMFkHGWu64XGSeTFD7wAQAQFDJytdDSIV9
         MKhksAhCAQBFqiAyeSmwHI7yWZgW8hFy92xRiPlS2WQToO4OjrgyCXtaifU17s7VSTXc
         bWVlWBsNSRrwSxNjS7xtAV86X0oeRftzh3VUuyivZACfbdHCSrtavURm2NeD33uOc/WP
         5jpA==
X-Gm-Message-State: AJaThX7cyFYftGhXI2zmApchSxv4rcRsl57Rxo12pojOxT1KdQjiKNoR
        baDfNFUbfSdF0/4d3Ky+11hInkosoJqRFbnOwx0SKg==
X-Google-Smtp-Source: AGs4zMb820cCLP6dUJ4sQdfm3nOXUlj7cfWJ0iZdY9m2MtO5SNc3gYuEy9dYozJLNHnCDy+aT6NdRZTdFOwq/RL7QjE=
X-Received: by 10.107.20.21 with SMTP id 21mr15156847iou.116.1511198276079;
 Mon, 20 Nov 2017 09:17:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Mon, 20 Nov 2017 09:17:55 -0800 (PST)
In-Reply-To: <20171120171517.6365-1-chriscool@tuxfamily.org>
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 20 Nov 2017 18:17:55 +0100
Message-ID: <CAP8UFD0uNE+hsY1E4Hqvm9=NHHnBQZSOFFMtEEehnYZ5hq+RKw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Sorry I forgot to mark this as v2.)

On Mon, Nov 20, 2017 at 6:15 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> By default running `make install` in the root directory of the
> project will set TCLTK_PATH to `wish` and then go into the "git-gui"
> and "gitk-git" sub-directories to build and install these 2
> sub-projects.
