Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D94AF1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 01:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032456AbeBOBuJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 20:50:09 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:38497 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032437AbeBOBuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 20:50:08 -0500
Received: by mail-io0-f172.google.com with SMTP id d13so27250406iog.5
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 17:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=byEoH5hdWKeAb9LwLZzC/iRh1RdpvaZOVZg/RzJKCMk=;
        b=UBMohs8EPiqaOCEAWZxmuxw+tILXNp2p5suWdLcOoIYDsv5GpwNJK5hwJXS3lsbc1i
         Nyn2j5fpD4JT4tvRPMUKDSk2Yg6KpI6R+F339gUh5f4vwxIPTs30jTLnBDvkHe4zEuhC
         dgg9cO+0RTKIn+es8fTSta0rJt69PJSs5EGQfwSm0HShUQkCf58+k06cpHacxjT22W4M
         RpUaz6f9vU/rs30aWZKTDJq4/sUJbZWWDgSCvww9dd4uW3WpyjkrWUWfk3f6E2xB/J6l
         +QfuiKUD8KSEiLV3zP/2hhcqxxawHOONgJvyFskNQQbVA79CJejg3r3LHGf2j9pJcLkN
         LuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=byEoH5hdWKeAb9LwLZzC/iRh1RdpvaZOVZg/RzJKCMk=;
        b=G1pO40+oAowcOpjEPxoNWElnPoXUxTZlqa8AUNvLbwnMKaxdqaONOM7tjelMTiHaTS
         pcykuxjiy6kYFhLinCh1nUk2xzslUWkZB0KqEpLQo2MfYY1l6YpHOoIlvrK4cWtFIkkg
         gXx64+3I8wMVqWZXlYTaJE42xWmmdhnaQKl4EvImCYIJ7lkrwWBtGsTr6+2dvJXzzwaC
         zfbdoVBdEIxNVCUbbPdqXl4aMUMO5QY/3TVEh8JEnllSY0RVFq+kjF5HU/7t9dHIxyiV
         OMNWU+Z2SQt3SAJU/GMLjZEhFFU/XoCvjtL9Jq54dXmZiLuOtOERKIatN8PwquwDo6Th
         dwgg==
X-Gm-Message-State: APf1xPAof5DPBEC5b8/7vElvUCgHEHjC2kXUHh0oNfJtqMikSgeaoNni
        FnGskh1WceKJrqdhegjqXPrTf0pypT4v1uP49RU=
X-Google-Smtp-Source: AH8x224MNGlLoeMvhc/9byLnegwmJEY1nXY/KPah/UeI4wj2kKrSbkvNkGalf0DxbErlP6TJwPvvxTJr1uVqNhhYLAk=
X-Received: by 10.107.24.70 with SMTP id 67mr1578458ioy.15.1518659408291; Wed,
 14 Feb 2018 17:50:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.5.147 with HTTP; Wed, 14 Feb 2018 17:50:07 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1802150148040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAEWZXo7KiRWK7ddyZgQKs=F+sHY7TtFsXTMXyE-57=FRr6kf6w@mail.gmail.com>
 <CAGZ79kZf1UKsBEJXuwAH+EWr+ZKj-FE8DuBvcM2nJeNhLEA4CQ@mail.gmail.com>
 <CAEWZXo6ws5q-73AP6+Ru39a+drO88fRO49_QGJbQXfOYRpqKwg@mail.gmail.com> <nycvar.QRO.7.76.6.1802150148040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Psidium Guajava <psiidium@gmail.com>
Date:   Wed, 14 Feb 2018 23:50:07 -0200
Message-ID: <CAEWZXo74Z0PRkVPzkrMDdKNhLzyKL03vUYiN=SEnt5MBdXT81A@mail.gmail.com>
Subject: Re: git-rebase --undo-skip proposal
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>, Paul Tan <pyokagan@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-14 22:53 GMT-02:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Now, when is the next possible time you can call `git rebase --undo-skip`?

What if the scope were reduced from `--undo-skip` to `--undo-last-skip`?
Also, further reduce the scope to only allow `--undo-last-skip` during
a ongoing rebase, not caring about a finished one?

But, this could be so niche that I have doubts if this would ever be used;
