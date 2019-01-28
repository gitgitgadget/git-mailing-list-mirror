Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM,URIBL_RED shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84CDB1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 19:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfA1TF4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 14:05:56 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:42976 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1TF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 14:05:56 -0500
Received: by mail-ed1-f42.google.com with SMTP id y20so13950730edw.9
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 11:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KaNH0+sPXxAV8v7LjrGypzUmu3w1dcQBIwQCx3RwOPA=;
        b=SbIzVjJM4W+cukqkjPv5Jme1Fxh64tK8Qf4oxJ9nwYSeiCiNwwz9VM238JM7gsNjTj
         9vwrVi7mnxgT7xVJfEJSEXYf4tNZ30MGXI165lNhUCv0s2FW+/Tmkfgss4WVkatMVfPA
         4r1gkUCPXBdw22wB55QZQVb1IqcivyenOdXwpmUpJZBrBRFg3LBvsYSvzR8FcEOzjz8S
         jd7SlyMn2jfkrJWkquup6dk4idGPzxOEbzRRCXX4E200jZcAAT7Kly4OwmkAS1wMUvBy
         nIA4nDKQppX5cKvSS1oHNGhFX2nNymXqnTTW7exDsvDWWCpSa5hnmyOG8PAXvW8wngCr
         hPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=KaNH0+sPXxAV8v7LjrGypzUmu3w1dcQBIwQCx3RwOPA=;
        b=ntMcaX9XgU+z+5P2bSSIc6xHDD1V/ZYue/j5ncDIH7StM+gIxt1pwz4WCUFtCsiLZ6
         EQQwfZ2p4TYEy//KwGhc5N/nG6zb7ZiC5jyz89bC7nF+cnZIFzdk7TnQPN59Hq1Gy4bw
         HIqwQ9P+SwFUYfbr9uy/n3+iz4UBjlv6cE8UeB6XwT5UD2af8QXM9+TNvvZTNqqDw0dW
         8Dzdepvme5QpEcFwDlu6FxuG7VMq6qWZX9zh2xm4JIsMJEE1bSZV3q0vhsYxrWD61+Pb
         fL9vWdH/+eLO2PUh2F7GxRNjo+qmf3tfFuDZrq1R359WGTK306cneqPFvGa5QSgxfTMz
         07RA==
X-Gm-Message-State: AJcUukdIrOaERnZEGHMiBWOhvczaWmDNXakpfikbJZgxNW9sZFgYzh6I
        ILHPuG2MiZJIBu6/tY/LiybhFrf0
X-Google-Smtp-Source: ALg8bN5WsbESZygOGM6MvXBLWVSAJGXsarr4uzHExaTAZnaEEJyT1jbxsDOQ4xvCd0XZLMXipzN4uw==
X-Received: by 2002:a17:906:4bd7:: with SMTP id x23-v6mr20615032ejv.105.1548702354595;
        Mon, 28 Jan 2019 11:05:54 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id v14sm13261677edq.74.2019.01.28.11.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 11:05:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     William Hubbs <williamh@gentoo.org>,
        Git List <git@vger.kernel.org>, chutzpah@gentoo.org
Subject: Re: [PATCH v2 2/2] tests: add test for separate author and committer idents
References: <20190125215955.30032-1-williamh@gentoo.org> <20190125215955.30032-3-williamh@gentoo.org> <875zuc49uj.fsf@evledraar.gmail.com> <20190126010632.GA4000@whubbs1.gaikai.biz> <874l9v4x6p.fsf@evledraar.gmail.com> <CAPig+cQKKqL7QD_nwy8tvHaxuGqBXATVt2Mo+gELpif9aULc6A@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAPig+cQKKqL7QD_nwy8tvHaxuGqBXATVt2Mo+gELpif9aULc6A@mail.gmail.com>
Date:   Mon, 28 Jan 2019 20:05:53 +0100
Message-ID: <8736pc4n72.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 27 2019, Eric Sunshine wrote:

> On Sat, Jan 26, 2019 at 3:53 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Which, looking at this again, you'd only want if a previous test in the
>> file was leaking its state. That's not the case, so this isn't needed
>> and you can just apply this on top:
>>
>>      test_expect_success \
>>             'author and committer config settings override user config s=
ettings' '
>>     -       sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
>>     -       sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
>>             git config user.name user &&
>>             git config user.email user@example.com &&
>>             git config author.name author &&
>
> Aside from future-proofing against a test being inserted before this
> one which does set those environment variables, these invocations of
> sane_unset() serve the additional purpose of documenting the interplay
> of configuration and environment, and further indicate to readers that
> the test author took this into consideration (rather than merely
> slapping together the test without thought). As a reviewer and reader
> of the test, I appreciate the additional context the sane_unset()
> calls provide, thus think it makes sense to retain them.

As noted in <875zuc49uj.fsf@evledraar.gmail.com> ("various override
interactions") there should definitely be more tests where the
combination of config & env is tested for.

But I don't see how it makes things clearer to unset a bunch of
variables previous tests didn't set. If we applied that to our test
suite much of it would be pointlessly unsetting various GIT_*
variables.

Better to assume other tests have cleaned up their own state, and when
it's not the case fix it.
