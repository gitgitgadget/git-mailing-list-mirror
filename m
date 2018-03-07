Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA611F404
	for <e@80x24.org>; Wed,  7 Mar 2018 18:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754279AbeCGSUF (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 13:20:05 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40027 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753168AbeCGSUE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 13:20:04 -0500
Received: by mail-wm0-f66.google.com with SMTP id t6so6496491wmt.5
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 10:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nboMftfXmq5H0tb9q4Myzwp99jt4YSLgQmiL5D9bLt8=;
        b=JP7RdyH8Xw1J3CbZ/1edwOuFmYcqugEUYcOjx18ot0mdOdM/rV8G3Fs5EBtsKKqPwE
         g7kcOJX7s1+MlfVqeCF7jqy0tTZntEFuInrNMD43n1B/07R4raglSzUp9bGfMExWHfK7
         P/kG/w87/H8Fiz537nO6rxO7EgmziHV+ujKA2N7iChZ5WWznBIPvroG7IvasF8H5IkrJ
         R6dbBJ7P5UbRoi6eJKzSB7/u6VADL6uLJW0YbKe/VmXDMuKuuIHCB62xv0cnvUQTGjkx
         DHa1EA+pRd4hObW4q2DNvI4wI4Scs4JwzEiYnbm9NKe/SwOkGTgr/xDCHwvWgFOAFS5U
         mhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nboMftfXmq5H0tb9q4Myzwp99jt4YSLgQmiL5D9bLt8=;
        b=pE/c+EJBB15cCxCuCAYWIExKF3DHdWD6ptuDPqpZlB6p6+kg0KdkilHQScO2ENTw0W
         e6tInkSs3VeyB4XEaPkmt+hvUUJmgUNTTA/DGSRPklaZ0/F8bso2xwicbQxnJ0shpxGV
         Rqv4Q/1QGMP4TFZU/BvOnlsdscUKhH1kGocXAZk0GenhLdHHGlxUqoYci0baEqo6Vn8q
         eBxMl/2dRMV3BVaSP3RqnHbaX9wZ94P4KFXc9rstoxLxvaIQH2QmLWNprHNekvIfC6/7
         QW1LR64pP2WlrfMnJyCj7sl+xxBK+Le0yqSNL6bnt8Pt8ROWG0tXrY2GnRt3ZeJWiH0n
         ztMw==
X-Gm-Message-State: AElRT7E9u7pNM5558cW9iFpnF2/xzCaa7gJfcV2lDSjmpZFCYsRT+gCF
        LgC1IaGA5Cy60eKYRh1EIhA=
X-Google-Smtp-Source: AG47ELunbsOwHeIBcXWS4xBNuiSqf9grcmjTCth0dTJMvOdRZ2AjU1+FuBl95nzvVxyFoaFVhO/AXg==
X-Received: by 10.28.9.19 with SMTP id 19mr16817047wmj.114.1520446802865;
        Wed, 07 Mar 2018 10:20:02 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s2sm15374214wmf.0.2018.03.07.10.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 10:20:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
        <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
        <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
        <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
        <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
        <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
        <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <xmqqzi3k23fu.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803070804440.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 07 Mar 2018 10:20:00 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1803070804440.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 7 Mar 2018 08:09:57 +0100
        (STD)")
Message-ID: <xmqqh8pr21f3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> OK, does this mean we want to wait before merging the "recreate
>> merge" topic down to 'next'?  For more than a few weeks, it has been
>> slated for 'next'.
>
> Maybe a few more days.
> ...
> I want to discuss this in the other subthread, though.

If we are talking about a drastic change, a few more days may not be
sufficient, but we are not in a hurry, as this already sounds like a
2.18 material anyway.  As you made it clear that it is OK not to
merge the current one for now, my objective of asking the question
is already satisfied ;-)

