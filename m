Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6316220248
	for <e@80x24.org>; Sat,  6 Apr 2019 19:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDFTow (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 15:44:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43022 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfDFTow (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 15:44:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id t22so3304014edw.10
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=tQEmH1cxCnGEg2mCe78qJwH/LglBYXkllzVoXYYfGPA=;
        b=Xz7ePktlYa9NyFlIXM2C41LLrnuh5GSnBYvblnxxjrBAAs7MD7U63VqYhOCe4oZMdv
         uOZgWrGIWjfCRC0/vrz5Dir4fQnFhf+q9E87JmkiwK6R0qOMgJwr82RByHFXiYVgpy6A
         JTVYKds79iJNbw5Dy6i+zoColDhQjk/v55olsCMuG5t2vIEF+Ez9oXD3DQ4cqSDGyIjD
         xYohMGL/q5FcQFqHloxidZmdMx3njS0+1TJMhKFb/fXnzUwksKZnRH04M7NSsOOSNPIz
         CY0eiL8ed8oy2lVRG8FY0HwIHNeOmx+dlxM5iNJ39fvLU84jp5IFik0sZaNhb5/wPwF6
         +yOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=tQEmH1cxCnGEg2mCe78qJwH/LglBYXkllzVoXYYfGPA=;
        b=YUsUa3JRZyPtHAarwmmesDMPq+Bx5Gi1rOIzWTmdDuEEUh5/HIkxTZYPHl13pxqJfn
         ARGe/0nRCLyRrw+9iWkP/ru/zAWuFKyrcIRy0XCduISSPXvuIoUcpsZDYrR8elgUXJlW
         MC+ZTLupQBZsa8pkEo+UcLj4i7F17gCwrO34TYTQQj96a4FZVskOLhc4HfE8QK/657TU
         5AMVEmf/v9hvyJeuLZOGmnJHp8WaZr06hsHQOKSxfS9XLJyI3LtUc9QL6+1YY/hqVLUY
         75aPUuXvbZWxAPP0c3ecE4dfZrA/RF6Sv2qW5DuW+oGxIb++eJtlLGO1vdTSCc+Oy39P
         dX5A==
X-Gm-Message-State: APjAAAUEf48iQjtHvV5iI6FhlPzJRo4p0BlhLrgOP3RQusA7RA+HywSt
        yc3/vyTRaGGjDXNk9bFzzgg=
X-Google-Smtp-Source: APXvYqwEqitO1inS9u4Gb+fozHM/V21D/n9wegI6Ex0sG5wN71+GnV3FoqIIvIAi92XTn9RbmR3pGQ==
X-Received: by 2002:a17:906:a2d2:: with SMTP id by18mr11409362ejb.202.1554579890699;
        Sat, 06 Apr 2019 12:44:50 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id b26sm4633921ejv.21.2019.04.06.12.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 12:44:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 0/4] rebase: teach rebase --keep-base
References: <20190328221745.GA3941@dev-l> <cover.1554151449.git.liu.denton@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <cover.1554151449.git.liu.denton@gmail.com>
Date:   Sat, 06 Apr 2019 21:44:49 +0200
Message-ID: <87ftquapfy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 01 2019, Denton Liu wrote:

> Thanks again for your feedback, =C3=86var! I think we're both on the same=
 page now.
> Hopefully I've addressed all of your high-level concerns with this patchs=
et and
> we can move into a discussion on implementation detail.

Late in replying to this, have been off-list. This also applies for your
v4.

The current version you have still doesn't explain the "Why would we
redundantly rebase every time in this case..." question I had in
https://public-inbox.org/git/87tvfma8yt.fsf@evledraar.gmail.com/

I *think* it's closer to "it was easier to implement this in terms of
--onto, which happens to behave that way now" than "it must work this
way for --keep-base", which is fair enough.

Although I see when I forward-port my POC patch from that E-Mail that
one test fails now, which is good, that wasn't the case before, but it
looks like that might be testing something else than just the lazy
behavior.

It would be good to know in terms of commit message or (better) explicit
tests so that if we teach these various rebase modes the same lazyness
--fork-point uses in the future it's clear if that's OK or not.
