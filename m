Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72D821F855
	for <e@80x24.org>; Mon,  1 Aug 2016 16:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbcHAQ7M (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 12:59:12 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:37375 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220AbcHAQ65 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 12:58:57 -0400
Received: by mail-it0-f51.google.com with SMTP id f6so176443632ith.0
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 09:58:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n9srw/4bDNA5ifMYEJO9lXtamzWM7w/tVff87AmH044=;
        b=fb5aoxwwVNeGnKyMDPL0kdiuGM6bEUludJ2pJzeIHXiaYKTLzMPtot7m96CQOdwTpm
         tP1zPpyG5hHUSXJS2kso8WT80zHNohVTUFzbHE6mZf1VrZy/INoSu5yIhyrnwjeC7aU2
         m4gA02pUJ4tEyGHyrhWZQHIA5dbPQ5okOpHgXvqABvxpW/sBDCGgkoHNgvZ8iaMM54L7
         8QjB0d4rJ1ehih5TETlbRXyFXsjtylhkAFUe7ApbodWXjfBvmwRAemo1Yoc9xEFTXpq3
         9WjvDVddaBY3EiwZIVJcS5dCaXCSTMpRKv6Pjy9Re/Pyd3QUOF2Xs0ErN9hX7scBtCyu
         qynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n9srw/4bDNA5ifMYEJO9lXtamzWM7w/tVff87AmH044=;
        b=Jc4a4KKxeIa9jOZ9F9aBsWGLortEqlLDdEQCoX2M+y1Ie2Cd23Z2Z2BekXG1wVy7BL
         AUoHG6Dam0xYFOb7ljtWMsohGJF7aRTkfWKjPhFlWjr1m2JfHQ7e4JWQCU0HLOPd6xDo
         WSTq2kvgtW90j7xapTOkM/Jox1uJiimlzZJWmWtm3ewR5MSP7CNrKROG68ft+ScQ7qtK
         Gw+MeGcmnhETNJK4xp3AqfATXw8Jfvm7j4BpCS56gv6ictTqAq8eJV8QQKt33RyP0Bod
         BYPX/qMQJE9NUAf/hxJDpqH/aWXM6XS8evmlSN1wffvMRCZ94rnQeSI/OIoN7VNmd5/E
         U2Eg==
X-Gm-Message-State: AEkoousn5oZZHDTNGkpqDcSHX2NNpECGgd/3NgyUoA9/qlR+uFCAIF0gJ4XbwA+gHnGTvugNdvoACLmt0Xd2ImS4
X-Received: by 10.36.228.138 with SMTP id o132mr14381120ith.49.1470070736126;
 Mon, 01 Aug 2016 09:58:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 1 Aug 2016 09:58:55 -0700 (PDT)
In-Reply-To: <20160730172509.22939-40-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org> <20160730172509.22939-40-chriscool@tuxfamily.org>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 1 Aug 2016 09:58:55 -0700
Message-ID: <CAGZ79kYpm=X2nTdif+Sz3K_cHBqWq2Pu4AmiKrgZ38aDDyTNjA@mail.gmail.com>
Subject: Re: [PATCH v9 39/41] apply: change error_routine when silent
To:	Christian Couder <christian.couder@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 30, 2016 at 10:25 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> +       /* This is to save some reporting routines */

some?

In case of a reroll could you be more specific?
Specifically mention that we use these for the
muting/when silence is requested.
e.g.
/* These control reporting routines, and are used e.g. for muting output */

> +       void (*saved_error_routine)(const char *err, va_list params);
> +       void (*saved_warn_routine)(const char *warn, va_list params);
> +
