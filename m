Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E1620966
	for <e@80x24.org>; Mon, 10 Apr 2017 16:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbdDJQb4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 12:31:56 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33402 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbdDJQbz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 12:31:55 -0400
Received: by mail-vk0-f68.google.com with SMTP id j137so13233375vke.0
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zXwYpOhKcCk7TvlOec87GRRPiwOP8eThWwXiYBCrTPo=;
        b=qhnACsYRQRGdabEbW3ad1YH86+QCLm/LkJlwYX2l/iVSk0fDtRDJAU6Rm1hPQ9329t
         lB+Gcr+vJmjIPXmf4Ycs1eAvE04UVJoOlCEO04ipX1Vbb8q4OV4s+1VhHwzYNzuFxSFw
         EpKsnY4lFWT4Qefwoihb3C6+PHQQ4ELgczX03fYuPVz8ABjSJufYhFi2Fai0E6SivMHk
         4ymm6FPEUDnf7EqSF7WdfxPEi7gqT/OlfVNGRdvsfMNMTRb52sZsG8lUSuSVy40NZkNe
         NL2DZT5/5T5e1qdvSN/obksXBTtTntGLrFxe1henhQs0tUpoB+WtMGq5+3Uv6i+ccQOK
         byXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zXwYpOhKcCk7TvlOec87GRRPiwOP8eThWwXiYBCrTPo=;
        b=EUmby557CZvh/zxdpvhakD2biLKyCsuIaq93iyJ7mrpLSuSNPEq008UkOwYCXbsW0H
         U+6gBmGJF3uHNsr0Lw7j0P0jMqfIRi1uduZ7w/kd9YKvZGZaqF+2X+qDps7ZQoIoXNxo
         z2ciZFd9pgJ9orB9DF1amiu8al+iAA93x8j0g8VUTxfmERW3ZM8h7jzKoMk9NmkUYOBD
         9Sd0EO24zl0q4daSJSMjNcfMcu3ACnvdrZejdIno2KAIyWITy7uPuaa7lG02c9+Hyefx
         mRlOS672EpPliPpkSWoo5oM6N/OoouEFIkCaeB2Lo1xzw/1oWEJcUSduUQO3ei2QR5ka
         7v3w==
X-Gm-Message-State: AN3rC/4DO/gUVw+FjbaUp6qB3uzVUwO8LDS8fRUrKKaJioe+C/ToOWc9XvLhbLMCrp3b2CVZH8BB+u4PX0klYA==
X-Received: by 10.31.182.141 with SMTP id g135mr1691534vkf.32.1491841914822;
 Mon, 10 Apr 2017 09:31:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.16.94 with HTTP; Mon, 10 Apr 2017 09:31:54 -0700 (PDT)
In-Reply-To: <20170410135837.2ukgksfxdlcfqldy@sigill.intra.peff.net>
References: <20170410125911.6800-1-szeder.dev@gmail.com> <20170410135837.2ukgksfxdlcfqldy@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 10 Apr 2017 18:31:54 +0200
Message-ID: <CAM0VKj=4Utapk9iFasChkPSdkWxB5WiHtpZGPUYKMC5LKrnGXw@mail.gmail.com>
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test script
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 3:58 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 10, 2017 at 02:59:11PM +0200, SZEDER G=C3=A1bor wrote:
>
>> While this change doesn't completely eliminate the possibility of
>> this race, it significantly and seemingly sufficiently reduces its
>> probability.  Running t6500 in a loop while my box was under heavy CPU
>> and I/O load usually triggered the error under 15 seconds, but with
>> this patch it run overnight without incident.
>>
>> (Alternatively, we could check the presence of the gc.pid file after
>> starting the detached auto gc, and wait while it's there.  However,
>> this would create a different race: the auto gc process creates the
>> pid file after it goes to the background, so our check in the
>> foreground might racily look for the pid file before it's even
>> created, and thus would not wait for the background gc to finish.
>> Furthermore, this would open up the possibility of the test hanging if
>> something were to go wrong with the gc process and the pid file were
>> not removed.)
>
> Could we just leave open a pipe descriptor that the child inherits, and
> wait for it to close?
>
> Something like:
>
>   git gc --auto 9>&1 | read
>
> should wait until the background gc process finishes. It depends on our
> daemonize() not closing descriptors beyond 0/1/2, but that is certainly
> the case now.
>
> It also loses the exit status of the main "git gc", but that can be
> fixed with shell hackery:
>
>   code=3D$(sh -c 'git gc --auto; echo $?' 9>&1)
>   test "$code" =3D 0

Indeed this seems to work, and luckily we don't need that much
hackery.  When there is a single variable assignment and the expansion
of a command substitution is assigned to the variable, then the exit
status is that of the command inside the command substitution, i.e.

  $ v=3D$(false) ; echo $?
  1

This means we can write this simply as:

  doesnt_matter=3D$(git gc --auto 9>&1)

It's still hackery :)

OTOH, this makes it possible to continue the test reliably after the
gc finished in the background, so we could also check that there is
only a single pack file left, i.e. that the detached gc did what it
was supposed to do.
