Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4215F1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 17:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389422AbeKGCjj (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 21:39:39 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37867 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389227AbeKGCjj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 21:39:39 -0500
Received: by mail-it1-f194.google.com with SMTP id j79-v6so6719573itb.2
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 09:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYZ2B+DNtTC0VWaGr7c0lGB9ph1+8svKJdElmsiiehE=;
        b=WRH7EsLk1mezZdp18L5RTzlTI2Kvp9LW8ewPcZgxnJrVBPjW2ljsCDNkXgJahCGeMh
         nvckEpaZpcqsmZLxY/0H95i9LPdsi30Sb+9RP8wqAAOGbS3J902ZFZ0IlXIwsxnhBIbK
         cIhRMNUdjn0+0lIQPAfFkR2UNhKcdFxEVutkfcX5SSiq/P5QqqPqDN+6qZyUOhZ4DZGZ
         B3SirWimzd0b/4JzEva20jJv1PFT7m/KTZ4TnjkaFTxDQVLCVhZk0gyVOlj5JWDA4W0s
         Y70GTwBo4ejxYARHBSWnp6Ue8WEoZfsRcZE4e2WV5f5F38YmkGFfaWBMrvZUtifCNokC
         R3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYZ2B+DNtTC0VWaGr7c0lGB9ph1+8svKJdElmsiiehE=;
        b=pHVtW5UfQOuxl3pL4FnUgaueI2txQFTmipsE1F8xXT8nBqHYunm0nQ/UOpv+GdDczb
         p/jeDVyXAVXgmw8WZxVDLg5z/xhyER/bUB3pYsuV7YwLHBHfEKXAaYwmdXYsiT5WwXjp
         qYFSlVibkmAG2gD4oWyY26kR153burteZk+4pvMkxkiPSsYDRMVKQwp4tfiEkJbxwKVP
         +jqcsuzQwVZYaH7YrrOhuxLZlexFleXEh+e3H0++77n2ImWKDIo93JWtgB67lHb9jhZG
         7Xm2w9g/cRD5sXhM/nTiF99ZmEZZZsHuAT6qLuawngZWGDd9A2NJFEYnMVq90SkPkHvP
         j68A==
X-Gm-Message-State: AGRZ1gKuVvVLaV+KmF8Wd0x8qbfc604/tU908WSYiZQblCDnf9JqQk0X
        Nc0waEd39iHWVD/Fgu9sCpZOBh338qEHyCG63Ibk4C5m
X-Google-Smtp-Source: AJdET5e6F+nORZWBkCStcNKHz4pCmW0Xl1MPwYBhlP8zuyak2EYrDTwb0MbPlWXDK2VaaQuyEgLdIx2rQtPHZevR5xw=
X-Received: by 2002:a02:9795:: with SMTP id s21-v6mr24858290jaj.92.1541524406571;
 Tue, 06 Nov 2018 09:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20181106104811.14625-1-leif.lindholm@linaro.org>
 <CACsJy8AjY1-KT9x_CXuo+L3-g947OaC5Av0KwuJF-Xkz6VMiPQ@mail.gmail.com> <20181106163118.wkvcjvb7uxjvnryk@bivouac.eciton.net>
In-Reply-To: <20181106163118.wkvcjvb7uxjvnryk@bivouac.eciton.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Nov 2018 18:13:00 +0100
Message-ID: <CACsJy8BGMDqiekYLdStfyxNBsW88HKv9Z_KwKjjGrEQuucnDPw@mail.gmail.com>
Subject: Re: [PATCH] format-patch: respect --stat when explicitly specified
To:     leif.lindholm@linaro.org
Cc:     Git Mailing List <git@vger.kernel.org>, lersek@redhat.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 6, 2018 at 5:31 PM Leif Lindholm <leif.lindholm@linaro.org> wrote:
> > > diff --git a/builtin/log.c b/builtin/log.c
> > > index 061d4fd86..07e6ae2c1 100644
> > > --- a/builtin/log.c
> > > +++ b/builtin/log.c
> > > @@ -1009,7 +1009,8 @@ static void show_diffstat(struct rev_info *rev,
> > >
> > >         memcpy(&opts, &rev->diffopt, sizeof(opts));
> > >         opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
> > > -       opts.stat_width = MAIL_DEFAULT_WRAP;
> > > +       if (rev->diffopt.stat_width == -1)
> >
> > I don't think we get -1 here when stat_width is not defined. The
> > "undefined" value is zero but I'm pretty sure we get MAIL_DEFAULT_WRAP
> > in here unless you specify --stat.
>
> From what I could tell, if nothing is specified on command line,
> rev->diffopt.stat_width is set to -1 at this point (I assumed by
> rev->cmd_log_init_defaults(), but didn't go digging).

I thought the same but could find where cmd_log_.. is called by
format-patch. I was not even sure if I read the code correctly so I
ran the command through gdb. It was definitely not called.

> The patched version certainly gives the <= 2.16.* behaviour with
> --stat and still restricts stat lines to 72 characters without.
>
> > So I think you can just drop the below assignment. But if you want to
> > be on the safe side, check for zero stat_width instead of -1 and set
> > MAIL_DEFAULT_WRAP.
> >
> > > +               opts.stat_width = MAIL_DEFAULT_WRAP;
> >
> > How about a test to make sure this will not be broken in future?
>
> Sure. Only today was the first time I had a look at the git sources,
> so some guidance would be most appreciated.

No problem (and if you don't have time to do it, just say the word and
I will continue; this is my bug after all)

> Should I add a function to t/t4014-format-patch.sh and just put
> something longer than a/file for the expect template?

First of all the README file in that directory could give pretty good
basic instructions.

Back to this test, I think you could start by copying to a new test
(the whole "test_expect_success" block, optionally including the
"expect" file creation too), add --stat there and see what it looks
like. For stat testing, t4052 could also be a good example. Or perhaps
the test should be added in t4052 because it already supports long
file name ($name is 120 char long).
-- 
Duy
