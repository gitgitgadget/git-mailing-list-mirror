Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D9631F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeCORdZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:33:25 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45721 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeCORdW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:33:22 -0400
Received: by mail-wr0-f194.google.com with SMTP id h2so9088827wre.12
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6Yk51T+UaOHGWF/3Ggu0GbYIe5wTSt4HqG0YVzQKAHk=;
        b=tncHXetCjd5X6a1UqOB9LZbp6+ab8lFrM8Nb8E2zYy8SR82MJghP0ZOkSZYxy/Z+Rk
         FzNeVaxdX/YNsxid8Gr7gthRpUaPUnRjrJCWJxqrdz7UJJYYMNO0fpCviBd12JWpbMJa
         2DJrt3UGdLUDdfPolwh34/4AaQ1oa3lRs9x7bRcaOWrusRZSFT5y0cJ8Elxp40nbk3oU
         BAGgaN9ymf8xfWko/PnPsIsS/EujdKUfD83vtKQEtQkxWd7MEcHsOMoK+RHlTFhGa59i
         VfEoMXExF4274fBuVbZ9q1nx44WYs/g2oImOiqbG/r14Mw454QQNUbj5mB9mgLHhIzLK
         EDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6Yk51T+UaOHGWF/3Ggu0GbYIe5wTSt4HqG0YVzQKAHk=;
        b=FiM3geIWno+gNhlKRPZj3rDHuZ3dv41M3DQxM9oU4n39S6CSq6JbW6Pv7QIlgdXnaU
         QCvjZHEjYEk0H6y/iMmxsYiSIwRI6HElavA0zowrn1a4h5hjyXV1qEeX1ChYUEwYVOtQ
         pnGPXKH6FxsFNXnMGOU9R+lPX9Cwf9wcPwKooNvBfENVJ4iysjXoDohryKgmPuBdGouh
         l5QQoWg3Z4XDqh8EXPqb7kzFhiYyCQmFnYOlTHFi16ahdyYThDPFJ2o1u3L5NHBayS6R
         uzAU+OuaU4QrAjkHbE1d7O2AtUP0TUf4oBxaiA9qeODkti5EAi3YhzOK1uPqFcNlTii7
         c9HA==
X-Gm-Message-State: AElRT7HO2mp282aHfTA6xhVVwVw0JtfSHUy1IgzpQHu86svFUplNSeUK
        QLle9mpskWtmn+qV9zsGKLk=
X-Google-Smtp-Source: AG47ELtBnIGoULozy6e9w20OUoD04Wk2ZaPN1QwuSLe0SWjdZ1PKYQVwC2EfqoK47zhM2pXV4NUD2g==
X-Received: by 10.223.183.37 with SMTP id l37mr4440801wre.265.1521135200380;
        Thu, 15 Mar 2018 10:33:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r14sm5688069wre.35.2018.03.15.10.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 10:33:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Takuto Ikuta <tikuta@chromium.org>, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: What's cooking in git.git (Mar 2018, #03; Wed, 14)
References: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
        <87r2olenw9.fsf@evledraar.gmail.com>
Date:   Thu, 15 Mar 2018 10:33:19 -0700
In-Reply-To: <87r2olenw9.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 15 Mar 2018 09:36:22 +0100")
Message-ID: <xmqqk1ud5jmo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Given 2.17-rc1 next Tuesday according to your calendar, what's the
> status of these two landing in 2.17?

A rule of thumb for an average topic with just a handful of commits
is to stay in 'next' for about a week before graduating.  A larger
topic with wider implications to the codebase may want to be a few
weeks in 'next' (or stay there since before -rc0 and during the
feature freeze to the final), while a more trivially correct ones
may be there only overnight.

I tend to think that the perl-fixes topic is something we'd rather
want to push packgers to try sooner rather than later; there aren't
room for "bugs" that affects program execution, but the impact is
more to the installation procedure people have around our build
procedure.

I do not have a firm opinion on pcre v1 vs v2; the patches are only
about flipping the default and not robbing any capabilities from the
packagers and the users, so I do not see any need to be unusually
careful to merge it down (compared to other topics).
