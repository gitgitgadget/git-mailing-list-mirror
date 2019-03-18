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
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD9A20248
	for <e@80x24.org>; Mon, 18 Mar 2019 22:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfCRWSm (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 18:18:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34336 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfCRWSl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 18:18:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id a16so14927376edn.1
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 15:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=P4p6tFwydKfvh433ujGxbYe4hqYdHDB7bDv0F7wMQZI=;
        b=FbXnJx9nQZPJLY8VNsclVXVnX3QZ6V94AFmAPgUAZeTQ1kU9momVfEhximMjlqnwFX
         fF+4jCIzP7WXaxfAA36AouIuZCZMWKipTLiAy2bP9FtQ+GLp0+zIqsWP9KxnFRwHrww4
         cSOeStY4eTMdQvQ4QaT8/qMRlb89uGLcqClRXB9XK5LFxMJZflhaJOIURIKmt4jI9w5D
         ufErvp1XsZaYJmoyKVJudi2VtoZ6GeixvRoLNFDCE3qufXuOtLSZRP5RaddtSObCP+E4
         Sdf9A8fg88eYju8zro54QbO7X70xRBSHYFmvvBU/M0xyi17Hxk8W975MZmFd5iWFreZ2
         a44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=P4p6tFwydKfvh433ujGxbYe4hqYdHDB7bDv0F7wMQZI=;
        b=nyaUESWsI9ngEnyEPoQx5JXjzpkouWp7NVB9Gsb4FimjNWmAN6DRozyF94YCDiAjYQ
         skgfrkxinAr+Bp2Ee1mlMCXwmxp9RYULRCRCdha9aOo/mYwrz7mtDLt9iUA8MhRufFJY
         Q1wjqioAev9Y3xRrJS1PZ5z+dR4zxQsUOeSs74p+8sADYMG4d0OHYX0t9sKsr9RvXbvD
         YP+/EcJpvc3pNcvQqrG5Ajn2sUEc24gTV1p6+IIvaKetUapuW3toh3xmKBsMjy++zvFt
         2Q4anCp9RFXLktii0Q6XOTqrz/sLhIRIlwSt9ZexKynFPRlN4azR5rU9zTVNfRWQwtVU
         pdCw==
X-Gm-Message-State: APjAAAXh4INmlBA8Kw/fPn+kPjBxd1o+1oWrFYq0mA3QHS6PN2TKMif8
        yZ42OeyzlZYW/8W+VJdFBrM=
X-Google-Smtp-Source: APXvYqzW0BeHcxNlId1JtGjCSq0b5v0LcuCvnWc6XPtGE+jHjc9z3TapNeWaWGBn10ln3EZdXa9NSQ==
X-Received: by 2002:a17:906:88d:: with SMTP id n13mr12378812eje.154.1552947520226;
        Mon, 18 Mar 2019 15:18:40 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id l42sm1044441eda.60.2019.03.18.15.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 15:18:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 1/4] gc docs: modernize the advice for manually running "gc"
References: <20190318161502.7979-1-avarab@gmail.com> <20190318161502.7979-2-avarab@gmail.com> <20190318212719.GE29661@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190318212719.GE29661@sigill.intra.peff.net>
Date:   Mon, 18 Mar 2019 23:18:38 +0100
Message-ID: <87imwfesht.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 18 2019, Jeff King wrote:

> On Mon, Mar 18, 2019 at 05:14:59PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> The docs have been recommending that users need to run this manually,
>> but that hasn't been needed in practice for a long time.
>>
>> Let's instead have this reflect reality and say that most users don't
>> need to run this manually at all.
>
> Yeah, I think this makes sense.
>
>> -Users are encouraged to run this task on a regular basis within
>> -each repository to maintain good disk space utilization and good
>> -operating performance.
>> +Most users should not have to run this command manually. When common
>> +porcelain operations that create objects are run, such as
>> +linkgit:git-commit[1] and linkgit:git-fetch[1], `git gc --auto` will
>> +be run automatically.
>
> This is in the description, before "--auto" is introduced. I wonder if
> it is worth just describing it briefly, like:
>
>   When common porcelain operations that creates objects are run, they
>   will check whether the repository has grown substantially since the
>   last maintenance, and if so run `git gc` automatically.
>
> That gives a first-time reader an idea of whether they need to care
> about this command without having to dig into what "--auto" is.

Yeah I think that's better. Also more briefly describing gc.auto=3D0
without an example (suggesting people run that, which for most is a bad
idea). I.e. just adding to that "This behavior can be disabled, see
`gc.auto` below."
