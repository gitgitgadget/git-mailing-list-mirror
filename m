Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F20FECAAD2
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 09:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbiHZJeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 05:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiHZJeX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 05:34:23 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB420F4F
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 02:34:21 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id d6so398925vko.7
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 02:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=yYQKbnXzWYWSD1ezpJVEeMLvZoF8Gob02VWcqqB1PAo=;
        b=Ua07EuZFU7rSRPwiwRn3G+i/MTwrIUiFO681xEPO3V9uewLfYFKF764WTORqjj/tTb
         +B3La6q53rqiegmwhzw9bCYCxP+Nh53ozOw+nGkQs2ct4uNpPLydT0ZzqGeqR1NpJBty
         fAN/rwh8DxGon9LeOykzmT5kYDIjw9FLdR5m1iuAJ93dUuDrLhi5difCcvHlI0l7KQfC
         6zoYAhYIKs/hn2dVrZbp4P3mVuZOmUZGnM3Qx0rxhbQKTaVhD2AzKcfK+y7QQj3rDQ8F
         yQIJFF7VS8nM85OKpBp3s1Nln90i1L70KNp3164+WS3kJPnGtj8Bm3auHg9R6fjCOJiy
         zUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=yYQKbnXzWYWSD1ezpJVEeMLvZoF8Gob02VWcqqB1PAo=;
        b=UZHGGA30HG8xU4WKet1oAj3UvQds8UUCqTsiyDJo2xC1vLxjJLRPZfqFLV1RcF43h6
         NONpklZTUNj+BKiglZ5XF4pBcmTQs5Lj9DpxmkIIac2gZEGuvlqxRVx+/xs76rWRTUGr
         xraONZWStbj2Ld84hwPTsI5wKwk41DpbXF15pkyyJulBVuThvx+4PQlqdn1E7D1h2WbW
         pHFuvGOVbEIqL/fDwtZhtgxFrKCHKQrjLNgm68gtUZOdEIZ73cs9SchLwbjZVE9KBrYn
         IhhcmemjIXFXGk1IiyUFYGpumsVAF5fwGosYnMiKXHZJNbMEklUaVdSZD7+6Rz8xi14I
         7YTw==
X-Gm-Message-State: ACgBeo13S2ap9cCcF1qhi3twAO3ecocmSrMVuWP8jyJ2Kg1byUluZUHy
        dD6uq4SYoStTpzihg6boijqPLduIjkvOX3bnDA4ClEIl49U=
X-Google-Smtp-Source: AA6agR48o0ujepaAmOpXX7+Y6VcWmyy/3If3/OByzuZGUkGFS9RHhL7cudA5ae4FefqDKej9HlQ1WVJXt+umVYyuR80=
X-Received: by 2002:a05:6122:2004:b0:38c:daf0:59 with SMTP id
 l4-20020a056122200400b0038cdaf00059mr2967620vkd.6.1661506460836; Fri, 26 Aug
 2022 02:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAH1-q0iPsnkypiF=2LRgXwNqE_+R0gj706FCKgqGEUum+OAhQg@mail.gmail.com>
 <87a67rjxb6.fsf@linux-m68k.org>
In-Reply-To: <87a67rjxb6.fsf@linux-m68k.org>
From:   Javier Mora <cousteaulecommandant@gmail.com>
Date:   Fri, 26 Aug 2022 11:34:09 +0200
Message-ID: <CAH1-q0j8a4q47UOBvUp0W0JgF+W7J+EQLLRhv9hx-dxdhqSYqA@mail.gmail.com>
Subject: Re: Potential problems with url.<base>.insteadOf
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El vie, 26 ago 2022 a las 9:09, Andreas Schwab
(<schwab@linux-m68k.org>) escribi=C3=B3:
>
> On Aug 26 2022, Javier Mora wrote:
>
> > Well, now I have a problem.  If I do:
> >
> > git config url.'http://example.com/'.insteadOf 'http://example.org/'
> > git config url.'http://example.com/'.insteadOf 'http://example.net/'
>
> git config --add url.'http://example.com/'.insteadOf 'http://example.net/=
'

Well, that was embarrassing...
My bad; I didn't know about the `--add` option (nor that gitconfig
supported multi-value options, for that matter, but that's on me for
not reading the whole manpage).
Maybe the manpage section on `insteadOf` should mention that it's a
multi-value option, but I see that this is not a bug as I thought it
was.  (If anything, a not-very-intuitive feature, but that's a
different matter.)

One minor issue I still see is the fact that adding the same insteadOf
key-value pair multiple times will result in the same line being added
multiple times unless you explicitly delete it first; there doesn't
seem to be an easy way to "add key-value pair if it doesn't exist
yet".  (The closest seems to be `--replace-all`, but that complicates
things a bit.)
