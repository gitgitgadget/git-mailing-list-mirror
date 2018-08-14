Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7CE51F404
	for <e@80x24.org>; Tue, 14 Aug 2018 13:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732822AbeHNQfN (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 12:35:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45683 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732699AbeHNQfN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 12:35:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id f12-v6so17242733wrv.12
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=i/XSSflgxn8cz3r6Blxv7P6HUUCeG+z7iNfwVoF5Se4=;
        b=e/iMGGbh8DxPjGa7gefuy67BSTLqLxPtfDv4ImDwJdbt0+bIhIB1EcUQG5jiZZBYeY
         rUwbEh0v+8mH8c4TlFX2SZ+mRYPFUMBa2mHZBcs9p0M2x5f1GUqgSclbF3Km0jy4zOAk
         sL63QiXdnjcTexNge7zEBj4+Wq3un6w4xB2vZox0ujWERawLA6q/e1sgNvOp2wIBtTr9
         sApkE6WHr+WnoUFhn80hQls/+Zli2RF0vrYzIpRPZr0uDUlsRztcN4xHhMNQGAln3wzt
         JfZwOPf7DkTADSdB3ZCRgjvCD5sU8SAAPVrE/dzjH3PrZX7GUCcP2SxyNLyUibdVvjTB
         7xdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=i/XSSflgxn8cz3r6Blxv7P6HUUCeG+z7iNfwVoF5Se4=;
        b=j4k3ZO3FLeNl90S53lWzUWxLzlk3Bx+2HaCY7rrpxqsNJdtYzXPZSQr0m90tbkvfFV
         vsQJlexYYy5hB6UlBLCYexB/z0MzvIuQq35tLqeF3wlopqMhxtq2e9t6V2BfasQ7Sh2o
         AMcfl0+vKnv79tJawitZRky0etq+oWZ2ZNRijinK4iJCq8FUGWjDzitIQB4Ntxd/YNc4
         675QhuuzfEluBZrhboT35cm0FXf6I2lwrQ0lSjZk941uHbEK3h5AXOFWdVxpsVBwCbXD
         WKHEiswBUptc/WM4y7YphzP0nAFnbXfkNeHnzpxGwPisLenlpjICE4jDdB1t1PfZg7Er
         wZPg==
X-Gm-Message-State: AOUpUlGeF68Q81iBJC16kgQgoHFnFDmDnOJDpaPpNrRmWP9ZHmm4NVp6
        +bU3dl+4xUCcJjhmJGJlX/M=
X-Google-Smtp-Source: AA+uWPz9lkOTtEisWCzS719hL8FekB19lCHTCn6v/sKykYws09XZmOCLA/yFbSLcDTPPeyqzhkW/+g==
X-Received: by 2002:adf:9101:: with SMTP id j1-v6mr13069184wrj.3.1534254476604;
        Tue, 14 Aug 2018 06:47:56 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id z8-v6sm15965991wrp.54.2018.08.14.06.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 06:47:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH] mingw: enable atomic O_APPEND
References: <pull.17.git.gitgitgadget@gmail.com>
        <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
        <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
        <bc9132ab-3030-07e3-03d1-d2ddae6a1b45@kdbg.org>
        <xmqqr2j23tnb.fsf@gitster-ct.c.googlers.com>
        <84c749fd-23d2-0bc5-225b-74f8d31502b6@kdbg.org>
        <87eff2rmgt.fsf@evledraar.gmail.com>
        <20180813223701.GC16006@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180813223701.GC16006@sigill.intra.peff.net>
Date:   Tue, 14 Aug 2018 15:47:54 +0200
Message-ID: <87a7pprred.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 13 2018, Jeff King wrote:

> On Mon, Aug 13, 2018 at 11:22:10PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> > O_APPEND is POSIX and means race-free append. If you mark some call
>> > sites with O_APPEND, then that must be the ones that need race-free
>> > append. Hence, you would have to go the other route: Mark those call
>> > sites that do _not_ need race-free append with some custom
>> > function/macro. (Or mark both with different helpers and avoid writing
>> > down O_APPEND.)
>>
>> O_APPEND in POSIX is race-free only up to PIPE_MAX bytes written at a
>> time, which is e.g. 2^12 by default on linux, after that all bets are
>> off and the kernel is free to interleave different write calls.

[I should have said PIPE_BUF, not PIPE_MAX]

> This is a claim I've run across often, but I've never seen a good
> citation for it.

To clarify I'm claiming that this is not a guarantee POSIX or linux
support. Not that in practice it doesn't work on some systems.

The relevant POSIX docs are here:
http://pubs.opengroup.org/onlinepubs/9699919799/functions/write.html

    Write requests of {PIPE_BUF} bytes or less shall not be interleaved
    with data from other processes doing writes on the same pipe. Writes
    of greater than {PIPE_BUF} bytes may have data interleaved, on
    arbitrary boundaries, with writes by other processes, whether or not
    the O_NONBLOCK flag of the file status flags is set.

