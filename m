Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E2581F406
	for <e@80x24.org>; Wed, 17 Jan 2018 21:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753502AbeAQVoa (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 16:44:30 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:44688 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbeAQVo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 16:44:28 -0500
Received: by mail-wm0-f52.google.com with SMTP id t74so18153386wme.3;
        Wed, 17 Jan 2018 13:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rrs9m0Mp3fjtEoJHsX1v8vzBWRXusqjS8zmRDKw5khg=;
        b=CPsQNO4DBD8W3LUf3d0dEzjP03M2xdMelDmx39ZYsiBuWJNj934r+icGnE17dODBoZ
         Air8TJdUJCsNUNBF3wslOxHzB42aKmguWpTff/+d8EpErDZaLWOx+k2dQGC1m4kEMSdV
         LmGBgGifnZlCay/8M0S/rqDBT9nKmSPFSZpfB6Cf/r82XIt8gSygPliDbj2OWDbykKdX
         bvGpt2+pT/siUpd0EGmgT3CaBNfEzX8/eLnzrjlGabC+QBiacw7kftCOxzU2J/4ktN1y
         rgewiaGKFyaWGv9469Q0MFtRcXgC7vIdn16m6ZdTNJRUvhtUBHtotc+iHGbPOIjms2sH
         jxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rrs9m0Mp3fjtEoJHsX1v8vzBWRXusqjS8zmRDKw5khg=;
        b=FFI/y3Iu4NN9lwnu3fQDvLhh6uAyRmx1Sh9rRdOpU84b8d6esb89qCMy239OogUKIX
         S+wQ+kXA+3sGm1RBb1ntFO/YLtKNgotU+MHvw+mKkwerfJ6xrqHxjfhRqDPUWz175jys
         Vd3dDJpCkctTxl7lwbFH/0/aGxb2px081oIJ40GNYXDgvnWM4C2FTVjM+yyVTk+PWp+9
         hhnp9wL+SffLc8W/TFPYAyzZkg3xML0gegQj56S3N06ju0U204nS9x2LEQLqVu/xhy73
         b2os8//EelJUQvMeRsONDq3OX6F/EEaelKcWkWybj4/0ORl4Q9kQpzRKMZttMDaTKwKO
         kcXw==
X-Gm-Message-State: AKwxytdzJfJDxQ/6GXdHG+HBDz/ICbCE6tXoldIyz0dzmPYnnAqDWUzA
        1biIY61MBjDOzwAJOgdaGSw=
X-Google-Smtp-Source: ACJfBou0naMCCwaSBIGErO748jv2MIxAGDSeOeMcZW3oSZowR3BRgDlBVBhelCt9laccsPoI7JRMtg==
X-Received: by 10.80.211.7 with SMTP id g7mr4921561edh.76.1516225467216;
        Wed, 17 Jan 2018 13:44:27 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id 30sm3727533edz.63.2018.01.17.13.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jan 2018 13:44:25 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christoph Hellwig <hch@lst.de>, git@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
References: <20180117184828.31816-1-hch@lst.de> <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 17 Jan 2018 22:44:25 +0100
Message-ID: <87h8rki2iu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 17 2018, Junio C. Hamano jotted:

> Christoph Hellwig <hch@lst.de> writes:
>
>> fsync is required for data integrity as there is no gurantee that
>> data makes it to disk at any specified time without it.  Even for
>> ext3 with data=ordered mode the file system will only commit all
>> data at some point in time that is not guaranteed.
>
> It comes from this one:
>
> commit aafe9fbaf4f1d1f27a6f6e3eb3e246fff81240ef
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Jun 18 15:18:44 2008 -0700
>
>     Add config option to enable 'fsync()' of object files
>
>     As explained in the documentation[*] this is totally useless on
>     filesystems that do ordered/journalled data writes, but it can be a
>     useful safety feature on filesystems like HFS+ that only journal the
>     metadata, not the actual file contents.
>
>     It defaults to off, although we could presumably in theory some day
>     auto-enable it on a per-filesystem basis.
>
>     [*] Yes, I updated the docs for the thing.  Hell really _has_ frozen
>         over, and the four horsemen are probably just beyond the horizon.
>         EVERYBODY PANIC!
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 0e25b2c92..9a1cec5c8 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -866,10 +866,8 @@ core.whitespace::
>>  core.fsyncObjectFiles::
>>  	This boolean will enable 'fsync()' when writing object files.
>>  +
>> -This is a total waste of time and effort on a filesystem that orders
>> -data writes properly, but can be useful for filesystems that do not use
>> -journalling (traditional UNIX filesystems) or that only journal metadata
>> -and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
>> +This option is enabled by default and ensures actual data integrity
>> +by calling fsync after writing object files.
>
> I am somewhat sympathetic to the desire to flip the default to
> "safe" and allow those who know they are already safe to tweak the
> knob for performance, and it also makes sense to document that the
> default is "true" here.  But I do not see the point of removing the
> four lines from this paragraph; the sole effect of the removal is to
> rob information from readers that they can use to decide if they
> want to disable the configuration, no?

[CC'd the author of the current behavior]

Some points/questions:

 a) Is there some reliable way to test whether this is needed from
    userspace? I'm thinking something like `git update-index
    --test-untracked-cache` but for fsync().

 b) On the filesystems that don't need this, what's the performance
    impact?

    I ran a small test myself on CentOS 7 (3.10) with ext4 data=ordered
    on the tests I thought might do a lot of loose object writes:

      $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_MAKE_OPTS="NO_OPENSSL=Y CFLAGS=-O3 -j56" ./run origin/master fsync-on~ fsync-on p3400-rebase.sh p0007-write-cache.sh
      [...]
      Test                                                            fsync-on~         fsync-on
      -------------------------------------------------------------------------------------------------------
      3400.2: rebase on top of a lot of unrelated changes             1.45(1.30+0.17)   1.45(1.28+0.20) +0.0%
      3400.4: rebase a lot of unrelated changes without split-index   4.34(3.71+0.66)   4.33(3.69+0.66) -0.2%
      3400.6: rebase a lot of unrelated changes with split-index      3.38(2.94+0.47)   3.38(2.93+0.47) +0.0%
      0007.2: write_locked_index 3 times (3214 files)                 0.01(0.00+0.00)   0.01(0.00+0.00) +0.0%

   No impact. However I did my own test of running the test suite 10%
   times with/without this patch, and it runs 9% slower:

     fsync-off: avg:21.59 21.50 21.50 21.52 21.53 21.54 21.57 21.59 21.61 21.63 21.95
      fsync-on: avg:23.43 23.21 23.25 23.26 23.26 23.27 23.32 23.49 23.51 23.83 23.88

   Test script at the end of this E-Mail.

 c) What sort of guarantees in this regard do NFS-mounted filesystems
    commonly make?

Test script:

use v5.10.0;
use strict;
use warnings;
use Time::HiRes qw(time);
use List::Util qw(sum);
use Data::Dumper;

my %time;
for my $ref (@ARGV) {
    system "git checkout $ref";
    system qq[make -j56 CFLAGS="-O3 -g" NO_OPENSSL=Y all];
    for (1..10) {
        my $t0 = -time();
        system "(cd t && NO_SVN_TESTS=1 GIT_TEST_HTTPD=0 prove -j56 --state=slow,save t[0-9]*.sh)";
        $t0 += time();
        push @{$time{$ref}} => $t0;
    }
}
for my $ref (sort keys %time) {
    printf "%20s: avg:%.2f %s\n",
        $ref,
        sum(@{$time{$ref}})/@{$time{$ref}},
        join(" ", map { sprintf "%.02f", $_ } sort { $a <=> $b } @{$time{$ref}});
}
