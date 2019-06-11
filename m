Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77981F462
	for <e@80x24.org>; Tue, 11 Jun 2019 00:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfFKAlK (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 20:41:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41397 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbfFKAlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 20:41:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id 83so5903879pgg.8
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 17:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ae4j4XJXudu9eCGSaiRuyx+ZeC4mP6i9EaFUOWRFBbo=;
        b=rwwjoV2RrJZGMEyrFJgCUwdvr0soTTcx+q1fL2870OCFmFcAe0SXXn5G92QEdjTeVs
         Iy2JNvs9voyI53eLGRb6IhvmPjnEODmwe2nJT4KUGcpR3BYQMNi/Y7eB01Z+PxDtt6gF
         xI8isXUUBGjF+6rh+lerB4lS3akwgyWjKQ+/8qBCahvh2ktjmKXsCusKM+mrQEK28ygC
         IWAQICxNqGge8fjMyT4LJOkp8GNGocxe5q/MZzHw1VFiEIVxeCOvkvvBefIQ/g03cRvy
         y8K0LXXP9suM5a87YMGsAQuNfDgXbVfXbhgbS2sFFvDysO1wcpMm9Fugov0jnop9nX4c
         GTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ae4j4XJXudu9eCGSaiRuyx+ZeC4mP6i9EaFUOWRFBbo=;
        b=JcaLmxXxF/0tnwgzAep5qlPezOAAY8D8IodxdBqlLjaw+58418lqmtiBxg7CZV232/
         PTBjM6/o4hgR528TCe5uyBOlS4wRyE5ZnqU+lBy5Yi+lp+ZWkVGTIukL1oPKR6pJfcpE
         lNRfXJLoqBdWGa8smiVEXjD1bh653iDoV20PFqSSchax2s58kd9U03+ICeQxiDMuo16z
         hFn38jw1QlarANTaK22ZvvvthXcyl39eU1PB2ZjE9eFJ8A5lbIUxmkb1o1ybVYFmnzVD
         z0agqyhbY/Gr8XtEFipkBoVosL9nI0C0iCtBoc1gyT/olkGzyQTCNicAvcXjxTGSbFDk
         /YpQ==
X-Gm-Message-State: APjAAAXsHw2mRmPCg3e9EUbAl+Iaqf5rhX9rQV1KqVEqX29Cqb2Lz2Wn
        smBXeGt/EB0j4qs8VJg0i2ZhP7Ni
X-Google-Smtp-Source: APXvYqyiTzW7YXAwSl6S60Cr/KY3PC6LCIQolQIOnfxr645BhS/A0fJjkK0lW+bAOP8Ux8crcRKfiw==
X-Received: by 2002:a63:f346:: with SMTP id t6mr11185745pgj.203.1560213668800;
        Mon, 10 Jun 2019 17:41:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id v138sm9052509pfc.15.2019.06.10.17.41.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 17:41:08 -0700 (PDT)
Date:   Mon, 10 Jun 2019 17:41:06 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        avarab@gmail.com, git@matthieu-moy.fr, olyatelezhnaya@gmail.com,
        samuel.maftoul@gmail.com, gitster@pobox.com, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com, emilyshaffer@google.com
Subject: Re: [RFC PATCH] ref-filter: sort detached HEAD lines firstly
Message-ID: <20190611004106.GB64137@google.com>
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
 <nycvar.QRO.7.76.6.1906090954510.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <20190610234918.GA10396@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610234918.GA10396@comcast.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Matthew DeVore wrote:
> On Sun, Jun 09, 2019 at 10:17:19AM +0200, Johannes Schindelin wrote:

>> I find that it makes sense in general to suppress one's urges regarding
>> introducing `{ ... }` around one-liners when the patch does not actually
>> require it.
>>
>> For example, I found this patch harder than necessary to read because of
>> it.
>
> I understand the desire to make the patch itself clean, and I sometimes try to
> do that to a fault, but the style as I understand it is to put { } around all
> if branches if only one branch requires it. Since I'm already modifying the
> "else if (cmp_type == FIELD_STR)" line, I decided to put the } at the start of
> the line and modify the if (s->version) line as well. So only one line was
> modified "in excess." I think the temporary cost of the verbose patch is
> justified to keep the style consistent in narrow code fragments.

Git seems to be inconsistent about this.  Documentation/CodingGuidelines
says

        - When there are multiple arms to a conditional and some of them
          require braces, enclose even a single line block in braces for
          consistency. E.g.:

so you have some cover from there (and it matches what I'm used to,
too). :)

[...]
>>> +	LC_ALL=$zh_CN_locale LC_MESSAGES=$zh_CN_locale \
>>> +		git -C r1 branch >actual &&
>>> +	git -C r1 checkout - &&
>>
>> Why call `checkout` after `branch`? That's unnecessary, we do not verify
>> anything after that call.
>
> It's to get the repo into a neutral state in case an additional testcase is
> added in the future.

For this kind of thing, we tend to use test_when_finished so that the
test ends up in a clean state even if it fails.

[...]
> test_expect_success GETTEXT_ZH_LOCALE 'detached head sorts before branches' '
> 	# Ref sorting logic should put detached heads before the other
> 	# branches, but this is not automatic when a branch name sorts
> 	# lexically before "(" or the full-width "(" (Unicode codepoint FF08).
> 	# The latter case is nearly guaranteed for the Chinese locale.
>
> 	git -C r1 checkout HEAD^{} -- &&
> 	LC_ALL=$zh_CN_locale LC_MESSAGES=$zh_CN_locale \
> 		git -C r1 branch >actual &&
> 	git -C r1 checkout - &&
>
> 	head -n 1 actual >first &&
> 	# The first line should be enclosed by full-width parenthesis.
> 	grep '$'\xef\xbc\x88.*\xef\xbc\x89'' first &&

nit: older shells do not know how to do $'\x01' interpolation.
Probably best to use the raw UTF-8 directly here (it will be more
readable anyway).

Thanks,
Jonathan
