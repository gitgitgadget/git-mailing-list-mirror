Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0152B20966
	for <e@80x24.org>; Sat, 25 Mar 2017 21:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbdCYVud (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 17:50:33 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35126 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdCYVuc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 17:50:32 -0400
Received: by mail-it0-f43.google.com with SMTP id y18so40158156itc.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 14:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s6BfQp17EONKGACJcKpBpuK6OH38kvmgElfJTmpiZho=;
        b=iXeR51hlBWL9tSD9X3YsaVSHAFqdA9GVmdysQgevIlfmHMBwVRL6jxOaBHTsZf91oC
         WzLp54PIRAsl8COoHRaUMORo9I8KEjdbWlYw4htNabRUe8FR2Qr4PXGKjYEQ9sbxn5VV
         KVNUgiPr1O2dVJxiriCCoZjc/Pl08QhNjWQbSc5SmN6IEhziv3L6r07gHjMY1qEf162F
         h2gZJJn/yYsjgT9HC+xdA8YfXKV4pFZTwYgNJWrK57k7HGp85Licf1Wkyu83X+/ooPfc
         KBycQ2yDxxmAyaFRpUGOvpiWrp2yfBgy9OzaN27pyZtmqxMYGbtA7Y34BwKX6yKLineg
         cktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s6BfQp17EONKGACJcKpBpuK6OH38kvmgElfJTmpiZho=;
        b=Y6eQmZo4Nw481sfJie1QRIbB0GdoKjsIw5uDbD9LACRqlCjcr5Li02NGe91kbe1pzm
         pMZOIG1itrP+U+8zNWO/jR6PMSlSSdjH9oecHjqdJ9N68vLUKcbzrNTMy80ji9nJAAIP
         jNoUZvXv+Sml9wZGTwccE/tBmArP78MAcEQ8rzYeCuXCrHflHJzAH/8pgcgietlwY3g/
         MW5IYCeLKxoBf5gPxXcxNs/ZzNihfaEsQevut9QxZLULaYL/RkjIyQuphGJ+r/X9WWnN
         XEQnJu5Pp6FIvd+rPJ4Eop6A7pNpRWFi6N7PNAualz/cx/HeYxkctzIBczn5NCkANgGy
         E2xw==
X-Gm-Message-State: AFeK/H0tf3pi5oIrS33/ljj5aVV1eW3uvEt0d34B+aVacKH3U+648xQ0aTrOKH7uuF66vc+6dQzcDKECloKIRQ==
X-Received: by 10.36.65.203 with SMTP id b72mr3537622itd.24.1490478627636;
 Sat, 25 Mar 2017 14:50:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 25 Mar 2017 14:50:06 -0700 (PDT)
In-Reply-To: <20170325211135.62sa76hlvyiexvje@thunk.org>
References: <CACBZZX6F47uC9jLxppgkUnwVpGV2jpzzP4kwTuqKgayCevomeA@mail.gmail.com>
 <CANgJU+UCJ9qR-pi9w3+oYjEwDdhbtNX9Nv6brj31VXvt-k-3Lw@mail.gmail.com>
 <CACBZZX7dXsdu0bwt4Rznregw4=v=Sc3cFTQbxJcb-ynf3HXq3Q@mail.gmail.com>
 <CANgJU+UG1JGYomyQa1FgyN8Q6SkPeEtGKEJfNETrkbtGwrMn9g@mail.gmail.com>
 <CACBZZX4Haah8JmSG6BbfpdOA1aAxtjiuYirLH4=jt01kHL4eQA@mail.gmail.com>
 <CANgJU+WR4L-7-r97od7ids6VK9QyO-QzAntbg7SazmPGj0yWXA@mail.gmail.com>
 <CACBZZX5bK=emjaQ80J7QuTHXHm=nT3G80zq4xogMqC7Eq9Bs+g@mail.gmail.com> <20170325211135.62sa76hlvyiexvje@thunk.org>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 25 Mar 2017 22:50:06 +0100
Message-ID: <CACBZZX6smBoWg1KKAT=dc0Bn1n4E2chtRyO6xVisACrtGuHzEw@mail.gmail.com>
Subject: Re: Will OpenSSL's license change impact us?
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 10:11 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Sat, Mar 25, 2017 at 06:51:21PM +0100, =C4=98var Arnfj=C3=B6r=C5=A1 Bj=
armason wrote:
>> In GPLv3 projects only, not GPLv2 projects. The paragraphs you're
>> quoting all explicitly mention v3 only, so statements like
>> "incompatible in one direction" only apply to Apache 2 && GPLv3, but
>> don't at all apply to GPLv2, which is what we're using.
>
> It's complicated.
>
> It's fair enough to say that the FSF adopts a copyright maximalist
> position, and by their interpretation, the two licenses are
> incompatible, and it doesn't matter whether the two pieces of code are
> linked staticaly, dynamically, or one calls the other over an RPC
> call.
>
> Not everyone agrees with their legal analysis.  May I suggest that we
> not play amateur lawyer on the mailing list, and try to settle this
> here?  Each distribution can make its own decision, which may be based
> on its legal advice, the local laws and legal precedents in which they
> operate, etc.  And indeed, different distributions have already come
> to different conclusions with respect to various license compatibility
> issues.  (Examples: dynamically linking GPL programs with OpenSSL
> libraries under the old license, distributing ZFS modules for Linux,
> etc.)
>
> We don't expect lawyers to debug edge cases in a compiler's code
> generation.  Programmers shouldn't try to parse edge cases in the law,
> or try to use a soldering iron, unless they have explicit training and
> expertise to do so.  :-)

Yeah fully agree with the internet lawyering. I'm not looking for
that, just seeing if someone knows if this might be an issue for at
least some distros, then it's something for us to keep an eye on if
OpenSSL's license changes, and a sane default for us to adopt might be
to e.g. require that some flag be passed to the Makefile declaring
"yes I'm OK with combining AL2 + GPLv2" if the OpenSSL version is
newer than so-and-so.
