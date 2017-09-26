Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C634220281
	for <e@80x24.org>; Tue, 26 Sep 2017 19:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031947AbdIZTik (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 15:38:40 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:45770 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966493AbdIZTij (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 15:38:39 -0400
Received: by mail-qt0-f176.google.com with SMTP id t46so11539396qtj.2
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 12:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XpxTAI1WjBg5R9oe7HlJ0Jo0MjaCTCyy/De8YavddZU=;
        b=Pi17z9Tx+izGJPcQH43YlAezElwhf8u6bBL1XEYkjS9ozDZubxd2TKx2xwt2i3L8+U
         lrYfLNComFi1hzoNzVm2udsBCpYlkloh+J2QntysII1q0XxdcGcqMnkc831oR9zzyhWT
         r47HxaSHJ1PA1iWXKIZSq7NGqsb04HPTkd6HTbJ8rHY36XDKvqJ5JijKdTXqQSnhJeXB
         rmQCjCx6AUGjJOvKq5qIxZmZl3WTaZ7gXowUixmp05oq5LhuXeZrl3pSA345cO2dotQy
         tFW/wpqiKCR4J0dGvxmFTNUCEj+UJ/0XzCrvgwZry7CNn94N3LDtRoGzvtb0uwaIgTdg
         PgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XpxTAI1WjBg5R9oe7HlJ0Jo0MjaCTCyy/De8YavddZU=;
        b=HDNK4iWEz+mX+fh4SErmZUc9F7Vsg9CQZxDshUvQ6+QLwMbJ338gP+NdDpGghGKfu3
         EP8RCr59WjgBl9nygKMwdvY5tfDZcVtjCLAjgYJnvWidbbr7go/wYN+CKUN3+jKTHQ7v
         xim89yxzPkKH7d+0FK78X4GEh08t6LTDs/LNudwrqDacEy3Cw32pW6OwyMl9qhzBWMm1
         ioHuBfyu2vWlmHRc/9kijDtZwhMYsKBYoiTvd9FwV6/pFxxSiXWpIRX22r26K4AJq3wq
         dphIhZxiRuXDtFIPT8c34z/az7D2meLgkSCuambVrCiWyMWnOvTniXjNSB8r/aDaZz9m
         PXdQ==
X-Gm-Message-State: AHPjjUh01Lim6lIS3yCIX+HVh+bBuFaOKu6GGi5sNJjE1P5oUmBDuWDc
        KntfaFnZzE6/vaaR0o9THdVqYmup/3b5BvlkzNSKLQ==
X-Google-Smtp-Source: AOwi7QBRgEK2Zo6zy+cInZ1RuoeNlfmh/X5+MmYxDceZ26KIYW3rIPJ2wU9PSH2e7JAQ0Y47qqDGmmNTzMrSGIKpkt8=
X-Received: by 10.200.47.173 with SMTP id l42mr17943380qta.298.1506454718862;
 Tue, 26 Sep 2017 12:38:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Tue, 26 Sep 2017 12:38:38 -0700 (PDT)
In-Reply-To: <CAFY1edZ6FX6s+H_XWa-=nKqr4NA9BNVxR6fcOo+5gn-Z1XKdUg@mail.gmail.com>
References: <CAP8UFD2j-UFh+9awz91gtZ-jusq7EUOExMgURO59vpf29jXS4A@mail.gmail.com>
 <xmqqbmm0h6h1.fsf@gitster.mtv.corp.google.com> <CAP8UFD1C80cHnMtdZ-iTYQpNNErUEJ9TmQ9baG1J2w+pv1ceSw@mail.gmail.com>
 <CAFY1edZ6FX6s+H_XWa-=nKqr4NA9BNVxR6fcOo+5gn-Z1XKdUg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 26 Sep 2017 12:38:38 -0700
Message-ID: <CAGZ79kZzgBYLRHWcVZX9BcWBvrg4gQa0Y1f+A357hi-L4j+v2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Teach 'run' perf script to read config files
To:     Roberto Tyley <roberto.tyley@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Roberto Tyley <robertotyley@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>   "Note: Amazon SES overrides any Date header you provide with the
> time that Amazon
>   SES accepts the message."
>
> http://docs.aws.amazon.com/ses/latest/DeveloperGuide/header-fields.html
>
> ...so the only way SubmitGit can offset the times is to literally
> delay the sending of the emails,
> which is a bit unfortunate for patchbombs more than a few dozen commits long!

How many series of more than "a few dozen" patches were sent to the list lately?
I'd argue this is a non issue for the typical use case of submitGit.

> I'll take a further look at this when I get a bit more free time.

Thanks!
Stefan
