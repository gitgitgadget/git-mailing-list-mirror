Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7D932027C
	for <e@80x24.org>; Sat,  3 Jun 2017 00:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbdFCA0G (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 20:26:06 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33095 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFCA0F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 20:26:05 -0400
Received: by mail-pf0-f170.google.com with SMTP id 83so779907pfr.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 17:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=C4+CSWUVIYUwwILM2TtbMRsh/5pqWqSGfGecwDnC4Fs=;
        b=fZPmSG6UF5Sgt0JBzpuMOaZZ7qnJDjxVdFiFux9K2D2D4tjuijs+dPOnru4xaCeOrH
         u0JbHZdQR9TrlfqGWUPTo/YFGp8/jt/W+NRdxjSKfNdouf9TRJ7pfAonrldkfdo2VRbS
         gTScLmOJ7SexgcaVGNf0sk3TSesXyCUAmYroxLaKRNilgzecylp8cFAFiPjTxNwHeqAQ
         C85MP7I69FVaD0VgP3TRgFz5lPiDPNQ4Gy8YbWlbTEtWouRClSZdmecXvLGIJCN8Goyc
         H2MAsl+fqtcmZufAulBiRr0hO2nzKcrZ3Si+yL/906xwtT5Pe16SQIwJp2pzN6mcH8OO
         QFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=C4+CSWUVIYUwwILM2TtbMRsh/5pqWqSGfGecwDnC4Fs=;
        b=LcWcYrK90m8bNZgC8sICS9G/7T8m2hTHgLt9/7xPgO9wHd0PcUe9rKb9QyGBMWzQ7y
         fL4UL7cX8xuaIVGrmtWrZo02QMZG5+mOMso3zg3LU7m9pfvpEPsH7tKYzu/kylWD6+2d
         JiQZ+z696oDIqD+rSk8hUMVW11I+S4QpIPu9Y+CZbJgxTun14JEpmm5ODFfCSjcK/GHo
         qkcEA2AdqM8hTZNWBm3RHq6m00PH6MdE9+gDUYbAUoHErwEcCQ9ftVUXILT5VxJgH3tY
         QbgNT9ngTCALfEpszFO/XxG4gp1/QNa1/NIsk4DzvJ6mU6ELjwasvMg0V6/StthyfTXA
         unDA==
X-Gm-Message-State: AODbwcAplYQruMypmg9hLh1yUDOSuVp4ULd8Kq6yc4RG+pCcbtFoxYq+
        F6NRGx3d76Hd6w==
X-Received: by 10.98.58.83 with SMTP id h80mr9422628pfa.50.1496449564665;
        Fri, 02 Jun 2017 17:26:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:49ac:b4b9:21bb:8989])
        by smtp.gmail.com with ESMTPSA id y5sm36034658pgb.4.2017.06.02.17.26.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 17:26:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <dturner@twosigma.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: preserve untracked cache, was Re: What's cooking in git.git (Jun 2017, #01; Thu, 1)
References: <xmqqshjk5ezb.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1706012052480.3610@virtualbox>
        <CAJZjrdVS5e5udjLtZoZcTEUg8WGFPuaG+MB_enPJ9poti3LktQ@mail.gmail.com>
        <xmqqfufj47oz.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1706021211300.171564@virtualbox>
Date:   Sat, 03 Jun 2017 09:26:03 +0900
In-Reply-To: <alpine.DEB.2.21.1.1706021211300.171564@virtualbox> (Johannes
        Schindelin's message of "Fri, 2 Jun 2017 12:11:53 +0200 (CEST)")
Message-ID: <xmqqvaodx6g4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 2 Jun 2017, Junio C Hamano wrote:
>
>> Samuel Lijin <sxlijin@gmail.com> writes:
>> 
>> >> What is holding this topic up? Anything Ben or I can do to move this
>> >> closer to `next` or even `master`?
>> >
>> > It's in `next` right now (3196d093d6).
>> 
>> Thanks for pinging and checking ;-)  
>> 
>> I think the topic was merged to 'next' on the 23rd of last month and
>> graduated to 'master' in the past few days, together with other
>> topics.
>
> Okay. I never saw any "Will merge to" message, so I got worried.

Well, I cannot quite help if you are not reading them ;-)

Issue #06 of May marked it to be merged to 'next':
https://public-inbox.org/git/<xmqqo9ulo1yn.fsf@gitster.mtv.corp.google.com>

Issue #07 of May marked it for 'master':
https://public-inbox.org/git/<xmqqwp98j8q2.fsf@gitster.mtv.corp.google.com>

Issue #08 of May kept it (i.e. no issues discovered in the
meantime):
https://public-inbox.org/git/<xmqq1sr889lb.fsf@gitster.mtv.corp.google.com>

Issue #01 of June reports it in 'master':
https://public-inbox.org/git/<xmqqshjk5ezb.fsf@gitster.mtv.corp.google.com>


