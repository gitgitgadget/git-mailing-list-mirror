Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63BC81F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 15:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeKLBak (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 20:30:40 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54344 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbeKLBaj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 20:30:39 -0500
Received: by mail-it1-f195.google.com with SMTP id a205-v6so3740981itd.4
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 07:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=InKv2vHF8MExezH0U1qFx6djyxCv7CSE56sNfPqpOZM=;
        b=bn0Dwb1WuFWSW7ODlP6fB/BwsF0wJ8RgcchROtgr/gjIHeVQUFcqaFFTGHp4EdA16B
         WkuXtO5jngyu5ObZDSGQF8AiCiKCrXIZRRvwh49UoUeduw4anjSAuKptlebmaIBNUaHQ
         XUS5vIQ99EQuSipYv9VRCsXfXnBs+/0nf9v0eQqY/Bqhzrunoeo4h0ijmwnjPU0qKvBC
         WVwM5X+1y58kk0fnWQWDPMQcA82IoNmluWBtDAvECG1yppK2kQkWOooKN0JE7eFRaQUl
         M854sk6MGuKrX8/5g/dhLcvDskIrTOYTWxORWuIYHn0WtxsYEiKGvd8igCspGEvK6dY0
         xRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=InKv2vHF8MExezH0U1qFx6djyxCv7CSE56sNfPqpOZM=;
        b=t+iGUp8K5JIYSBa8qGBuKz8Mq70bQCRnnBjfNB11YI3OzoWb5SknqDNzBXBx+YVxwo
         annD5gMxfDn9aCaIJLhWY3pollkszTPcLg5LFllo6zJwoFukoEQY1WQnTl8XSuGx5ywg
         9A303NSRkr8+DnNDPiACWRlLpiHaz3IhsKDedIMFaBH//fr6DyKY1ZdL61heOlX5Jkap
         dX2T4hQHuHGQgsDs2Q3qAFMzce0fbwEj1eKKZzN+mBeyRjw81PeXK586OKk9zhXCaK43
         XzjDmiHp/5nenc8DbOCSFAYiTiHPYdyplEw1k1sj0p7+RzTi1f5XCf8nt87cWjmHEc4l
         kriA==
X-Gm-Message-State: AGRZ1gJP3tutcXQlZx1uBw10jP/PUIfw/XKuIRvWphWaRGatkQKnU749
        sjafHNSMwdCYiYg0tCabyg1OyNxhVRUd7VOY6MA=
X-Google-Smtp-Source: AJdET5eoTSKfRZWwC7g1m7q1oNBKQ4PP5KRUMsMw+jsGGPeAszX7TBS37ZwvNCP5SdsiCs976bgcXxh1Q5/Ta4KbVsk=
X-Received: by 2002:a24:ac5c:: with SMTP id m28-v6mr8800732iti.123.1541950907102;
 Sun, 11 Nov 2018 07:41:47 -0800 (PST)
MIME-Version: 1.0
References: <875zxa6xzp.fsf@evledraar.gmail.com> <20181111095254.30473-1-pclouds@gmail.com>
 <871s7r4wuv.fsf@evledraar.gmail.com>
In-Reply-To: <871s7r4wuv.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 11 Nov 2018 16:41:19 +0100
Message-ID: <CACsJy8CYpuc7-CZhk7kQQVQFxOfLFZu4TVpG=b0a7j8P1J394Q@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        per.lundberg@hibox.tv, Junio C Hamano <gitster@pobox.com>,
        git@matthieu-moy.fr, Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 1:33 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> The users who need protection against git deleting their files the most
> are exactly the sort of users who aren't expert-level enough to
> understand the nuances of how the semantics of .gitignore and "precious"
> are going to interact before git eats their data.
>
> This is pretty apparent from the bug reports we're getting about
> this. None of them are:
>
>     "Hey, I 100% understood .gitignore semantics including this one part
>     of the docs where you say you'll do this, but just forgot one day
>     and deleted my work. Can we get some more safety?"
>
> But rather (with some hyperbole for effect):
>
>     "ZOMG git deleted my file! Is this a bug??"
>
> So I think we should have the inverse of this "precious"
> attribute". Just a change to the docs to say that .gitignore doesn't
> imply these eager deletion semantics on tree unpacking anymore, and if
> users want it back they can define a "garbage" attribute
> (s/precious/garbage/).
>
> That will lose no data, and in the very rare cases where a checkout of
> tracked files would overwrite an ignored pattern, we can just error out
> (as we do with the "Ok to overwrite" branch removed) and tell the user
> to delete the files to proceed.

There's also the other side of the coin. If this refuse to overwrite
triggers too often, it can become an annoyance. So far I've seen two
reports of accident overwriting which make me think turning precious
to trashable may be too extreme. Plus ignored files are trashable by
default (or at least by design so far), adding trashable attribute
changes how we handle ignored files quite significantly.
--=20
Duy
