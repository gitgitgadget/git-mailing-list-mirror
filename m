Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3A5C07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 08:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiIXI6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 04:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiIXI6h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 04:58:37 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2983D219F
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 01:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664009896; bh=IYvWqB2GBjn89uOYHyb18lhVicEAYZ6/EiAfaaEkV1s=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KyuY9qM1wdsPLgAlIuj+Jv+48/J3++LKjw2JgeNuqpoAD8Q1QRAQ9OZ+bd8qHZWj8
         dOFAaCsXUzbPXeS9COLWArVan+zMdtESmtb1ZrIloZfR59UKA8pzToxkleX0IO2ak2
         KQOVpbn9ISYRxko5WdFU/53qJTR82qvIw1XPAo2ClV+EckLP2AYuzw8gIBc6KfdJaB
         D98QdzmFt30PSWJlliH0f5CG1KmR/AV9WdVMWGjeNnhqasRxEsEgF3jwL4BsLnjEjo
         ZHB0uqQ1MwLaojdPq6sGzPW3LWOcuWxcF+tIfQYLNb3rJ3qGNhbatsiifctYBYFQKs
         LkXRDp/4Y8PhA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.26.1]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQ8ao-1oxxiy2Kjg-00MN81; Sat, 24
 Sep 2022 10:58:16 +0200
Message-ID: <8eb5131e-5ae1-79bd-df0c-bf0b2ec8583f@web.de>
Date:   Sat, 24 Sep 2022 10:58:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: git --archive
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Scheffenegger, Richard" <Richard.Scheffenegger@netapp.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <PH0PR06MB763962EB6321F85803C5CE2D864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
 <xmqqleqbxj4h.fsf@gitster.g>
 <PH0PR06MB7639720FB3A1611F4C96E52C864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
 <Yy0ChPPqZUwVFyAt@tapette.crustytoothpaste.net> <xmqqedw2vysc.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqedw2vysc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nxY1RLNrpIBTTsmFxJx3Ca/Jhw5jMo7N0K01AJvAw1/1D82rU9A
 sQF5qI9gFdLupkRy4vh8//iC4ZxCnnvNd44bnhZJs9tkcmM3VtqDEYS36U09vW6UMM18HHF
 hL24YEoizrIl1E7TUk+qbspnkaAJaw35TZHvAnnmSKvpaYx4qI3/UDj/Tm28JRur8E6jBhr
 zWo6BgaJnN8r0CaCAhQvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t3eMPfOGQJw=:b3HKwhW1PvEH4Z4U5GBETn
 f8LRnPaslSnHeBDoCtnRQXDrUp5wTraXi1wX7cvGVELXWvfs6yDvtf8id34BqafmRN1iegG4n
 3EaPtEws1DA7XE1YyRAD1elU/YQPJWwPGkjFmMgfrYNyORu3H8gmvqjO5YBp9HpiYHe0M4BGN
 vhQnIxfZj6RjY0+DLOlnINcBJHPsMA+owiSsREsFwHi0JGWjy8Wlbd1GggiPgLRTBwSC4K1Bi
 7HNFJn/tRqROyHvWwP2hjEDwSeUKuaE7kaLAh2H/J24EB9B52/mx2FT/nQFUNfP/QMZnz57P7
 vucJ8d+2Ey2iGv068EUs++0MSe2AwASeuinSvIQbI0ZWUXgiBs4i7qRCvnCx84Np7s8R7O5FF
 IksK13QqQJTlyfYwqG+doadzWECoXj0k4TBcPffVj/lKa7T6gMzWAiw+rhMBCp799llvMEB4B
 lT9Mfzdp3cAzwMu0Z2Nd/UHsBBEnySGQGKXkCU+42IyLPo+Uh7wyCdkmkMDXaUYdlXehLtfTL
 WtoEc1DMeeMvuQTo3MYTmSo0dIYQYiHc40NeI1iwp/vmvhQB3GZZ0903l3RthIuadu4B2s34D
 hFScUY1kmbVgvOeqUVqDXR/fmh4JaEQJHs91jUBUvUBDdmSMi19fw+5N/0fbIMMMdhqIZPLGU
 +23f2CrMfSMXRWWtdzproG1rI80iD/gaEQAfNgCa/mnAu1KnIFqg062HI7gGh+A9oiy/2RMpM
 iLjF4vwd9SWozbA3iooA2OEwMDBmDZOJLEz/nYyCVsfN4XkwVa74EWpkVH0T1PnQ+0TFu3fL5
 PS3WBJScS4DnjBImuvZiz0c1H+V06fiIPO2K6ZWXcAmdaxY2GKcQ+HylW56OxQKJDQ7SpzYsX
 Joh9I6P0tKWYmTHwCLexaPAbdhADqlcp0WkQxVKlFBtMXh6NY178Sizq44HE2Ikt8RKf8nb/6
 ejVWUM2XwYzvCAA5fx7C3ISvE/vprYKMz0FYKjVcvBnUBjPcUg9pjV/BUXMX1tQs01n6LyDff
 KkxGCmFgyKA1ZbfiH3FdQSRkzqkU+jbkPZOipXAYEO7hvYbatTfFjllcV1uPDzrNW5loMQ3hP
 ssVWAcawm6UV79YoDEINdaTv6Hn1SMg6FuIOLYkgKtbsQsqTGRM5JjGNd4Ml3TjTbBBNcdtOd
 /Yb9Q=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.09.22 um 18:30 schrieb Junio C Hamano:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> Maybe they can technically be stored in any order, but people don't wan=
t
>> git archive to produce non-deterministic archives...
>> ...  I feel like it would be very difficult to achieve the
>> speedups you want and still produce a deterministic archive.
>
> I am not going to work on it myself, but I think the only possible
> parallelism would come from making the reading for F(n+1) and
> subsequent objects overlap writing of F(n), given a deterministic
> order of files in the resulting archive.  When we decide which file
> should come first, and learns that it is F(0), it probably comes the
> tree object of the root level, and it is very likely that we would
> already know what F(1) and F(2) are by that time, so it should be
> possible to dispatch reading and applying content filtering on F(1)
> and keeping the result in core, while we are still writing F(0) out.

That's what git grep does.  It can be seen as a very lossy compression
with output printed in a deterministic order.

git archive compresses a small file by reading it fully and writing the
result in one go.  It streams big files, though, i.e. reads, compresses an=
d writes
them in small pieces.  That won't work as easily if multiple files are com=
pressed
in parallel.

To allow multiple streams would require storing their results in temporary=
 files.
Perhaps it would already help to allow only a single stream and start it o=
nly when
its time to output has come, though.

Giving up on deterministic order would reduce the memory usage for keeping
compressed small files.  That only matters if the product of core.bigFileT=
hreshold
(default value 512 MB, the number of parallel threads and the compression =
ratio
exceeds the available memory.  The same effect could be achieved by using
temporary files.  We'd still have to keep up to core.bigFileThreshold time=
s the
number of threads of uncompressed data in memory, though.

If I/O latency instead of CPU usage is the limiting factor and prefetching=
 would
help then starting git grep or git archive in the background might work.  =
If the
order of visited blobs needs to be randomized then perhaps something like =
this
would be better:

   git ls-tree -r HEAD | awk '{print $3}' | sort | git cat-file --batch >/=
dev/null

No idea how to randomize the order of tree object visits.

Ren=C3=A9

