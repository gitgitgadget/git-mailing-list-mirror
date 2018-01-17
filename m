Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4CA11F406
	for <e@80x24.org>; Wed, 17 Jan 2018 23:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754009AbeAQXQ5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 18:16:57 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33886 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbeAQXQz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 18:16:55 -0500
Received: by mail-wm0-f45.google.com with SMTP id 81so136935wmb.1;
        Wed, 17 Jan 2018 15:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=opaOMYZENbCRn13dIrpGaEhzm+cSebl2vpOjG8Ec9rQ=;
        b=BQ2UmTN8RcxpCzYjubBpwWzFkmfHE7sUlHE+G87z7+qayiHb+hZWAUOaC93TKu4NqY
         2q4gy/WaVRrqG1gyPaeb8lVEuH9TMcrn7o9A6hBnv17y2PbL4r3+98q5mCI+IqH9Lwqp
         QqJXsyQYN3NwDx8DPZnqo7sb5DwOMRmeU2iKZDM/KY/63BID3M1hf5e+BULtgtgb4z8e
         ozw1tlB02hFg3KbScJFYdxKeVzMV7cKmXGgTU5IP6+J74HfzhE0PZPuj1IF6D/6W+lL1
         edx/gwnI8tOnmFhlDXXkac38UoG2aQaZUXQ9EiqTZojgymwp7DUGYO/Gh6rfL+McZJym
         LYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=opaOMYZENbCRn13dIrpGaEhzm+cSebl2vpOjG8Ec9rQ=;
        b=r/vXM2SGY8QNEt+fgb59A+voBgXV2zlaexqQWuWVuog1+iY9kvTLjcodZS/mreiDWp
         fIj5oyG95iAzkYJm9riqXKPoXaTPNdg2QF9+VT2oY0nzEXFeamd9kmGuP3A2tDOpeHQE
         JpoNkcDJn6vZtsg/MK7+x2B9Z3thRdqyENg7pUHuo16TzwBAHnMne7dpVHXH25Tkv10c
         xfDuxxwCJeuEKgdHsHYYBvxEePc/ZSwsKCBX5mmagJB4HCy0CyqoFCfH1gWIZbIlqULB
         ryDk6Vqz81jmIlbvntQXWbw8IWRLXU+AT8OB8GOw8/ji2J7sueFoNwJfGMz92Y2JCr6f
         Ttzg==
X-Gm-Message-State: AKwxyteu+6fn0lMtjNZsLTwdHmc6K/tKV+0skKIBAwIIvLfQNI0nEzVo
        51Uw81cetxb9rbWMjhcEK1w=
X-Google-Smtp-Source: ACJfBouknragCdnoNT7K6rg8Rn3sta0EYHM7DQtQaLBNXjsE+4ZQRQt49dlWB4Toyp8PsjBChD0X8w==
X-Received: by 10.80.155.7 with SMTP id o7mr5051563edi.105.1516231013425;
        Wed, 17 Jan 2018 15:16:53 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id y3sm3032452edb.1.2018.01.17.15.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jan 2018 15:16:52 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Christoph Hellwig <hch@lst.de>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
References: <20180117184828.31816-1-hch@lst.de> <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com> <87h8rki2iu.fsf@evledraar.gmail.com> <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
Date:   Thu, 18 Jan 2018 00:16:51 +0100
Message-ID: <87efmohy8s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 17 2018, Linus Torvalds jotted:

