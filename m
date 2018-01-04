Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892551F404
	for <e@80x24.org>; Thu,  4 Jan 2018 17:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeADRUU (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 12:20:20 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:46168 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeADRUT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 12:20:19 -0500
Received: by mail-wr0-f178.google.com with SMTP id g17so2134214wrd.13
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 09:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jSOoSAQ2pzARo+HIN7XfCfXD5wiUDxyChEV5Q8n5y1Y=;
        b=CtN3N8xzpDzh+MkkIDAgforwvyFQUgnrlPD+AxA69pc25ipJDruCzWBs8thT852cYz
         Bn92NaLxmvXgwlSkRWF9E8F9JhQhkmjHgqVVjLYVGKLy1Vd0dOf7qaCWPDERnrf3tBox
         usYOZBCkc306uBRJH0SFH0kyFHliiUx7KmKJLNe97q9hgUgM2mCB3zIg+zH6W8TiQDMu
         Zoju/Uq4WHJBTlSQ8+nF+7MqrJvG7YkrLg9ISqkN3RPup47Mhxz0yeaDkueD/DYqiUPh
         IZysgXL2EG63SbkLwnS/lq6ATGN0FvEowStxckSfjEA7NpPppHwM52RDqPj9yca5z4za
         yIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jSOoSAQ2pzARo+HIN7XfCfXD5wiUDxyChEV5Q8n5y1Y=;
        b=RZlMwgE6nxoj9p2RGEcUJJhUJmJkvvASIzMzUoVQoTtbzBTaplKkncoRMz8s5GTe08
         Bn+NN0Uhk85dbstylE2kvhcymws+bZVBCbwmRUnDUtAIBf2+4HFgCLGnfHbPCvee4u6n
         zNa0snESN0ws1d6bqRXHZTadm5HpxPB2xFh3YWdwI0dvgrzRnUINw2ikynFPFfEwddAq
         Un8ffzYavRnsSXaDROJmHUc/lxiSAms2Mdj1bC2t7dwdlEeq3IJQZGnH5gggrCJ3XHeY
         HHOQHNXahthyg0CzoLctQMHi0SZAn6OWw/cs5mmnJm15Gwy7lZmctlWMPkgBxnbGZI9T
         7Yiw==
X-Gm-Message-State: AKGB3mLto4E97RzWA7gR7/TqTjh6OJ6i3kvDgY2q3BQUHIGI1nlK1kMY
        2LljWjDkvO7zHvKsVDvG4No=
X-Google-Smtp-Source: ACJfBotlHUoAWPZCXb7ZwQcNZf7JyLgi92/RYznPEoxUGqAi3jajCrt98ebjDpOB2v9rTFxzzbaJMw==
X-Received: by 10.223.144.1 with SMTP id h1mr265060wrh.147.1515086418107;
        Thu, 04 Jan 2018 09:20:18 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id y137sm4367193wme.0.2018.01.04.09.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 09:20:16 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Segev Finer <segev208@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] connect: add GIT_SSH_{SEND,RECEIVE}{,_COMMAND} env variables
References: <20180103102840.27897-1-avarab@gmail.com> <xmqq373mh62r.fsf@gitster.mtv.corp.google.com> <87bmiacwoz.fsf@evledraar.gmail.com> <20180104044230.GA12113@sigill.intra.peff.net> <87a7xuc4ty.fsf@evledraar.gmail.com> <20180104155325.GA18376@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20180104155325.GA18376@sigill.intra.peff.net>
Date:   Thu, 04 Jan 2018 18:20:14 +0100
Message-ID: <87608hczht.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 04 2018, Jeff King jotted:

> On Thu, Jan 04, 2018 at 11:10:17AM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> That's badly explained, sorry, when I say "push" I mean "push and/or
>> pull".
>>
>> I don't know about Github, but on Gitlab when you provision a deploy key
>> and associate it with a repo it must be *globally* rw or ro, there's no
>> way to on a per-repo basis say it should be rw ro.
>>
>> I have a job that's fetching a bunch of repos to review code in them
>> (for auditing purposes). It then commits the results of that review to
>> other git repos.
>>
>> Thus I want to have a ro key to all those reviewed repos, but rw keys to
>> the audit repo itself (and it'll also pull with the rw key).
>
> OK, that part makes sense to me.
>
> But I'm not sure how your patch solves it. When you "git fetch" on the
> audit repo, wouldn't your GIT_SSH_RECEIVE_COMMAND kick in and use the
> wrong key? What am I missing?

I add both the ro and rw key to some projects. Those are a tiny subset
of the overall number.
