Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6918F202F2
	for <e@80x24.org>; Wed, 22 Nov 2017 09:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbdKVJHh (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 04:07:37 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:40161 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751476AbdKVJFo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 04:05:44 -0500
Received: by mail-wm0-f43.google.com with SMTP id b189so8548999wmd.5
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 01:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=O6LyCStAOZ54A78Y/pUI0/CcgqpRq+7idNk9fCz+rt4=;
        b=jGXV39Fp9OZzrzjg3yi6cS4w5RYEnnLTcZcC0QFO+/kLHHmwTRo1qXY1ROfwZ4rv6p
         Q0gX3pEscq6iBQt0hpfpw3n15bfq6YzGfc1TR6kN8mnmyHNqJpAobZxWBXBn4ixI2OFC
         t9bZfORAhVUyONebpCO7/6gTDYz8N2Pdcd8Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=O6LyCStAOZ54A78Y/pUI0/CcgqpRq+7idNk9fCz+rt4=;
        b=GZuwSzzxzpsMQbg6EG7UCFa5FMBuzuinLKR9ox9E2sAam0QO5PaxX6U1BHKjixDIK/
         y5G3wFWlY0ne2BLd9f9pGrvLyVceSZ6pLlfxhPk/Gg9+aR46GmF0XpoQvtlgWGBQkBuR
         48N6cyKQj4KxD7jGe2yjp1qriadWyQmKrwLXNINjNLx6/X4RKzfBUGDO7M5BGboB7z3y
         Ghfj6/8eTo3XIYFv3tX8o3ancidFcuqv0EudW87J7sPSxDAW7/3uqnn4hARHcYN5UDrP
         yWcRxB3z3ofr7Ayi5Qs2fIM97Ty6GvLKX/Qw46L0NksYUa460lx5CrOyqK3O2bg0yYmF
         Iojw==
X-Gm-Message-State: AJaThX6Uri4xdf0SMYlKZmcWWLw2yigzxtdLYyy7J3OiIIrjRiHKZs0v
        +EvwSXl+NfKVar4WnwoUUsaHdA==
X-Google-Smtp-Source: AGs4zMaOpTB7c20HAth8apLnVrqLdckOft3HwJnRQSfu/HAgxjWNXACd+u5lqr6fpXnXEVQk/6AiDw==
X-Received: by 10.28.193.66 with SMTP id r63mr3390703wmf.18.1511341542684;
        Wed, 22 Nov 2017 01:05:42 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r14sm4510510wra.71.2017.11.22.01.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 01:05:41 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTPS id 5F3253E025C;
        Wed, 22 Nov 2017 09:05:41 +0000 (GMT)
References: <20171116154814.23785-1-alex.bennee@linaro.org> <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com> <87wp2jwe9o.fsf@linaro.org> <20171121205206.fvwjkkwhil4abmmk@laptop> <b131cc195280498ea3a77a37eff8444e@BPMBX2013-01.univ-lyon1.fr> <q7h97euiradu.fsf@orange.lip.ens-lyon.fr>
User-agent: mu4e 1.0-alpha2; emacs 26.0.90
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Adam <thomas@xteddy.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
In-reply-to: <q7h97euiradu.fsf@orange.lip.ens-lyon.fr>
Date:   Wed, 22 Nov 2017 09:05:41 +0000
Message-ID: <87vai2wumy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Matthieu Moy <Matthieu.Moy@univ-lyon1.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Was there any reason why Mail::Address was _inadequate_?
>
> I think the main reason was that Mail::Address is not a standard perl
> module, and not relying on it avoided one external dependency. AFAIK, we
> don't really have a good way to deal with Perl dependencies, so having a
> strong requirement on Mail::Address will probably end up in a runtime
> error for users who compile Git from source (people using a packaged
> version have their package manager to deal with this).
>
>> I know we had trouble with random garbage that are *not* addresses
>> people put on the in-body CC: trailer in the past, but I do not recall
>> if they are something Mail::Address would give worse result and we
>> need our workaround (hence our own substitute), or Mail::Address would
>> handle them just fine.
>
> For a long time, we used Mail::Address if it was available and I don't
> think we had issues with it.
>
> My point in cc907506 ("send-email: don't use Mail::Address, even if
> available", 2017-08-23) was not that Mail::Address was bad, but that
> changing our behavior depending on whether it was there or not was
> really bad. For example, the issue dealt with in this thread probably
> always existed, but it was present only for *some* users.

So I just did a little digging on my systems to illustrate the point. My
work machine is Ubuntu, so has a packaged git via PPA. It depends on
libmailtools-perl which includes the perl module and:

  apt-cache rdepends  libmailtools-perl | wc -l
  45

So for binary packaged systems it's not a big thing - libmailtools-perl
seems to be quite widely relied on.

On my system at home, running Gentoo, while requiring "perl" doesn't
explicitly pull in the Mail::Address dependency. As a result the git
send-email stanza I was running at work manages to corrupt the
addresses. If I manually install dev-perl/MailTools of course it
silently starts working again.

Good job I never usually send patches from my home machine ;-)

My hacky guess about GIT's perl use calls is:

   find . -iname "*.perl" -or -iname "*.pm" -or -iname "*.pl" | xargs grep =
-h  "use .*::" | sort | uniq | wc -l
   88

So that is about 88 perl modules used in the code base. How many of them
are not part of the core perl distribution?

Should the solution be to just make Mail::Address a hard dependency and
not have the fallback?

--
Alex Benn=C3=A9e
