Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B9B1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 16:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeHWToR (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 15:44:17 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:55440 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeHWToR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 15:44:17 -0400
Received: by mail-wm0-f45.google.com with SMTP id f21-v6so5765847wmc.5
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=U+gkluwVTskT6gUx3Gg8ZzvIM5AmRBoU+p7qb92wPC8=;
        b=ohFg1UvY2KE5B49tEvGms75zfXwa/8PbjZ7LexOa44pYJ6GQYSpaTMHpu2GERfluz2
         SYyAx2q0laWeaRr35jYlzqsSS4db+AI3OWga5rr3Xhz8u3PrYHH5WXsnPYW5YoFH7d5N
         VtqwaunL9UCUMfMPL5a0kyaxWtvqhBzKBBFhJDUfTpZ9cJesmh88f4KQgk6GSW5Lze6h
         zm/PYRklQaOJNuUKdd0kySO5PZFjE9bz0AkSKiapgsQdPdRknXuSmzpW9vGvVMS4wzk+
         6tBYxp30/5oClwR0NgqaN+mn21k68++BFX18BOoa5l1Nc7NzZ0yRbKPhSia1lfH5anUZ
         OOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=U+gkluwVTskT6gUx3Gg8ZzvIM5AmRBoU+p7qb92wPC8=;
        b=NzFKezZRvZI8NbZXNAQvQvdayoi16P4cJv+0TJTz2SxrWaayPbtn3LeUvsFbWL6EBZ
         /UIK0opy6Af5hvvOlLW7Q1TXWXsD6Ley6sRydUXbAo+2ro8LmPpsu3+/6ZhoGLE9D45T
         fg6A+Zxzk9mzAkjAj7ZVdHjAxNktzAuTtqTSgOdq7x7ofrp44gy+Y9BJSWmzFb9WyC06
         iG3l5lHrZYs5oDktWyJE5hsrnTuL86/gDpG1xDyGMcITgaHYdkrNU+PGcsUV9NwCiv4J
         nSqB6pl2U9UZtsgZhkaonRkWeFs2xIzpWZIIYQkOYOUVJryrWgtoKgYlqXx61ILBJ1No
         bi4g==
X-Gm-Message-State: APzg51AjYTvPjrIQ7eVlkE0SKcofi7iSF2d2pyfJDSDJffVUdpLi//S5
        kxShS6Mx8v5vXoUlC7zb9CU=
X-Google-Smtp-Source: ANB0VdaJGJjo1bLCTxmDxfrIXhokQEOvo8QWLAzKdwjtLJvUp8FSSAhSKvtgpnOp2W4QphaKhP5bGQ==
X-Received: by 2002:a1c:9893:: with SMTP id a141-v6mr5372967wme.62.1535040833012;
        Thu, 23 Aug 2018 09:13:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 144-v6sm7150117wma.19.2018.08.23.09.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 09:13:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Questions about the hash function transition
References: <878t4xfaes.fsf@evledraar.gmail.com>
        <xmqqy3cxjgz1.fsf@gitster-ct.c.googlers.com>
        <876001f6u3.fsf@evledraar.gmail.com>
Date:   Thu, 23 Aug 2018 09:13:51 -0700
In-Reply-To: <876001f6u3.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 23 Aug 2018 17:20:04 +0200")
Message-ID: <xmqqa7pdjc1s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Aug 23 2018, Junio C Hamano wrote:
>
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>>>> - The trailer consists of the following:
>>>>   - A copy of the 20-byte SHA-256 checksum at the end of the
>>>>     corresponding packfile.
>>>>
>>>>   - 20-byte SHA-256 checksum of all of the above.
>>>
>>> We need to update both of these to 32 byte, right? Or are we planning to
>>> truncate the checksums?
>>
>> https://public-inbox.org/git/CA+55aFwc7UQ61EbNJ36pFU_aBCXGya4JuT-TvpPJ21hKhRengQ@mail.gmail.com/
>
> Thanks.
>
> Yeah for this checksum purpose even 10 or 5 characters would do, but
> since we'll need a new pack format anyway for SHA-256 why not just use
> the full length of the SHA-256 here? We're using the full length of the
> SHA-1.
>
> I don't see it mattering for security / corruption detection purposes,
> but just to avoid confusion. We'll have this one place left where
> something looks like a SHA-1, but is actually a trunctated SHA-256.

I would prefer to see us at least explore if the gain in throughput
is sufficiently big if we switch to weaker checksum, like crc32.  If
does not give us sufficient gain, I'd agree with you that consistently
using full hash everywhere would conceptually be cleaner.


