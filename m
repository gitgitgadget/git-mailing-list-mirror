Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3CF81F404
	for <e@80x24.org>; Sat, 17 Mar 2018 19:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbeCQTpO (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 15:45:14 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38461 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753439AbeCQTpN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 15:45:13 -0400
Received: by mail-wm0-f45.google.com with SMTP id q137so2526706wmd.3
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 12:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=j209e3Hg/B5afNe19FYa6aXU9oRHWYRndrdxlGn1D3o=;
        b=Fr5VQaWwZ8KJK59Uf6mJHMBVmwnfENNcXtUMdvhXB6hjdZ9WyVi9+MiiJwhT4eBu2o
         zmg9FLiifX5d1hBtpPdVwe5kXmQs4ijjBQ88entZUz2RCaKvN7eZ1GT1zKzmuCm/oaBB
         GqWgCbXCcMZHCxjozToRooXuzd58tUP9DsMz3C/o6b3ZjCctWyeirxgF20dfeNY5D6mV
         c/a0a3nxInpmWZW85GRT4cE2a8pCilRK1ZZ4KJAcO/q+xCinY3Sb2bp6MG3YMPwyLfEu
         +/62XnPEbek7DEeJXML35aDONOToFYOsOsLKQzbU4X4GzBMddTWOAquhaWHow4yOMV9Z
         GaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=j209e3Hg/B5afNe19FYa6aXU9oRHWYRndrdxlGn1D3o=;
        b=HtJ3MHqirRLHBiRmG01PDT+fcYzqofr2uHsp/2yNxlptuuO2nmi96DbJsn2wZoGp7H
         rV5uR8NtTQg8UErcIqUk043ieVQdt74WS1itRrsJNGluiU7sVJHjqdj6do/zwRc8Buep
         Brbnn1GXU2IktK1NP85WwqM5CEY1MN1WGzO/m33LyVWCvTwHGH/rQ9r0dFuuVHtG7FcZ
         7gvgHaj18Tkwsdhtf9+fGleOnavptQ/piH+fCsn0i8exNxMviU3loaB1QU/jizYNNEqU
         2UZb+o/9jRf1Dp5AkaWYmkDpBUwRZBsH1Js6D6a3hQLYFscxmS4Ytor9GUNyFuW6En9k
         Wu+A==
X-Gm-Message-State: AElRT7FCSOkf6TCV3kPyPmrDfWRJYjdDCqhPujcFqWxAMdPw0VNs/rwY
        KaRtiGgkjPh07N2Fwcy8vv8=
X-Google-Smtp-Source: AG47ELvUURgNShBVPu0x51kKQCiNmHnjvhmWqO260np5+nqn0+CKhxdhMW8MMlcH9bpQP/o82JaigQ==
X-Received: by 10.28.208.70 with SMTP id h67mr5183491wmg.95.1521315911600;
        Sat, 17 Mar 2018 12:45:11 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id o2sm9971121wro.31.2018.03.17.12.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 12:45:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v5 00/11] nd/pack-objects-pack-struct updates
References: <20180316183200.31014-1-pclouds@gmail.com> <20180317141033.21545-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180317141033.21545-1-pclouds@gmail.com>
Date:   Sat, 17 Mar 2018 20:45:06 +0100
Message-ID: <87po42cwql.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 17 2018, Nguyễn Thái Ngọc Duy jotted:

