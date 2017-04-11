Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611E01FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbdDKKeJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:34:09 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36278 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754086AbdDKKdS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:33:18 -0400
Received: by mail-io0-f179.google.com with SMTP id l7so128384580ioe.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 03:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x571+MF2/isqI5F0FuCwXiWWXy/9HYOyISw3RwnVb8g=;
        b=AYSAIj5EYBSu5KNsmToAMSNGLh09HSsSXhle7yb6AQMCnRUb4JEu10UxnMIXfUP5WS
         K0RbpCQ88ZPLluPphAH1aBCIZcmyDAuskKt7aUiYXJMk96TP6km0sasEK/aC/YNq84K2
         hvlUX6Qdk6j5GfQd40apXLjDnXus8AAvlixrIdUKsnXyC5Hpx+tnh7azCOTvmkuvoOZ3
         iiCw+eQJy5Hi6D8I+IGQzrTZXvDofzPX2qePutV2ArP/38BOUj7/dwh5gWcPKfaixU19
         zcwltaJhSPq68sDaEYT8fEnV0Rcct1klBSYXK1HU6qtC+AFgxDJ0ikYrbIpTD0VC2J13
         40wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x571+MF2/isqI5F0FuCwXiWWXy/9HYOyISw3RwnVb8g=;
        b=KMPJSAaPb6u5b/rBSN8m3M08AymDi+ucooS4pfY6iw3dPVYJscU0pNbSBWcsY8qVpQ
         WdMLaPc8Ku2v8NblyvUKV4Bh6cjEbehwV+9hUTm33Z3Fv0PwS48GzNGJtAXnlw/F6BVG
         5Ebf4TbbN8JlqOpxzME5gaO80SsMo7wbuFtirpahqHoi6OMK7YuEhXSSGMCL0MDYVdF2
         nRfRyifBqATRFsmImyHVmDbiznS9dhNICdU0u/RIFUnuHdzCOUoBUffP0PYi8QPucN9a
         jsIKviq4y3sKTDm+KWfStVJdYK4s5+qWCnw70PCBpEvB3kfwJC2H00kx6TxLILu/3P8m
         ibVg==
X-Gm-Message-State: AFeK/H2Em/nsyRjp4Lvxy3Xo8hflBK4s9rr5eLDr7E2jj+m7EPIaYRxBgzhY18qHUbA0weroK4hARVe8Unzkjg==
X-Received: by 10.107.32.199 with SMTP id g190mr60601146iog.117.1491906797767;
 Tue, 11 Apr 2017 03:33:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 11 Apr 2017 03:32:57 -0700 (PDT)
In-Reply-To: <20170411102333.itfca2aofu5l23bc@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com> <20170408132506.5415-6-avarab@gmail.com>
 <20170411102333.itfca2aofu5l23bc@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 11 Apr 2017 12:32:57 +0200
Message-ID: <CACBZZX5jGGUToK83e2iugpbSBDpATi7J0BWg9=UY=YC4ZixT+Q@mail.gmail.com>
Subject: Re: [PATCH 05/12] log: add exhaustive tests for pattern style options
 & config
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 12:23 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 08, 2017 at 01:24:59PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Add exhaustive tests for how the different grep.patternType options &
>> the corresponding command-line options affect git-log.
>>
>> Before this change it was possible to patch revision.c so that the
>> --basic-regexp option was synonymous with --extended-regexp, and
>> --perl-regexp wasn't recognized at all, and still have 100% of the
>> test suite pass.
>
> I thought we _did_ have good coerage here, but I think it is only for
> grep (via t7810). It makes sense to cover this for "log", too.
>
>> The patterns being passed to fixed/basic/extended/PCRE are carefully
>> crafted to return the wrong thing if the grep engine were to pick any
>> other matching method than the one it's told to use.
>
> This can be tricky since POSIX allows implementations to add arbitrary
> extensions for otherwise invalid syntax.

For POSIX basic v.s. extended I'm relying on (|) not being
metacharacters in basic but metachars needing quoting in extended. I
very much doubt any regex implementation doesn't conform to that, but
maybe some crazy implementation does...

> See my recent 7675c7bd0 (t7810: avoid assumption about invalid regex
> syntax, 2017-01-11). In particular:
>
>> +             if test_have_prereq LIBPCRE
>> +             then
>> +                     git -c grep.patternType=3Dperl log --pretty=3Dtfor=
mat:%s \
>> +                             --grep=3D"\((?=3D1)" >actual.perl
>> +             fi &&
>
> I'd have to double-check POSIX, but I suspect that it may allow (?=3D1) t=
o
> work in an ERE (since it's otherwise bogus to have "?" without a prior
> element to match).

Distinguishing PCRE from the rest is much easier, I'll add some more
obscure PCRE feature to that which definitely doesn't exist in any
POSIX rx library, e.g. (*COMMIT) or something.
