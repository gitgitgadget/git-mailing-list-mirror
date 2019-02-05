Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088F31F453
	for <e@80x24.org>; Tue,  5 Feb 2019 17:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfBERxc (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 12:53:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34985 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbfBERxc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 12:53:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id z18so3887507wrh.2
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dYKQGjpo+kzUNjO1h7d+aDBWCVf4jERTAsIzZUnEDbY=;
        b=l8cgCPCDqUTLj2Hi2TB373XpI/mypSSaRx/ghASeEI9KtteWEgSF7cmPCjahEhxzf+
         tuGeg7ccDIpNFUPpI2s8zCBM6LLONbWK+X9Z7l64UOidG1G1CjpHld4VKLK+1QfXlht9
         on2Dsmoe1iF7/shiXuXWkgEjEyCV0Tqo2M/1VwdvU+NcJ3848QuFn2rL8Pl62qg+bIqs
         zsQLWTxdKXAJQrUWC42A6ntFpQwH2mlSfRS4TH9e7Gi0w05fA3JXmWY4nygcuubFyZb/
         d70DvxBSlZhpFpZqp/0Hx55np8shlTFtclmwuSl7Pg9qQvW6suZRPc5YZiQPSOyn8qVX
         jMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=dYKQGjpo+kzUNjO1h7d+aDBWCVf4jERTAsIzZUnEDbY=;
        b=hwtimaZun/gj/i6xbkJu/9xzITjmuJzC2pRQ4s1AteelkzWENpj3dX5Ru9XA0Gs97A
         yD5XdJcabOz+0jI0P3b355qnI9SDS8D7JRn2TBn9fZ8JNmwfx6PUU26d27MxXAJEZONl
         QjSamm3UbIaZ81myUbZjp65avy3nF60DMiNIsm9WquCKemRnIqAJcT7Jn0QmCaMTbZkp
         huU+pKVAOWUFnA7ZUq58K758Za7QTuKMwZVRT9fLZwlkReLi+x0sm1oJm/iJGjZ8rGg1
         27qx7Jw01AUhIAq6d7D8cM+tCpD4njPfUa5x81LslNwoKE+vw9C2geNxJh1VOqCIacV0
         G6Kg==
X-Gm-Message-State: AHQUAuaMP0E6wMUMY81s/gWV9owl+jzm83wE4v+IwUMSj5gpqSlFEnPI
        GceRgAnb6ICgM8Fr8XMETKw=
X-Google-Smtp-Source: AHgI3IZaynJDwRxqGw7H4js05Lux6pFRe1IdkRFYXBgxt1eR1SxLK7aZVRbTRXwyH5SjNVQAeTbKYw==
X-Received: by 2002:a5d:6b8b:: with SMTP id n11mr4499850wrx.216.1549389210286;
        Tue, 05 Feb 2019 09:53:30 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m21sm13504431wmi.43.2019.02.05.09.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 09:53:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: make the OSX build jobs' 'brew update' more quiet
References: <20190202163421.19686-1-szeder.dev@gmail.com>
        <xmqqk1ifv296.fsf@gitster-ct.c.googlers.com>
        <20190204193823.GA4511@szeder.dev>
        <nycvar.QRO.7.76.6.1902051240080.41@tvgsbejvaqbjf.bet>
Date:   Tue, 05 Feb 2019 09:53:29 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1902051240080.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 5 Feb 2019 12:41:11 +0100 (STD)")
Message-ID: <xmqq4l9it946.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 4 Feb 2019, SZEDER Gábor wrote:
>
>> Under Dscho's bugreport it looks like they already merged a one-liner
>> fix, but how long will it take to tickle down to Travis CI, I have no
>> idea.
>
> Since the fix affected a Homebrew package, it was not so much about
> trickling down to Travis, but about trickling down into the public
> Homebrew repositories. And it seems that that trickling is complete now.

Good news.  Thanks both for reporting and monitoring.

I still think the >/dev/null thing is a good idea, so unless I hear
otherwise, let's merge it down to 'next', etc.
