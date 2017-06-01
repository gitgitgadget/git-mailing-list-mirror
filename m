Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B093A20D13
	for <e@80x24.org>; Thu,  1 Jun 2017 22:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbdFAWI0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 18:08:26 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36155 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdFAWIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 18:08:25 -0400
Received: by mail-pf0-f174.google.com with SMTP id m17so38682732pfg.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GCA44/j2N9sb27BthAQWsZJnDLGG5fA/aOujrEm7rds=;
        b=nBG18EMy0peYfJMIv/C4vBs2J/Qc2EvcHdP/0rjLRmHWWQgcgWnRgP1JAH1foPnRYf
         O1dbNz1xUOExIQEykJF5rVKn0piSCEjpxV18QLN6DaBpclzBrXLVIebljN+1VkLk/udX
         sxwZoj7U+Md5zU0YR6eZYNZK0GoIKjQqMJDzVnSFKerXFCSXcndCq7taPuBUCQL6k9eN
         xVesrnoPXGzX912+vcNRZXkr5FguL9vIMmUBDdvPXzyiHydyXTckUihXljDvihu4o6s5
         nKWAOSpMuXGqqY4JovZk6XS2V1xZHED19QD5FXA0w1kUcGzmdo8ZQ/MN7Pjfh/PUoFvp
         y68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GCA44/j2N9sb27BthAQWsZJnDLGG5fA/aOujrEm7rds=;
        b=sZ5LgKcMU1jORuQIDDuNA0RUJsnJ/cHJ8bvLyBxu/OJgg3Z+lpxKiOzZ8ov5aIUoI+
         tSEikdioPqwHNp/ZbChbqMzG0GaS7ocwnhAF5yG5y/jjSSuhqZrSXY9wKs5GE4Z51py2
         Dl4KaDpqzgES0GeGxhZnOnYLPVOZJmCvf3SsKW7OJYZCMW5qbN13RGf+2eM2/Oq4ABwX
         KgevOhjIJJGOQm95v9e1L4dzc00pVqU9sEJRzcVqiHftWmG3r3o3cr0IHMOfXkFFgPKz
         JeLzjln1SgJYVirp73/1Ko8un26epVa5nSb5KjbYZY0BUvF7PFD9CN9zpI8o0++btUIm
         OWMA==
X-Gm-Message-State: AODbwcBLM/ePfscN+Nlf0umiPPO6yPzR7KoOsQPz/XtBBdG5eRN1iFg/
        JI0lD4AqGTkoPr2hN4Qsggq75s8dBhus
X-Received: by 10.84.174.3 with SMTP id q3mr39326153plb.52.1496354905105; Thu,
 01 Jun 2017 15:08:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 1 Jun 2017 15:08:24 -0700 (PDT)
In-Reply-To: <CACBZZX78_eBswHCqcWL34xXbFgv=nZXG=R0ZjB_b97s_U4P=Ng@mail.gmail.com>
References: <20170601182056.31142-1-avarab@gmail.com> <20170601182056.31142-3-avarab@gmail.com>
 <CAGZ79kb6O7hraY4caY8tdFn1d0Fi+LRr9cHk2UuXf79LbnPdhw@mail.gmail.com>
 <CACBZZX7hffa3iGndzyJMKYAwDqjjYO6XacWLrHnSo29xYSKAsQ@mail.gmail.com>
 <CACBZZX580g_fKMnCf0XGD4sGY6DjgH7t9cBtcXZf6muemKWXLA@mail.gmail.com>
 <CAGZ79kbcdSykdCku-skCY2FVNO-mpP8nkZ1rC1nXTKzAFQzb1Q@mail.gmail.com> <CACBZZX78_eBswHCqcWL34xXbFgv=nZXG=R0ZjB_b97s_U4P=Ng@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Jun 2017 15:08:24 -0700
Message-ID: <CAGZ79kYd7rVk8-CnmpyuLy0Ok2pnvYNjbZYHyPw5dfDJQD3zJg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 2:55 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Jun 1, 2017 at 11:45 PM, Stefan Beller <sbeller@google.com> wrote=
:
>>> I didn't mean to change this bit, it should remain "if
>>> (!num_threads)". I was in the middle of monkeypatching and didn't
>>> review the diff carefully enough. But it any case, without this change
>>> the rest of this diff is your proposed (but segfaulting) change as I
>>> understand it.
>>
>> Sorry for the proposing a sloppy alternative. (I missed one occurrence
>> of num_threads used in a conditional).
>> I think the original is still better than littering comments everywhere.
>
> I should have said: None of these follow-up diffs of mine (including
> the added comments) are something I think should be applied, I just
> inlined that to explain the code in context.

ok, cool. :)

>
> Just to make 100% sure I understand you, do you mean you think the
> original v4 version I posted here makes sense with that explanation or
> do you have other outstanding concerns?

Well as I said in the first message, I would have tried a different approac=
h
for this patch as I'd find that easier to understand. (Not sure what exactl=
y
is missing there to make it work).

But the version v4 is fine with me, too, no other outstanding concerns.
