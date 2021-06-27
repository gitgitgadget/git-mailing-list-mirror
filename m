Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC73DC48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A265661C17
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhF0MqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 08:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhF0MqV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 08:46:21 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464A6C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:43:57 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id a7so2536066ilk.10
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=AnRtvrkenI8hFlSLufQywT4g+/Ix8PYj2kuaGS1l5R4=;
        b=iaFsW/7IGajAz6VazemTMpuOm+fC8L74w1N4F7T5V7BD1bkbiSylfJnwJY0Z9NNlCn
         tGGNzo7ZYHrQAismbQg2LisXBcSxP3QCKqf+u8afQxBNwJMgq2i3ZBjpq+2jiVqkfhaF
         BqvJhbShT1xvOkfZz4HlVQcemUqlqgOkfWBOunAZThd3a14oSHn8siIK6JI+wQi4UNgn
         ZdD58NEAgfesyuKQvoWeR1NFmxo3xHP8jymNgqxpb/XcIAWTo8Vb0AAySin8DCf/dXLh
         oAihrKX37ithoFSnxeYQkDwbqbXUICr4jJjSEWnTcsCkuqP4lOgs/Y3pn2fpn8axE7xx
         7UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=AnRtvrkenI8hFlSLufQywT4g+/Ix8PYj2kuaGS1l5R4=;
        b=A77onrHJWQcHmsyD5e6lfgd9ZhYg0o72HJRqmTz+MyXeNv2y+LmDyVVpZLB6Xuk3AY
         NJo8wVfkWT1VW3/1F7mrp8l8l7dZjpJNNTyO8rxLYnDEDM4Vw1vS3SE+OuIjPzrVoGLk
         Sw7wVze9J6jXbJ5jqwb4FVA8O/u29XbhaXehquvvrcNnbDeSrVXgKcFdX9X8nzybmeMJ
         UcD9eHr7//Y4YgKhtiNT6+YHK/nwY/S93xPMfNE//qyWt6vjTrxC2h6KOR0G8L5u/fv9
         X//2AlswBnDiXAMFAdrxlmyeJDmSu0NIrMDgpTi1HBHjSqM3/OcKHqx+9vgHXurnRLP9
         fl2w==
X-Gm-Message-State: AOAM533/bRqUO+r2erRsUKoiojjMkwROgJ3uYd26t5JJGE6OOLxKA48o
        JgaQQtq9XPH0S9X8SKNkYeO8FC2M0p4qjBuNhvDaq1vZgDForgCZ
X-Google-Smtp-Source: ABdhPJyAucBduorYw5m1zjHaTv3PQzFMRsEE4ZZdx+zFuqIbdxzHomjI2Il4smYasme5gMFrRyIxhFnC0eOwlejWkvU=
X-Received: by 2002:a92:d2c5:: with SMTP id w5mr1145098ilg.174.1624797836141;
 Sun, 27 Jun 2021 05:43:56 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 27 Jun 2021 20:43:45 +0800
Message-ID: <CAOLTT8TLhL3MNnkB7s1J4hAQmovaUPoeydn8kepzFOT_UL83_Q@mail.gmail.com>
Subject: [GSoC] Git Blog 6
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My sixth week blog finished:
The web version is here:
https://adlternative.github.io/GSOC-Git-Blog-6/

## Week6: Performance Testing

This week, `Christan`, `Hariom`, and `Bagas` reviewed my patches. I
revised the commit
messages and made some content adjustments based on their suggestions.
Patch is here:
 [[PATCH v6 00/15] [GSOC][RFC] cat-file: reuse ref-filter
logic](https://lore.kernel.org/git/pull.980.v6.git.1624797350.gitgitgadget@=
gmail.com/).

Compared with the big changes that made `git cat-file` re-use
`ref-filter` logic in previous
weeks, the overall change this week is not very large.

Although from a functional point of view, the current version of `git
cat-file` can support more
atoms, but from a performance point of view, it is far less than the
previous version.

