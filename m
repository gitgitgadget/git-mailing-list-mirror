Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 080971F404
	for <e@80x24.org>; Mon, 19 Mar 2018 20:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971508AbeCSUyF (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 16:54:05 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:41892 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971539AbeCSUx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 16:53:59 -0400
Received: by mail-wr0-f178.google.com with SMTP id f14so19992467wre.8
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7rtgpTVbqu2oFWw7xxFTxNe9JD29LI3ZRKpXEzEWQQ4=;
        b=GduL7y/1HkehV/Ge00cMmEKLnhc+F4daGI49Qh84SB6RCiEDOqrvLkknnvyX/VyPnT
         YaNwujaKRsqpRsDgKwowGTeQIdNPUgZP7H9qLALTHaHtdtrs+aqL8ZRUv4pwq0mIZurZ
         zacFlu/p0rbxY+l5RDejWQV4RNaFwLR2F0YI3ZNRvYpzolZ09R2Eyr648Px4a3LkntSV
         jF4Ydl0cuvbGmc0dc7FixqK9z7ls29TNus6fEqzpQWOInJKh/h9L5zJkHkwXZoNRGY3d
         lP5zfK1rxfbXnjcEuufUubdBh3A4DzgeGYtGPhFR6CcjPPtiYKJRR0k4oe/yK0aQf9rS
         fByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7rtgpTVbqu2oFWw7xxFTxNe9JD29LI3ZRKpXEzEWQQ4=;
        b=fTIebeypjUR8eV5x6ncW3uF3dQI5Tm3t1FCL6idiI711jZF4EigPiZBbdm8YfBG0JS
         kSJdAxg2J9gSSV44dBVOjidGXtNYIKZWZ8ojqouQIqYxp53e2V99yii35aipCoiXI04x
         mQDkpS2jScnKXs3ySBJDyQrr1/UCX0BdXtLbqJrv5Ev8dVZZkIJtm/srgo8ZZLE2JdGy
         NNdlPgDhEPLr4ga0aQbSw2n5zzWRgjQ645JhCXtaCT1z07Ia9xKbbtfJ+aHHuADv7dip
         NuAesif8HUS+PLvRUIkVWbaYMumdrtcO02Ep8i54nOX8OWwGi7qjSOBpFhmpNaedCZBY
         TXmA==
X-Gm-Message-State: AElRT7F+Gg9iijz0FmbqboTPTovKSysKQbKAp95OsSjHABhvjCZRsE91
        adEnuok0jrLsKHMHCxzhKrk=
X-Google-Smtp-Source: AG47ELu+fkBT0hALQ+bixbjuPQ3wABTExuUIBFUXzj4vw8ZR4SqqE9mjigoW6VaSaac1rDA9N6C5Og==
X-Received: by 10.223.209.72 with SMTP id b8mr10391099wri.122.1521492838096;
        Mon, 19 Mar 2018 13:53:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 53sm122989wrv.9.2018.03.19.13.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 13:53:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joseph Strauss <josephst@bhphoto.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug With git rebase -p
References: <9a1c2c55ff7f412f8830dbdc4bc033bc@EXMBX02B.bhphotovideo.local>
Date:   Mon, 19 Mar 2018 13:53:56 -0700
In-Reply-To: <9a1c2c55ff7f412f8830dbdc4bc033bc@EXMBX02B.bhphotovideo.local>
        (Joseph Strauss's message of "Mon, 19 Mar 2018 20:23:48 +0000")
Message-ID: <xmqqlgenu6qj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joseph Strauss <josephst@bhphoto.com> writes:

> I found the following erroneous behavior with "git rebase -p".
>
> My current version is git version 2.16.2.windows.1
>
> I made an example at GitHub, https://github.com/jkstrauss/git-bug/
>
> There seem to be two problems when rebasing merge commits with git rebase -p :
>   1. All lines of merge commits' messages get collapse into a single line.
>   2. When an asterisk is present in the middle of the line it gets replaced with the file names of the current directory.

I suspect that this has already been independently discovered
(twice) and corrected with

https://public-inbox.org/git/20180208204241.19324-1-gregory.herrero@oracle.com/

and is included in v2.17-rc0 (and later ;-).


