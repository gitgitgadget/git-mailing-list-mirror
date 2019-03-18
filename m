Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AAD420248
	for <e@80x24.org>; Mon, 18 Mar 2019 12:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfCRMNi (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 08:13:38 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52136 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfCRMNh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 08:13:37 -0400
Received: by mail-it1-f193.google.com with SMTP id e24so20071658itl.1
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 05:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BD8/MGAmF81RHQSfqaY7cx+6hi5shIRyX5wyVnEtH1A=;
        b=R2j1sMj1qEdZspzDfWBh19Wt5wLNI9qn7qvCzalaDUbKI440gmqtC6j2shgvoB2b0a
         o5PO9qD3HNkH5uM1u9bVo31vEBPtE1Ibkrp7jXw81Bl/xgCDEROs6LilRKw4m/6GoWr2
         iL4H+q41jQHFCfnG5NSlN2yamnjTlYjnZGnlsqpStEvQJrUt2xFKeNxWuAJZ1VH7JvpJ
         00AcqEHVabB761n9yqHJRq3sdlyJZd2R2a+CA5q11lmashsWC2wR+rNW4AUreb5Ni22T
         BtQcvxUMElnMb2/sNQVTpCefKj1XkOfOjBze1MVABBs7wzK32OmNHT9+dTcfzkwlHykS
         1Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BD8/MGAmF81RHQSfqaY7cx+6hi5shIRyX5wyVnEtH1A=;
        b=NdFrwvGyIvhEmUF1KOoDMlnqawoi8j+q/OHMvtJXhkWvJ+tVziM2pM8JrfAu3I4eM9
         GGC8RiCai7ZTgfaC83k9x/UNWsOHNP7AKZEyQN/LXEk4kw0l1M3TOkGNPd9zDeYIP2HV
         hLJDvFTn2WwUL8ur2ePifIVLka6j6EwHlw20DPxEuG1ldsUqp2Tdaeit/FqOngWrHcEl
         VO+1WoqJnxcbhawXwIRTe0iyUeW4U9aJjieE64q6/gxk/R7gv90zNZP2Lz/tkfw6pNca
         Yqy8jT2ukkdH0TgZR667cQ4Xh+ZjvgEL/H8bIBYD75QKfBtfbH+89v31hC7h6rTuIMz+
         sYlw==
X-Gm-Message-State: APjAAAVRQHKgT9HhsxntZfaZc/xlz1K/HI2gMLq+cZsGhg+Iax5JfJfF
        Il/kNWe4T+bzetCaqbT5Bd8WfbnYH6T983SQFhc=
X-Google-Smtp-Source: APXvYqyQ9tg9vFrxoGmvez8pp0pVnJ6MB7hmQO+2oEnCNq5objD68QohSuhSoXKLqzjLTMDq1uMjETyjm6SbDHN/TRo=
X-Received: by 2002:a02:241d:: with SMTP id f29mr10423190jaa.30.1552911217022;
 Mon, 18 Mar 2019 05:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190308095752.8574-1-pclouds@gmail.com> <20190317124926.17137-1-pclouds@gmail.com>
 <CACsJy8BevFGXt-RL_1G263ntXYee69N055TY8_GQL1unvJNPnw@mail.gmail.com> <xmqq4l806avp.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l806avp.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 18 Mar 2019 19:13:11 +0700
Message-ID: <CACsJy8B+VmwygpxWQ9Ug=L8bQXDVX7h6MjJwVU1cR2sbuHo6qQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/26] Add new command 'switch'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 11:54 AM Junio C Hamano <gitster@pobox.com> wrote:
> I often find "git reset --hard <some other starting point>" after a

It still bugs me that I need to use this to abort some in-progress
operation. There's "git X --abort" but I would need to find out what X
is first. I would like "git abort" or something (and "git continue")
but haven't really thought that through yet. That direction may also
lead to "git undo" which is another can of worms.

> failed "git checkout -b new <starting point> && git am -s3c", so I'd
> be opposed to a change to refuse a "reset --hard" during the middle
> of such a stateful operation, but I do not think of a reason why I
> would want to "switch" in the middle.
-- 
Duy
