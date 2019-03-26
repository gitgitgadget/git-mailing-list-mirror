Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6476B20248
	for <e@80x24.org>; Tue, 26 Mar 2019 03:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfCZDII (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 23:08:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36967 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfCZDII (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 23:08:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id v21so9434899edq.4
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 20:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nz4TpFaKsY8qiz/iis55cFQTgfkn5no+dfOQ+ojhcEY=;
        b=jkocAiaCdR5Y3f7GYM4fNA+AuqnYdlkJ4cpS9hehI7QYhFd/tdJjVnVbNUwKwBvlGV
         EMu5fJ8hPWt4KCEYHcJUvjVT4F1Tn0OuLQvkMR5y+ZAwXgQ0dx13L8dIPSSFYcM8em06
         InwiNKgxnspQLtv5wTcBTfDnywZb/23LKd8bIM+djzDV61DOibHoUsfklmIaWwMSxkyh
         YX7pJPdIvRQbwaQ2/t0Ei/pyGODKtZ2EqBhD/Yqpw34zvrWkqKXger+csvHpK3wljKUM
         aKmKmxIU8YTjsznfXrg9H9eMhgvicm/1FLwWnz1EBRi0n5J/nh4PgD4IdxP65l3ctL7p
         ZleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nz4TpFaKsY8qiz/iis55cFQTgfkn5no+dfOQ+ojhcEY=;
        b=Ab65sP4SkZG3Lzmlqh9ruwV6lX39WPrV2DNVMTyJYa76QXxtk2+MmnYr/9YqtgOsf1
         ZXy/pKIo4iShkSjWiJzYD/nKqf2ZlOUgucId7jaUhP5U558NtdVLuVRskTJ4AOA9i7Nm
         L45QN+n39iLS8XLREmCc5OEHyPcFuRKRu3wCJPtgAIsTVAfc8cLdofGV3r+AgMBjhSXm
         QqyFeIHLLm0YFtpxcqP+M/h99IK1E0j3OD2Zqn/FwXpouPxEW84x4/vPYxzyBLjJyiP7
         VwNYCU14SMjrbhQFiDJt/wkR9kNGbqgJukfo268y9mI0chtb378rZFIxPvX6LPZ7TWF8
         bNZQ==
X-Gm-Message-State: APjAAAXAH4hi1P9uR+sIQQ7n+QW4HkYQon+eEithl99HLKtAAoDofZJf
        RnxPwU5JRncs8NE45LTmll0Lk6V6+/VoRYI6LGLlGule
X-Google-Smtp-Source: APXvYqzfQ0IiY557SKYs0LpvrizNyTIcm+aoLUjyNEZlRLJfbTtC7z8tuziic/oMiBtWLV/ZT68WZJ+5++OFbBZ4zfA=
X-Received: by 2002:a17:906:3941:: with SMTP id g1mr672483eje.168.1553569686119;
 Mon, 25 Mar 2019 20:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190324235020.49706-1-michael@platin.gs> <xmqq5zs7oexn.fsf@gitster-ct.c.googlers.com>
 <CAJDYR9RWUmXzh9Pn3qGBXAxNf70-SMKUCB3wwXVYKRTKOy8F_g@mail.gmail.com>
 <b077afed-d143-506e-977e-6edf2492f75f@google.com> <CAJDYR9R77_+gfOgLXX_Az8iODNRyDTHAT8BAubZeptEWJViYqA@mail.gmail.com>
 <20190325233516.GB23728@sigill.intra.peff.net>
In-Reply-To: <20190325233516.GB23728@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 25 Mar 2019 20:07:53 -0700
Message-ID: <CA+P7+xo-AHmB+Wv0Z+dpgshhmqSLEb41T-JP+NKJD8DAFARA5w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Fuzzy blame
To:     Jeff King <peff@peff.net>
Cc:     Michael Platings <michael@platin.gs>,
        Barret Rhoden <brho@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 4:37 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Mar 25, 2019 at 11:21:19PM +0000, Michael Platings wrote:
>
> > > I work on a project that needs a major reformatting, and one thing
> > > delaying me was the lack of an ability to ignore commits during blame.
> >
> > I think we understand each other well then - I'm working on a plan to
> > change the variable naming rule in LLVM, and naturally other
> > developers aren't keen on making git blame less useful.
>
> This is sort of a tangent to the thread, but have you looked into tools
> that provide an interactive "re-blame from the parent" operation? I use
> tig for this.  Quite often my blame turns up on some boring line
> (whitespace fixing, minor tweaking of a function interface, etc), and
> then I want to keep digging on the "same" line, as counted by line count
> (but it's OK if it's off by one or two lines, since I'm looking at a
> blame of the whole file).
>

+1 for the usefulness of this approach. It really helps figure things
out in a way that doesn't require me to track all "uninteresting"
commits, and also works when I *am* trying to find that uninteresting
commit too.

> Obviously this isn't as automated as saying "ignore commit X, it's just
> variable renaming". But it also eliminates the need to a priori figure
> out all such X that affect the lines you care about. You get an answer,
> your human mind says "nope, that's not interesting", and you press a
> button to dig further.
>
> I think there's room for both solutions to co-exist, but just suggesting
> you to try out the one that's already been implemented if you haven't. ;)
>
> -Peff

That's also my sentiment.

Thanks,
Jake
