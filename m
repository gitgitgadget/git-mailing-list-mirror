Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F6051F404
	for <e@80x24.org>; Tue, 13 Mar 2018 21:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbeCMVqs (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 17:46:48 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:37778 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeCMVqr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 17:46:47 -0400
Received: by mail-wr0-f170.google.com with SMTP id z12so2446408wrg.4
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BwBt6b2GTZRiZ8YC5DQVReQcs1gWS0QfGptOdFYVAdE=;
        b=FxAJSyvdMujsL/5sDFvQb5/tlGJPG0xo3qglc0AZjHsLoKOYjg1FIohLDMs8KPjbuq
         IjmqEQMpCHw54IsVH2NEqC9l/f/QPn2KagZVztrbf0ON+9Ez8rMOGjE//1Imbdb+w85A
         il8CiHzgJZcC1txSZtfT7ISgQiGUNPE/slxqHm6vT8tJyrGTuoifmEaKd5dJY06CTBmm
         0m/fLrdJMUHquOO0H1ELvE6Iy9Q/I4cGKLvkRDkYEK6VBOawNohJShaNSnTeXejOgAea
         zcYnd8L8+HTJwOSFlW2GYRjnhTtpVSFQfgg/82zWic0f/2eXuKC2EEP6RSNejBJFDXNq
         LnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=BwBt6b2GTZRiZ8YC5DQVReQcs1gWS0QfGptOdFYVAdE=;
        b=OKrlkMibCJmzyq3Oa7TMcIC5Ss0qOb/OiZd6a3Pz7OiqdmILVIN/4hbmCAZFCS7N32
         xCzwCO0SFhVV0Yf/1Ij69yR1LTdu/T/IuBbpp9f8x+znYSqn+1dabdrbPpy7gx4af6j+
         ycytJzCtOF+aLr7NqHzcinI8vzs+hWVvj42EUWdu41xNL5ORi31ss2tRuvnVEzV5VQNv
         ur7yKfLimHuNgfZGP5HC4u9ee4zcudJh4/RnyK4uZRmV2sBJhxxwq0VhaAqs9Azeanyg
         I67ijD6meLohuQAsPYs1B18QLfkLJwYHSA0B2661pRZNmi/OnVJlB5S3Xceq+F4IcPIO
         TJxg==
X-Gm-Message-State: AElRT7F4z6uYTbBSbzl6UsNGiaQ11ozoJsM23aOQKWft39r2JhNtjq+B
        iEt5yJEW6aJtDUjlM6A8800=
X-Google-Smtp-Source: AG47ELvBc34IPWev/c1ts4T/tSSWgWeey10aAaa5UwJw8Ll18ZdNrnkmE4b4E0hYstvaSFApPgPXAQ==
X-Received: by 10.223.153.230 with SMTP id y93mr1750999wrb.215.1520977605860;
        Tue, 13 Mar 2018 14:46:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x17sm1366645wrg.32.2018.03.13.14.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 14:46:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] shortlog: do not accept revisions when run outside repo
References: <cover.1520680894.git.martin.agren@gmail.com>
        <78669e644b64fc10c34adb59717d2039f81cb092.1520680894.git.martin.agren@gmail.com>
Date:   Tue, 13 Mar 2018 14:46:44 -0700
In-Reply-To: <78669e644b64fc10c34adb59717d2039f81cb092.1520680894.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sat, 10 Mar 2018 12:52:12
 +0100")
Message-ID: <xmqqo9jr1we3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> in order to decide whether we should read from stdin. (So yes, after
> this patch, we will still silently ignore stdin for confused usage such
> as `git log v2.15.0.. | git shortlog v2.16.0..`. But at least that does
> not crash.)

    $ git log -p | git shortlog Documentation/

is also a nonsense request.  When outside a repository, i.e.

    $ git -C $path_to_repo | git shortlog Documentation/

is not giving any revisions, so the error message should not say "no
revisions can be given"---a nitpicky bug reporter would say "I gave
no revisions, why are you complaining to me?"