The following is an excerpt from the commit message of `[GSOC]
cat-file: reuse ref-filter logic`:

```
The performance for `git cat-file --batch-all-objects
--batch-check` on the Git repository itself with performance
testing tool `hyperfine` changes from 669.4 ms =C2=B1 31.1 ms to
1.134 s =C2=B1 0.063 s.

The performance for `git cat-file --batch-all-objects --batch
>/dev/null` on the Git repository itself with performance testing
tool `time` change from "27.37s user 0.29s system 98% cpu 28.089
total" to "33.69s user 1.54s system 87% cpu 40.258 total".
```

Now the performance of `cat-file --batch` is almost half of the
previous performance of it,
because of the complex logic in `ref-filter`. So I am thinking, how
can I find the performance
bottleneck in `ref-filter` and optimize it?

So I try to find and use performance testing tools to analyze the
time-consuming steps of
`git cat-file --batch`.

* Using Google's `gperftools`:
1. Add the link parameter `-lprofiler` in `config.mak`: `CFLAGS +=3D -lprof=
iler`.
2. `make`.
3. Use `CPUPROFILE=3D/tmp/prof.out /<path>/git cat-file --batch-check
--batch-all-objects`
to run the git and general `prof.out`, which contains the results of
performance analysis.
4. Use `pprof --text /<path>/git /tmp/prof.out` to display the result
in the terminal.

* `git cat-file` after re-using the `ref-filter` logic:

```
Using local file /<path>/git.
Using local file /<path>/prof.out.
/usr/bin/addr2line: /<path>/git: file format not recognized
Total: 283 samples
62 21.9% 21.9% 62 21.9% __GI___libc_write
34 12.0% 33.9% 34 12.0% 000055d9164cdc36
20 7.1% 41.0% 20 7.1% inflate
12 4.2% 45.2% 12 4.2% inflateCodesUsed@@ZLIB_1.2.9
8 2.8% 48.1% 8 2.8% __memcmp_avx2_movbe
7 2.5% 50.5% 7 2.5% 000055d9164cdc33
5 1.8% 52.3% 5 1.8% __libc_open64
5 1.8% 54.1% 5 1.8% __memmove_avx_unaligned_erms
5 1.8% 55.8% 5 1.8% _int_malloc
3 1.1% 56.9% 3 1.1% 000055d9164ccbce
3 1.1% 58.0% 3 1.1% malloc_consolidate
2 0.7% 58.7% 2 0.7% 000055d916478d78
2 0.7% 59.4% 2 0.7% 000055d9164cc821
2 0.7% 60.1% 2 0.7% 000055d9164cc8f5
2 0.7% 60.8% 2 0.7% 000055d9164ccc49
2 0.7% 61.5% 2 0.7% 000055d91659dc02
2 0.7% 62.2% 2 0.7% __GI___libc_free
2 0.7% 62.9% 2 0.7% __calloc
2 0.7% 63.6% 2 0.7% __fstatat64
2 0.7% 64.3% 2 0.7% __memset_avx2_unaligned_erms
2 0.7% 65.0% 2 0.7% __strlen_avx2
2 0.7% 65.7% 2 0.7% __vfprintf_internal
...
1 0.4% 92.9% 1 0.4% _IO_new_do_write
1 0.4% 93.3% 1 0.4% _IO_new_file_write
1 0.4% 93.6% 1 0.4% _IO_old_init
1 0.4% 94.0% 1 0.4% _IO_str_init_static_internal
1 0.4% 94.3% 1 0.4% __GI__IO_default_xsputn
1 0.4% 94.7% 1 0.4% __GI__IO_fwrite
1 0.4% 95.1% 1 0.4% __GI__IO_setb
1 0.4% 95.4% 1 0.4% __GI___libc_malloc
1 0.4% 95.8% 1 0.4% __GI___mmap64
1 0.4% 96.1% 1 0.4% __GI___qsort_r
1 0.4% 96.5% 1 0.4% __GI_munmap
1 0.4% 96.8% 1 0.4% __abi_tag
1 0.4% 97.2% 1 0.4% __strchr_avx2
1 0.4% 97.5% 1 0.4% _int_free
1 0.4% 97.9% 1 0.4% _itoa_word
1 0.4% 98.2% 1 0.4% adler32_z@@ZLIB_1.2.9
1 0.4% 98.6% 1 0.4% inflateBackEnd@@ZLIB_1.2.0
1 0.4% 98.9% 1 0.4% inflateReset2@@ZLIB_1.2.3.4
1 0.4% 99.3% 4 1.4% msort_with_tmp.part.0
1 0.4% 99.6% 1 0.4% unlink_chunk.constprop.0
1 0.4% 100.0% 1 0.4% zError
...
0 0.0% 100.0% 150 53.0% __libc_start_main
```

