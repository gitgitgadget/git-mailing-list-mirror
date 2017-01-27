Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28D661F6DC
	for <e@80x24.org>; Fri, 27 Jan 2017 06:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754007AbdA0Giq (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 01:38:46 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34936 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753898AbdA0Gip (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 01:38:45 -0500
Received: by mail-lf0-f42.google.com with SMTP id n124so156754893lfd.2
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 22:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HOVNJKeptPXWmfgPfrqE88VGjmK1LCKtfJqDDnSeLTI=;
        b=saj6zWhQFBc0ypAYedsrQrGkz+o5gfm4hscePnpfexkOKRzhlf+G5CqhvPylJFJyVm
         4Gk4ORPA/tBd3JF7CuCG8FO5P7Fvz5/w2oWO9Q03Ak1ZJBd1fFgq62UJga6IDzsF3f2R
         1pyR5P7wX9K3hrRX3G8klxWZeaiOhYuKxqPAvf2sEQPfuejzbiW0a2QlOa5/oAd/jHh7
         p20Yc0jtFARIL4r4WxLMbvxRemdzV2CSyt7xWzDaPr3dj3cswTdujk6V1TDuwd1aD5nz
         ZZsQRmvPMiHxJCNtQltfpbBXO+vSAQeHfLS1a9Wrr3FllA2pr5SNKgboe3pNn0wlroMb
         okEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HOVNJKeptPXWmfgPfrqE88VGjmK1LCKtfJqDDnSeLTI=;
        b=P6rxsW/2W3XE/lUFcmSP9+NdP2tIAzog4q7SPZsVgJYF+w8t1vrAnckc/abiPrQXA8
         xOWnprNkguLGb6gqq4E6L9O2FvR3jBmE3zBZF9kvxzGy6q71zWs7hWJUoH/bRuWsVMho
         z2OJI3mCSzoz7062mAC5EfKvx6/UUQFa8tE8kR2dcrDcEpSAZ43tQzW6v4LxDK9g5x0z
         o4oxHljkHPRyJiLeEXtLgdZqv/Kq627DHICbAJ61gkHCSiq52DmCg6gNBZJv/lWifugy
         QyBnk8hNc5QqaXCd15rlcxMRpBwVRaGPJwmR1/rDcBsRY4Z04o4umshLUpLOd4Y7GGF/
         iNaw==
X-Gm-Message-State: AIkVDXKP5q9HDUG+EBqZiyXqnwSToRw/7Gjr1hONzvSM7YkEMcDBt8rN86VhlStU0rgIGDrRNpF9fjoyhjWpvA==
X-Received: by 10.25.210.79 with SMTP id j76mr1862891lfg.129.1485499124201;
 Thu, 26 Jan 2017 22:38:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Thu, 26 Jan 2017 22:38:43 -0800 (PST)
In-Reply-To: <20170127035806.rtvlas7dja5ikvxg@sigill.intra.peff.net>
References: <818851a6-c3ef-618e-4146-518fbe6bd837@ramsayjones.plus.com> <20170127035806.rtvlas7dja5ikvxg@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 27 Jan 2017 07:38:43 +0100
Message-ID: <CAP8UFD3EBKxP7mgsQvJCTdjnPt4C-9i4ssLDNxhezbLo0kxhpA@mail.gmail.com>
Subject: Re: Intermittent failure of t1700-split-index.sh
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2017 at 4:58 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 27, 2017 at 02:45:15AM +0000, Ramsay Jones wrote:
>
>> I can't devote any time to looking at this further tonight
>> (it's 2-45am here, I'm off to bed!). Can you reproduce the
>> problem, or is it just me? :)
>
> I can reproduce here with 'pu'. t1700.17 seems to fail reliably with my
> stress script after 5-10 seconds.
>
> It bisects to ff97d10f57c2f99b6d86da8f07c16659979b2780, but take that
> with a moderate grain of salt, as I may have marked a bad commit as
> "good" if it simply got lucky and didn't fail as quickly.

Thanks both for your tests and your report. I will take a look.
