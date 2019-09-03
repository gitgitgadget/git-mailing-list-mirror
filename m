Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11D081F461
	for <e@80x24.org>; Tue,  3 Sep 2019 02:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfICCcr (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 22:32:47 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:34634 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfICCcr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 22:32:47 -0400
Received: by mail-io1-f45.google.com with SMTP id s21so32558744ioa.1
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 19:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XcBNr3bDLHDyx8Mujb6iSmWVEvlO5wUjec57alAludQ=;
        b=dU4v31Tm7MZGAIYHff/7rBgquEvLp/Lc1hjasb8Dp4YHZkudfFi6cDVktoZRQBFt3t
         hJznSzN4L2x80d81HYdC5BbnKTrefzUZwFVfcDBNgLMdsnWEbujCEgq3Rvn+/PidG7X6
         TB6lBINXIPhV+d95MO184mDL928D8zCmElAX1kUsf19YC12pTEKC3yFv0NaLPGPpsJ/F
         mOZJtZa4dzizmhU6lImR6w56tuacT5Z4iC9TeCgaHR+yWEisUHM8F7ggoQHSBycdKYfC
         1H0n4Kl6Vj61xRLAJoM5+UlZ5/crj4XjrZDyP0ecNMDUrEzLodd1a949rQf5kL+t0259
         d5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XcBNr3bDLHDyx8Mujb6iSmWVEvlO5wUjec57alAludQ=;
        b=H6hy2gdpM6X7jOQjgimY303kpFTZ8lQu3rV8oAoBav7GnicyWUuzSC+k1/zwwWGaOe
         qo/00YJZe5eipMSEHWWLrWdB+b1gH7UibIBgzC792FqMrfJEv3Y8UIoNgYnkgVzPH1/P
         z8Q2PLoFVBbYU2OrP2focgh0U/TAYS9nlPG6fsuSXJCR3VbAsZQy2/IuvRqbJX+rW/8j
         0ej4+9fEPKfcYSXWavtadIz2YaK5DUSM2YzXd2I+dAHHRlfP3bC8b6Vsa/pBTsKelwey
         NvAEugJSSSALcN7HqhIrplzaNRG3MmyYbT4d5Cw5ZoL6ZlDKkwr4tVqxNa964/mufwgg
         Qwqg==
X-Gm-Message-State: APjAAAULv64+LQpDanskHUbN/9azUp+Z07nbYnaayaKIcA5zu0ph+pIL
        xDiuM1pGC2W42g6fu9AqGrpz3vYzr9ZwZauFx5UiiX7SnYo=
X-Google-Smtp-Source: APXvYqx39Ur90ik6qxxnJuV45N50D5b22dE+3Rl1sN5wVnWA3XtXeo5OCWNrqnJkqXnpWSMOwbJXmYdqHBjjl7Qk668=
X-Received: by 2002:a6b:5b07:: with SMTP id v7mr4558955ioh.76.1567477965798;
 Mon, 02 Sep 2019 19:32:45 -0700 (PDT)
MIME-Version: 1.0
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 2 Sep 2019 23:32:34 -0300
Message-ID: <CAHd-oW4d=x51EwwyZ-FhxHgLJNZM5sHLd19mUOuacFrhT_CQwQ@mail.gmail.com>
Subject: [RFC] Post/tutorial for newcomers
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

I've been writing a blog post based on what I learned during GSoC to
help other students here at FLUSP[1] start contributing as well.

In the meantime `Documentation/MyFirstContribution.txt` was released,
so I've pointed my interested colleagues to it. But since I was
already pretty close to finishing the post, I decided to conclude it
anyway.

Here is the end result:
https://matheustavares.gitlab.io/posts/first-steps-contributing-to-git
If you have any comments or suggestions for it, please, let me know :)

Thanks,
Matheus

[1]: https://flusp.ime.usp.br
