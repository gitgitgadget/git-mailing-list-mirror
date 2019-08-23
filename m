Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF04F1F4B7
	for <e@80x24.org>; Fri, 23 Aug 2019 18:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405162AbfHWS31 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 14:29:27 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:36968 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404001AbfHWS31 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 14:29:27 -0400
Received: by mail-vs1-f41.google.com with SMTP id q188so6871617vsa.4
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 11:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPDeHScAeTGqVRqEH0EuVqi/senwT6mJaCV9dS5ItR8=;
        b=O1EUuYH5obA1e1CTUfgXr5uPyNMIwD0fbyDdOf0E7sSFfPVwHUIZXAB2dCwmny/xaK
         oT/h5KRxRWNWu9vfKiSDar7Q/3ABDpQFKODMfJsQc9kJRzTdu/XHfn/svcMRkNV38XCa
         +e3dHMYzAq0yX1z6M/K8altIvODxm/fENnesgmhoGX+XHf1X761FYc5zXRew4J7aNgkz
         eXj6tTDdXVxl7Ju7QfHviiymZPeX4eboaU8TFgQ7nsgQqENNPrmpR6V8QujXUCrJxyDT
         MD0oqzTGGhH2ogschZViP+PkYBEDqVmBuPKZ2nHDixS4nPv2+FKZIanqE3uqCLXrb1+Y
         NAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPDeHScAeTGqVRqEH0EuVqi/senwT6mJaCV9dS5ItR8=;
        b=kf4qvl6byKp0BwlIhUakKnx4P5yRwJfiemDXsnrgEVBv3LhCq7iV9LQy5ByUbYbqWH
         exrfEP4L2uFy56MV1hYBs0M6vrge6ydDjiSCQauRxtM/96gVYcnnYO6okHKRUGYtvxrN
         cVRk93l0CFu/Gy3ePkOQtruhDLI5UBuYOM1oFZon1ctrQrLfbAG5UAU4AIA0Pg/sIAiC
         FLmlZePN6KhnABf05Z4Npkf/D5x1dvIuKwuGSgyg92zo06M8qD6qw8Nm2ImyAmHODJqm
         4qCgtCuHB4RisN20prlIpPYZQvdzvoOREA3/DXXO1LJkJQW19b758bGwomegZT0moCVp
         NnZQ==
X-Gm-Message-State: APjAAAXZ1RQ1IRxOH4mR7mga/xDgywt63fD+ikb7SPHQnFCIExAlXoMg
        QgDg51Dq9s22Kb4BMDy+Qylh9UeTfPtKUmfug14=
X-Google-Smtp-Source: APXvYqza9GcGKQjr86fACRbkNP+mhRqiwc2AIw6dlXWG6njsaR0gjUOKwYJZJ3BTbhN2Z43FmJ3qCfH3DWZzP4q5Wo8=
X-Received: by 2002:a67:6244:: with SMTP id w65mr3610162vsb.117.1566584965988;
 Fri, 23 Aug 2019 11:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEr8LVM+yWTbi76hAq7Moe1hyp2xqxXfgVV4_teh_9skA@mail.gmail.com>
 <xmqqlfvlne3k.fsf@gitster-ct.c.googlers.com> <CABPp-BFK65qL4GCs5bFuiPPYwMCDYrxMyYejacVS89d2GK4nDQ@mail.gmail.com>
 <20190823030059.47ftwfne6y436e5j@dcvr> <CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com>
In-Reply-To: <CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Aug 2019 11:29:14 -0700
Message-ID: <CABPp-BFxOA83uL=gsNir5zSgMsfBX6=9+YnWqp+Q4NiztiC6bw@mail.gmail.com>
Subject: Re: RFC: Proposing git-filter-repo for inclusion in git.git
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 23, 2019 at 11:06 AM Elijah Newren <newren@gmail.com> wrote:
<snip>
> Safety:
<snip>

Ooh, and another one I remembered just after hitting 'send':
  * If the user provides a --tag-name-filter that maps multiple tags
to the same name, no warning or error is provided; filter-branch
simply overwrites each tag in some undocumented pre-defined order
(lexicographic) resulting in only one tag at the end.  A regression
test will fail if you attempt to error out and warn the user, so if
you are trying to make a backward compatible reimplementation you have
to add extra code to detect collisions and make sure that only the
lexicographically last one is rewritten.  (fast-import will naturally
error out if told to write the same tag more than once, so you have to
avoid triggering it.)

<snip>
> Summary of above: Anything compatible with git-filter-branch will be
> slower than molasses and extraordinarily unsafe.
<snip.
