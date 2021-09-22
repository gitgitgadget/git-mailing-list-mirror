Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486E7C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 16:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A366105A
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 16:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbhIVRAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 13:00:31 -0400
Received: from mout.web.de ([212.227.15.4]:59175 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236537AbhIVRAa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 13:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1632329925;
        bh=RsDRK3mp9wDCmG6SKVo1BK8TXSEHr/WF3U+0H4NT3gA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=d0rmOPKNnNMdq3v5f+g0VGfSE6by3ryiZr1HjIw0VdJK3CISN7adSMRdcCVD9yK2d
         tBrqY6nHGcSImXuNF53LRlTa7KY9+WcuX0ZKsVzyg2EwX7yccjnU6jvOO2kZuBhAob
         ZIARh4VSagTiJDLXDElppVi4hUd7+4enWY+Wu/xc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LnSKE-1n5Cp90YXO-00hdNf; Wed, 22 Sep 2021 18:58:45 +0200
Subject: Re: cb/pedantic-build-for-developers, POSIX-but-not-C99 and
 -Wno-pedantic-ms-format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Wong <e@80x24.org>
References: <xmqq1r5iaj9j.fsf@gitster.g> <87lf3q9u6b.fsf@evledraar.gmail.com>
 <CAPUEspiBP+4Ac4O5ZRTK0N+8PhHeewksrhL=x8TcswrvnS1JOw@mail.gmail.com>
 <b0eba1c6-5468-df31-db6f-701bcd24adff@web.de> <xmqqee9g8u3n.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <03283614-c589-5e19-4d35-f0a017e69895@web.de>
Date:   Wed, 22 Sep 2021 18:58:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqee9g8u3n.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wtsYEDPGgsR7AVc4+kmxoK4UwutBkv9Bgn5Ro8D4pT+RREkVy0v
 QW5NkMhG+Pi9eaSPQ2NGfF7hczOw7Hd7O0t4QZGL9EQ3/7rS6NDCZX3lABny7n5jZLdjm+s
 LtDN42hbbRsTQfSRKGeg242zckz1Pc1gyfpLk9f7gnzWSUNgiLrJYywQToJbHoFwaW/JR7g
 pekc5/6kk4zg3Nw7eWq8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mtiVim9CdcQ=:D0A+csM0+lebPKNa2ak/Ad
 t0GtFjy5OuJiZe35D/xN+fb3imu/Sh55K70mGjjpNN78mZX2pgfNUxuZZa6DnfRI7p6pxfkv0
 Gxp1aeX2X7hC6tQ/gSnXM1r3KZvhktiAEk2O8bs8MeyZrdANblWZ/GcuV1sZg3TXg1uDzsOvK
 fsHFXyzJ60t+VSSVnsuJPy2iYkN7rxKoRBBS4m41vCS7p39jZS+R0CvS1xojMthFRvFYZvY9E
 iyidxKW73OphQ6dKUkCy8BhQtqzBZJlHnOxMyIoRNLmX3D7/QuNQ6CTYvf0hPusFhYo27dBIH
 D0oXfOqHwtE8WP+M3fyqjUWVWnn6z+nQod4eBbQbyDORAW4Stg89R94qA7yIW0EWDJivKLf7j
 sqElpCg353uJQ/2ZpMbEssMsstxlzX/zaQUAmtl/QFr11fxsvuDDIOIbtQDSJ8kBsM5JwI6Qy
 6UfdZuMtmybVSEPejK0uQ1/bfePMZlWaM5+DJkv3XswPWs4hfqa7lOwYoT8d0k/9f4yBxHK2C
 eDl1fOYdzcU2Sj2UU6J1ICKI1QCblpudTI7LCoj7P+c35N7DT5SUkQwGb3+hbJhvZhD04jYDk
 aDZm3Gpqgf0AoDHXjKLtYj/2dPWJpYZ9q1Jn/uM65sQSV8dmjP5Hl9WCnOJs+Bc+mGoXSwLMS
 QUKOAMfn9IsaAswJ6vWVqvnjLTPkQUijZ9ePhyvpIUpn8UdKxgDDQoUgzC2hWV/G9iH6kQj77
 0PTgT1Kw0Mt7OMiETLBxMN67ZC6MJmlaMUDn6YpuJVFHSUW1Rc8/Ox5VUmYUoK6vtdghTKRJW
 dGWl4asbgsAP9xcMKlF7X3GB0u2rWZNWUT/etr2FLb8qEPPP3FJF/y/MWJfj9Vwod9WpyFOkq
 wT/v0IASXJQ9B/Y/QtouqDAx0WH/MhsBVArZwWewJ4irgymavDVqeWMyEB4m3NZeIVaxr/dKP
 Cb9c5sZpGoF/NH0IrRvm/PiVrKiMccrrMCDi6Kw78DG11rdcFaiDvEGU+GF8+6bEAZngooaH3
 8eY0CQ7QQFVAlWPkxE5cc3MjmXJ1w1IY39eUB++ZqN3ILi4MI2EoDXaaAhYaJiEvGQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.09.21 um 18:15 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> The lack of warnings about the use of that extension in po/ means
>> translated formats are not checked by the compiler at all, right?
>> According to the gettext documentation [2] msgfmt takes care of that
>> when building the translation files, though.
>
> It is not even seen by the compiler at compilation time, right?  _()
> at runtime is merely a function call to map its parameter string to
> another string using what is in .mo (compiled from po/).

Right, and it's up to the program that builds these .mo files (msgfmt)
to only accept valid mappings between printf format strings.

Ren=C3=A9
