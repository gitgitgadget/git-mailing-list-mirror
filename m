Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6C0A1F42D
	for <e@80x24.org>; Wed, 30 May 2018 03:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754964AbeE3Djj (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 23:39:39 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33496 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752854AbeE3Dji (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 23:39:38 -0400
Received: by mail-wm0-f53.google.com with SMTP id x12-v6so168012wmc.0
        for <git@vger.kernel.org>; Tue, 29 May 2018 20:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KUq6OLscqjs4sgGm8BpoBJjj5sGjPEu1q4GQm7gURpw=;
        b=ApRnsAIpzd6Zy847lbOC0JxTNsHQ9VS5Gqe/9XfrEBWmvvnfh037W6HS0iSEb+jTOL
         dTGSOAZybIr9DzkJLCDEpIg0w1AMUbUeEpA3/vri8eGvRk/t6VHrpZwKa/3eagGkrnbY
         v2u3occZo7C8nkenRWqUDKLDEVCu4uotAOqFei5czm7cx8mvBv9p8QJQ/+044pBy0svR
         hhTcWlSOis0scY25nEwLXWLktjev4VQqFlqDZOupGXmpC8C/1431x0rm3Ue0nz3Oys1v
         FAzJCzFwz+pNpbUDf9ec68dl7yFpdxn+np6XpZqwlA4BrF5RI8GJJYjAJiDZ/dZx4Le0
         Dbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KUq6OLscqjs4sgGm8BpoBJjj5sGjPEu1q4GQm7gURpw=;
        b=CdkzgI1VScBloFBs2m3+Sg1Pb4SGWGCf6LLy7Qksngz2a9QgAHuIvOg9yIwowFNZik
         kqbfFgBKdx/UcVVBA6Wrh+C9xzXCSJaehiSGpjJh8IU1qkqX8Axl38qHBx39EGwsj21z
         Y7mkPrQkgZXyYGHqc+V7m5UHs8KI0O9c2PJ7F9EyqIkPnCuYMQyMX3MaH+fmuHK6o2RP
         6wHcmVc0PlVXwJY6bLsNO6dZoGUrzWJxteGkn4ab2dvCUMtltBhixiML/G2of6UW1JjP
         wXYPSjyShWbMkXGWe/IZx41NSqWMi1k2uwHQS5CFLtkklWntBqdwqnBQOewid+U2s+sz
         Xv4w==
X-Gm-Message-State: ALKqPwcBiHQZFNskjIDNvfROxifCtsETQNb/2ydTSvFFbodAeZAqfZO3
        vE5MUURbi8marNy2vt3Fy+1Vv7Lh
X-Google-Smtp-Source: ADUXVKKqepH/vg4ols3WPaTjhz9xUHzW6vvBxvm3w442JFY3tBBm0Bpu7EByzvwgrEmaPYMJ348Wng==
X-Received: by 2002:a1c:da13:: with SMTP id r19-v6mr151587wmg.2.1527651576731;
        Tue, 29 May 2018 20:39:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p5-v6sm18419257wre.83.2018.05.29.20.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 20:39:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/5] config doc: unify the description of fsck.* and receive.fsck.*
References: <20180524193516.28713-1-avarab@gmail.com>
        <20180525192811.25680-1-avarab@gmail.com>
        <20180525192811.25680-3-avarab@gmail.com>
        <CAPig+cT=i0XYOrMymNjsBJqcLfJ38Ft_=MZPZD3N-AMo8raAHQ@mail.gmail.com>
        <xmqqa7skjep9.fsf@gitster-ct.c.googlers.com>
        <CACBZZX5mSj2=JXtVPrPZ8Y1gCyu9p+EMYoSPeFZtuvm3FsdLNg@mail.gmail.com>
        <xmqqr2ltetcy.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 30 May 2018 12:39:35 +0900
In-Reply-To: <xmqqr2ltetcy.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 30 May 2018 12:05:01 +0900")
Message-ID: <xmqqmuwherrc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Between "fsck.<msg-id> makes sense only when you use these rare and
> you-probably-never-heard-of tools ongoing basis" and "when you
> already have (slightly)broken objects, naming each of them in
> skiplist, rather than covering the class, is better because you want
> *new* instances of the same breakage", I'd imagine the latter would be

s/breakage/& caught/; obviously, otherwise what I typed does not
make much sense.  Sorry about the premature <SEND>.

> more helpful.
>
> In any case, let's see if there are more input to this topic and
> then wrap it up in v3 ;-)
>
> Thanks.
