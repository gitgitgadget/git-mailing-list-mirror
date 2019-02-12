Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4DBD1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 17:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfBLR4p (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 12:56:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39836 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfBLR4p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 12:56:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so3717791wra.6
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 09:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=u7TT0HYosA0MIXpyERuaBDg+QDpcon2FBqs/no5NdzI=;
        b=YEt47lUcImeNdNcQROtvcsHQAQ6FHsjGYXIEuvL3RaGbxZTp9q1pUD4UYLCFOPRan8
         wAp6O/xC/op9m/QYJ1HPM9qziosU80uRqtwJCJK+eiLR0A6PcuuxW13A60QSrQDCVfkv
         Pvz1fIxe2GXj0XhaVjZEL8KmI6BRjuJtBD7fwDjnLTaH5Wz+sAN2zIcOsxQyEhaRx2ZR
         Dbpq4EDxZwoE47+whfr3NWU2FW3rMbNTXJ3aKPawPtCcdr9jjBOouSVHkbl+4fEoYZlV
         VNM4sx1dtSum+cZctgSdp/4cN+lPllhBbl+rtDQlZ72e/LGSvZZBP8+Mri+K3zsavHdA
         4hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=u7TT0HYosA0MIXpyERuaBDg+QDpcon2FBqs/no5NdzI=;
        b=cig8k3zOfsdOjsRzzZH0Fc6uWWwnyMb1iQQD1YFrgudoFbicM0BITqI6Q/G77qm0Db
         7c99wkHeLDpN4g9Qqh2Gnp5CfbTGvEgLLEegnC+XWsbvwgD7/PUUCYgcZgE8Ljbp9Kv6
         cH57B1AwtDmzHqh2wbQbGe/9Ow9zPqphI9cCFUZspgcDzlt2QkSDnhtC/b3mREb3XomP
         2mpOIewXphi+d1yc8JHtHKz7yTogjMYkjmJb35aL1kQJrxmX0pEsSmzQchwqkYncB0j8
         gV7gSHbgEW24/WGfygBLb1YQ0KniIeyTbzOsloN0UOe6yOZyaNHgkQ8B7aLGuTKKgXbg
         zhYw==
X-Gm-Message-State: AHQUAubKqtQHLTLKLWwWWnXMyRJzvjNq+LC91qCmCwJf4g8xLlXBvdk+
        +qcZywdqDieATfnQa7SarBA=
X-Google-Smtp-Source: AHgI3IZy95hWRkLM77VQzcsEl0x6sBET8XL3mkQAuTl7cBeWP86dtQypBH/MbU2bDyxq+yi/uaAx0A==
X-Received: by 2002:adf:e80c:: with SMTP id o12mr3719032wrm.114.1549994203207;
        Tue, 12 Feb 2019 09:56:43 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j3sm2949554wmb.39.2019.02.12.09.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 09:56:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git v2.21.0-rc0 broken on *BSD, maybe others
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
        <87sgwtjjbk.fsf@evledraar.gmail.com> <20190212124323.GA11677@ash>
        <xmqq8sykevy6.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 12 Feb 2019 09:56:41 -0800
In-Reply-To: <xmqq8sykevy6.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 12 Feb 2019 09:52:01 -0800")
Message-ID: <xmqq1s4cevqe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> The AIX problem is from d1dd94b308 (Do not print 'dangling' for
>> cat-file in case of ambiguity - 2019-01-17). Apparently AIX compiler
>> is a bit picky about enum being a strong or weak type. I like this
>> compiler. The below patch should do.
>
> That would cascade down the call graph and contaminate everything
> (eh, rather, requiring that many places "int" needs to turn into
> "enum get_oid_result"), no?  For starters, cache.h still says that
> the function would return an "int".

Sorry for wasting bandwidth and please disregard the above. I was on
a wrong branch when I started my pager X-<.
