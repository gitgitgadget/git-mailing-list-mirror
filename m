Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819981F404
	for <e@80x24.org>; Fri, 14 Sep 2018 06:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeINLSu (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 07:18:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46643 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINLSt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 07:18:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so3766600pfn.13
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 23:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ovQP8O1DgVOVQWi07OFxz4enORuFnGskYKkGHabC0Y0=;
        b=Apr3MWX5M2kUOqIDfdOz6xhe2O/BzbmQJgfSwLMg8PgSEnv0AqWx+UvCBnVnh08u7z
         lqKUod4brsg6NZ7iRZpnLNKMT9CC0qkbkzg61Q9mjay5DsX3aXI4p18RTmKxpO5+uyDW
         agjspz8JQDfoqLuiIfdpw8Jjix4TgrzvYI5FsUPwA/mIePFADfkQHb0jcVYO39jo0X9D
         qCvmU6zHz0HIcBFDrBbQyARW8XpTGuuvfV1MIhLFZQitPyg5e2MROTONb9K4HjWre4mX
         dooID3i8k5Huquk4/9M470/KfGKRkEPNqXCc4/pI3mPU1q9CS02otmuP1733qWfNQQkK
         roEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ovQP8O1DgVOVQWi07OFxz4enORuFnGskYKkGHabC0Y0=;
        b=dli5CHO7MuAMkxqYO/QUbvwDSWrEGPCK1ZAQTUmqHHgnRsRojHBOQkXRL005qOtARN
         uJw1u7AJn4vNU1hQkNKRf46YSWDek0q/q0v2lv5n5sSBJ5DK5B6jUoe/h5lM73/SPdBj
         6rw79ap3GZgab4k24sNPr1JJTTT6FUusmI+DfPrEJclsAwZnx0qkupvXMmvzPr8nHCxu
         eidWMcZyjm6SNEc1862YOEFkvC8DG8vp/2uuTlfvohRxlOryNnQkorJV79I8JMU7j4ww
         m0x1/66fmX7mcGXpZbV1rfuLjpAqp6QhWwaG6rqOEpCHZ+PhQj11nxK56SCP2Z332yF8
         /+wQ==
X-Gm-Message-State: APzg51BhtITnH7RXlmo8jiox1JGwc4t1pZQR2vkUTp6CrfdCvK+Ytrm4
        3bGCJTxMp0G5TM2qk+SAb6Y=
X-Google-Smtp-Source: ANB0VdbRH1Sgwkqwq1T6LZUDFB2sdQol5od/ReRGby/6IQIoy/NwmD4tDo0oNJH0w+Gr/3t4A9idMg==
X-Received: by 2002:a62:c406:: with SMTP id y6-v6mr10716486pff.161.1536905155422;
        Thu, 13 Sep 2018 23:05:55 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a90-v6sm14013342pfg.106.2018.09.13.23.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 23:05:54 -0700 (PDT)
Date:   Thu, 13 Sep 2018 23:05:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Josh Steadmon <steadmon@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brandon Williams <bmwill@google.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH 2/3] archive: implement protocol v2 archive command
Message-ID: <20180914060552.GD219147@aiede.svl.corp.google.com>
References: <20180912053519.31085-1-steadmon@google.com>
 <20180912053519.31085-3-steadmon@google.com>
 <CAGZ79kZOTsUH=zQX3rLXvuSOx1vp8C98maSn47ssfca8c-BrBQ@mail.gmail.com>
 <87k1npkzh5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1npkzh5.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Wed, Sep 12 2018, Stefan Beller wrote:

>> Would asking for a setlocale() on the server side be an unreasonable
>> feature request for the capabilities (in a follow up patch, and then not
>> just for archive but also fetch/push, etc.)?
>
> This would be very nice to have, but as you suggest in some follow-up
> change.

Indeed, I think we've gone pretty far afield from the goal of this
patch series.

> I think though that instead of doing setlocale() it would be better to
> pass some flag saying we're operating in a machine-readable mode, and
> then we'd (as part of the protocol defintion) say we're going to emit
> GIT_ERR_UPLOAD_ARCHIVE_EXPECTED_DELIM_PACKET or whatever.

I think you're suggesting client-side message generation, and that is
one way to handle internationalization of server output.

The main downside is when the server really does want to provide a
custom error message.  For that, we'd need

 1. To propagate LANG to the server, so it knows what human language
    to generate messages in.

 2. On the server side, to produce messages in that language if
    available, with an appropriate fallback if not.

We've been thinking of doing at least (1) using the same trick as
server-options use (cramming it into client capabilities).

It is difficult to use setlocale for this because it affects the whole
program (problematic for a threaded server) and affects features like
collation order instead of just message generation (problematic for
many things).  Does gettext have a variant that takes a locale_t
argument?

[...]
>  4) Aside from translation purposes, getting a machine-readable
>     "push/pull" etc. mode would be very handy. E.g. now you need to
>     parse stderr to see why exactly your push failed (hook denied, or
>     non-fast-forward, or non-fast-forward where there was a lock race
>     condition? ...).

Indeed, this is a good reason to provide error codes instead of (in
the case where the message doesn't add anything to it) or alongside
(in case the error message is more specialized) human-oriented error
messages.

Thanks,
Jonathan
