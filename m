Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B1E11F453
	for <e@80x24.org>; Fri, 19 Oct 2018 01:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeJSJ1s (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 05:27:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46786 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSJ1s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 05:27:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id n11-v6so35561752wru.13
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 18:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FremTYRFmtfe9SDyw7x9ZXQUo0kSgcbAFYOTXPQ+PtE=;
        b=UNmxvGEgWgHZxfdY5KKU12tI9kypxbku6T48oWhdQNKffpZJeYr1sSuK/DAMoPTnKl
         Q/YK2IhnvEJ2OU2jZy6eqm2uOn5AX+/2hZNEarQ2ym+UIdhlJXCDZ27l6b2LjJPPrbRV
         ulKxe4CzjQ2qFtgi4mWcnpR9fjzw5qTois9SA+ELigpI20TtG590Dh2MIUPRESkv/ONL
         /QApO5qzyt5MlA29wLjfln5SfcR1mDcjIUjRjse+pWknZEZIAxegVWiIUGLRfkO5T24X
         wHoY3L57zYOiso4zFwcQ6JuW2tjRytTrMQ9AOhVM4p2quCCog1YdeRXwnnQB0pPsKMkR
         mazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FremTYRFmtfe9SDyw7x9ZXQUo0kSgcbAFYOTXPQ+PtE=;
        b=fxp04KcHeNeiJbmJCTvtHPgEkn3yDVc6LiVAoOtVJRzHM/EUqHHMJS6caoGT58Ltg4
         ZOJZVlNJQTdopw6pGDnA6/XPnB6vKsb7uz/sXxMFbcHRFJhpN4lNH7hhOhS+jYZ5Wrfm
         aZg3rqb9wlq/uzUUIh8WU6Qn1QNdKsk89OK9sBl9HeAAFMgLa0X+X9CU3Ut6MSV03rEY
         iYg8sbMskaDNP5lOdq5wdUHAIR61vbW2n0qXBB3fzzpwGD121uI0ejxAxidG7+7kwlFl
         4cGbz1pGtFgDj5xzdRw4gpyT6a09HVk9Bq1Lrp1aVgZ/FrA50x0VM9aHSEKwX7/rDtc2
         VFGA==
X-Gm-Message-State: ABuFfoicqkwW4rM4b0vNr77X1FUi5yBA52B7rTMz+hSQUHKG2fkF7y3F
        0Vqm2FVQoXTNHEHYmXvRQJc=
X-Google-Smtp-Source: ACcGV608D2QMw/Z/fE07qtoBSqnoBU7i4/Q3yISYEvyyQoULwjVxL5fBou6VF0r7yuik1PpX5oAA7Q==
X-Received: by 2002:a5d:4706:: with SMTP id y6-v6mr30037598wrq.256.1539912241697;
        Thu, 18 Oct 2018 18:24:01 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e142-v6sm4647949wmf.20.2018.10.18.18.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 18:24:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH] config.mak.dev: enable -Wunused-function
References: <20181018070522.GA29499@sigill.intra.peff.net>
        <3295c759-473b-f279-5443-f915fd0b1061@ramsayjones.plus.com>
Date:   Fri, 19 Oct 2018 10:23:59 +0900
In-Reply-To: <3295c759-473b-f279-5443-f915fd0b1061@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 18 Oct 2018 18:01:44 +0100")
Message-ID: <xmqqftx24tlc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> I haven't looked too deeply, but this seems to be caused by
> Junio's commit 42c89ea70a ("SQUASH??? - convert the other user of
> string-list as db", 2018-10-17) which removes a call to the
> add_existing() function - the subject of the warning.

That is very understandable and it is immediately obvious to me that
the unused-function warning is being useful there ;-)
