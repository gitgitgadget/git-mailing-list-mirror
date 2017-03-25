Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAF832095E
	for <e@80x24.org>; Sat, 25 Mar 2017 16:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbdCYQgb (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 12:36:31 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:38439 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdCYQg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 12:36:28 -0400
Received: by mail-it0-f51.google.com with SMTP id y18so16951715itc.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 09:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TXua17erjHgplW1HVKpC2dazNEVSOLR3m3l2G/LfXqw=;
        b=KWyDAVUTU5NKwbff6pSnms8NEh0eXvInPtnYjdXLovmLjvvjCKmn1uprd0SVsl72pm
         WB1D1e40KJiiYRTtXY1RjkYFfqw+QND8B+k3gUWx90NTZQT5Mp0pnkWyDY9YQRGhT5V+
         41SjuZPbXFlR4NCL6A1KGEYFBcWaE1KJOnxI50SifhoRHLRPvskzTHGFXeVUP8suj26I
         1kaKqLASyq9dW5zNC6wNaz0YnOx2hcPBGUlcgynsbvHzwlzvm3tHWPRkQmM0529yCOw1
         3flhqbr4wd45LjSoOuVyV/omMgyGjMwZduTJ9IQAqVjYk7q1RoYpDphk6N9C0rSuhe8H
         rx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TXua17erjHgplW1HVKpC2dazNEVSOLR3m3l2G/LfXqw=;
        b=KCbUBgVDdNAu5vJTlflWhUu4/s+DB4mPrfCXlCOd4UT0xtPB2Rv05XxMO89snAwFR2
         lFJDM/ozhVqFLVoq9B827/GtfFfQWMg3IchmYCcRrTlhBWxTrBKq/7khfybVA7p+gQN7
         Tp+PmkGcIo8QmJhw4rUrribRln2uv2jYA+hilp6/MJTzFauIQ65q2cPwcBhYyp2kaD3a
         sgVM23bWqI/mhsv49EJsbWisYmXlleu41tX3HxHsABRzW2pTPurgL3q1R9EPEIqNKVVJ
         opezYTRapO99OmPRFKfH/J9yKDTKYFQGYfAsR+RJ9VZcvcMOq/j6jeqnKZ/uZl5VsxgK
         8yZg==
X-Gm-Message-State: AFeK/H3L1s4ek0Mp3uCv4dpWg2k1OYMlPYQfePN2N72f3lmL/xE2d9+iAfjFdiIqcDABbfGR2Hi4B4xA0x0gZw==
X-Received: by 10.107.150.201 with SMTP id y192mr15326854iod.33.1490459773843;
 Sat, 25 Mar 2017 09:36:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 25 Mar 2017 09:35:53 -0700 (PDT)
In-Reply-To: <CANgJU+UG1JGYomyQa1FgyN8Q6SkPeEtGKEJfNETrkbtGwrMn9g@mail.gmail.com>
References: <CACBZZX6F47uC9jLxppgkUnwVpGV2jpzzP4kwTuqKgayCevomeA@mail.gmail.com>
 <CANgJU+UCJ9qR-pi9w3+oYjEwDdhbtNX9Nv6brj31VXvt-k-3Lw@mail.gmail.com>
 <CACBZZX7dXsdu0bwt4Rznregw4=v=Sc3cFTQbxJcb-ynf3HXq3Q@mail.gmail.com> <CANgJU+UG1JGYomyQa1FgyN8Q6SkPeEtGKEJfNETrkbtGwrMn9g@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 25 Mar 2017 17:35:53 +0100
Message-ID: <CACBZZX4Haah8JmSG6BbfpdOA1aAxtjiuYirLH4=jt01kHL4eQA@mail.gmail.com>
Subject: Re: Will OpenSSL's license change impact us?
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 10:43 AM, demerphq <demerphq@gmail.com> wrote:
>
>
> On 25 Mar 2017 10:18 a.m., "=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason" <avar=
ab@gmail.com>
> wrote:
>
> On Sat, Mar 25, 2017 at 9:40 AM, demerphq <demerphq@gmail.com> wrote:
>> On 25 March 2017 at 00:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com>
>> wrote:
>>> They're changing their license[1] to Apache 2 which unlike the current
>>> fuzzy compatibility with the current license[2] is explicitly
>>> incompatible with GPLv2[3].
>>
>> Are you sure there is an issue? From the Apache page on this:
>>
>> Apache 2 software can therefore be included in GPLv3 projects, because
>> the GPLv3 license accepts our software into GPLv3 works. However,
>> GPLv3 software cannot be included in Apache projects. The licenses are
>> incompatible in one direction only, and it is a result of ASF's
>> licensing philosophy and the GPLv3 authors' interpretation of
>> copyright law.
>>
>> Which seems to be the opposite of the concern you are expressing.
>
> The Apache 2 license is indeed compatible with the GPLv3, but the Git
> project explicitly uses GPLv2 with no "or later" clause
>
>
> Read the paragraph immediately (I think) after the one I quoted where the=
y
> state the situation is the same with GPL v2.

My understanding of that paragraph is that it's still laying out
caveats about exactly how GPLv3 is compatible with Apache 2, when it
is, when it isn't etc. But then it goes on to say:

"""
Despite our best efforts, the FSF has never considered the Apache
License to be compatible with GPL version 2, citing the patent
termination and indemnification provisions as restrictions not present
in the older GPL license. The Apache Software Foundation believes that
you should always try to obey the constraints expressed by the
copyright holder when redistributing their work.
"""

So they're just deferring to the FSF saying it's incompatible, the
FSF's statement:
https://www.gnu.org/licenses/license-list.html#apache2 "this license
is not compatible with GPL version 2".

Anyway, I'm not a lawyer. Just thought I'd send some E-Mail about this
since I noticed it, if it's an issue (and we could e.g. get the SFC to
comment, Jeff?) we might need to add e.g. some checks / macros to
ensure we're not compiling against an incompatible OpenSSL.

>
> $ head -n 18 COPYING
>
>  Note that the only valid version of the GPL as far as this project
>  is concerned is _this_ particular version of the license (ie v2, not
>  v2.2 or v3.x or whatever), unless explicitly otherwise stated.
>
>  HOWEVER, in order to allow a migration to GPLv3 if that seems like
>  a good idea, I also ask that people involved with the project make
>  their preferences known. In particular, if you trust me to make that
>  decision, you might note so in your copyright message, ie something
>  like
>
>         This file is licensed under the GPL v2, or a later version
>         at the discretion of Linus.
>
>   might avoid issues. But we can also just decide to synchronize and
>   contact all copyright holders on record if/when the occasion arises.
>
>                         Linus Torvalds
>
>
