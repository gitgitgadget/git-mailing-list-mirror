Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C239420D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbdFAVpK (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:45:10 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35892 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdFAVpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:45:09 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so38247138pfg.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8YdSd36nacV0DTn1C+Fn8iSV5dga43T4zAhb1hZj+qA=;
        b=q/7CgwYIq28c2lnhwQGnEnOvvPAHbBj1luiimGsKT+5sZZ42R5DZZtz2EGgvgP2+Xy
         tRDXrTh0kYhaq+BfkeNXErJaQxlXrUE7mRGLWcy3jnXhkKfCJotYESYj1/6ALSnHHtY4
         aaTZ4RDCt1ZbW2m8I5QGlOyujYWL1gEdv7kWW4rviAqXatVyRl9NrE8gL00gONSbzTnb
         K/M2CMvO5UEspoc7Fvpz6AbPblyGyAfRCwUrHvjsnaLksxdjgUBSXOA7YkwqL+3ou/NM
         XVV0dsw5IZ3Ry46x+qpIvGBcbg5Me6AIIWDbdDSwtS36ShsjM1ibzWETwOQzhgZNO+eP
         ZiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8YdSd36nacV0DTn1C+Fn8iSV5dga43T4zAhb1hZj+qA=;
        b=b5or1/Dfb/7X0udvlMZ/FYu/YUr55ut+FyDfU5tBammEk0D5KygcPJqwOa35yRh5HU
         +Q+Ozj/6E4XByGRp53xjH4eMHM+l/9wVPInOiOB4urnI4pJ4U1TXqoceuCmD5dT1AFk0
         PI7occwOPDkerjCD/jhZ5TowgzQhC9RIbgj5R1dliY4rr+kWDHjPDWTmhCQq+vmnK0Fz
         oMxz6NUVpz1hq053lC0dj40/xPmWmGChMiY413Sde9RkXrSktxIh6IDP+aFJ8qabipV/
         ETEQVOLZMpJ+jzwnlj+1nMYSXwMaD2J01DXW/WoP5WY4MXAZxfTHpQiTkI9mhh8myWuV
         Dd7g==
X-Gm-Message-State: AODbwcCbHJm3RSnMB8Ac+ZZYNxr6IhqV/5jVB15d/UWJfihWb4rcZrLR
        /90AwQQnxqedzWVap0zhd9FVN7VbEj4xcMs=
X-Received: by 10.101.76.201 with SMTP id n9mr3332067pgt.40.1496353509115;
 Thu, 01 Jun 2017 14:45:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 1 Jun 2017 14:45:08 -0700 (PDT)
In-Reply-To: <CACBZZX580g_fKMnCf0XGD4sGY6DjgH7t9cBtcXZf6muemKWXLA@mail.gmail.com>
References: <20170601182056.31142-1-avarab@gmail.com> <20170601182056.31142-3-avarab@gmail.com>
 <CAGZ79kb6O7hraY4caY8tdFn1d0Fi+LRr9cHk2UuXf79LbnPdhw@mail.gmail.com>
 <CACBZZX7hffa3iGndzyJMKYAwDqjjYO6XacWLrHnSo29xYSKAsQ@mail.gmail.com> <CACBZZX580g_fKMnCf0XGD4sGY6DjgH7t9cBtcXZf6muemKWXLA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Jun 2017 14:45:08 -0700
Message-ID: <CAGZ79kbcdSykdCku-skCY2FVNO-mpP8nkZ1rC1nXTKzAFQzb1Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] grep: skip pthreads overhead when using one thread
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I didn't mean to change this bit, it should remain "if
> (!num_threads)". I was in the middle of monkeypatching and didn't
> review the diff carefully enough. But it any case, without this change
> the rest of this diff is your proposed (but segfaulting) change as I
> understand it.

Sorry for the proposing a sloppy alternative. (I missed one occurrence
of num_threads used in a conditional).
I think the original is still better than littering comments everywhere.
