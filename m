Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2C701F404
	for <e@80x24.org>; Sun, 16 Sep 2018 15:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeIPUca (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 16:32:30 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33950 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbeIPUca (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 16:32:30 -0400
Received: by mail-wr1-f54.google.com with SMTP id g33-v6so14826526wrd.1
        for <git@vger.kernel.org>; Sun, 16 Sep 2018 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DJRLIbR44YVSZAJhK/HqPI1BxA6+hR0koUGV9LIv0zs=;
        b=TCFyHuKIdPbdJ6oVm2TOmVd3/7pUPqlnmtkumXivFlXLsK5HEcpUy1tCQ+nGR3zl3G
         MAmzXnXCfMqRCmORa05HeQ/UY8fw4aQQzGrupAcJfEATFwo8OjVPdG3ymAN+FCSFYxyZ
         k5S8DuMTKRmLNvztd132euKCPhSwipbORf/m7hSIxI63BMinoBoi0ZwbZYmh+3R/jFWE
         LTPPoNJ5pH1fGT7FlUrHCwYR5fJ//u0v1Nl4RftHvd7mFwj7jRLW1249Bloa6G68a57u
         tJXT8GrevH82TGZ5/2njNvEK8Q3qfQL9443Aqf3X+nq+rHHYPzCTY/WtoEDRVX/Kqfzw
         QiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DJRLIbR44YVSZAJhK/HqPI1BxA6+hR0koUGV9LIv0zs=;
        b=iHlDMGOqVwMofg/w7urumLJEQU1jdSJ/GsCSlo2ez4xvHF1aJ9nElzr9dSBYanHs7e
         dwgLMGt96uzA/sHiWeO13/NC490+QIUlmFabOVfPW54e8ibvYxD421gDw1MQaOfyCIhq
         Xm8DzUERfGiftlEpxwg4ZVWUet2PzlfJeZqX/LlnOmvkQU4QbITUekahLcz2MHBvlq/D
         +mij237N18p7m0U1PmQ0GaPQmoT0MNtyOwGod8hmRWNAc+djJQpJGIPeayEQl34vk+6a
         +7IJBUPmJ0frv5FO30KFTQmZ2dKsou1JYcNtctVXwyVGkUQ9MFvUwhr7stzIKJyxzmie
         2I+g==
X-Gm-Message-State: APzg51CXtAKjahwduGL/+ElEb5lu7La5PumCvbO4ZZ2fDBv1vZC9QBqv
        uik+2YL1BMoVry8H1/eRUnY=
X-Google-Smtp-Source: ANB0VdYRTeZljn+BDcBKjSSyMW2AVTy6FyhhzcvtupW/ZQf5VOm35P5ooRhYDkE5ezqAUwFhV/FQ7g==
X-Received: by 2002:adf:b202:: with SMTP id u2-v6mr14658467wra.19.1537110553637;
        Sun, 16 Sep 2018 08:09:13 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id x65-v6sm4354127wmg.39.2018.09.16.08.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 08:09:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2018, #03; Fri, 14)
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
        <CACsJy8DXT8rF_WYE3C0ak7E8_8j=kRS+Yhi1pZjKd5Rr4OsM_A@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8DXT8rF_WYE3C0ak7E8_8j=kRS+Yhi1pZjKd5Rr4OsM_A@mail.gmail.com>
Date:   Sun, 16 Sep 2018 17:09:10 +0200
Message-ID: <877ejllbs9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 16 2018, Duy Nguyen wrote:

> On Fri, Sep 14, 2018 at 11:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * jn/gc-auto (2018-07-17) 3 commits
>>  - gc: do not return error for prior errors in daemonized mode
>>  - gc: exit with status 128 on failure
>>  - gc: improve handling of errors reading gc.log
>>
>>  "gc --auto" ended up calling exit(-1) upon error, which has been
>>  corrected to use exit(1).  Also the error reporting behaviour when
>>  daemonized has been updated to exit with zero status when stopping
>>  due to a previously discovered error (which implies there is no
>>  point running gc to improve the situation); we used to exit with
>>  failure in such a case.
>>
>>  What's the donness of this one?
>>  cf. <20180717201348.GD26218@sigill.intra.peff.net>
>
> This topic has stayed in 'pu' for a long time. I thought it was
> concluded that this was a good change? Jeff, Jonathan?

There's still outstanding feedback on it, including my:
https://public-inbox.org/git/878t69dgvx.fsf@evledraar.gmail.com/

I think it would be great to merge [12]/3 down, and have a re-submission
of 3/3 stand-alone, once that's merged down, so we can untangle
obviously correct bugfixes ([12]/3) with meaningful changes in exit code
behavior (3/3).
