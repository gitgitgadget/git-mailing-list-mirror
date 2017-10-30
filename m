Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9CBF202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 06:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbdJ3GSn (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 02:18:43 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:56938 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbdJ3GSm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 02:18:42 -0400
Received: by mail-io0-f181.google.com with SMTP id m81so24634085ioi.13
        for <git@vger.kernel.org>; Sun, 29 Oct 2017 23:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FO1ZkXug7DvZoNerPVjidVk2xhS+ZVuKlRZMPd3y1eE=;
        b=EiVQYmPqhfq+2B6MOcA+RgHHJrN/HxTflNv13tMHTA2PRRdWWVQUY2Sbrckagm0Vj2
         Lo/S4QP9+i1NSoQ366j8xOuScJplgZe8+e0DFhLI76MHfPHdM3uqtaqeVTuFY9bSmQ2c
         zkIlnMC12GvPYgy1cqphhllciuWwFQAbaI2SUsuif94rc9bd4XEtWlkWY40EMAPQthuu
         EQRFbwrSS38elB0LTT/pg/aeDX75F3DDidBEyisNgC8dDhR6+5h8HJMgAnyMbu7WgGL6
         d2RjRxK/IwgbXuj2vu+SP71vtaROI1plUJRBlkM0xjC+tzhbPrW0BiHrAuhbPuOsQ789
         PGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FO1ZkXug7DvZoNerPVjidVk2xhS+ZVuKlRZMPd3y1eE=;
        b=MwhVbr+FsZNNCsVo2wXP/kPk3Yk8L9rNbCs9l/zRBiUzh5LggxpSf+k0ekJlt8awV+
         wdYthfE5GKB6wwEp+s8NLlRDdJIFfLLzVUjmi5rS7P1ZAcyWehl6S73DgMLLv9nVxErR
         dqK7mcPPQ8YM2BXCvjjx0Y0/eeOpRq+u2pnVrBoq+/DNFqLGMZ3TnUX/NRrbfWyQ9iLo
         C2ayn/8JGzm1+n8ovS84fFJgpa3yxzK6VTICHYp/iVAaGe3s5uKUDkXBmYEuWlIlmKQ/
         wphK1LgXtyJR17mr+MaVQRdSZdCN4LL/L/U79sJjkyk/JA1Ez13FB+tfb+BIT0E7FYG/
         mUYw==
X-Gm-Message-State: AMCzsaWBWw7Mwyqeq/3T0anHOTeE8S6SqmI+Uk6zDEZV7RhHgO4D2UxT
        ToTQ52Q/vhVmWX9PYCEkC/pDTSIoX2wbflm2tQc=
X-Google-Smtp-Source: ABhQp+QsEH4wtCJKr66ryOmO9U2ZS/4YMyfLTsP8Wl+nYHtzW7tMnL4SuC739ibi+NzcigwxDb3EGn/tDEtIQO9AtGQ=
X-Received: by 10.36.10.82 with SMTP id 79mr4767139itw.128.1509344321707; Sun,
 29 Oct 2017 23:18:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.7.10 with HTTP; Sun, 29 Oct 2017 23:18:41 -0700 (PDT)
In-Reply-To: <xmqqvaix8o6k.fsf@gitster.mtv.corp.google.com>
References: <20171019123030.17338-1-chriscool@tuxfamily.org> <xmqqvaix8o6k.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 30 Oct 2017 07:18:41 +0100
Message-ID: <CAP8UFD3qjmSrCJ1OE6x=sitbm7LqRB3aSm42aV4h=gAG853PhA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Create Git/Packet.pm
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Oct 30, 2017 at 1:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I've queued this from Dscho; please take it into consideration when
> you reroll.

Yeah, I was planning to add something like that, though in Dscho's
first email the patch was adding:

+modules += Git/Packet

and now it's adding:

> +modules += Git/SVN/Packet

I wonder where the "SVN" directory comes from as in
https://github.com/dscho/git/commits/cc/git-packet-pm my commit
(https://github.com/dscho/git/commit/46032e5f55f6e87d22f9a3c952b5d48a5f100a86)
still creates perl/Git/Packet.pm and not perl/Git/SVN/Packet.pm

Thanks both anyway,
Christian.
