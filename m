Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04E3020D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbdFAVzh (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:55:37 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:36733 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdFAVzg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:55:36 -0400
Received: by mail-io0-f175.google.com with SMTP id o12so44840614iod.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H0Xdne2taTEJuwyR3WVykXRSa9R2MtInhe4dOKJ9UQ8=;
        b=OB/crO5d/9UmvR9hEY1oeqGV+v3o5I0Z3P/LgUIth/Lu+KfKR/gIqcPyaqDdkUxycH
         Visi3EKjWtfZ/dAqPv8fkVyEGztizFMBUfDWSSiH8rortvcMYDdfA59L1ZrmkD5AeIuZ
         J0cben5OLc9TzENqKKD0638Z7zLBt2exnCoPsfnL2AqNhlsTBqoAIysA0DFAI4vKA0gw
         HHFah7QrIi727PiOi7UQ7f2ggHcYVoiyfKCS1Ry86pVlwHlmmYgBfwlUR47PdNtMpa6d
         rF9j67m0l7zj2aHKyICAtoDc14+JPbUGMSLKpkYv35omtOsrRDXe4uVxByxHBpyHLi3m
         Hwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H0Xdne2taTEJuwyR3WVykXRSa9R2MtInhe4dOKJ9UQ8=;
        b=AFGfhjOo94LSGLCbF4iiYSimuYHxZcT3vWxfeBVXCWvwJ60bfQ6zPClhzNdDJYG/fU
         n41csvaKdkhj7qeeobp3m+SQV4ul2iBynZSYD4LTo4RkxA9WSoHt2LYBhfj4fEyj797F
         JpFIAaUmlynRmKDX3yAdaUUwgOg/lBiOQvx17aqPP51fKVvIx4/Kcjj2y6Io75/2mMYZ
         y9Tkll7D/S7dWPn4rhqdLeeX3fiB8XtgtB45Oi2vGT+rlhHOsO+922yQ5qg9AMf+y2kw
         yKcfF9POMJiJZYtYUd2IbrWJXiPPkdaA3lWVokE5gpicIJ2z4P11sEXAWzhfqf/MNAZB
         5sbg==
X-Gm-Message-State: AODbwcC93/oloyWOvktZLR+Gk/wWSSvgJcs8HsYuaYVDOGHJ6x9oV59Y
        cH4EoOZaPcrDhWF4AGFdbtw0XQhgRA==
X-Received: by 10.107.178.215 with SMTP id b206mr1220899iof.50.1496354135561;
 Thu, 01 Jun 2017 14:55:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 1 Jun 2017 14:55:14 -0700 (PDT)
In-Reply-To: <CAGZ79kbcdSykdCku-skCY2FVNO-mpP8nkZ1rC1nXTKzAFQzb1Q@mail.gmail.com>
References: <20170601182056.31142-1-avarab@gmail.com> <20170601182056.31142-3-avarab@gmail.com>
 <CAGZ79kb6O7hraY4caY8tdFn1d0Fi+LRr9cHk2UuXf79LbnPdhw@mail.gmail.com>
 <CACBZZX7hffa3iGndzyJMKYAwDqjjYO6XacWLrHnSo29xYSKAsQ@mail.gmail.com>
 <CACBZZX580g_fKMnCf0XGD4sGY6DjgH7t9cBtcXZf6muemKWXLA@mail.gmail.com> <CAGZ79kbcdSykdCku-skCY2FVNO-mpP8nkZ1rC1nXTKzAFQzb1Q@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 1 Jun 2017 23:55:14 +0200
Message-ID: <CACBZZX78_eBswHCqcWL34xXbFgv=nZXG=R0ZjB_b97s_U4P=Ng@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] grep: skip pthreads overhead when using one thread
To:     Stefan Beller <sbeller@google.com>
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

On Thu, Jun 1, 2017 at 11:45 PM, Stefan Beller <sbeller@google.com> wrote:
>> I didn't mean to change this bit, it should remain "if
>> (!num_threads)". I was in the middle of monkeypatching and didn't
>> review the diff carefully enough. But it any case, without this change
>> the rest of this diff is your proposed (but segfaulting) change as I
>> understand it.
>
> Sorry for the proposing a sloppy alternative. (I missed one occurrence
> of num_threads used in a conditional).
> I think the original is still better than littering comments everywhere.

I should have said: None of these follow-up diffs of mine (including
the added comments) are something I think should be applied, I just
inlined that to explain the code in context.

Just to make 100% sure I understand you, do you mean you think the
original v4 version I posted here makes sense with that explanation or
do you have other outstanding concerns?
