Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A3D200B9
	for <e@80x24.org>; Mon,  7 May 2018 01:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeEGBpP (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 21:45:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42492 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbeEGBpO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 21:45:14 -0400
Received: by mail-wr0-f194.google.com with SMTP id v5-v6so26755436wrf.9
        for <git@vger.kernel.org>; Sun, 06 May 2018 18:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=frVLtlQzplBy70Hqg6mwvbA9d7TDyoYo5hKGamZTTCg=;
        b=F7/cHvcTFm3lgO8f+5GzikEEUP1Mucqd1v/PonkrCgJVsajuxNjImgugNQbKIZMlPz
         IGFqhAGE62icP6Sec27JIp9mN07HINWlZ5Q1LmlXxkTFzPQ8zGLv7CuIpqgUf0HSdjze
         VliFnQJf8hH7wbx3tZnYpB8Uq3hY5uDgIjEILktwwYeNatarBCkWu2u8MqvGw+4gzbwD
         XdGriQNPRnRcApGea1cyxCCCYoxQqGeBbqFqQBYp6C0geolsf26w72WVOcYSjS86ve2i
         vdPa6fGKtStb4AhnfuMT7u574thDEtC1ZtWHB8QggUuwhFDYjVmtwk/QeINPstNEySVN
         AjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=frVLtlQzplBy70Hqg6mwvbA9d7TDyoYo5hKGamZTTCg=;
        b=mo4Q4F4tqz7AFb2g2/vwQv5zHmS1CiXKCjjyGNeNGDtsnahTOGfuaWagMV0J+c4LeX
         L6E8CNlJQ5sx6X7EEeOlAIGu9EwKj5Nq3keY8cc07cI+rxXPLwg6rQOb/EcATOzKqWCt
         Eiwrlh+DqHE3BUCg2bklkI+Mb+kKp/PdqgK79Jwgp/OEXFK9zdfXzqHKJqbINMIFnT7i
         As9pM9uvcqyxqGJUMmilWhVarOYJMj74ZbzmgNOZ+34VZMnliO/HX8b6Jx0MmdDgLY3N
         QIYrtQgnkLy84Ar+V3RAFqm87pssB5cpr51NqbOCo2MwEKUAaNTc6EiAJ7SxHXS8/g1X
         5+JQ==
X-Gm-Message-State: ALQs6tAklGhx8Iw9cdkZvGN86HoD1PsX5z2ahUFe6J//yKYWXy37ryNX
        2OsmMFEyEQHdK8vCPGAMbZJDmayl
X-Google-Smtp-Source: AB8JxZp/8aPa7Fmqn1QBR9cPVZyGQE8SRAi7pDINRiU/IK0VlRgr06JrQGqfHX0v33z+qobbBq8QNA==
X-Received: by 2002:adf:b2f5:: with SMTP id g108-v6mr29743672wrd.147.1525657513273;
        Sun, 06 May 2018 18:45:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 76-v6sm14274920wmj.0.2018.05.06.18.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 May 2018 18:45:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
        <cover.1525448066.git.johannes.schindelin@gmx.de>
        <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
        <20180505182631.GC17700@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
        <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet>
Date:   Mon, 07 May 2018 10:45:11 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 6 May 2018 14:21:54 +0200 (DST)")
Message-ID: <xmqqr2moqlw8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> If tbdiff were "Thomas's branch diff", I would call this jbdiff ;-)
>> but I think the 't' in there stands for "topic", not "Thomas's".
>> 
>> How about "git topic-diff"?
>
> Or `git topic-branch-diff`?

Yeah something along that line, which is about comparing each step
in two iterations of a single topic.  It would be wonderful if it
also supported a short-hand

	$ git tbdiff --reflog 1.day.ago js/branch-diff

that turned into:

	$ git tbdiff js/branch-diff..js/branch-diff@{1.day.ago} \
			js/branch-diff@{1.day.ago}..js/branch-diff

That compares "what was on the topic a day ago" with "what is new on
the topic since that time", which is exactly what an individual
contributor wants when reviewing how the topic was polished, I would
say.


[Footnote]

A variant I often use when accepting a rerolled series is

	$ git checkout js/branch-diff
	$ git checkout master...
	$ git am ./+js-branch-diff-v2
	$ git tbdiff ..@{-1} @{-1}..

so this is not only for individual contributors but also helps
integrators.
