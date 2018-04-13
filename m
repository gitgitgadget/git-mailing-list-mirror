Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AC611F404
	for <e@80x24.org>; Fri, 13 Apr 2018 22:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeDMWpS (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 18:45:18 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:42441 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeDMWpR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 18:45:17 -0400
Received: by mail-yw0-f179.google.com with SMTP id z82so4778570ywd.9
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=csNMsTZOvf3pqYBFqmLB1c97dzlUxSnV9DSPAO27+v0=;
        b=g0m1yutrWCeLui2SZnoyfSyDeTlIhZyTmitwsrrOYzpeGfin8BUDWuUI6qdFTI+B9p
         d8ZC8pCcu9H7a89CMw6QRSm+7wjvryeGSM5USDEOUX+LNPb0ePr+Apz3ZV9vgEU78wKT
         Be4fhYysMBv7BhpmQJlrCl4DB9dbX9w6GWeMoH67vH3dgzTkL+GB+n5Q9TsbUnVHFA8O
         OQNadf/Qwy4nz09GWFX/0LYYuxpcce9RLcEFJ+YuBDIyegQ3M3i7/N34Xxew7hy/mIBl
         q9pBsYIeZhPpw/yN856Z7TO8aa72L2ZaehwZaqRGYhhiqXS/nHLfomW5dImD4a3wKKUF
         C5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=csNMsTZOvf3pqYBFqmLB1c97dzlUxSnV9DSPAO27+v0=;
        b=PgFqTg0WHWIQylw+WDAVPP0Ah0fJwFvRQHpH5R+VnSVY0kRulO5rswMfCQQ/8bvidf
         oIFQZKRVArIdS0P1yd0TnSIJJyeq5xuvCsZDUM5ysak/euGdu1rYQWN4QRqMIHOEOB0K
         mBpL3ujNSZhtt7VfxbVZxZuMA54YQeVDAGGyhLO6pWyKNoX8qExDpmUXe87mtWBNX4Jz
         GvYy+axAPL12SWGudgca13dr4Yx45qZyrFatGLHUDLkW71xOSo6x3piVoHYslVMD6YIc
         ZbFwTPvMo5Grq+/h2sgLn4SUHfx7YvkMzAyLWkYZizGq5xE6600vTMKSy6HatzUfBEsm
         OUrw==
X-Gm-Message-State: ALQs6tDTzJvNv5WSVx/mVvAuIddYUU+H2wOxsw+sryCNKnu9JYSNlO76
        CjaMIfO0B+UFlR6upFElrxFmlbkX+McatbeC19esgWNa
X-Google-Smtp-Source: AIpwx4/Vls3SzFXbVsESRJCfO2TTaKrXC4hNe/dRS3EV0AkqLiV/GEMYS52gsm19Y2W3/zPkVsUnrBHzycC/+Ukxkz8=
X-Received: by 10.129.232.5 with SMTP id a5mr6247814ywm.421.1523659516746;
 Fri, 13 Apr 2018 15:45:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Fri, 13 Apr 2018 15:45:16
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804132339130.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de>
 <CAGZ79kbEec_U5wL_aOS5O_3+ZOshGwARALpjz801h-fRx-zotA@mail.gmail.com> <nycvar.QRO.7.76.6.1804132339130.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 13 Apr 2018 15:45:16 -0700
Message-ID: <CAGZ79kawFhCuDbAndg2oU87jFT-PhpLBMoEBumN=J_DfGK=v9A@mail.gmail.com>
Subject: Re: [PATCH] Deprecate support for .git/info/grafts
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Fri, Apr 13, 2018 at 3:35 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,

>> I wonder if we want to offer a migration tool or just leave it
>> at this hint.
>
> There is contrib/convert-grafts-to-replace-refs.sh.

Oh cool! I wonder if we want to expose it more such that people
discover it.

> I wonder whether we have to care enough to implement a `git replace
> --convert-graft-file`...

I don't think so.
