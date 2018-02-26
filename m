Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 862A71F404
	for <e@80x24.org>; Mon, 26 Feb 2018 18:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeBZSIA (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 13:08:00 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38799 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeBZSH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 13:07:59 -0500
Received: by mail-wm0-f65.google.com with SMTP id z9so18925534wmb.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 10:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ys2P6ISdwSPDdw87DXNjOKUo6LbBdJJf3onzxzNDVFo=;
        b=czJqAd/lAT2SL1RppEAfwgqq1bHXvB+xaZ20UL5hFeOcXVf3HNLpuvTJ2+neO7SAX6
         7iwW7Z93xP5rWCoYFctoCqAxTsBp3z5eS38mhH2I7Ql1yjFKMzizydLBo/j70+jW2eyI
         PHZDLnAOKJlX3MYNmXtdOIU4Q5Yjd5Y8WX7RidSuxuDZKR/qRmiim32r6X3dVClbhGWJ
         2df+xUPVIoj8fXKVBKMU0SaELJBTkrHl0Vdj2JrzLdyzeKa1DIlonbPd7n8rT8J01kxE
         qzM6P5XMBw3TPNP5HJUFGGJmFBnxtlw+J1a2hesdU/worudUbGYi/mZwxNbegXteZV2h
         lZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ys2P6ISdwSPDdw87DXNjOKUo6LbBdJJf3onzxzNDVFo=;
        b=qOeebyunbklit2DHXuHNMPZn+KemBdDTclKUSIKK0UdDeCDOg5SO8PQxPMSrZSHczp
         lF8XUFmDupzezexNJBe4TfKPyHU2u0SMi34wr15/MF1bgtmx/gzAf/n3rnqNNBbCcajF
         wtzzuZLdgpHfMgy2ZtwuJmgjZNt5sxjmo6/SUrUgvVilzh6+EqfKDpI+rUGSoTEhjj9X
         bggSlZM1pTIVWHsHoP0oiJyByrCMXn9nQsNcoP6Tq1W0QxsC2Kxwesz/wVP/M7r8BnNe
         sPlMzfl3eBCV7fEIrN5y8VHlklygsfdZa2m9mViqDjthjANfIO3d35XsdhsLzO37uNoo
         i4pg==
X-Gm-Message-State: APf1xPC48uZ4VqSujBB1cF1LE9h7yNWbRSxDwk3S68WAdSAxo9hf94y8
        d1qjPjjwPw1KVG0jmuVdg18=
X-Google-Smtp-Source: AH8x227NdMG5FwoSKCmOoADxeMb8d2c8oMGtkszNgBLNCC2fqjjd+x18oG9VWJs0z9TMJsCftMHOWQ==
X-Received: by 10.28.142.142 with SMTP id q136mr9579255wmd.131.1519668477360;
        Mon, 26 Feb 2018 10:07:57 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k45sm8934174wrf.62.2018.02.26.10.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 10:07:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jonathantanmy@google.com,
        sbeller@google.com, sunshine@sunshineco.com
Subject: Re: [PATCH 0/4] Delete ignore_env member in struct repository
References: <20180214180814.GA139458@google.com>
        <20180226103030.26900-1-pclouds@gmail.com>
Date:   Mon, 26 Feb 2018 10:07:54 -0800
In-Reply-To: <20180226103030.26900-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 26 Feb 2018 17:30:26 +0700")
Message-ID: <xmqqsh9nr5dx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This series is built on top of Stefan's object-store-part1, v4. I
> could rebase it on 'master' too, but then Junio may need to resolve
> some conflicts.

As a follow-up fix for combined "move things to the_repo as much as
possible" efforts I think what you did makes most sense.  I would
say that it makes even more sense to make these part of the
object-store series if/when the series needs rerolling--after all
the topic is already a multi-author effort.

I'll have to read them carefully before commenting on the actual
patches ;-)  Thanks.

>
> [1] https://public-inbox.org/git/20180225111840.16421-1-pclouds@gmail.com/
>
> Nguyễn Thái Ngọc Duy (4):
>   repository.c: move env-related setup code back to environment.c
>   repository.c: delete dead functions
>   sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
>   repository: delete ignore_env member
>
>  cache.h        |  2 +-
>  environment.c  | 13 +++++++--
>  object-store.h |  5 +++-
>  object.c       |  1 +
>  repository.c   | 79 ++++++++++++++++++++++----------------------------
>  repository.h   | 21 +++++++-------
>  setup.c        |  3 +-
>  sha1_file.c    |  6 +---
>  8 files changed, 64 insertions(+), 66 deletions(-)
