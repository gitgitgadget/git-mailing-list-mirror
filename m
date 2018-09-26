Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670801F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeI0Aay (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:30:54 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:44022 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeI0Aay (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:30:54 -0400
Received: by mail-wr1-f52.google.com with SMTP id z14-v6so10487537wrs.10
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Cr3IrLq6wjtGo/7N4q6S2GZmOzDqSobtL8iRNChmTsU=;
        b=PDNa9Getid0HuuIkSvl7cqblrL0NyEMV6PnKGda7oXiMw0jVnKYI9gbi34Dyu/OEsG
         ve69XQ/nGznX0CyBOpi1gpcFYv3djVNEGyWQq5Tbg6Ji+aFF+qYrCptUeGymnx/uA1FQ
         Bn8DVo7lyddYah4o/+sgK8RcRvN2OWyaUUOO3l2HNPTFNQg/fGcM7jHTEHe4eAp9ptMu
         JinGDn8xPHrWtIT7orptwrrSVvw9PkFPDh1u1Ld4mQy1zNYwpxgMP3hBHMvZ7t70hXle
         JUVHALsLeaJI5pIgxhTYnUFqV0I9HWggCVKhV9XtAZFX3K/XQ+bvSyM8bub7yuAn47+v
         /RDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Cr3IrLq6wjtGo/7N4q6S2GZmOzDqSobtL8iRNChmTsU=;
        b=Y2bPhO9i88WYzt9MyRNxMbmV5uFyAjLesM6rQ9SINXBW8YuVqOnjUbI9IrbNBCD+4J
         BSQHgbojZ4ItV4eNJbmx4rbINyKQ2xJ5DloJFiIw3RD/7+VGHjfAM1tF6EcDXSesj13V
         H59zQTi4tSKkte6aQ3mYZy7Hyz/cvK7Oz9542b6tI9E7NAvY6aOFyrZaKLM6WTHkdkjj
         3nuaoNTCEUCEiF86PW/ZBI6z2hRqykJweSKQ5OoTgZMYYBe0igDrgkeo9BI5lxOd0jrm
         l1DmswDGoZRu04ZUDsyXAs/Vek3bYyVmU6EGfy3cetQFl6ljW/hKNj7707Gmy/sPpmuX
         X/WA==
X-Gm-Message-State: ABuFfoiZimgwDzyhi6Mk1Me+Kq3K+RQOswsIhjMRL362n259NIBLjseX
        PyhJwOAqajo1/ysCgVsl4bc=
X-Google-Smtp-Source: ACcGV63fIbOp7B5Xwmue3oR9EW83mRbzCTdF3IvzJ2MDEgYOCwoEUO6ACDileSsK8ISyssvY2CD12w==
X-Received: by 2002:adf:fa4e:: with SMTP id y14-v6mr198666wrr.155.1537985796927;
        Wed, 26 Sep 2018 11:16:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 75-v6sm128910wml.21.2018.09.26.11.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 11:16:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Alexander Pyhalov <apyhalov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: t7005-editor.sh failure
References: <CALOYryFX4PPR+=1L+sjEqPsdmNh_+vNxGf0wwuAgoYzau=GShw@mail.gmail.com>
        <CAN0heSrhaaP0ds8K92g9w5DAnbwuq8mM6WLKrTQ7e_a8Fku9KA@mail.gmail.com>
        <CALOYryEMB5HoCXbVKnc49KLkk2ySZjn4DG9RbJjQAvPn1H5K6Q@mail.gmail.com>
        <CAN0heSpUhzbTjceVhBxk_jjE=vOAVTzXGFQ=UL9Y+muJHe0S6w@mail.gmail.com>
        <20180926121107.GH27036@localhost>
Date:   Wed, 26 Sep 2018 11:16:35 -0700
In-Reply-To: <20180926121107.GH27036@localhost> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Wed, 26 Sep 2018 14:11:07 +0200")
Message-ID: <xmqqlg7oktto.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Having said all that, I didn't omit the quotes in 4362da078e with the
> above in mind; in fact I tend to use quotes even when they are
> unnecessary (e.g. in variable assignments: var="$1"), because unquoted
> variables and command substitutions freak me out before I can think
> through whether its safe to omit the quotes or not :)

I quote >"$file" (but not var=$var) because the CodingGuidelines
tells me to:

 - Redirection operators should be written with space before, but no
   space after them.  In other words, write 'echo test >"$file"'
   instead of 'echo test> $file' or 'echo test > $file'.  Note that
   even though it is not required by POSIX to double-quote the
   redirection target in a variable (as shown above), our code does so
   because some versions of bash issue a warning without the quotes.

;-)

> Sidenote: this test should use the write_script helper to create this
> editor script.

Good suggestion.