> v5 changes are small enough that the interdiff is pretty self
> explanatory (there's also a couple commit msg updates).

I've been testing this and it's definitely an improvement. I think it
would be good to get some mention in the commit messages themselves of
the incremental improvement, to that end I wrote this:

    $ cat /tmp/howmuch-mem.sh
    #!/bin/sh
    cd /tmp &&
    (
        for i in {1..3}
        do
            /usr/bin/time -f MaxRSS:%M ~/g/git/git --git-dir=/tmp/linux.git --exec-path=/home/avar/g/git repack -A -d 2>&1
        done | grep MaxRSS: | sort -n | head -n 1 | tr '\n' '\t' &&
        git git-commit-summary &&
        echo
    ) | tee -a /tmp/git-memory.log

I.e. we repack linux.git (I'd already repacked it once) and do three
runs, and take the lowest RSS size. This yields (I rebased your series
on top of git@github.com:git/git.git master and pushed it to
git@github.com:avar/git.git pack-objects-reduce-memory-footprint), via:

    git rebase --exec='make -j8 CFLAGS="-O3" && /tmp/howmuch-mem.sh' -i

That gave me, kb on the first column:

    MaxRSS:3746648  f23a196dd9 ("pack-objects: a bit of document about struct object_entry", 2018-03-01)
    MaxRSS:3700696  953b6473d7 ("pack-objects: turn type and in_pack_type to bitfields", 2018-03-01)
    MaxRSS:3700404  6cbe573539 ("pack-objects: use bitfield for object_entry::dfs_state", 2018-03-01)
    MaxRSS:3654044  0b93ebcae9 ("pack-objects: use bitfield for object_entry::depth", 2018-03-01)
    MaxRSS:3654040  67a4d48773 ("pack-objects: move in_pack_pos out of struct object_entry", 2018-03-01) [X]
    MaxRSS:3654104  e77319c65a ("pack-objects: move in_pack out of struct object_entry", 2018-03-01) [X]
    MaxRSS:3608096  a72cfcfea3 ("pack-objects: refer to delta objects by index instead of pointer", 2018-03-01)
    MaxRSS:3562212  76eaa779eb ("pack-objects: shrink z_delta_size field in struct object_entry", 2018-03-05)
    MaxRSS:3515164  42e28dd4b3 ("pack-objects: shrink size field in struct object_entry", 2018-03-05)
    MaxRSS:3469440  26eba3ded4 ("pack-objects: shrink delta_size field in struct object_entry", 2018-03-05)
    MaxRSS:3423704  c6493de964 ("pack-objects.h: reorder members to shrink struct object_entry", 2018-03-12)

I.e. on git.git we end up with just over a a 8.5% reduction, and
interestingly have a slight increase over a past commit in one change,
and one that just makes 4kb of difference (marked via [X] above).

Also, your v0 says it overall saves 260MB of memory. According to this
it's 320MB. You did note some reductions in subsequent patches, but it's
worth calling that out explicitly.

I have a bigger in-house repo that looks like this with this change:

    MaxRSS:4753120  f23a196dd9 ("pack-objects: a bit of document about struct object_entry", 2018-03-01)
    MaxRSS:4699084  953b6473d7 ("pack-objects: turn type and in_pack_type to bitfields", 2018-03-01)
    MaxRSS:4699028  6cbe573539 ("pack-objects: use bitfield for object_entry::dfs_state", 2018-03-01)
    MaxRSS:4645452  0b93ebcae9 ("pack-objects: use bitfield for object_entry::depth", 2018-03-01)
    MaxRSS:4645288  67a4d48773 ("pack-objects: move in_pack_pos out of struct object_entry", 2018-03-01)
    MaxRSS:4645548  e77319c65a ("pack-objects: move in_pack out of struct object_entry", 2018-03-01)
    MaxRSS:4591484  a72cfcfea3 ("pack-objects: refer to delta objects by index instead of pointer", 2018-03-01)
    MaxRSS:4537980  76eaa779eb ("pack-objects: shrink z_delta_size field in struct object_entry", 2018-03-05)
    MaxRSS:4484148  42e28dd4b3 ("pack-objects: shrink size field in struct object_entry", 2018-03-05)
    MaxRSS:4430404  26eba3ded4 ("pack-objects: shrink delta_size field in struct object_entry", 2018-03-05)
    MaxRSS:4376148  c6493de964 ("pack-objects.h: reorder members to shrink struct object_entry", 2018-03-12)

I.e. a tad more than a 7.9% reduction in memory use.

This series also doesn't make a difference to the total runtime (which
is good, just wanted to make sure). On linux.git on my box best out of
three is 1:15.74 before and 1:14.93 after, which is within the margin of
random error.
