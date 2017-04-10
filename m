Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91AF1209F1
	for <e@80x24.org>; Mon, 10 Apr 2017 14:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbdDJOwQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 10:52:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33616 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbdDJOwP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 10:52:15 -0400
Received: by mail-wr0-f196.google.com with SMTP id l28so4675446wre.0
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=81Z1zmuw/MDBeY5LtBm+KLm9Pfp5uEEtiUrsNFzEEn4=;
        b=Uc/qHTNEb+fRjVC/0Lsqer5GLmvnMkq0n7VV1xZeVxhz4sPyiICs9IB9XMbfg7NEGy
         i2ff5ctT3WYzVwFz4yrsZED7Js3q3BQ4CyEVPuGyCCqrapAFR5w1E+ZhczZSpIH6N34H
         uBVAEVYD6v7pOnARqW5dtrO0zxb0otsLZF/grfWEr9AkfDtaEPcrVldDUM12gb3Ly9Kb
         zt2QSwAggSD4rOE7U8MD4rqYP1j6v+xDYLQwVPTJfZjO7i4SxJ7438PygU8x9jvxwyDj
         l9bJpzK5c+yjD8fAHCXfns1mMdYTGB2mpg8nhvNuQ3JQFh1pQH04ZCpYJ1987xw7vkg4
         OGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=81Z1zmuw/MDBeY5LtBm+KLm9Pfp5uEEtiUrsNFzEEn4=;
        b=Gb04DcRYyo+bKfD4BIj0RusYqQJ8R7sxC8W1unfLFwOTRYFCFzoI87Yaunn6I6XFwk
         EYxvGWfkeiIm1lwXM/C7S+1Mu/YBgltZ2S0AiO8SI3EP79gf5sdx0tokaYKI7pzDTvyt
         2GBX1DV7uFyM770wgihdoRkikEAaF/TlIXrdXz9wVllkEs64OLLhPuMeI54Y3s729oj0
         Hm9R+0cIMY2CaS93C+78WfO2sWF4lG+1y4U1phg9JJpbG1v3wHatv59fIDE+GRyiquSo
         OLVgLZVD5mC4ysGayCAK5z2xUci7UTWIEr6zAZhiJs/LJZJ1QF5MkbNHuTvrVe9ZhrlL
         qkEw==
X-Gm-Message-State: AFeK/H20bYFep2pnpdH70xGuxLYnsfCnTBq0Vw07AbOH0W3dmvXjoWMmzppgP7vQi+scLA==
X-Received: by 10.223.172.129 with SMTP id o1mr43325510wrc.121.1491835934178;
        Mon, 10 Apr 2017 07:52:14 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id v188sm10636772wmg.11.2017.04.10.07.52.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 07:52:13 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 4/4] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170410142850.GA23068@starla>
Date:   Mon, 10 Apr 2017 16:52:12 +0200
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        ttaylorr@github.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F4C4D5CD-5A96-404C-88D0-00BCC78A1C65@gmail.com>
References: <20170409191107.20547-1-larsxschneider@gmail.com> <20170409191107.20547-5-larsxschneider@gmail.com> <16331164-8E8C-4CDA-B319-AB8092BD7188@gmail.com> <20170410142850.GA23068@starla>
To:     Eric Wong <e@80x24.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Apr 2017, at 16:28, Eric Wong <e@80x24.org> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> wrote:
>>> diff --git a/convert.h b/convert.h
>>> index 82871a11d5..da6c702090 100644
>>> --- a/convert.h
>>> +++ b/convert.h
>>> @@ -42,6 +42,11 @@ extern int convert_to_git(const char *path, const =
char *src, size_t len,
>>> 			  struct strbuf *dst, enum safe_crlf checksafe);
>>> extern int convert_to_working_tree(const char *path, const char =
*src,
>>> 				   size_t len, struct strbuf *dst);
>>> +extern int async_convert_to_working_tree(const char *path, const =
char *src,
>>> +					 size_t len, struct strbuf *dst,
>>> +					 void *dco);
>>>=20
>>=20
>> I don't like the void pointer here. However, "cache.h" includes =
"convert.h" and
>> therefore "convert.h" cannot include "cache.h". That's why =
"convert.h" doesn't
>> know about "struct delayed_checkout".=20
>=20
> You can forward declare the struct without fields in convert.h:

OMG. Of course. Now I feel stupid.

>> I just realized that I could move "struct delayed_checkout" and "enum =
ce_delay_state"
>> definition from "cache.h" to "convert.h" to solve the problem nicely.
>>=20
>=20
> But yeah, maybe you can reduce cache.h size, too :)

Yeah, then I will do this in the next round.

Thanks,
Lars=
