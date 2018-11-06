Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25171F453
	for <e@80x24.org>; Tue,  6 Nov 2018 16:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389289AbeKGBqt (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 20:46:49 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45082 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389159AbeKGBqt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 20:46:49 -0500
Received: by mail-io1-f66.google.com with SMTP id p83-v6so9622476iod.12
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 08:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9rdHwGAT4eBCM3DAyikv7PE1pPH269bBX/p21BI22o=;
        b=CRNKEg07gHa9Kmlcu6N4awSRszf88YqKTazt1H09IG92/oDd5jCf1hS//qHrlfUTSG
         okqmSlY9qYqhWh+/jneVQoPb1LV5fBY3GLXY97KrQWEUi99eoj7mUPEdwwXhDIT52HG8
         JDrHdrndij9EHRf/9EonLIGkmgnELL6GyJUv6b2/fmfQfFelt4oQMOeIUdW5mVjAksny
         /48Xm3gJcRGhZlm/pZjOmbP8sEhYjfTy/8t0oMAyPK+Q/U6RZpvJMd0Mhw/xFNYIawA4
         GtYIK6m5VwZpXi/uuulBcttqQ7E8FpNhWq5DEDi49WUT/3bxN8BfjoG1Ui5WRFCdjngS
         Jm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9rdHwGAT4eBCM3DAyikv7PE1pPH269bBX/p21BI22o=;
        b=rv08/IeuqfAtHmd538Wm14P1rkVlhbcYhj5eSZF+0yaGbM7KQpL61PfR9x6gXvzlWt
         VifNVt47BZchDWD2PjguWNqfpyu1TBCnshVjCUo33nCosgiIS85uii6/Ea8qZRjzNDqr
         04fMHkNciYNcXZk6IXQavMQbSQJoSm4xKP97995xwA3qxoB8b9UT4pLHd+eS3smHq4lO
         ylYQN0YYMyXBJwgXFPFfBg1KbJlpbeH0nxOpZTmxx7yd/DHWi0j+dMEo2EOaJJxf18O8
         57zGN9GRhH/F4AN/y1e1wD5stYfDv5Z5qSq/06gy2dv160pXRrLCLGU2WyEYxS7iCHEO
         25Gg==
X-Gm-Message-State: AGRZ1gJJt0cu9YWDVd3J2QwPFORgGpP6qsZpHTVKYX0rDPXkK7B3akUh
        4VMklE5CDG6wcSgAJuzXY06xqFm+HX/yigQisqk=
X-Google-Smtp-Source: AJdET5fdSF2e/ovCFUBQXeHt6rPP0X14e0crhgDLb74aabpQVBIbLMEN8htqdMDYi656ps9WoXtjPoNeMIZabsBgoe0=
X-Received: by 2002:a6b:9383:: with SMTP id v125-v6mr18884867iod.282.1541521251848;
 Tue, 06 Nov 2018 08:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20181106104811.14625-1-leif.lindholm@linaro.org>
 <CACsJy8AjY1-KT9x_CXuo+L3-g947OaC5Av0KwuJF-Xkz6VMiPQ@mail.gmail.com> <0171b18f-0732-48fa-b4be-efbc9ba22f85@redhat.com>
In-Reply-To: <0171b18f-0732-48fa-b4be-efbc9ba22f85@redhat.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Nov 2018 17:20:25 +0100
Message-ID: <CACsJy8CqfApePPY4zA9f=KOSTsA8pUA2ez_3KiXeOJQqtSNb7Q@mail.gmail.com>
Subject: Re: [PATCH] format-patch: respect --stat when explicitly specified
To:     lersek@redhat.com
Cc:     leif.lindholm@linaro.org, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 6, 2018 at 5:18 PM Laszlo Ersek <lersek@redhat.com> wrote:
> >> +               opts.stat_width = MAIL_DEFAULT_WRAP;
> >
> > How about a test to make sure this will not be broken in future?
>
> Oh, looks like I won't have to test this patch at all! ;)
>
> (Just kidding, I'll test the next iteration.)

Just to be clear I didn't mean you didn't test it. I meant adding a
new test case to our test suite.
-- 
Duy
