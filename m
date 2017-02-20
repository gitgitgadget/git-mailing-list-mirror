Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308A2201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 13:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbdBTN5M (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 08:57:12 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36404 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbdBTN5L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 08:57:11 -0500
Received: by mail-vk0-f44.google.com with SMTP id t8so62064328vke.3
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 05:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c/X8YPVbvnBHHOYezxvwuP6bM/PpXSInLYWh9OnxsqA=;
        b=kCdJ6wqAVnLkqZpuGaMMkBBizT7POvzFvQ2ZMkeuo54HX4czPg5nwRBmCi+KnC77jw
         /GmaHlR/+jKYIj8BMTvcfqOpZAkMyFQwISFjGBzea5ldTWtAA873TmueCCVJGBngrGBl
         JAmR+lOXUrQcljYW2/vJW9M1esjr1yguL8as3DpKm9rtvQebtdu3WEcVvqeMBU758l5D
         kRhCog9DOuxh60V2D0llojHeJwU7DyzFvD9NG8HHKPhEYsdg/1YjPQIcngxVXgB4V3Gq
         kzSszuI6thkC/CnaQpEfgjb8RO3rSPf//uUnCvrMM9lOVH0EkPNRbhYuvq8JoMUmg3WT
         X9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c/X8YPVbvnBHHOYezxvwuP6bM/PpXSInLYWh9OnxsqA=;
        b=mRmldukXjtU6uNBeZfUZVBCIkXcu71/zvxYPHtb3FMBAUBXdgnYUJnV6JXoPVBDXIT
         CuVnzTZygm5vYwUzdxW7F/a2Gvbldcv/Z1kNTl7foQZLs216gENCWe2/o4qu5Q80cO1m
         NO5YtGngCaDOWlgUDpu8lNHGadKsDCzo8aNLjYhEhrGZ9XN4WcX2vrRBli5yZWbiIp4k
         FHJcq6wwg+/X3E3U1L7rv3+nIa2dGrHSNXwgRga99y8BI9xH0znnndsM8JDA8woIK+3X
         UipMfb8VmkZeG8yIptLbS0t7XI+ESOoctktDsjDpf8r7pt7Kby0nbQK1BcaQV3pnxmUd
         Ip0Q==
X-Gm-Message-State: AMke39nko/w1yQtQLnFiuysT4kyfWp/CFC1Sr6C9dq8zl74ZKuR1k497n3YVsGMo2iPPLjxh1HK3D/yDYnuOgg==
X-Received: by 10.31.161.137 with SMTP id k131mr10770098vke.12.1487598610321;
 Mon, 20 Feb 2017 05:50:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.31.242.11 with HTTP; Mon, 20 Feb 2017 05:50:09 -0800 (PST)
In-Reply-To: <58d25138-de2e-6995-444f-79c3ac0bbad2@gmail.com>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org> <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
 <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com>
 <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com>
 <d7bb866d-4a50-f75e-ff4c-bcdd54f75459@kdbg.org> <CAMX8fZWRgeK5XjSrFYzZea8YgT9Mqm0XJBxQGt1eqdWZU+DEnA@mail.gmail.com>
 <CA+P7+xrch9WDo6OgU3vUEpXqAETZ07mkf76dC9nJctm0LTFQHQ@mail.gmail.com>
 <CABEd3j8sgDd8DXW8+2Q7pjANPTr-Ws1Xs1ap875mkxFOfnenYw@mail.gmail.com> <58d25138-de2e-6995-444f-79c3ac0bbad2@gmail.com>
From:   Oleg Taranenko <olegtaranenko@gmail.com>
Date:   Mon, 20 Feb 2017 14:50:09 +0100
Message-ID: <CABEd3j8m5D=bBbUD+uzvE9c8AwdBEM79Np7Pnin-RLL=Hjq06A@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>, Alex Hoffman <spec@gal.ro>,
        Johannes Sixt <j6t@kdbg.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Anyway, I don't think it is feasible to weaken the assumption that there
> is only one transition from 'old' ('good') to 'new' ('bad'); this is
> what allows O(log(N)) operations.  See bisection method of root finding,
> that is finding zeros of a continuous function.

I don't intended to change default behaviour of git bisect, I can
estimate what drawback it could bring.
I'd rather implement something like

git bisect start --bisect-strategy=missing-feature

by default current state is being used.

git config value would be also useful.

Oleg
