Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FDBC20802
	for <e@80x24.org>; Fri,  5 May 2017 17:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbdEERxQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 13:53:16 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33681 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdEERxP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 13:53:15 -0400
Received: by mail-pg0-f53.google.com with SMTP id y4so6397071pge.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CrjRnAYDqa522ukMHzzlzDFFuAYtJpwYOzqIt9ivFEM=;
        b=UYiGNIRbruu8ML1HPiB3ElvHLDrIimB7T+RcRr/Bo8lGM60V0jZwOzOmE+SV8Hy31G
         xel0esQyRhNPZIMraITDx9/oGDfBlVQbKc60JPpBSupKDO5nTVs9/F9lxrI6phPW9Zne
         6oeFRqOaMMZ1HwR+x+KY4rSV9l7B2GYAE7qzqwEpKACuZ2t6TS+no0AOPJqsywP3ns7V
         /PtZxkMlT8HQHzNBonQhsrkr2kX/6Cj/37Z9mtX30+rNF/bm0SeYsQf8gKJk22Koo9NW
         VAkRa1ZHXoIqsA/I0mD8UBmz0u1Robt/GEGW4px27PasX5RLvjLZBBs1DEG2OAZ3TCbl
         0DqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CrjRnAYDqa522ukMHzzlzDFFuAYtJpwYOzqIt9ivFEM=;
        b=NzxcYGyIcq71GAE/RSkMxoH8B80HWCDT/T2/BU1TndFThBvC16rvNHNBO7GAE6uxU0
         CUzCoPpDRXdPiFAG9ukxZGkFvP22zFUxLLZFoOkIy3xrq4gC1FGriq5Ny6BCxeamyHLo
         UFUKTE9yFnJiyUoBrPLQGVK6s6JVqXwVTgBDIh4aJ0NDUwHTZwrUbbemR/lz4+gUCi/w
         LpDfPUMT2W8B4jfm7tMeipYeZof077Jo2u5Lb8NwkoQ5/pF53XlFovkVxXQUPpee0F/p
         AqQWgo0nsgwWMsla4SfD98ZoxZ3CyPPie6c7w2jsCe9ijoqH2C4DTh9j3Vy3klOGtq5s
         HHig==
X-Gm-Message-State: AN3rC/4j6cb2DlXlOdmsvwUajeop4uFbUFQ/A/4XdwY/Dc/J8RjVFh+P
        I3ur8k/ZzX/sTC2hEWroQzv6EpVxvReH
X-Received: by 10.99.126.92 with SMTP id o28mr4925362pgn.63.1494006794745;
 Fri, 05 May 2017 10:53:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.140 with HTTP; Fri, 5 May 2017 10:53:14 -0700 (PDT)
In-Reply-To: <CACBZZX6ZzrJk77ReJ592rJrNR1xhVCQid6_5KTonwTot5eq-hQ@mail.gmail.com>
References: <20170505154053.58128-1-larsxschneider@gmail.com>
 <20170505173841.20555-1-sbeller@google.com> <CACBZZX6ZzrJk77ReJ592rJrNR1xhVCQid6_5KTonwTot5eq-hQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 5 May 2017 10:53:14 -0700
Message-ID: <CAGZ79kaJ-S3-ihj_FKXKO9Bv=y+nrm5LyuQcObKiNDTv7q9-uw@mail.gmail.com>
Subject: Re: [PATCH] t7406: fix i18n expectation of error message
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2017 at 10:50 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> I have a fix for this in my gettext fixup series (so far lingering on
> the list, not in pu):
> https://public-inbox.org/git/20170421185757.28978-1-avarab@gmail.com/

Oh, should have checked the list more closely before.

>
> The diff is quite a bit smaller than yours:

I agree that this is the way to fix it best.

Sorry for the noise,
Stefan
