Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1341F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163017AbeBNT37 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:29:59 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:55032 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162999AbeBNT3z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:29:55 -0500
Received: by mail-wm0-f48.google.com with SMTP id o189so5030678wme.4
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vkEFmhGrxUbAExl1llmh7D6/tq7xzCOVtdme8Pl5cfQ=;
        b=eq+0GoQ7uw61H8x7iLSOx+wWyikeKvIxe0tqzOFP1YtfJuu+DGfL/pkhZXdfx4vUxV
         oXi596zpz/biia/KLds5BmKNhA1yIcFVOu8TOzuIdmKVxLDsjFJf4IpJ0t88NRzmA9yN
         RExxdNyxYRY0HSXztvFZIr+Gyw8f/OGYuD3FG1te8xAyB2qVthxjlfwEfQeXRy/i5IGY
         AvOtGTggdmSQpyx273zWF793z4Da/IPAlTJEMDNum5dB6FYFUIz9g6ViDYe1WDf7i2t1
         Ok9u8A2tS+8YWo2SDiqpsyx7pQred9wzptP8tfzgqTzvpDbSgCUpDvzDecwSNGDfxr/9
         7pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vkEFmhGrxUbAExl1llmh7D6/tq7xzCOVtdme8Pl5cfQ=;
        b=HZU/8q1y5IXy00VUatHCWX78soOIRKrraybk1ogSMGkNGvStz9S9B2dUqjiW5YCZq+
         AX5oBT9qg9yZacAdHUnN7VVsVFIndoEEJxTqU7o5YwOebV5laqKx2rociwelTSg8pAOd
         kavhaVz0GSMro5TRulEPzPXDCQrA0kveMnqvj0AZ6wd2dWFBMjqAsFX+GTb7Tae7fEGh
         ut87aAIYhehwxjQFXACgs2ZRPp5sh6w1ub9g+qXnIdoIUT1/U/xx8GPLM+t7Ogm73MX6
         R2RA/f6+Gdj5JGdUcjpGXjHQT3W+PO9Wu6Sqr3u1P1GF2Mj59Wff50EZWXV8mvZ3Q7fO
         U3Og==
X-Gm-Message-State: APf1xPA29R8WraMg+nR57kTYeS5EAsRY0+O5Uu93+0f1RYr31NLKBBXO
        L3cXfjPdu129wHsBWzFB6kI=
X-Google-Smtp-Source: AH8x224dy8QZIioOIgTK5CKe9LWE8jbD/vUQocRLizFQ+K/QHdgwbdcNBn37PlyThjdaAkBsregEeg==
X-Received: by 10.28.212.13 with SMTP id l13mr122936wmg.83.1518636594146;
        Wed, 14 Feb 2018 11:29:54 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x63sm5403965wme.35.2018.02.14.11.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 11:29:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Goffredo Baroncelli <kreijack@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "git add" with several pathspecS and one doesn't match
References: <d5e4138e-d5d6-3a84-a222-8d0170a52ccb@gmail.com>
Date:   Wed, 14 Feb 2018 11:29:52 -0800
In-Reply-To: <d5e4138e-d5d6-3a84-a222-8d0170a52ccb@gmail.com> (Goffredo
        Baroncelli's message of "Wed, 14 Feb 2018 19:31:28 +0100")
Message-ID: <xmqqtvujmksv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goffredo Baroncelli <kreijack@gmail.com> writes:

> I am facing this issue: I am ADDing some file with several
> pathspec, and one of these fails. The results is that no file is
> added at all.

This is a good example of a pretty conscious design decision to keep
operations atomic/a-o-n when appropriate.

