Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E4F20286
	for <e@80x24.org>; Wed, 13 Sep 2017 22:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbdIMWwD (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 18:52:03 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37230 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdIMWwC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 18:52:02 -0400
Received: by mail-pg0-f68.google.com with SMTP id v5so733928pgn.4
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 15:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bbhethOQOJA2kdlTzkWTQ/leR3dkJ/HvgolDADXTKMw=;
        b=sjED+muEx49OEcw+LOQ75DfL0nZ9VKkxCy3AfeDmTcMWkgZBIhx5tyK9MRXeBubFsX
         4CO+HZURBD4O7P+nMWzEvxrSuQmd5VaCFeT3TcOr8nMA8WSdRRxpPsd05YStcd4zyLYl
         D9Q4t4iplPG6cN3L+9+putygkhH5U3bEBE9jZeGcf5OGeocS3J1KwTyIusK2e3e54e7S
         Br3B/t2/ISWJCA2wClm5pRoC2UhA2+laBNNTGpD213oxVQWeMowURnliP9qIs0scTU0S
         f4ICGFqxzljgWXwEpD4MA9LKEIyO+0fS33yrdaq2YF1GifBZ0tQS5iIELCrfoD46k7wW
         xH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bbhethOQOJA2kdlTzkWTQ/leR3dkJ/HvgolDADXTKMw=;
        b=NAAOFWHK1m43nZP+XmN7dg739ME79hEMYEn5+/XTj2bsgwrD2sYgfB4a6abEHLStTZ
         8ZqjXymOyfRA1GwaQh6H5aaCmokXEcPzZOrsaGV1964IitgDR22OXgSlHOqEHAjzfEPr
         XsqtD2Oq46jf5geX6XBTwMIMkcqiNGBl4vvwfwzlZF5pibLmB7IzC5b44Eb72WZ+z3is
         Sc3QFJ+Eoqm2DNUJeAivSKrmbsrO7QPWk+CHiDj2SlSZR60DI44raRpJNUAkD5uImNlL
         YOnk3Tm+pzA8M8VKH+NNlvfLH/RL8bpNCICKzXqw6HeXYJ/PDCWUsZcaLS/PUEyMwjAY
         eE0g==
X-Gm-Message-State: AHPjjUiLYrhabAzahxQyGUWjakA0D/R66+V7i3eFNYUHMP2+NKNvgsrZ
        PmYINtRWF5LwPw==
X-Google-Smtp-Source: ADKCNb5OD9rv+oyWlB7TW7IYHqnepq/bTtFcXK7BdDuV4XJ72y5RU0xRFU2bC4vyQUZfKSqD4AQGLg==
X-Received: by 10.159.252.5 with SMTP id n5mr13363099pls.360.1505343121450;
        Wed, 13 Sep 2017 15:52:01 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id n19sm27637664pfj.114.2017.09.13.15.52.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 15:52:00 -0700 (PDT)
Date:   Wed, 13 Sep 2017 15:51:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     demerphq <demerphq@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20170913225158.GR27425@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Yves wrote:
> On 13 September 2017 at 14:05, Johannes Schindelin

>> For example, I am still in favor of SHA-256 over SHA3-256, after learning
>> some background details from in-house cryptographers: it provides
>> essentially the same level of security, according to my sources, while
>> hardware support seems to be coming to SHA-256 a lot sooner than to
>> SHA3-256.
>
> FWIW, and I know it is not worth much, as far as I can tell there is
> at least some security/math basis to prefer SHA3-256 to SHA-256.

Thanks for spelling this out.  From my (very cursory) understanding of
the math, what you are saying makes sense.  I think there were some
hints of this topic on-list before, but not made so explicit before.

Here's my summary of the discussion of other aspects of the choice of
hash functions so far:

My understanding from asking cryptographers matches what Dscho said.
One of the lessons of the history of hash functions is that some kinds
of attempts to improve the security margin of a hash function do not
help as much as expected once a function is broken.

In practice, what we are looking for is

- is the algorithm broken, or likely to be broken soon
- do the algorithm's guarantees match the application
- is the algorithm fast enough
- are high quality implementations widely available

On that first question, every well informed person I have asked has
assured me that SHA-256, SHA-512, SHA-512/256, SHA-256x16, SHA3-256,
K12, BLAKE2bp-256, etc are equally likely to be broken in the next 10
years.  The main difference for the longevity question is that some of
those algorithms have had more scrutiny than others, but all have had
significant scrutiny.  See [1] and the surrounding thread for more
discussion on that.

On the second question, SHA-256 is vulnerable to length extension
attacks, which means it would not be usable as a MAC directly (instead
of using the HMAC construction).  Fortunately Git doesn't use its hash
function that way.

On the third question, SHA-256 is one of the slower ones, even with
hardware accelaration, but it should be fast enough.

On the fourth question, SHA-256 shines.  See [2].  That is where I had
thought the conversation ended up.

For what it's worth, I'm pretty happy both with the level of scrutiny
we've given to this question and SHA-256 as an answer.  Luckily even
if at the last minute we learn something that changes the choice of
hash function, that would not significantly affect the transition
plan, so we have a chance to learn more.

See also [3].

Thanks,
Jonathan

[1] https://public-inbox.org/git/CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com/#t
[2] https://public-inbox.org/git/xmqq37azy7ru.fsf@gitster.mtv.corp.google.com/
[3] https://www.imperialviolet.org/2017/05/31/skipsha3.html,
    https://news.ycombinator.com/item?id=14453622
