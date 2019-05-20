Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2705A1F461
	for <e@80x24.org>; Mon, 20 May 2019 15:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbfETPRY (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 11:17:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43472 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732343AbfETPRY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 11:17:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id w33so24391621edb.10
        for <git@vger.kernel.org>; Mon, 20 May 2019 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=n6KT/JllFft5cE+IMdole+7d+Ac08LunS/hD9c5WtOg=;
        b=VnloKE9DRqwlFQweegqnAivf18iiJvFREdh7mCz2eRQ0mZzFdp/k4O8OQb2313RSTT
         TYnk84UX0BJCnpXgBAhT26joUxRdI58TVrGKUiPDMaZ5cYMiDXB7CyonhetIJtP5cWkw
         7+yOU2uLKM6KdLaLzRr2Apv+ZCAKH6Si/C/qBrN5X5HSZJFEN7AQ4fThkdz7wOW84zX2
         SlNNNzskZDes2fnK06ZYpZMXGzWmLls5LI5QO25CSn0t1rIW8ugQiuk71BKBxAWxALWz
         tEmqZQcWnHts6LYnLVrYcWi2bU4O8zRu6LGpjbQKcxCo7ex6vX61BdhwVyeIQxgfhDiE
         JGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=n6KT/JllFft5cE+IMdole+7d+Ac08LunS/hD9c5WtOg=;
        b=TdjKac++3mipBmUFep/fcbAFmPcyRoA2RWqPbH8IWu7j/kqA79F/AE++nHVKUSeqjP
         Qw6zp9NoNZ/BwcW+uotd/JlKWKVEHC8bnEoBYTHlez1pS7614sZUqkbwK6VwemMhtLQ4
         ItsJs1YXSyfbJfQvlwcAPk/GW2BB3Zdh53XdnEVnnSQc8ANrnUTOEZKB6/ZEXumUxWrl
         s+FO9oc5Ou7SRH8wQ+33dCOGtvnuyKBiqmQBINUPILUVbOAc5T2Lrtnw1y/Pc6JsrpwF
         xkK+TP+S4QE23BrGcLiM5yIkKujHp+SdblpC2zlTsOpnzch0v8OfKQQ3LT7y7AxGxemD
         Qhyw==
X-Gm-Message-State: APjAAAXRBHRfMOwMafyeU0+rMJPE3Iqczm5/5AP4fMT0hmuvLmcIeM//
        MyAblBOauEV7KTlQfw+aQvw=
X-Google-Smtp-Source: APXvYqw5Un/maTwKmSR8n4ErlDmqyep1gOdaTRahYvDanqTRSeJ/5OWw2LBsl2qetPs9UeZl9QxgKg==
X-Received: by 2002:a50:8e81:: with SMTP id w1mr75910619edw.271.1558365442315;
        Mon, 20 May 2019 08:17:22 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id l19sm5688042edc.84.2019.05.20.08.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 08:17:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] clone: auto-enable git-credential-store when necessary
References: <20190519050724.GA26179@sigill.intra.peff.net> <20190519051604.GC19434@sigill.intra.peff.net> <87imu5ut4x.fsf@evledraar.gmail.com> <20190520140825.GA31580@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190520140825.GA31580@sigill.intra.peff.net>
Date:   Mon, 20 May 2019 17:17:20 +0200
Message-ID: <87h89pupdr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 20 2019, Jeff King wrote:

> On Mon, May 20, 2019 at 03:56:14PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > -test_expect_failure 'fetch of password-URL clone uses stored auth' '
>> > +test_expect_success 'fetch of password-URL clone uses stored auth' '
>> >  	set_askpass wrong &&
>> >  	git -C clone-auth-none fetch &&
>> >  	expect_askpass none
>>
>> I've only looked at this very briefly, there's a regression here where
>> you're assuming that having a configured credential helper means it
>> works.
>>
>> I.e. I have a ~/.gitconfig where I point to some-gnome-thing-or-other
>> what doesn't exist on my VPS in my ~/.gitconfig, cloning just warns
>> about it being missing, but will store the password in the repo.
>>
>> With this you detect that I have the helper, don't store it, but then my
>> helper doesn't work, whereas this worked before.
>
> There are more cases beyond that, too. You might have a helper defined
> which doesn't actually store passwords, but just sometimes tries to
> provide one. My thinking was that if you're clueful enough to have
> configured helpers, you can probably deal with the fallout. But you're
> right that it may still be a regression in the sense that the user may
> still have to actually _do_ something to get their fetch to work.
>
> I guess a more robust version of this is that _after_ the successful
> clone, we could ask the credential system "hey, do you have the
> credential for $URL?". And if it can't answer, then we can take action
> (whether that action is setting up credential-store and seeding it with
> the password, or just advising the user about the situation).
>
> -Peff

Yeah I don't mean deal with some there-but-broken helper, but this:

    /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnom=
e-keyring:
    not found

Until then the observable effect of that has been to make the
credential.helper config a noop, but now it's causing "we have a helper"
behavior.
