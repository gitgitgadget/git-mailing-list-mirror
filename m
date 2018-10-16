Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F87F1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 04:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeJPMjB (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 08:39:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42450 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeJPMjA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 08:39:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id g15-v6so23748384wru.9
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 21:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qJJfUgahlli97u6WJN0sJRH328wue3//eUKRRGC/0oc=;
        b=WlMuBZnEHb0lm51hSUDVRrV3q0406uH8cDNcS8eZX1b8n0mcZkigU6YDM96JHL01dI
         dpuW4iXrfbbI0eAmZXedA/hJT8lcbjW/XlZDPIU4HaDeNPNZxTi966jeKfy0a7y0D/UO
         4aV5wFt8DAAfQTmpDhwdv3Pw1HyMwgibFWtbZtBCpmTyFChOgzauHktKJtwc3+zI+kLQ
         6SsAhMk2uEBCaCX1VjaCY4lXHysJF0TJ0lVrsSCT143h+N0DC+t7HzrZvvt8kqg0zqkf
         qYw5ZdoaVNRWLsA05P4jeovyXOExB7EDBesf27sBm81QvQr2ybSeVD8EPJMZyudg5KeK
         +Uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qJJfUgahlli97u6WJN0sJRH328wue3//eUKRRGC/0oc=;
        b=LyYWSYxk3zKHGMMA/iAYUA/x8OF0WjP9Lgx55c3GlhnlXkna5cF5UxmrpCEOwE8tus
         i0ZbMAJtBUKcBYd38N3jPs1vtbdLGlMTkYyzkV9qOA6YlfSQJzm+t4IUdta2xQyr0SSU
         5UG2ROxxUC1vKtz2RNr6HZqk2Kc46AFv3WmpFgng/YPtI75KZLI57AGdjVm11+L/yj+n
         uYKx0OTvNiANO2cTGWMhwFv1b6BS6hgDrUI12LV3Y9zY26xPw2xswMLHz4/NG169M39k
         wEzL5PnWnLiAah7auLkQ0NFGs8GBngIw06L202tiVU6V8FbuElWgchTTeouR/iub02Qg
         n4GA==
X-Gm-Message-State: ABuFfois3oS8qo3kT0AqpDdiI4qpJYkJDqiaBBmAdJrN6wUPgcGSDWpg
        o9sWfZ8Xw5DoLCbEwrFN9EQ=
X-Google-Smtp-Source: ACcGV63uac31zEJ2kCn4BRo4w0z5W+ww60Uhe1+Y6eSAFARI016T990mXthtA0hUyEPLiYnBRD98ww==
X-Received: by 2002:adf:9206:: with SMTP id 6-v6mr17258684wrj.275.1539665426788;
        Mon, 15 Oct 2018 21:50:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z185-v6sm18662116wmz.47.2018.10.15.21.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 21:50:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>
Subject: Re: [PATCH 0/9] Offer to run CI/PR builds in Visual Studio Team Services
References: <pull.31.git.gitgitgadget@gmail.com>
        <8736t7dzan.fsf@evledraar.gmail.com>
        <CACsJy8DeA0Zko4+ZM5F2L6YO5rpvL9LX3H9NB_bVCyO2mJFUzg@mail.gmail.com>
        <CAP8UFD3cpXpyx-AtTybPirzduFR7TfhFf2woa-_CU46DN3RaXw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1810152032140.4546@tvgsbejvaqbjf.bet>
Date:   Tue, 16 Oct 2018 13:50:25 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810152032140.4546@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Mon, 15 Oct 2018 20:33:20 +0200
        (DST)")
Message-ID: <xmqqd0sa1omm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> AFAIR Junio does not push to github.com/git/git, it is an automatic
> mirror.
>
> GitLab could easily do the same.

It used to be in the early days but these days git/git and
gitster/git are updated in a same for loop that pushes to various
destinations.  You are correct that GitLab or any other hosting
sites could do the same polling and mirroring.  I am just too lazy
to open a new account at yet another hosting site to add that for
loop, but I may choose to when I am absolutely bored and nothing
else to do ;-).

