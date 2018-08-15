Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6EEC1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbeHOURR (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:17:17 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38311 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHOURR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 16:17:17 -0400
Received: by mail-io0-f193.google.com with SMTP id v26-v6so1606235iog.5
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 10:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLKj4IHRmAGD26G5S40WjjQ9GB2TaZTUdPi8B76ROzY=;
        b=T1LeCX5eVzxzAdPKrMVkkRmDDqCxjX04N4vK6v1PcJXxIfNZKd+i7saUJnNPguErk2
         O2o1cgjI8GAWJ8D0LAElC7AF5OdH73U+MMcSek48O3DW1WH3e2mcZfy+ZPY3UdtpRSJb
         Ef9hQNTKBTQUhyipCvVZMZu9vbsqFF9GckGOqDIELq9A4+8f+Vd4mKP0ehb5Oji99P/W
         0c6hX6Xu14xHuFhkoGjDkl2Ep5iyWA53xRrVGvwqxBXf2hwQ3KZOmo1MEQl8r0iEwziN
         3NujK3fuiImc9uwUKLHh+pP7lUhGmh6fiGg4MwNgwLqnCtGSHJ7VNiqEygne1f1flxaY
         wvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLKj4IHRmAGD26G5S40WjjQ9GB2TaZTUdPi8B76ROzY=;
        b=HWltM6LArbOvSKniCaf1o1ZXKUfSq27WtvwxcjNY8yDmXefQz306d6OdnSzkZmxQpY
         ghtwngBJX3VOHmGzjtbyFdwUSVQTmBGh1THTcMsoq4nek49H+wiv8BKnBu7GKoBCeeX2
         /dijXLOZiSwx/mTwwRXP66CSK9U4PYxFioGtUsawddASiKSVpWwUtr8UVrdFej3DRb+A
         V+99ZzNoZJDnf1FU7AYoJsxpI3wVWN2YzzEfPRIhAsdBUU9nJJgKyliG6CgUVIyyZNoh
         2oYRMkvdEw22rCu7a9OtJvF5NFYYWim5zU4LiP5eaoMkcw8cERQq+wygOk3ooCQSl3u0
         JfaA==
X-Gm-Message-State: AOUpUlF8OYiL+2PCb8Q4FSAkJ0TbRVrfFfxGwusd3PE/iapCWfJnL9km
        JLFJrVLTpgLnfHKHSC0Um5lHGKtOG5W2EC+nei0=
X-Google-Smtp-Source: AA+uWPzwk0nTuUztQjurOt+wxIIkLb61B2VhfFtmx5Hkq5WqX0jx/R+UZ4we+oEOVPEULKy8NfelPgy551DX/t7Cayg=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr21028376ioe.282.1534353854816;
 Wed, 15 Aug 2018 10:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180815162308.17747-1-pclouds@gmail.com> <CABPp-BEC45snMzGeCre-dD1rtqGok-RKuLGbMaV=VJhwx1ceew@mail.gmail.com>
 <CACsJy8B3ip+_sDrpvaZ32a35-6hWkY=eE6g4RObWgbHnf6g8uw@mail.gmail.com> <xmqqtvnvim2j.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvnvim2j.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 Aug 2018 19:23:48 +0200
Message-ID: <CACsJy8Cx42bhLq9MJqcB9ayO8TqASh1xbmOE8O75-ufKXAK8ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] branch.c: remove explicit reference to the_repository
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 7:20 PM Junio C Hamano <gitster@pobox.com> wrote:
> I also do not think remove_branch_state() function belongs to
> branch.c in the first place.  The state it is clearing is not even
> about a "branch".  It is state left by the last command that stopped
> in the middle; its only callers are "reset", "am --abort/--skip" and
> "checkout <another-branch>".

sequencer.c as its new home then?
-- 
Duy
