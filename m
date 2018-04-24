Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B4C11F424
	for <e@80x24.org>; Tue, 24 Apr 2018 17:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbeDXRrf (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 13:47:35 -0400
Received: from mail-ua0-f173.google.com ([209.85.217.173]:44048 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752891AbeDXRrb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 13:47:31 -0400
Received: by mail-ua0-f173.google.com with SMTP id h15so6701942uan.11
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QDn55Ec4E/iCQ90hQ3iRzsa4Ojwp1sr460SLiilB1yw=;
        b=Y5Zoww5qR1A275goPdHxV7T8F7jP8wB7ct2okEqyqal+aMMCtiYw29nSVI/ceUbYR5
         ZerPn9uMo5JDK4s5Xg565lJx+f5OUHvip2F8QbHDoyNrebeC7egX21HlnnxN/CdmAYRS
         OgcMSt+0B+VJIOrfwO+ETWV0sH8NpMsy3orRulmmV1doUn4X3YH5uYu841SydxcD/79D
         MNgiqYyKHvdslPMBsE3QNPbXJJMY6BGZfFVpGEiUvRVMhP2VuqXZNBuZkJeTKKUb3sc5
         jXo04/7wY4eeSR0D1t6wXCC8RSYAx5w3B61MSQV4B/h2k96uwvJgu+TEbNTBtyoIB+nC
         siaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QDn55Ec4E/iCQ90hQ3iRzsa4Ojwp1sr460SLiilB1yw=;
        b=RK3Wfya/SjsEbskqRukM8FnVx5+uFBVtDkk8yhdITdkJOX31y+Y7cajqdK5aWeIl5C
         Xmz+OD3YCncOACiHn9F5HMkh0hdLBngY642BnQbC8C6g7FaMglJMqB84LQU6u3aQc31w
         ITB4O+P0FTgUqLbC+2OIljwNgVLC83kECAqcYi6Tmr4xTI67DYJfsyJQ2Dol7OqjITf6
         +aSzfba+53HzvK52dq29FRQIhJEvSKeU6STpDpPWcBXXzSjV/voqd4463SfFUA60LXEq
         M/ftLeDP7WmOaZ6PjbWDe+sRFpWmZsomEQRPbJbAvjm7e44ZL3vA+WdJLRNGVtdSMwDh
         x86w==
X-Gm-Message-State: ALQs6tA3Xhka/0zPyAF849EsKE+1WoksZ6xwgdSAMRu52wAbcNCytiEw
        7LqvhZKl1hd3bqL/fWp7/9rldO0eR1KqBHrfj78=
X-Google-Smtp-Source: AIpwx49GWrjieLCOGvO1Snv10HG6w0iE0nb+1hfNCKRF4kgbw30qiDU+PCY8jOH7oNyhoWdZFUqjMqQ6PScAW9rmcUU=
X-Received: by 10.159.56.15 with SMTP id p15mr15794341uad.112.1524592050519;
 Tue, 24 Apr 2018 10:47:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Tue, 24 Apr 2018 10:47:29 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804241354520.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180420133632.17580-2-benpeart@microsoft.com> <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
 <cd49481c-9665-124a-5f94-791f1a16657d@gmail.com> <CABPp-BFqj2TFiHUDsysafq0NHC4MV-QYZVxOZe1TNRrXMOQfng@mail.gmail.com>
 <xmqqwox19ohw.fsf@gitster-ct.c.googlers.com> <1fb11850-4c20-5327-a63a-6d1f5aa18ea4@gmail.com>
 <xmqqy3hd8q2k.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1804241354520.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 Apr 2018 10:47:29 -0700
Message-ID: <CABPp-BFwN7nkA1ss0Ca+TSgrqsJLrBscWCOn7Eu0ZS5TmnopvA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Tue, Apr 24, 2018 at 4:58 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
>
> On Tue, 24 Apr 2018, Junio C Hamano wrote:
>
>> Yeah, but as opposed to passing "oh, let's see if we can get a
>> reasonable result without rename detection just this time" from the
>> command line, configuring merge.renames=false in would mean exactly
>> that: "we don't need rename detection, just want to skip the cycles
>> spent for it".  That is why I wondered how well the resolve strategy
>> would have fit your needs.
>
> Please do not forget that the context is GVFS, where you would cause a lot
> of pain and suffering by letting users forget to specify that command-line
> option all the time, resulting in several gigabytes of objects having to
> be downloaded just for the sake of rename detection.
>
> So there is a pretty good point in doing this as a config option.

I agree you need a config option, but I think Junio has a good point
that it's worth at least checking out the possibility of a different
one.  In particular, you could add a merge.defaultStrategy (or maybe
merge.twohead to be similar to pull.twohead??) that is set to
'resolve', and use that to avoid rename detection.

Perhaps performance considerations rule out the resolve strategy and
favor recursive, or maybe you need the 'recursive' part of the
recursive strategy (rather than the rename part), or perhaps there's
some other special reason you need to go this route, but since you are
avoiding renames right now it's at least worth considering the resolve
strategy.

Elijah
