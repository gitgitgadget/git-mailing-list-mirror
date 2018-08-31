Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189731F404
	for <e@80x24.org>; Fri, 31 Aug 2018 09:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeHaNOg (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 09:14:36 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:53733 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbeHaNOf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 09:14:35 -0400
Received: by mail-it0-f43.google.com with SMTP id p79-v6so6259069itp.3
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 02:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BmMMLxgN7MNje+ss3T2IvwtGm6WVgPll2swO8lx0Y3o=;
        b=gs0Fa8rLwFVSb+lVkeMuz3vHlv+d5gLKOvybyx8QlDK3bNbp9/N/LhQQ0ro/p6KDmv
         x6/BsuUuGpTiEuNABkUmTXm0Eh7449CO70i0vRvLrF48DV2B5q4EG9/r0nIi9YivQa1A
         lsCLXPe3Rzztut6Sbs58cD2IG7MC9QHxH1p7HMSTQnf56qBwMi61GzxMFLJecAm936+k
         gnS09xiewgOwWPgozmrMS2RYVm4o4+NL06G15x9ZYNpIZECWwx0dtlEPl84nMveQfSH/
         LSIazY/O3ZdNhQsu7UOkyD7lJh7h8DF9010GQ/59G9Tel9Dj2fkwhDWwJ6FOXtcUug1x
         tPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BmMMLxgN7MNje+ss3T2IvwtGm6WVgPll2swO8lx0Y3o=;
        b=VJFAq7CwS68SpbYwYIpaODOnQ87IE+QxL9n1T8/FrETt9uUNaaGecGIk8eAtjDPJjX
         RBx/NjheO1CCBvFx89zD+Bhn2Kwez5FI8iNz/ucMa4D0/UaLWc+WVKHBZN14aGaMTq73
         F/wimDv4HrHfxHqgJLZxvxwkz/GH3wc5YzwZkS5jrp+0S0WNVEPbXYfzoHfqWKPUDGIV
         7yhmooquJjGKspnp2wc5LgHKlZyoVtTkS5TFR2vSG9KXOaYdIaKyGB698FdXfDb4qNi2
         usTILS9je8TtoYAHrev6pu46LJtmLfd6Yl/EHio7idt67LmKU//PTxznUcIRGycuVwlh
         BRRw==
X-Gm-Message-State: APzg51CynJPVjgX7ky2Ou5vFyWhxBqoSS3T8WVRw0phXrVy2InYRn3fE
        2eMdMTDBeF8RiwRu8jCc1r0UXO54eSpIlMxpw0E=
X-Google-Smtp-Source: ANB0VdY656Orroh+Lab05bXpFo2SpgAtrZAzDoNb/EmgeGrsTcywBn+8S0fsYsh01rbc/1fcYYmgu3NFZlBEU3DcQWo=
X-Received: by 2002:a02:5651:: with SMTP id o78-v6mr12198158jab.8.1535706484736;
 Fri, 31 Aug 2018 02:08:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 02:08:04
 -0700 (PDT)
In-Reply-To: <CAGZ79kbN7CGiQFoCF-3zkJH3h0kxbfM4xigpYc7XNuF-1bcONg@mail.gmail.com>
References: <CAJmvCd1BwPNgZM+g7c6An-EESMHDOSGQe7RjkAAz36eNY3fvGA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1808301324120.71@tvgsbejvaqbjf.bet> <CAGZ79kbN7CGiQFoCF-3zkJH3h0kxbfM4xigpYc7XNuF-1bcONg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 31 Aug 2018 11:08:04 +0200
Message-ID: <CAP8UFD028pgFaZ=D0rggn4o7dBnTh=4M_o2j2v926o0_Awbmsw@mail.gmail.com>
Subject: Re: improved diff tool
To:     Stefan Beller <sbeller@google.com>, pierstitus@gmail.com
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 7:22 PM, Stefan Beller <sbeller@google.com> wrote:
>
> AFAICT this is more than just a coloring scheme as it both produces
> a different low level diff, which would need code in the xdiff parts
> as well as colors, that is in diff.c.

About the low level diff, Michael Haggerty's tools for experimenting
with diff "slider" heuristics might also help:

https://github.com/mhagger/diff-slider-tools
