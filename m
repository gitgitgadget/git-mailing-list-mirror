Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF1ED1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeCWR7O (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:59:14 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33888 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeCWR7N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:59:13 -0400
Received: by mail-wr0-f182.google.com with SMTP id o8so12977664wra.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=3PONo55tXVYJmVqqLjtKKHgqWWlThUfa93QR+q8op6Q=;
        b=gPjWjoFGxu2jtB1y5JAdvFqxAXCxQHbqRvSkmbumspr0SGyfUGXe5zUbzqD4uBC71m
         WQ3aEcPgRF/dHa7M3eU138zhwvgDmt97Ial0o6W/ZiWpb/7OUFNDrtfi5PWAk+6lROew
         lQGcts0tSbMwtxLZMXJJpgT4D5MQ+yMvDXArRAmvm3LwQLpuSykdh19QnkOXHwJI52/P
         ql2axOj4iNI74I2HSyG9Kn56YtSGFPaycS/9fZ5EtlgTa8LPJPT6MFd8jQYoCukhJ70/
         QNRXURqloesZ1+8eayot8IRRlLTy6GRLM30rdHY9pT6R0scYGuRWvrS3mI9LitcQYahF
         XrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=3PONo55tXVYJmVqqLjtKKHgqWWlThUfa93QR+q8op6Q=;
        b=MDv/TGiwYZQqWJiCgdhwj8iFUFBLnQsqw0SZMr+HGRLgljqeBeHFTFEmcHbevgQROZ
         VMdfo6yWv0LWtcfAxj2VsPn4rL6bcf8NY3GktRrVbJJ/mBI7fENtruAILc8WNYRPulgX
         DhmEgH3JLNQ5to+n7p5ayMaGbEV4YONO6yaQ9dPDpAYkyCUb3t1BvPESDYGM4TT4JpaG
         zzGy/sCX/xWe2YTENdXai/U/v4J9y/U83xwO2M3aCf0K6d9h/1zsTvXJ7uhXjUFaXmXj
         ehnt5VIXR+c0yeTZomnUCBMEAZvmlGhC0j7ES7BGJJcvQzaQLXStY4EupZrfhFJh/VCE
         tMDA==
X-Gm-Message-State: AElRT7EiGdZI5GrFOzVYNJtZpBohH0+47+Rtp5L+/wc0KhfFWtjO1nRU
        m8qZg9Bp34geSIeo77F81Dk=
X-Google-Smtp-Source: AG47ELtniKrZcaMrz7J+RSt9SJRiG858bVSWxawXSsezRSggn5UfYWQxK78a+F8FBeK+9shpQqlu1w==
X-Received: by 10.223.162.201 with SMTP id t9mr23393687wra.148.1521827951705;
        Fri, 23 Mar 2018 10:59:11 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id x10sm9512141wrc.64.2018.03.23.10.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 10:59:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Takuto Ikuta <tikuta@chromium.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.17.0-rc1
References: <xmqqtvt9nr7p.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <xmqqtvt9nr7p.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 23 Mar 2018 18:59:07 +0100
Message-ID: <87k1u2y8pg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 21 2018, Junio C. Hamano wrote:

> A release candidate Git v2.17.0-rc1 is now available for testing
> at the usual places.  It is comprised of 493 non-merge commits
> since v2.16.0, contributed by 62 people, 19 of which are new faces.

I have this deployed on some tens of K machines who all use git in one
way or another (from automated pulls, to users interactively), and rc0
before that, with a few patches on top from me + Takato + Duy + Derrick
since rc0 was released (and since today based on top of rc1). No issues
so far.

The specific in-house version I have is at:
https://github.com/git/git/compare/v2.17.0-rc1...bookingcom:booking-git-v2018-03-23-1

>  * Some bugs around "untracked cache" feature have been fixed.  This
>    will notice corrupt data in the untracked cache left by old and
>    buggy code and issue a warning---the index can be fixed by clearing
>    the untracked cache from it.
>    (merge 0cacebf099 nd/fix-untracked-cache-invalidation later to maint).
>    (merge 7bf0be7501 ab/untracked-cache-invalidation-docs later to maint).

FYI over some >10k machines I tested on around 1% had (very) verbose
warnings on "status", which was fixed as a one-off with 'git -c
core.untrackedCache=false status' as the
ab/untracked-cache-invalidation-docs suggest, and it hasn't happened
again since.
