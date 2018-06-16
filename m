Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF21F1F517
	for <e@80x24.org>; Sat, 16 Jun 2018 08:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932385AbeFPIWr (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 04:22:47 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43069 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932188AbeFPIWp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 04:22:45 -0400
Received: by mail-wr0-f195.google.com with SMTP id d2-v6so11953931wrm.10
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 01:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xWeYXGhs3ot6nOAiC9XUExSZSqgFU3BUDOCoqPE3bZc=;
        b=J1NjDFuOhwRLEwWi2zDOhewXTtjJGMGxNfcDekWB2TgFip00K0NA/vLvKuJEE39Y8L
         zbgolfU5vJ64MkqR0yfkJYfqfAQ7mBiKJJ1IGim0rod13X4efYlK6il9vijAtWkJKSGh
         vRdOW73u0Nk+L4zSiw9YYZxgOl+DWekNjwjssB8b7sMf0hBN6D/c/v9aEdBP8p2HA6cS
         qA7C0yYxOSyIp4PvVAeVxV1gjSfHYJK+KxDQN9EsYYb1u4DoDzwLHM219VUtivNsi8F8
         dj3ZIjeMmeT8ENYyefnTBWU6WvJrka3T6MqM2/KYKo1U1prNNRSYFPEQP1P4MxxzoGj7
         /6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xWeYXGhs3ot6nOAiC9XUExSZSqgFU3BUDOCoqPE3bZc=;
        b=NBxt6EdGc7PolJYIi3o3HwIWxfL/mZXuX80oZVdOugAGw/EBSIFVwGjcbE+nX0hzYN
         5ocwAJRvXu4ucZDuugU7ZFb8qU051i24AhRyn0/+btFUdnYPZp71PSdk4Cn941w/jFIP
         UAbTBtrxALjnW2vSSR5GRnQEyil5Q3v2FMnoabscAYMBKQ3xD/0FtHJv76Dy7myYNYK7
         yW35nKroeRZjoRuQu4PQZr2QUHGftmfc6Jpqc7RE7C2Ey5xOVML4i3zP7C8ghXO1nGHr
         zprWu/CByHUrWUbwTsAbsWutuM6RYf/L9CAAKjQdseyzlSLaRLZqixSuSnI4yoHZKzz8
         arCQ==
X-Gm-Message-State: APt69E3EpagCZl3/QQWuzkukmmj2IHrlOLXKWrG66zCUYInEPaxNzQIT
        MjZiKpkYhBMOK4AuRe/FHkN5EqXxnu2ehu6TV8U=
X-Google-Smtp-Source: ADUXVKImJxFoyBS0gaD7iER7f+YwbT6IClh0XN+ft1QQFsArL07R3t7Uxt7j3Oy/dd75Kn6P1AxM8GaM0fgmE7dIr5w=
X-Received: by 2002:adf:e644:: with SMTP id b4-v6mr4492873wrn.254.1529137364421;
 Sat, 16 Jun 2018 01:22:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:eed9:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 01:22:43
 -0700 (PDT)
In-Reply-To: <xmqqh8m3zurz.fsf@gitster-ct.c.googlers.com>
References: <20180615044251.10597-1-max@max630.net> <xmqqh8m3zurz.fsf@gitster-ct.c.googlers.com>
From:   Max Kirillov <max@max630.net>
Date:   Sat, 16 Jun 2018 11:22:43 +0300
X-Google-Sender-Auth: WBBHksyCoCaRvTDvum_t22e5b9M
Message-ID: <CAF7_NFR8dKZtbRr+p_HGECdZhyqSWAsMuZ2JthXefGyFL+57zA@mail.gmail.com>
Subject: Re: [PATCH] unpack-trees: do not fail reset because of unmerged
 skipped entry
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I do not know offhand if "reset --merge" should force succeeding in
such a case, but I agree that it is criminal to stop "reset --hard"
with "not uptodate", as the whole point of "hard reset" is to get
rid of the 'not up-to-date' modification.

I originally had a fix just for "reset --hard". It was in
verify_uptodate_1(), to move check for "->reset" earlier. But then I
found that "merge --abort" does not use "reset --hard", but rather
--merge, so I fixed that. Because --merge should work also, shouldn't
it?

Actually, I think that fix in verify_uptodate_1() was right, I just
did not find what it affects, after the other fix
