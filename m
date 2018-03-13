Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 946E01F404
	for <e@80x24.org>; Tue, 13 Mar 2018 18:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbeCMSky (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 14:40:54 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37313 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbeCMSkw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 14:40:52 -0400
Received: by mail-wr0-f194.google.com with SMTP id z12so1769573wrg.4
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 11:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Lbdz/dcAln02qFyG3MmeyY2fOd+a0LVMCSTC7zq1caU=;
        b=jFJLg1xA7VzTuw4JrSpP9WvmIOczVeeazd4T21Ic1MGbAjbpRLVsmjlK7Nn1uBPqWa
         sECafLyMJjubETteHTHxweghI3FzJJ7tQ6fwN5uJR0SgxEKxyB5GA8s/gUCNzxN81+K/
         W+BM9PNx6vMiOI0wXj4NW1DfD58DjVYMRBxAuwH3VFlUFYO7Ji6rf6Ocaf+UhgCzi+Qw
         8OXTCTFBYafpBbDG7fh64tG2mbkbSkVP6CN9qSznVmeipf/lvpk4+o5crhLpPCP5pp/+
         S8XrO8oG1+uqBeYlyel+B6yvkKGQVaUP2zNvymhDHmyn3aHBvf2LAroGnv5SP2Gip2hy
         T1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Lbdz/dcAln02qFyG3MmeyY2fOd+a0LVMCSTC7zq1caU=;
        b=NK/M4tr9LJmpZmOwJpTyYrDwJK2wEODWSgSV4yLMpRW2fulNKXKolYmhXCdaCEZSFD
         kQkp2cjoEhFTFIvryj59Y6tZgyPTvVWF78HDE3RKlsY+MlVwmCD2+GzbRwkDNYgWVA5O
         MrBd3FyzElxLGfBnX/ofLYzLQ2PTDSpXbpgEhnZVmoukRNFyg358h02KQ8Ghhbwfm7fo
         yx3DrUTe3zXvNnYjGCzGaOqr/vT5XX9Wi9zibwHzuckpZJyivOtWwfMOqp9Ky0PBV3Qt
         t02o4FGqoGuR8R8v/VP8AnHuuGyVYOIgVaX2OCH1gHJwnc25Ol3KPC1zLjYxA0RaBKyW
         heig==
X-Gm-Message-State: AElRT7Hd5i+P72PwA9DT3caFJv0cICutHT9csEji/40o5uGs0DvAFLiQ
        WlmCxt8Gc/T3HXsmFDhckF4=
X-Google-Smtp-Source: AG47ELtRNR/rlNORmqI6rJNaBknRAoPKLTzxhc6qThC2fcIGLTFybzRZ5s9Lh5K9EobX8+RPbLobmA==
X-Received: by 10.28.87.75 with SMTP id l72mr1590130wmb.48.1520966450491;
        Tue, 13 Mar 2018 11:40:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l14sm1135495wrh.62.2018.03.13.11.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 11:40:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alexandre Julliard <julliard@winehq.org>,
        Dorab Patel <dorabpatel@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH v2] git{,-blame}.el: remove old bitrotting Emacs code
References: <xmqq7eqmxysm.fsf@gitster-ct.c.googlers.com>
        <20180310123058.31211-1-avarab@gmail.com>
        <CAN0heSp9UMd=t2ssCa7Ln2Gtm2b=EKzyQbDEJGG4Lm5YboF8xg@mail.gmail.com>
Date:   Tue, 13 Mar 2018 11:40:49 -0700
In-Reply-To: <CAN0heSp9UMd=t2ssCa7Ln2Gtm2b=EKzyQbDEJGG4Lm5YboF8xg@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sat, 10 Mar 2018 17:50:25
 +0100")
Message-ID: <xmqqbmfr3jke.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

>> +Emacs's own support for Git got better than what was offered by these
>> +modules, or was superseded by popular 3rd-party Git modes such as
>> +Magit.
>
> This somehow reads like "Emacs's own support ... was superseded ...".
> Maybe that's what you mean, but i'm not sure. Perhaps s/, was superseded
> by/. There are also/.

I think "There are also" is way better.  If we really want to sy
superseded, perhaps "The features these modules offered were
superseded by Emacs's own support in VC mode, and popular
third-party Git modes e.g. Magit" is what we can say.

