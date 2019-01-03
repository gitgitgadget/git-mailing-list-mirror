Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F541F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 16:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbfACQz0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 11:55:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37600 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730411AbfACQz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 11:55:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so34162909wrt.4
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 08:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=h7mtwQ46mci/4ji3yW+IbYOOZtmVpQPaBX6qyToQ7GM=;
        b=MA2lXoNlBIs4NFyicl08MgU3vWmj9+hLLgRtOQl+PEZgT1ZPiBABQH5r/zTWgnFlY8
         v3b2k5IDK5fGLUQjQAKQODwHKqaSM2tYTxhtGDy85h6UsVzaKu8VBqpfQg7j1OeB0f01
         hJ4Yusw9JKGLVdBoQbHyVefjipqZiL0M0nIZ+/qS5stfZVCjBaQ36u6n6QNAjITjKwfe
         o5g0yT5rNxzZGpNKWT63z+Wg2O6K0RiIw98ax5dWjFeVgb5Qs3A6XmH3prlu7uYopc2P
         WFz0//eDGSHCNP7nQa/c3QOf0m9ez8Gpt0qzjmWkQzXtBD9jlZqWpQBY6C8Nhsyps5DL
         uFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=h7mtwQ46mci/4ji3yW+IbYOOZtmVpQPaBX6qyToQ7GM=;
        b=RyLnLuyf5ncfMjc+dXTVU1eHgW7oh8ZvEDzCot2bCEqzDV0xUs68EJQnubM5YY2qEP
         xoRVANUX6rCoQOFBm1NoYkAGq2hx4slATrArTaZTjkz/2jbDSWxifM+28jCQL0ZOzakj
         CwKm+UJbkhMOGYl4Cw+Jwjpd9xbByfM/BYm0d1VqSxjA8M49MjJ5loXxnnSaOm+NCCNJ
         Y5s+jmYdFMrctR7FYqxFAFgmGQM9n13Oz6k0EvhKNkk0syTbBwuruGXYMzZlgi9DoM3O
         WJCQTTxI+IcMemL9p3O9a+oLOD+jEl8tNsxuX3lUebxvlp5Lxi+hq1yXWzvyn27I40jn
         4I/Q==
X-Gm-Message-State: AJcUukdWICfJfvLLeQALOewqL9FT8oA25T0892Ao2QeL99aZfiOAh/G+
        qKpCTSkVHyHzFaN/rVU6pco=
X-Google-Smtp-Source: ALg8bN7qPJfMHX8O1MQV7ZTnsSuWKNM+iYe9w5ey5tW+Usr3gJ0F83L0ARuGszr0vpaL/8FTpDYUyA==
X-Received: by 2002:a5d:550f:: with SMTP id b15mr43944065wrv.330.1546534524004;
        Thu, 03 Jan 2019 08:55:24 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j3sm5837549wmb.39.2019.01.03.08.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 08:55:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Masaya Suzuki <masayasuzuki@google.com>
Subject: Re: [PATCH] config.mak.dev: add -Wformat
References: <20181012184037.15076-1-t.gummerer@gmail.com>
        <20181012184549.GC4917@sigill.intra.peff.net>
        <20181012185450.GB52080@aiede.svl.corp.google.com>
        <20181012191531.GA22611@hank.intra.tgummerer.com>
        <20181227185900.GE146609@google.com>
Date:   Thu, 03 Jan 2019 08:55:21 -0800
In-Reply-To: <20181227185900.GE146609@google.com> (Jonathan Nieder's message
        of "Thu, 27 Dec 2018 10:59:00 -0800")
Message-ID: <xmqqa7khisue.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> In October, Thomas Gummerer wrote:
>> On 10/12, Jonathan Nieder wrote:
>>> Jeff King wrote:
>>> ...
>>>> -Wformat is part of -Wall, which we already turn on by default (even for
>>>> non-developer builds).
> ...
> As discussed in [1], autoconf appears to not put -Wall in CFLAGS:
>
>  $ make configure
>      GEN configure
>  $ ./configure
> [...]
>  config.status: creating config.mak.autogen
>  config.status: executing config.mak.autogen commands
>  $ grep CFLAGS config.mak.autogen
>  CFLAGS = -g -O2
>  PTHREAD_CFLAGS=-pthread
>
> So this trap for the unwary is still around.
>
> Can we revive this patch?  Does it just need a clearer commit message,
> or were there other objections?

I think it is a good idea to give fallback/redundancy for this
case.  I do not have strong opinion between -Wall and -Wformat,
but I'd probably vote for the former if pressed.

-- >8 --
From: Thomas Gummerer <t.gummerer@gmail.com>
Date: Fri, 12 Oct 2018 19:40:37 +0100
Subject: [PATCH] config.mak.dev: add -Wformat

801fa63a90 ("config.mak.dev: add -Wformat-security", 2018-09-08)
added the "-Wformat-security" to the flags set in config.mak.dev.
In the gcc man page this is documented as:

         If -Wformat is specified, also warn about uses of format
         functions that represent possible security problems.  [...]

The commit did however not add the "-Wformat" flag, but instead
relied on the fact that "-Wall" is set in the Makefile by default
and that "-Wformat" is part of "-Wall".

Unfortunately, those who use config.mak.autogen generated with the
autoconf to configure toolchain do *not* get "-Wall" in their CFLAGS
and the added -Wformat-security had no effect.  Worse yet, newer
versions of gcc (gcc 8.2.1 in this particular case) warn about the
lack of "-Wformat" and thus compilation fails only with this option
set.

We could fix it by adding "-Wformat", but in general we do want all
checks included in "-Wall", so let's add it to config.mak.dev to
cover more cases.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
[jc: s/-Wformat/-Wall/]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.dev | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.dev b/config.mak.dev
index bfbd3df4e8..74337f1f92 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -1,6 +1,7 @@
 ifeq ($(filter no-error,$(DEVOPTS)),)
 CFLAGS += -Werror
 endif
+CFLAGS += -Wall
 CFLAGS += -Wdeclaration-after-statement
 CFLAGS += -Wformat-security
 CFLAGS += -Wno-format-zero-length
-- 
2.20.1-2-gb21ebb671b

