Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B6AF1F454
	for <e@80x24.org>; Fri, 19 Oct 2018 17:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeJTBpi (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 21:45:38 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:40409 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeJTBpi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 21:45:38 -0400
Received: by mail-ed1-f42.google.com with SMTP id r1-v6so32184011edd.7
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D0R6+qbE9BN40tZM6373LtgVs1c/14t9Ty9aPx7wKbM=;
        b=OCTSzhba/XNxCLCxEu8l7NRngWKPKuQTGpUV1pVyyDaou/Z57TiHCan5AG5Yj6KHCK
         LANoeZDDuLdEJGYbFpi1YbRo9tLAS8svjX3JNmylbHGFtEiysIlGH4aK8Zp0C5aeJkMi
         bFxDZ9Jv/h6DVwv2dm2ut4kYPI6Cp6eP4A6NJxfG79QrFEIARZ0S9KGIGz5KakQkqDIw
         rQROLdlDf7GYdwGfb2j+RTKHezoV/37IhiUJmyE+mYBnsfhEp3ohumNx+LdDRpdVF0Sh
         QS3wlaUr/XD9QqI96r03/F2vWWqnjfUTrPNWpcp/P6PNJgSTuJK0mQEKruq8eJiTUAR4
         nXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D0R6+qbE9BN40tZM6373LtgVs1c/14t9Ty9aPx7wKbM=;
        b=Tq6Q0v9+3KUbNKJKkgBlSNW3VPcjsuLCjZE8yJDJP1/xG2ilURL0cILdadCgeK1mdi
         u+GzWtMj2lvtJxaHfFaX+rtB7dbauixwm8/FmReKoPMINAVFcO9HHhlbLqRpE2JYBvZx
         iCtg/ve49oBx1i/lGN1lFSn3G6OKl9hTqumlJ5p+lWsgHsXN9nRO2sLI5V9i2KZvkNTd
         KuxfLZrgcoXK53O6AEofPBnE1iFqQHWUTZtGpP1HdJOZvykCcp7SLFq4PQLInLwJfV5Z
         3z4VrobAe9gAevBC6n23F/hA4qfxjguMzjqEZuVpip6y1HSSrRYnf9X0jCX/VaO6xOgM
         Gbuw==
X-Gm-Message-State: ABuFfoiNUgUqisO6ZxJZFCYJqb+iAAMEXxPkC4lXnkWk2fEXsx+4TICL
        lv3pqeZjkyZ0eR9eiBMOIdgqyXIdiySTR7hhQxTSFgBQa/4=
X-Google-Smtp-Source: ACcGV619UXf3C1cAjLmkQApqp7MEzlNNKFwd5We8bm7A34IsxmEwR7qYHvXujAucooHoR4uKR04cFXw2KrmOrv25ZI8=
X-Received: by 2002:a50:aca2:: with SMTP id x31-v6mr6773018edc.76.1539970712758;
 Fri, 19 Oct 2018 10:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181019145237.16079-1-pclouds@gmail.com>
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 19 Oct 2018 10:38:21 -0700
Message-ID: <CAGZ79kbQ_QLb_Oa3mg3q2FJUNoLkk_nzqoURHKY1U1i8iUSg4w@mail.gmail.com>
Subject: Re: [PATCH/WIP 00/19] Kill the_index, final part
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 7:52 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> Stefan I see you start removing more references of the_repository in
> another series (haven't really looked at it yet) so this is just heads
> up so we could coordinate if needed. Still WIP, not really ready for
> review yet.

I'll take a brief look anyway, otherwise you wouldn't have put in on
a mailing list :-P

Yes, coordination would be good; stolee brought up a good point
regarding testing these changes. Killing of the index in itself can be
just tested by checking if behavior stays the same, but killing of
the_repository is a slightly different beast, as it relates to submodules,
which means any global state that is still around, need to go into
the repository struct (we might have missed some there, whereas
the index struct has been around for a long time).

> This series removes use of the_index outside builtin/ and t/helper/.
> The only the_index reference left is in repository.c. The macro
> NO_THE_REPOSITORY_COMPATIBILITY_MACROS is now flipped to
> USE_THE_INDEX_COMPATIBILITY_MACROS. "the_index" is forbidden by
> default.

Wow, that is really cool. Looking forward for the patches. :-)

> After this I think we can start pushing the_repository outside library
> code. Then perhaps clean them up in builtin code too and you can
> finally get rid of it. But I don't think that'll happen in a year's
> time.

That sounds realistic.

Stefan
