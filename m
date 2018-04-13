Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4923D1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 21:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeDMV6M (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 17:58:12 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:44739 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbeDMV56 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 17:57:58 -0400
Received: by mail-wr0-f175.google.com with SMTP id u46so11513729wrc.11
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 14:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hi/DuUlQCz9kaxty0Mz2PN7GIzN3ZwLAp/IRYhA+rwM=;
        b=SGL2Qgn+/DMriKeUrOwi1f2c2FVrDKlT4yBlBlhf83SU++cLpjBkSelCIZ0o1CW2OM
         tTz1729k0gIwDki05KZyTkXgw3P8c9egCSWfSQLMRBFvEjEp38vlNw80nRw1MDK+Om5V
         1gpg2QrMn/CusZzpxzwciN0axESkq00CLNnXt8Myx79UIxrEv5uv4f2Y3j/AotzHZCeH
         dR7C0m01oS9eYHChIBeNjxrg6f7SxHBPzgvzpVwG0PzmQdG6cDD592wkjvgKHCXzqdUn
         jWV05fyu/BKIra2bE9l4DQm93rJ5i5nfdG3U8EPXSNLr648qy6nOYEjFRTlQjeci9zQQ
         8Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=hi/DuUlQCz9kaxty0Mz2PN7GIzN3ZwLAp/IRYhA+rwM=;
        b=oBu3XgZrvBbavrLsv6eYpTVf1AAx6baqOmUw6FrmH5gcrMYqrcd1t7BsSROMantt5m
         5yOR/Cr5f/dYDc6LLMlEApqWl9upLZLNAtumC/O8XPkA3kZG4R6O4IYmqUtVeqyH0EMH
         16m4ntw8L67xmvtI8jGMsanK+UKZCiN/Ez+AIFMhzDH8A0Ak1AA+HMW1hUYXPCPOuBu+
         YYgm6NHkzGF86Ysl/8z9vqW1sYKWq5CBUjsDYsjyEHF2OiqvYtmjl6JMVaY1utUUFEyt
         GCgifkdrkdu3zorOia4o7sRX8ERdA1c3pz8IMkkbPXV9UgfBOdjtLmh9bSPqHxFUeEWB
         lWZQ==
X-Gm-Message-State: ALQs6tC/CrFYXoNCroGDO+Qjb/JkFTi82gVWocObeMrURqiIohNsjtZ6
        1HsfbuS2KvW5dfr+YWcgXIxX1YlB
X-Google-Smtp-Source: AIpwx4/SuILzT49BYyI5qYnZwH8wr/Nvz2da6NBt5YyCUynQlz6UOnYQfSdrJuDIgUaZhnMMRP8TjQ==
X-Received: by 10.223.134.13 with SMTP id 13mr4488597wrv.219.1523656676839;
        Fri, 13 Apr 2018 14:57:56 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abrf152.neoplus.adsl.tpnet.pl. [83.8.99.152])
        by smtp.gmail.com with ESMTPSA id p187sm2448399wme.8.2018.04.13.14.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Apr 2018 14:57:55 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: File versioning based on shallow Git repositories?
References: <hbf.20180412fvfi@bombur.uio.no>
        <87d0z4b6ti.fsf@evledraar.gmail.com>
        <4af21bcd-7a68-50df-4cce-0b050ccaeb90@usit.uio.no>
        <86efjjmqsi.fsf@gmail.com>
        <nycvar.QRO.7.76.6.1804131157360.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Fri, 13 Apr 2018 23:57:52 +0200
In-Reply-To: <nycvar.QRO.7.76.6.1804131157360.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Fri, 13 Apr 2018 13:12:34 +0200
        (DST)")
Message-ID: <861sfin50f.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> On Fri, 13 Apr 2018, Jakub Narebski wrote:
>> Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no> writes:
>>=20
>>> Also maybe it'll be worthwhile to generate .git/info/grafts in a local
>>> clone of the repo to get back easily visible history.  No grafts in
>>> the original repo, grafts mess things up.
>>=20
>> Just a reminder: modern Git has "git replace", a modern and safe
>> alternative to the grafts file.
>
> Right!
>
> Maybe it is time to start deprecating grafts? They *do* cause problems,
> such as weird "missing objects" problems when trying to fetch into, or
> push from, a repository with grafts. These problems are not shared by the
> `git replace` method.

Also you can propagate "git replace" info with clone / fetch / push.

> I just sent out a patch to add a deprecation warning.

Thank you for this.

--=20
Jakub Nar=C4=99bski
