Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2006B1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 22:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbeAQWH0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 17:07:26 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:45782 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753808AbeAQWHY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 17:07:24 -0500
Received: by mail-it0-f67.google.com with SMTP id x42so11073484ita.4;
        Wed, 17 Jan 2018 14:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Uf8MHkl4IDmewO+KJVL1Asgw0HNf1M/44yIdecfmaOc=;
        b=ZwQHuTRzVnvn2WLiU0CVMyyIj5Fc8TopOuHNBQwCQW+YVLFVyAvV/PA0ZOzJKVZLF3
         yu5K2HqWP86a8wUJW6QbOknJJdIdjIWsmbJEBJxRaqO3MQ7ehdHfPSCKc597cnVOZ3fl
         68BDPP1M5Fz63GxKoEQ4xNumQNTIYHguz5kZGi0CTulLiArDofW1KYjQcxb3djSaTH5M
         UdgNwrJRz+9oIg9OIs6iwpTesutWudKgcbm9d+20D7aLgPu/9kTlzV7euuHem4sjMb5N
         ihYQOqlU37bXuLsqFqbm5UWOfC8OZttYHMDVvEbPCCqePj0XgcTxpslejr1GKvJh5k5q
         jiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Uf8MHkl4IDmewO+KJVL1Asgw0HNf1M/44yIdecfmaOc=;
        b=dBp5GMcfIxCTtKUMfUQxCcyi7Ma5Lgm7MQIxa0KW4zFbp5Z/5pFfR0IrnyFzqm6Bor
         TEnlzPFYZwBTAnHOmx1vdWcaU7L6NP4AFb5/evUs3l6MzJ50KlaqVZFAu0oF0Xq7mCQe
         htGJV6Ryn4PARf/Je9VLWwD6WrwJSYFUMV732HpFdmgPRRXDuyBByLEW08v9HqMtUeK2
         yAvGls8cFG/4+hgYhJVLe2LxgR6suDimZrX2cDWWuMmaEclhw8W6xEok18nE7twpFwv7
         bpfpnbcCx5i+2taLeDutsAS90aF7T1Xkx0pNF4o7nNFdW2Zb4xvqLLVbvo1WC5FJ+ub9
         lvnw==
X-Gm-Message-State: AKwxyte5V5MgA3qh4TFIey3JIaeqVv6wep80oPFwlHGA72LK6ti1kFMQ
        qgBXABCLRXtDRvW3HDvjPx0nMUhM9meCgntL9tM=
X-Google-Smtp-Source: ACJfBouybYiU2V7AGtG7gBoPWaTVj5Zx5s15wg+CQSI78uLaKHpowhJ7wecCD/RrtbJsrU1AgbinHbblhC0yNp7sZ2Q=
X-Received: by 10.36.175.88 with SMTP id l24mr18029071iti.139.1516226843377;
 Wed, 17 Jan 2018 14:07:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.6.147 with HTTP; Wed, 17 Jan 2018 14:07:22 -0800 (PST)
In-Reply-To: <87h8rki2iu.fsf@evledraar.gmail.com>
References: <20180117184828.31816-1-hch@lst.de> <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
 <87h8rki2iu.fsf@evledraar.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Jan 2018 14:07:22 -0800
X-Google-Sender-Auth: mK6N8IY2ZmzYwWJx8eFa_-Ltr1I
Message-ID: <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Christoph Hellwig <hch@lst.de>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 1:44 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>     I ran a small test myself on CentOS 7 (3.10) with ext4 data=3Dordered
>     on the tests I thought might do a lot of loose object writes:
>
>       $ GIT_PERF_REPEAT_COUNT=3D10 GIT_PERF_LARGE_REPO=3D~/g/linux GIT_PE=
RF_MAKE_OPTS=3D"NO_OPENSSL=3DY CFLAGS=3D-O3 -j56" ./run origin/master fsync=
-on~ fsync-on p3400-rebase.sh p0007-write-cache.sh
>       [...]
>       Test                                                            fsy=
nc-on~         fsync-on
>       -------------------------------------------------------------------=
------------------------------------
>       3400.2: rebase on top of a lot of unrelated changes             1.4=
5(1.30+0.17)   1.45(1.28+0.20) +0.0%
>       3400.4: rebase a lot of unrelated changes without split-index   4.3=
4(3.71+0.66)   4.33(3.69+0.66) -0.2%
>       3400.6: rebase a lot of unrelated changes with split-index      3.3=
8(2.94+0.47)   3.38(2.93+0.47) +0.0%
>       0007.2: write_locked_index 3 times (3214 files)                 0.0=
1(0.00+0.00)   0.01(0.00+0.00) +0.0%
>
>    No impact. However I did my own test of running the test suite 10%
>    times with/without this patch, and it runs 9% slower:
>
>      fsync-off: avg:21.59 21.50 21.50 21.52 21.53 21.54 21.57 21.59 21.61=
 21.63 21.95
>       fsync-on: avg:23.43 23.21 23.25 23.26 23.26 23.27 23.32 23.49 23.51=
 23.83 23.88

That's not the thing you should check.

Now re-do the test while another process writes to a totally unrelated
a huge file (say, do a ISO file copy or something).

That was the thing that several filesystems get completely and
horribly wrong. Generally _particularly_ the logging filesystems that
don't even need the fsync, because they use a single log for
everything (so fsync serializes all the writes, not just the writes to
the one file it's fsync'ing).

The original git design was very much to write each object file
without any syncing, because they don't matter since a new object file
- by definition - isn't really reachable. Then sync before writing the
index file or a new ref.

But things have changed, I'm not arguing that the code shouldn't be
made safe by default. I personally refuse to use rotating media on my
machines anyway, largely exactly because of the fsync() issue (things
like "firefox" started doing fsync on the mysql database for stupid
things, and you'd get huge pauses).

But I do think your benchmark is wrong. The case where only git does
something is not interesting or relevant. It really is "git does
something _and_ somebody else writes something entirely unrelated at
the same time" that matters.

                  Linus
