Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E679D20248
	for <e@80x24.org>; Fri, 22 Feb 2019 14:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfBVOed (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 09:34:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40529 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVOed (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 09:34:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id q1so2605339wrp.7
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 06:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PX2lOUxVyHAH7XNYYaa2p7TjVUR/I4UWc7FHgSWDNl0=;
        b=puIW+l9UsYtDscxdXtcTkYwlOQ4bmUQ9M8o2xyOJlankCq4ledR/CwYGE5t4WF05gP
         XJd2Y8d4geQ6YROLa7D2dgSzH1kuZjPo5M/IVdRiSxHbnp0ITuFt07JL+HA0E4FurmTh
         WgnH0e0e4rXLNC4FjLKc4/NOVcGfx7znD+yhjTK1eOJO2oJrNvtIi6QMbQpcDmuXmk3Q
         run5bH2Qi3duODOPyh9S32ioSIXOmwvBbQpVUi/s6SrOUHb2XwiSTDLchHb+1jheT75p
         9dzkodhQTe4BAs5PL3JWBW7x8P4npjpSNGks6BPy1hMZLd0M3ZAPRDsV6qh5khSKmJY5
         ti2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PX2lOUxVyHAH7XNYYaa2p7TjVUR/I4UWc7FHgSWDNl0=;
        b=aS+IPYeV0YRbuNEwkruOFiuxaklTiK7dHlm1WrgzKVJLn/CkWsNCDsKjNPw2QeQeun
         eYo+4Iae9DFkWYQWIVRadXSgtwoj48sMSv2GVnfpQa42c2wgfO6AGTDIIGC/kBHXnzwk
         QdOz0w/gssL13Yj26o/ZauiylABlmjwUOM8UR4DSxEOF2jxT9eXcuaxwUMttN7l1II45
         kaEE9bc0komSOVRufknz/2QYuikVnUD0P4krrV6LgigXwrLiGd4oGCWmVi0dvZeH8HmG
         NP6gE5ZEY0gEjUOP4pnE9QowqzZzLcUBz5LBeqAwvamHWAcEL4YHUOPju/MyVgaQag+g
         Cx0g==
X-Gm-Message-State: AHQUAuaQsRmtlGBA+aCHx7yVRW2zvXaiAm7ykQpK9gHZjssGaLRBw6Zn
        Dca/MRNGXjJVCqmI4S1NZFaH4ihfdrs=
X-Google-Smtp-Source: AHgI3IY6hGc1jv72m6hL3/OflM4D2Jw07RH4Crh9dz2a7VfPvGKzEPjDgie1eNbtbxjR+eUs6bU5tA==
X-Received: by 2002:a05:6000:1142:: with SMTP id d2mr3134852wrx.43.1550846070802;
        Fri, 22 Feb 2019 06:34:30 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id b10sm1844803wru.92.2019.02.22.06.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 06:34:29 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Sebastian Staudt <koraktor@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] commit-graph tests: fix cryptic unportable "dd" invocation
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com> <20190221192849.6581-3-avarab@gmail.com> <20190221204310.GS1622@szeder.dev> <878sy86anh.fsf@evledraar.gmail.com> <20190222105053.GU1622@szeder.dev>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190222105053.GU1622@szeder.dev>
Date:   Fri, 22 Feb 2019 15:34:28 +0100
Message-ID: <8736of6gej.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 22 2019, SZEDER G=C3=A1bor wrote:

> On Thu, Feb 21, 2019 at 11:26:26PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> >> -	dd of=3D"$objdir/info/commit-graph" bs=3D1 seek=3D"$zero_pos" count=
=3D0 &&
>> >> +	perl -we 'truncate $ARGV[0], $ARGV[1] if -s $ARGV[0] > $ARGV[1]' \
>> >> +		$objdir/info/commit-graph $zero_pos &&
>> >
>> > This will make Dscho unhappy :)
>>
>> Sorry Dscho :)
>>
>> Although this is a one-off in one test, as opposed to a new "perl -e" in
>> test-lib-functions.sh
>>
>> > Is there a problem with:
>> >
>> >   dd if=3D/dev/null of=3D"$objdir/info/commit-graph" bs=3D1 seek=3D"$z=
ero_pos"
>> >
>> > ?
>> >
>> > To my understanding of the specs it's well-defined what it should do,
>> > even when $zero_pos is larget than the file size,  it's shorter,
>> > simpler, and doesn't introduce yet another Perl dependency.
>>
>> I tried that as a one-off and it indeed works as a "truncate" on NetBSD
>> & GNU.
>>
>> My reading of POSIX "dd" and "lseek" docs is that we'd need some similar
>> guard if we're going to be paranoid about a $zero_pos value past the end
>> of the file. It doesn't look like that's portable, my assumption from
>> reading the docs is that the seek=3D* will devolve without a stat() check
>> on some "dd" implementations to an "lseek".
>
> Could you point to the part of the specs where your assumption comes
> from?  The specs are quite clear on what should happen:
>
>   If the size of the seek plus the size of the input file is less than
>   the previous size of the output file, the output file shall be
>   shortened by the copy. If the input file is empty and either the
>   size of the seek is greater than the previous size of the output
>   file or the output file did not previously exist, the size of the
>   output file shall be set to the file offset after the seek.
>
> IOW no such guard is necessary.

It was my reading of the seek=3D* section ("the implementation shall seek
to the specified offset"). I didn't spot that bit covered in of=3D*. Yeah,
I see that's defined & safe after reading that.

> I checked the man pages of FreeBSD's, NetBSD's, OpenBSD's and Solaris'
> 'dd', and they are clearly following the specs in this respect.  I
> tried NetBSD 6.0's and 8.0's 'dd', and both behave as advertised.
>
> And using 'dd' doesn't add a condition after statement...

>> I'm not going to submit a re-roll of this because it works, and I'd
>> still trust Perl's truncate(...) portability over dd.
>>
>> But more importantly because it takes me *ages* to fully re-test
>> anything on the slow BSD VMs I have access to, and I already tore town
>> my one-off hacking env there after testing these patches...
>>
>> >>  	generate_zero_bytes $(($orig_size - $zero_pos)) >>"$objdir/info/com=
mit-graph" &&
>> >>  	test_must_fail git commit-graph verify 2>test_err &&
>> >>  	grep -v "^+" test_err >err &&
>> >> --
>> >> 2.21.0.rc0.258.g878e2cd30e
>> >>
