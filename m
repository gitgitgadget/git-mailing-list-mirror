Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E752F1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 08:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfDXIWF (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 04:22:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35990 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfDXIWE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 04:22:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so3699917wml.1
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 01:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=X8gC9TkwEb6S8sJWldtXIKgc5vQBAH9VnU5vs3gOxAY=;
        b=XRQ+HjsGv8iE8gojMJn6pz6pLqihEnhQPl0KFVfW599flbRnNx1TkL4sR8k290aetj
         mHqIThTUZAFRBkGOlsw1kCfnb27WQATutze/qo0GCKNSo7zf0AMQPS79AfqvcM6BYfGb
         TRIDsSk8qFqxjqicUWqXvCrxwENi+ROH2hRoTjr6Xuzo/KERBjbb26YwgXjDxth7wJ8C
         Rs3LMkhmed4gmDDAmQ8kI4a5hMtujL1d447lyGVcItvoFQIhGktk2wlp/HwUtZ+r4KNs
         d46cW5GzDaydOl1NUgtij35Qyxck4yeMA2eP0Za04qbank7iG1ufOQZ2bKnZr1sRPcc9
         qf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=X8gC9TkwEb6S8sJWldtXIKgc5vQBAH9VnU5vs3gOxAY=;
        b=Gdfeyhw2v21e84KjOMEnAJo4f4RZUd1FG3aHc2jTrGhVGYs0e8i92Dd88/kJ54mZHx
         qPwuSJwEu0tCHpxGKFFES2iTj1TjkGjG4oGg2FIH8xpvN8YBOLpymfiPkWKrYtDnhjHT
         sYKshf5CU7Ojbb7+Bsx/x0D/RQkpXp0Bs93m2ki04EvmSf0OzBN68ORv5dDXHEfSdrKy
         jKdhIBXxOHbemjfTQTIKDTAC3bquPCexlrN/5SvrREuvNSYyBaxiOjWXqi+8nr+N44Ys
         qk7F9AeyrrW4VYuJbSbYiRfm3HiVCKowlP5zxIkNkanxdIwWvvGJ8pTADnUNznOsuyHb
         QY5Q==
X-Gm-Message-State: APjAAAWq3pd3Ey/7Vu2UAfHBOzRmP/79FKar7KuTL6omv/jKaV7Fq+29
        +byqGNsby2VjkrlZZX6m6JQ=
X-Google-Smtp-Source: APXvYqyfaiT1ZsSgS7dNBNDQRynusSuMYCNLxx1eZfHKUQabw1wQ5EORq0fA6z81ohCNriJY6Ee+qw==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr5499019wmg.14.1556094123003;
        Wed, 24 Apr 2019 01:22:03 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id a6sm19194127wrp.49.2019.04.24.01.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 01:22:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Multiple hook support
References: <20190424004948.728326-1-sandals@crustytoothpaste.net> <20190424023438.GE98980@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190424023438.GE98980@google.com>
Date:   Wed, 24 Apr 2019 10:22:00 +0200
Message-ID: <87r29rsthz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 24 2019, Jonathan Nieder wrote:

> Hi,
>
> brian m. carlson wrote:
>
>> I've talked with some people about this approach, and they've indicated
>> they would prefer a configuration-based approach.
>
> I would, too, mostly because that reduces the problem of securing
> hooks to securing configuration.  See
> https://public-inbox.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/
> for more on this subject.

I hadn't noticed this E-Mail when I later wrote similar musings on the
subject:

https://public-inbox.org/git/87zi6eakkt.fsf@evledraar.gmail.com/
https://public-inbox.org/git/874lkq11ug.fsf@evledraar.gmail.com/

I.e. what I wanted out of it was an in-repository .gitconfig instead of
inspecting some some random repo with a .git/config.

But the problem to be solved is the same: The ability to carefully poke
a config file with a stick at a distance, and carefully whitelist which
parts of it (if any) you want to trust.