> On Wed, Jan 17, 2018 at 1:44 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>>     I ran a small test myself on CentOS 7 (3.10) with ext4 data=ordered
>>     on the tests I thought might do a lot of loose object writes:
>>
>>       $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_MAKE_OPTS="NO_OPENSSL=Y CFLAGS=-O3 -j56" ./run origin/master fsync-on~ fsync-on p3400-rebase.sh p0007-write-cache.sh
>>       [...]
>>       Test                                                            fsync-on~         fsync-on
>>       -------------------------------------------------------------------------------------------------------
>>       3400.2: rebase on top of a lot of unrelated changes             1.45(1.30+0.17)   1.45(1.28+0.20) +0.0%
>>       3400.4: rebase a lot of unrelated changes without split-index   4.34(3.71+0.66)   4.33(3.69+0.66) -0.2%
>>       3400.6: rebase a lot of unrelated changes with split-index      3.38(2.94+0.47)   3.38(2.93+0.47) +0.0%
>>       0007.2: write_locked_index 3 times (3214 files)                 0.01(0.00+0.00)   0.01(0.00+0.00) +0.0%
>>
>>    No impact. However I did my own test of running the test suite 10%
>>    times with/without this patch, and it runs 9% slower:

That should be "10 times" b.t.w., not "10% times"

>>
>>      fsync-off: avg:21.59 21.50 21.50 21.52 21.53 21.54 21.57 21.59 21.61 21.63 21.95
>>       fsync-on: avg:23.43 23.21 23.25 23.26 23.26 23.27 23.32 23.49 23.51 23.83 23.88
>
> That's not the thing you should check.
>
> Now re-do the test while another process writes to a totally unrelated
> a huge file (say, do a ISO file copy or something).
>
> That was the thing that several filesystems get completely and
> horribly wrong. Generally _particularly_ the logging filesystems that
> don't even need the fsync, because they use a single log for
> everything (so fsync serializes all the writes, not just the writes to
> the one file it's fsync'ing).
>
> The original git design was very much to write each object file
> without any syncing, because they don't matter since a new object file
> - by definition - isn't really reachable. Then sync before writing the
> index file or a new ref.
>>
> But things have changed, I'm not arguing that the code shouldn't be
> made safe by default. I personally refuse to use rotating media on my
> machines anyway, largely exactly because of the fsync() issue (things
> like "firefox" started doing fsync on the mysql database for stupid
> things, and you'd get huge pauses).
>
> But I do think your benchmark is wrong. The case where only git does
> something is not interesting or relevant. It really is "git does
> something _and_ somebody else writes something entirely unrelated at
> the same time" that matters.

Yeah it's shitty, just a quick hack to get some since there was a
discussion of performance, but neither your original patch or this
thread had quoted any.

One thing you may have missed is that this is a parallel (56 tests at a
time) run of the full test suite. So there's plenty of other git
processes (and test setup/teardown) racing with any given git
process. Running the test suite in a loop like this gives me ~100K IO
ops/s & ~50% disk utilization.

Or does overall FS activity and raw throughput (e.g. with an ISO copy)
matter more than general FS contention?

Tweaking it to emulate this iso copy case, running another test with one
of these running concurrently:

    # setup
    dd if=/dev/urandom of=/tmp/fake.iso bs=1024 count=$((1000*1024))
    # run in a loop (shuf to not always write the same thing)
    while sleep 0.1; do shuf /tmp/fake.iso | pv >/tmp/fake.shuf.iso; done

Gives throughput that spikes to 100% (not consistently) and:

    fsync-off: avg:36.37 31.74 33.83 35.12 36.19 36.32 37.04 37.34 37.71 37.93 40.43
     fsync-on: avg:38.09 34.56 35.14 35.69 36.41 36.41 37.96 38.25 40.45 41.44 44.59

~4.7% slower, v.s. ~8.5% in my earlier
87h8rki2iu.fsf@evledraar.gmail.com without that running.

Which is not an argument for / against this patch, but those numbers
seem significant, and generally if the entire test suite slows down by
that much there's going to be sub-parts of it that are much worse.

Which might be a reason to tread more carefully and if it *does* slow
things down perhaps do it with more granularity, e.g. turning it on in
git-receive-pack might be more sensible than in git-filter-branch.

I remember Roberto Tyley's BFG writing an amazing amount of loose
objects, but it doesn't seem to have an fsync() option, I wonder if
adding one would be a representative pathological test case.
