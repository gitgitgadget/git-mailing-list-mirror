Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78B21F424
	for <e@80x24.org>; Tue, 24 Apr 2018 06:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756168AbeDXGOD (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 02:14:03 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33683 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755595AbeDXGOA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 02:14:00 -0400
Received: by mail-wr0-f194.google.com with SMTP id z73-v6so47232160wrb.0
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 23:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/w7bE+yME6heJ3UXgrqUtSeeOakDOWWC+9lzMB4I4pc=;
        b=Yjf7vXKrM52EoGPzxjnpS7GDHysOXRV+bVwk2jxtC58f+/fPLg0LwLDnffV6hQ3gcA
         zUccawEgUbJeU1ZhZ3fn1wyvefKxefcOVl1JOFjEls7eAbzP0A0a+GHBJfJiMsmbJTTf
         TNNSmJ9Q7k7zLa5qeYNWsb3Y3crfMG+cZHZm4Q89qJbgkT49niGAigox9dkxQfEKXCdz
         Cr5siqJ1N4gumBS5g4FHIv7z1yggjR8GE2LdVqiG4MlvDWBXO14XQJOlHwYSOo92o4sM
         VcGMyBiHK0hXCcpNf+SpJm6mMyWJmXaLMSMNEtrdTIKOfT8squ/7jDZzkUyLLzl6OO1O
         Eaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/w7bE+yME6heJ3UXgrqUtSeeOakDOWWC+9lzMB4I4pc=;
        b=IcD5yQ74Q7Rzp/Agyq8dcCvk/7QISsY/JUNszgI/xYjXhltIZK+GMGMwXe/HCg/bmu
         arC2me3pXay3M3rThYTS73Gw+zDlsvezpaNJ6vhV1VI0Y+/nxto868fFWZyl50hCRMpU
         u80LCpyBNvDZBDmX9PRYtTYv0Byxo0dYxfXvm7CCjMI9XX0kj66XPyytWEX1oagxl6dl
         ds7RrNXb4r7zX6I92FusaBecaaDkAXuErUh/5OlrrquGXfO3n42yYWIWeZe8/dRkar64
         xBwSZ1hq9Jx/e5jiEEoyDBWfbjOZjozfBfOJzouo3id9gNBp677qGBJN+y7FGkER4BJ1
         CKEQ==
X-Gm-Message-State: ALQs6tCz58ycbv2DVj5H1ZDXlX3CMOX5o9xEpJJ/6KG/7L7P9bnv5iwR
        SVrzBFUFtZrhbAQ9NDOCUG0=
X-Google-Smtp-Source: AIpwx49Pp22Q+hLbEGH45NyRw3TPusIOvLSq70yN9OlPXr4SDQifFPFHtFGPnErte1J0tQfphs1h4Q==
X-Received: by 2002:adf:959a:: with SMTP id p26-v6mr19887094wrp.211.1524550438687;
        Mon, 23 Apr 2018 23:13:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q188sm13722088wmb.37.2018.04.23.23.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 23:13:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>, Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 2/6] grep.c: take column number as argument to show_line()
References: <20180421034530.GB24606@syl.local>
        <cover.1524429778.git.me@ttaylorr.com>
        <5aaf7bebb27d385ea090cb83e97c596983ebae47.1524429778.git.me@ttaylorr.com>
        <CAPig+cQ2+wTTXE0mhnGnp2pZug=Po0SCVwCO_2agxUDaOsFRLw@mail.gmail.com>
        <20180423011726.GD78148@syl.local>
        <874lk2e4he.fsf@evledraar.gmail.com>
Date:   Tue, 24 Apr 2018 15:13:55 +0900
In-Reply-To: <874lk2e4he.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 23 Apr 2018 10:01:17 +0200")
Message-ID: <xmqqtvs15dy4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I think when we add features to git-grep we should be as close to GNU
> grep as possible (e.g. not add this -m alias meaning something different
> as in your v1), but if GNU grep doesn't have something go with the trend
> of other grep tools, as noted at
> https://beyondgrep.com/feature-comparison/ (and I found another one that
> has this: https://github.com/beyondgrep/website/pull/83), so there's
> already 3 prominent grep tools that call this just --column.
>
> I think we should just go with that.

OK.  If they called it --column-number, that might have been more in
line with GNU grep's --line-number, but that is not something we can
dictate retroactively anyway, so --column to match them would be
better than trying to be consistent and ending up with being
different from everybody else.

> Also, as a bonus question, since you're poking at this column code
> anyway, interested in implementing -o (--only-matching)? That would be
> super-useful (see
> https://public-inbox.org/git/87in9ucsbb.fsf@evledraar.gmail.com/) :)

Sounds good ;-).

