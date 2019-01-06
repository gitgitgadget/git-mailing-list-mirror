Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BF9D211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 18:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfAFSSE (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 13:18:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54116 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfAFSSD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 13:18:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so5243870wmb.3
        for <git@vger.kernel.org>; Sun, 06 Jan 2019 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8zql9kNLMJJ/iIHF7vgXGCN5nvGAG1IrwrsAu2lnyYQ=;
        b=TjufoeWxIBraZ9BEi+cFrztBWnzs7wUmsp9gkCvalvGqYd9gudVLa+DZkYKNuURR7c
         qcybd60BaDwKPM1DlGYq+OCGyK73UyqwC7cM2r/BU7hhaEI13f0hmXbtUJ5YAAfo5A9g
         tOId99FXOEpVrbE5nkBPXdWn2r/AGIxn0F9c3145H5oOxfoCHEaz6ymjzPZXucyYMuVh
         YbtYUCuyrttmOWIpN63g9LUBv3wtVlnvSB5kTT/8XGVgff/DET0FZBJ/Bc/OsP9pakxI
         mJ+uiKtsdgYU/eULvKn+Jqpcc9FsHHldhIrBZo4jM5P7Xtj/C+jd9Ystym2ufIIKo9nj
         t/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8zql9kNLMJJ/iIHF7vgXGCN5nvGAG1IrwrsAu2lnyYQ=;
        b=Au70KWlPoFzCnUsM2x+TI0pP25hExAfqgCPSnKXY9kxMKwHP1HSSZJWvBqjbPvXOyt
         1wjCAy9/QbSnGaZtRl9zdx986Vm/ekhfli4kMYj7iO4uf+7VaO1/kT957TmOlwcL8ISv
         PQjfYSOzU6I++QjXUj3ORFPGzWbFbqPgL45tKbF0tDFwoeSPUtsIn0UTqNV3j3u9F6A8
         +cG93PD8eFHem4Y8wyAhNikaK4VMm1PBt5hO1nfiiu5hHpygst82lt+yI5yx8ttRaRhz
         BUc65vInbN9I/fDtIp6I6dQl0MC3EYXv9fjP0uMlixGy3+ETD4jJ2AiksLCS4eQoZv7e
         1y0g==
X-Gm-Message-State: AJcUukcSlkxo2Ld8NdIMd5hHD+HtOwnLJxeea2noLxefowchfBBoaGNQ
        bmGxYYGvhs1FUn/nG5fwdSA=
X-Google-Smtp-Source: ALg8bN5xG2h6SgH83gQOMRB41Dot9cHt3L4Bf8XJyOZAED1puMq4Lcr/b4ZA/MTTdTDoDo0CQnvypQ==
X-Received: by 2002:a1c:8148:: with SMTP id c69mr6450656wmd.126.1546798680510;
        Sun, 06 Jan 2019 10:18:00 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id f66sm6098293wmd.28.2019.01.06.10.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Jan 2019 10:17:59 -0800 (PST)
Date:   Sun, 6 Jan 2019 18:17:58 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Masaya Suzuki <masayasuzuki@google.com>
Subject: Re: [PATCH] config.mak.dev: add -Wformat
Message-ID: <20190106181758.GF25639@hank.intra.tgummerer.com>
References: <20181012184037.15076-1-t.gummerer@gmail.com>
 <20181012184549.GC4917@sigill.intra.peff.net>
 <20181012185450.GB52080@aiede.svl.corp.google.com>
 <20181012191531.GA22611@hank.intra.tgummerer.com>
 <20181227185900.GE146609@google.com>
 <xmqqa7khisue.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa7khisue.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/03, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > In October, Thomas Gummerer wrote:
> >> On 10/12, Jonathan Nieder wrote:
> >>> Jeff King wrote:
> >>> ...
> >>>> -Wformat is part of -Wall, which we already turn on by default (even for
> >>>> non-developer builds).
> > ...
> > As discussed in [1], autoconf appears to not put -Wall in CFLAGS:
> >
> >  $ make configure
> >      GEN configure
> >  $ ./configure
> > [...]
> >  config.status: creating config.mak.autogen
> >  config.status: executing config.mak.autogen commands
> >  $ grep CFLAGS config.mak.autogen
> >  CFLAGS = -g -O2
> >  PTHREAD_CFLAGS=-pthread
> >
> > So this trap for the unwary is still around.
> >
> > Can we revive this patch?  Does it just need a clearer commit message,
> > or were there other objections?
> 
> I think it is a good idea to give fallback/redundancy for this
> case.  I do not have strong opinion between -Wall and -Wformat,
> but I'd probably vote for the former if pressed.

Just catching up after some time off over Christmas, thanks for tying
this up!

I agree with the choice of adding -Wall to the CFLAGS here, so even if
it is not added to the CFLAGS generated by autoconf (or in mnually set
up CFLAGS such as in my original case), we still get a complete set of
warnings when DEVELOPER=YesPlease is set.

> -- >8 --
> From: Thomas Gummerer <t.gummerer@gmail.com>
> Date: Fri, 12 Oct 2018 19:40:37 +0100
> Subject: [PATCH] config.mak.dev: add -Wformat
> 
> 801fa63a90 ("config.mak.dev: add -Wformat-security", 2018-09-08)
> added the "-Wformat-security" to the flags set in config.mak.dev.
> In the gcc man page this is documented as:
> 
>          If -Wformat is specified, also warn about uses of format
>          functions that represent possible security problems.  [...]
> 
> The commit did however not add the "-Wformat" flag, but instead
> relied on the fact that "-Wall" is set in the Makefile by default
> and that "-Wformat" is part of "-Wall".
> 
> Unfortunately, those who use config.mak.autogen generated with the
> autoconf to configure toolchain do *not* get "-Wall" in their CFLAGS
> and the added -Wformat-security had no effect.  Worse yet, newer
> versions of gcc (gcc 8.2.1 in this particular case) warn about the
> lack of "-Wformat" and thus compilation fails only with this option
> set.
> 
> We could fix it by adding "-Wformat", but in general we do want all
> checks included in "-Wall", so let's add it to config.mak.dev to
> cover more cases.
> 
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> [jc: s/-Wformat/-Wall/]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  config.mak.dev | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/config.mak.dev b/config.mak.dev
> index bfbd3df4e8..74337f1f92 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -1,6 +1,7 @@
>  ifeq ($(filter no-error,$(DEVOPTS)),)
>  CFLAGS += -Werror
>  endif
> +CFLAGS += -Wall
>  CFLAGS += -Wdeclaration-after-statement
>  CFLAGS += -Wformat-security
>  CFLAGS += -Wno-format-zero-length
> -- 
> 2.20.1-2-gb21ebb671b
> 