* `git cat-file` before re-using the `ref-filter` logic:

```
Using local file /<path>/git.
Using local file /tmp/prof.out2.
/usr/bin/addr2line: /<path>/git: file format not recognized
Total: 234 samples
52 22.2% 22.2% 52 22.2% __GI___libc_write
24 10.3% 32.5% 24 10.3% 00005564fbe6b0da
23 9.8% 42.3% 23 9.8% inflateCodesUsed@@ZLIB_1.2.9
11 4.7% 47.0% 11 4.7% inflate
9 3.8% 50.9% 9 3.8% 00005564fbe6b0d7
7 3.0% 53.8% 7 3.0% __memcmp_avx2_movbe
5 2.1% 56.0% 5 2.1% _int_malloc
4 1.7% 57.7% 4 1.7% __libc_open64
3 1.3% 59.0% 3 1.3% __GI__IO_default_xsputn
3 1.3% 60.3% 3 1.3% __memmove_avx_unaligned_erms
3 1.3% 61.5% 3 1.3% __strchrnul_avx2
2 0.9% 62.4% 2 0.9% 00005564fbe1621c
2 0.9% 63.2% 2 0.9% 00005564fbe6813a
2 0.9% 64.1% 2 0.9% 00005564fbe6b0dd
2 0.9% 65.0% 2 0.9% 00005564fbe6b0e9
2 0.9% 65.8% 2 0.9% 00005564fbe6b8f6
2 0.9% 66.7% 2 0.9% 00005564fbef4ce6
2 0.9% 67.5% 2 0.9% __GI___libc_malloc
...
1 0.4% 97.4% 1 0.4% _IO_new_file_write
1 0.4% 97.9% 1 0.4% _IO_new_file_xsputn
1 0.4% 98.3% 1 0.4% __GI___libc_free
1 0.4% 98.7% 1 0.4% __strlen_avx2
1 0.4% 99.1% 1 0.4% __vsnprintf_internal
1 0.4% 99.6% 1 0.4% adler32_z@@ZLIB_1.2.9
1 0.4% 100.0% 1 0.4% inflateBackEnd@@ZLIB_1.2.0
...
0 0.0% 100.0% 118 50.4% __libc_start_main
0 0.0% 100.0% 4 1.7% msort_with_tmp.part.0
```

Ignore `write`, `inflate` and `000055d9164cdc36`, the execution time of `me=
mcmp`
and `memmove` is very large.

However, whether it is `git cat-file` before or after re-using the
`ref-filter` logic,
the functions they call take up similar proportions of time.
* Using `perf`:
`perf top -p <git-pid>`

```
12.72% libc-2.33.so [.] __memmove_avx_unaligned_erms
7.39% libz.so.1.2.11 [.] inflate
5.56% libz.so.1.2.11 [.] 0x00000000000088ba
5.27% libz.so.1.2.11 [.] adler32_z
3.46% git [.] patch_delta
```
We can see that `memmove` is still the part that accounts for the
largest proportion of time.

We can already come to a conclusion: A lot of the time of `cat-file
--batch` is used for data copy,
this may be the focus of our later performance optimization.

--
ZheNing Hu