And the Linux docs at http://man7.org/linux/man-pages/man7/pipe.7.html
say something similar:

    Writes of more than PIPE_BUF bytes may be nonatomic: the kernel may
    interleave the data with data written by other processes.  POSIX.1
    requires PIPE_BUF to be at least 512 bytes.  (On Linux, PIPE_BUF is
    4096 bytes.)

> Certainly atomic writes to _pipes_ are determined by PIPE_BUF (which
> IIRC is not even a constant on Linux, but can be changed at run-time).
> But is it relevant for regular-file writes?

I believe it's hardcoded at PIPE_BUF which is defined as PAGE_SIZE on
linux. I think you may be thinking of /proc/sys/fs/pipe-max-pages which
is the number of pages that a pipe will take before filling up, but I
may be wrong.

> Another gem I found while digging on this O_APPEND/FILE_APPEND_DATA
> stuff the other day: somebody claimed that the max atomic-append size on
> Linux is 4096 and 1024 on Windows. But their experimental script was
> done in bash! So I suspect they were really just measuring the size of
> stdio buffers.

Yes, and some tests for this are wrong because they use e.g. "print" in
some higher-level language which'll always split stuff into writes of
1024 or something.

> Here's my attempt at a test setup. This C program forces two processes
> to write simultaneously to the same file with O_APPEND:
>
> -- >8 --
> #include <stdlib.h>
> #include <string.h>
> #include <stdio.h>
> #include <sys/types.h>
> #include <fcntl.h>
> #include <unistd.h>
>
> static void doit(int size, const char *fn, char c)
> {
> 	int fd;
> 	char *buf;
>
> 	fd = open(fn, O_WRONLY|O_APPEND|O_CREAT, 0666);
> 	if (fd < 0) {
> 		perror("open");
> 		return;
> 	}
>
> 	buf = malloc(size);
> 	memset(buf, c, size);
>
> 	while (1)
> 		write(fd, buf, size);
> }
>
> int main(int argc, const char **argv)
> {
> 	int size = atoi(argv[1]);
>
> 	if (fork())
> 		doit(size, argv[2], '1');
> 	else
> 		doit(size, argv[2], '2');
> 	return 0;
> }
> -- 8< --
>
> and then this program checks that we saw atomic units of the correct
> size:
>
> -- >8 --
> #include <stdlib.h>
> #include <stdio.h>
> #include <unistd.h>
>
> int main(int argc, const char **argv)
> {
> 	int size = atoi(argv[1]);
> 	char *buf;
>
> 	buf = malloc(size);
> 	while (1) {
> 		int i;
> 		/* assume atomic reads, i.e., no signals */
> 		int r = read(0, buf, size);
> 		if (!r)
> 			break;
> 		for (i = 1; i < size; i++) {
> 			if (buf[i] != buf[0]) {
> 				fprintf(stderr, "overlap\n");
> 				return 1;
> 			}
> 		}
> 	}
> 	return 0;
> }
> -- 8< --
>
> And then you can do something like:
>
>   for size in 4097 8193 16385 32769 65537 131073 262145 524289 1048577; do
>     >out ;# clean up from last run
>     echo "Trying $size..."
>     timeout 5 ./write $size out
>     if ! ./check $size <out; then
>       echo "$size failed"
>       break
>     fi
>   done
>
> On my Linux system, each of those seems to write several gigabytes
> without overlapping. I did manage to hit some failing cases, but they
> were never sheared writes, but rather cases where there was an
> incomplete write at the end-of-file.

Yeah I can't make that fail experimentally either, except in the case
you mentioned. I also checked on a NetBSD & OpenBSD and OpenBSD box I
have access to, same thing.

> So obviously this is all a bit of a tangent. I'd be fine declaring that
> trace output is generally small enough not to worry about this in the
> first place. But those results show that it shouldn't matter even if
> we're writing 1MB trace lines on Linux. I wouldn't be at all surprised
> to see different results on other operating systems, though.

I don't know how this works internally in the kernel, but I'd be very
careful to make that assertion. Most likely this in practice depends on
what FS you're using, its mount options, whether fsync() is involved,
I/O pressure etc.

FWIW this is something I've ran into in the past on Linux as a practical
matter, but that was many kernel versions ago, so maybe the semantics
changed.

We had an ad-hoc file format with each chunk a "<start
marker><length><content><end marker>\n" format (and the <content> was
guaranteed not to contain "\n"). These would be written to the same file
by N workers. We would get corrupt data because of this in cases where
we were writing more than PIPE_BUF, e.g. start markers for unrelated
payloads interleaved with content, lines that were incorrectly formed
etc.

But yeah, whether this is a practical concern for git trace output is
another matter. I just wanted to chime in to note that atomic appends to
files are only portable on POSIX up to PIPE_BUF.
