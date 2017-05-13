Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E5E201A4
	for <e@80x24.org>; Sat, 13 May 2017 10:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbdEMKNP (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 06:13:15 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34229 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbdEMKNO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 06:13:14 -0400
Received: by mail-pg0-f66.google.com with SMTP id u187so10548816pgb.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 03:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=YdzBeKP0uAbivXDDD4vrA9KH4ZTJcKh4IVDVe2nETGc=;
        b=g87ChJ4gbEsWyiUvYvd1mbRjBeMw/fDGoecTxlbBoNsGcxC64grjNZKgs3TRTBduRe
         GVXnxmQjBHXkiywqixWPOFBZSY+iZkj+WcaTbbSLZuD6edVKYL5gY0uu/ErabzrXsDuw
         R+D2TVZVwhbpSwDZoUvTPyXwhyVQSD3cWVGt+f6GLCLduC6GlI64TdyrnIKTUThKASwh
         NN7Bw1VYAVXEkPzeBzraASdtFpW6Lm3eKL5br+u5cP9eIY3bOgDI8474mszJijSD06b5
         wcXha5mRVWGBi+Ne9wicpW3kMdiGtMbZAGHttwSUeFE11mC4GMQ5N4LPnE9N0SAbQs3F
         QZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=YdzBeKP0uAbivXDDD4vrA9KH4ZTJcKh4IVDVe2nETGc=;
        b=TWuGBwZZOZmj+isaJ3x8TomnueTrrs8uamYp8b8Yvied+ncT+CnBcRQRNqWVBBQgHV
         XIpXr1nb3KgiO1cn9Q1jAgL+kjmZc9pGp2DE/tzVqQu9dbukgXQ11rzQEZQQsla8vPB/
         eV7MkEmUbEdVtBjazOFu0xyON4z+/uOTEBLswIeEZnaMfHyRbBb3Sc6iYTHQfM2CdRpc
         3rhlt0+efyLRvdephiHotlSWKSbczLlBGecvjV6zAQe/iV1aLKSz+KYXhRdNyN5+6xHj
         Yb61omtUgfmvCjJnztN8h+rFJPwIpr7KMN3soD04NkqyHmis5x4bYvyB33H8eTVKVHHB
         p/eA==
X-Gm-Message-State: AODbwcAMt6pC73rZA4WZXrdP8aqzfW0SKtSD8HQDwsOYfTIqDsjdQWyo
        aPi/FobKGcOlCA==
X-Received: by 10.84.216.10 with SMTP id m10mr11627403pli.4.1494670393840;
        Sat, 13 May 2017 03:13:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2d31:71a5:f712:48d1])
        by smtp.gmail.com with ESMTPSA id c23sm9244105pfh.131.2017.05.13.03.13.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 03:13:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/ for good
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
        <xmqqk25m98rd.fsf@gitster.mtv.corp.google.com>
        <xmqqfuga5lp2.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705121617420.146734@virtualbox>
        <20170512173846.GA27400@aiede.svl.corp.google.com>
Date:   Sat, 13 May 2017 19:13:11 +0900
Message-ID: <xmqqinl53w08.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Johannes Schindelin wrote:
>> On Fri, 12 May 2017, Junio C Hamano wrote:
>
>>> And this one is also important.  I do not think we had to touch any
>>> code that handles .git/remotes/ or .git/branches when we extended
>>> the .git/config based configuration for remotes, simply because the
>>> old data source are pretty much frozen read-only places these days.
>>
>> Okay. But by the same reasoning, I want to hear nothing from you anymore
>> about the sort of maintenance burden you talked about in the ssh_variant
>> patches. That burden was ridiculously small compared to what you tell me
>> you want to keep (and for a single user that may have moved on). Not one
>> word.
>
> I don't understand this argument at all.  There are costs and benefits
> to removing an existing feature, just like there are costs and benefits
> to adding a feature.  If I understand the two examples you're comparing
> correctly, then the same principle is at play in both: when it is much
> more expensive to remove a feature than to not add it in the first
> place, a maintainer has to push back on both addition and removal of
> features.

FWIW, I do not understand Dscho's argument, either.

And I do agree with you about additions and removals.  While these
are a bit of apples and oranges comparison, the same principle
indeed sits behind them.  Incompatible changes, including removal,
are costly to existing users, so we want to avoid them or when we
cannot avoid them, we try to find a way to alleviate the pain.  When
adding something new, we try to make sure that the addition will not
introduce the need to make incompatible changes in the future.



