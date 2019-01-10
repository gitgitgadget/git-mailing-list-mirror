Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B18E1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 06:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfAJGbE (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 01:31:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36335 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfAJGbE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 01:31:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so10725729wmc.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 22:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NPeTiXWX1eT+klYKeTavi1vSmY/mGf30JjPbSEcI/nk=;
        b=srBg99Ys8haYeHaRLHgC2IisH4CQFnxN8Wd7/U0mb1AuYxnBv07i276tO7N3wGkLIg
         Nb+ll6OWaDTKm4ssbf6dAqP/8l7VYO54EDZWwB8nCoHr+xgqskcVwgYyCVeJnjnZNYTk
         mAp+kKXqqJHFufGkid9KbxiI4GrPsUpZ8CtsXbMp4iANNc2i7lAk5IaWcevHxxA6tmeM
         pqB7prNAAEqN6+jvXz2CDxTyKI1mllgtzmW7qb9AFwobC6JmXb61eReKB4jhDjsUuq7U
         3/ogJcYwx6SZARR/mUdCEZJXnXCcSHtA66Cc3hWJBXGyh8IZEtTGa2z83lR/n8+WjB24
         iR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=NPeTiXWX1eT+klYKeTavi1vSmY/mGf30JjPbSEcI/nk=;
        b=oMHts28bSSuHTzlFtrDvxRY11ezn6UMAEF+rz5thoYruYosIcKr5ABL1kXNLK0i3fx
         /SA8u7OqJfarsa75HqfnJI948TMJal+yxayVzylQJ7qmpS3HA1vk5Th1uF+VmJo4SWr9
         wsZ+SH1hPCOjSvH0YKb7vCYUmERfaarWvvSUO2YjmGrfZs88XnosN7eYXQZWVOz9cTCt
         nYpFhV8loyGRtRcHdkScad7D/PVwUc1nUIYBvPSVRh8XjY9DCd1VCmxLmBIXmR72j6so
         2BuvZXrQZsAAekV73FjhiiF9E5MAf/tZYt87GKPtMARBGZC0M2750EDkVJnG4pBb4iKG
         lxKA==
X-Gm-Message-State: AJcUuke/i+/oYStg0RQJ5aue8miQcdKMpGi0Hp0qPJWR+A7Zhw7tTg6D
        448op+LRQ0Wf9Z3xv8yllJm1BsgNf0XKHeZhK+ZGc6I3
X-Google-Smtp-Source: ALg8bN74V7HwyL0oEDH3CQwZFxZzUpQq+ChHENVPRqhybh+gq+JG9YZ888mX3N6YgC2hFKQ5LN1PBbNQeFIJ8xVkyRM=
X-Received: by 2002:a1c:6e06:: with SMTP id j6mr8735184wmc.3.1547101862151;
 Wed, 09 Jan 2019 22:31:02 -0800 (PST)
MIME-Version: 1.0
References: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com>
 <CAL21BmnmfxpMgbW_Yz9D=FVZk_AzWF0uyrNZeSGPCs63PH1oag@mail.gmail.com>
In-Reply-To: <CAL21BmnmfxpMgbW_Yz9D=FVZk_AzWF0uyrNZeSGPCs63PH1oag@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 10 Jan 2019 09:25:40 +0300
Message-ID: <CAL21Bm=stCR8-yJ-eh396veQ2kAoGwLX5ci_T0N-6femAwk4jA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ref-filter: add new formatting options
To:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D0=BF=D0=BD, 24 =D0=B4=D0=B5=D0=BA. 2018 =D0=B3. =D0=B2 16:16, =D0=9E=D0=
=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@=
gmail.com>:
>
> =D0=BF=D1=82, 9 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 10:37, =D0=
=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelez=
hnaya@gmail.com>:
> >
> > Add formatting options %(objectsize:disk) and %(deltabase), as in
> > cat-file command.
> >
> > I can not test %(deltabase) properly (I mean, I want to have test with
> > meaningful deltabase in the result - now we have only with zeros). I
> > tested it manually on my git repo, and I have not-null deltabases
> > there. We have "t/t1006-cat-file.sh" with similar case, but it is
> > about blobs. ref-filter does not work with blobs, I need to write test
> > about refs, and I feel that I can't catch the idea (and it is hard for
> > me to write in Shell).
> >
> > Finally, I want to remove formatting logic in cat-file and use
> > functions from ref-filter (we are almost there, so many work was done
> > for this). I had an idea to make this migration in this patch (and
> > stop worrying about bad tests about deltabase: we already have such
> > test for cat-file and hopefully that could be enough). But I have
> > another question there. cat-file has one more formatting option:
> > "rest" [1]. Do we want such formatting option in ref-filter? It's
> > easier for me to support that in ref-filter than to leave it only
> > specifically for cat-file.
>
> Updates since previous version:
> 1. Fix type cast not to generate warnings/errors in other system
> platforms (travis CI says that everything is OK now)
> 2. Add check for negative object size (BUG if it is negative)
> 3. Update documentation (thanks to Junio for better wording)

Just fixed 1 cast from (intmax_t) to (uintmax_t).

>
> >
> > Thank you!
> >
> > [1] https://git-scm.com/docs/git-cat-file#git-cat-file-coderestcode
