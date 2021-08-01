Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0297C4338F
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 06:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88E161050
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 06:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhHAGpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Aug 2021 02:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhHAGpi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Aug 2021 02:45:38 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99528C06175F
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 23:45:30 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id l18so16588437ioh.11
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 23:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QkunUBaJRrmwRLefmE8Fa5o0cZdCdcvNXHIT2POTrLA=;
        b=QU4srcyeB8NeKWpf02mUfTGm6g+O/vfKQRxImtp0ohbRvRPduA1PWCMlLoPx25dVTS
         ApPjJ6h774UwGqqoElRMfX9T58ooM9ufsi8EZIldlTErTVvcxpG2WNLY+SRxZrKPfdoG
         baYYLcHjQv/99PyY0roYEL9Xlj0Ev6rt9Il8+tXjMZGGAfgScbUEQBPOOUmIFmR3NJBb
         DjkJIj2NKZ/zu2W0s0A4/XlG/AAhk6b0pLev+726E/zt74cgIML1U41L52JpmfAI+EV9
         XNjztRfV64fChmmJL6gf0mJReJsmybG+MsoLM93lfsscNaoTQDXukHPh5MD6rtertNhH
         kRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QkunUBaJRrmwRLefmE8Fa5o0cZdCdcvNXHIT2POTrLA=;
        b=PNSEDQIV6Bag+V2YkjvHS0nUzhNwLRGaFasm4h2+2VUQl42Uwz67js7reAMWMa7GmX
         OilW2Lmtan3/kipYI9PAkCl2AZisXbDjX07lQ60smK107+poyawZucnTg2eomRZMtX41
         wYcfa7J6WChVwCeNq17pbmXYp8U2wzA3ppjua3wVIEuwmhr1nHUzFABFr0qv1zhMX/jx
         V7NSy8eEyflExIz9g1QjzuDgEQYNFRxk7AqwhZ0v+UoCq3uux4CQSxoTtDtyFEZ8Z7Vo
         3mE3OTN9T18KftGv3Kk+QRR7Y1r2unkIb1gOm0MKWL9hd5b2Ko7RIna/FOZ8dK8Z4Cqy
         yI+A==
X-Gm-Message-State: AOAM530lDkoN/r7I6BTD51KRho4ES8IJSQA84ZWb8S3fDHZu6QwHN5i0
        oUIPLzWfgR8LWRrnrALOrvUmUZvn6UHLAABxhgWtGVqLp6K3/l9y5Eg=
X-Google-Smtp-Source: ABdhPJx15Yz7RB5fIArkyYI2VGJIqikWC5xwXaHD+7+5UOAsdxfCMOTFYNRETox9B6CwttOLaPAIb/4b/l898Jz9tDo=
X-Received: by 2002:a05:6602:25da:: with SMTP id d26mr780505iop.106.1627800330042;
 Sat, 31 Jul 2021 23:45:30 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 1 Aug 2021 14:46:09 +0800
Message-ID: <CAOLTT8RwwMF07f=XxWN=zGsPU0VQ8FqPVdyepQp78Ei8WZpSrw@mail.gmail.com>
Subject: [GSoC] Git Blog 11
To:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My eleventh week blog finished:
The web version is here:
https://adlternative.github.io/GSOC-Git-Blog-11/

### Attempt to optimize performance

This week, at the prompt of my mentor Christian, I used `gprof` for some
performance tests about `git cat-file --batch`:
[Re: [GSOC] How to improve the performance of git cat-file --batch]
(https://lore.kernel.org/git/CAOLTT8TdL7UhfVSOzbpmo-WFNrcKwmy=E720tNt4KM9o_p=keg@mail.gmail.com/)

```
This is my test for git cat-file --batch --batch-all-objects >/dev/null:

daab8a564: The fifth batch (upstream/master)

Flat profile:

Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total
 time   seconds   seconds    calls   s/call   s/call  name
 38.13      0.61     0.61  1968866     0.00     0.00  patch_delta
 13.75      0.83     0.22  6568488     0.00     0.00
unpack_object_header_buffer
 11.25      1.01     0.18   344036     0.00     0.00  unpack_entry
  7.50      1.13     0.12  1964667     0.00     0.00  hashmap_remove
  6.88      1.24     0.11  6153182     0.00     0.00  hashmap_get
  1.88      1.27     0.03  7746299     0.00     0.00  zlib_post_call
  1.88      1.30     0.03   842731     0.00     0.00  bsearch_hash
  1.88      1.33     0.03   827663     0.00     0.00  nth_packed_object_offset
  1.25      1.35     0.02 15385422     0.00     0.00  use_pack
  1.25      1.37     0.02  6236120     0.00     0.00  get_delta_base
  1.25      1.39     0.02  2581859     0.00     0.00  git_inflate_end
  1.25      1.41     0.02   826650     0.00     0.00
do_oid_object_info_extended
  1.25      1.43     0.02   826650     0.00     0.00  find_pack_entry
  1.25      1.45     0.02   825692     0.00     0.00  packed_to_object_type
  1.25      1.47     0.02   378521     0.00     0.00  get_size_from_delta


d3b5272a94: [GSOC] cat-file: reuse ref-filter logic

Flat profile:

Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total
 time   seconds   seconds    calls   s/call   s/call  name
 27.06      0.59     0.59  1968866     0.00     0.00  patch_delta
 16.51      0.95     0.36  2202293     0.00     0.00
unpack_object_header_buffer
 13.76      1.25     0.30  5327015     0.00     0.00  hashmap_get
 11.47      1.50     0.25   344036     0.00     0.00  unpack_entry
  8.72      1.69     0.19   521278     0.00     0.00  lookup_object
  4.13      1.78     0.09  1964667     0.00     0.00  hashmap_remove
  2.75      1.84     0.06   348709     0.00     0.00  get_object
  2.29      1.89     0.05        1     0.05     2.17  oid_array_for_each_unique
  1.38      1.92     0.03  6373452     0.00     0.00  use_pack
  0.92      1.94     0.02  2202293     0.00     0.00  unpack_compressed_entry
  0.92      1.96     0.02  1394836     0.00     0.00  grab_sub_body_contents
  0.92      1.98     0.02   348709     0.00     0.00  create_object
  0.92      2.00     0.02   348709     0.00     0.00  format_ref_array_item
  0.92      2.02     0.02    74557     0.00     0.00  fill_commit_graph_info
```

Before, I thought that the proportion of `lookup_object()` is not very
large(11.47%), so
I didn't care about it. But Christian strongly recommends that I use
`trace_printf()` to
observe the number of calls to `lookup_object()`.

Here is an amazing fact:

The number of calls to `lookup_object()` before and after using my
patch are 0 and
522709 respectively. Therefore, I am very surprised, why do we have
these additional calls?

```
(gdb) bt
#0  lookup_object (r=r@entry=0x5555558b8cc0 <the_repo>,
oid=oid@entry=0x5555558b8980 <oi>) at object.c:92
#1  0x0000555555665572 in lookup_commit (r=0x5555558b8cc0 <the_repo>,
oid=0x5555558b8980 <oi>) at commit.c:62
#2  0x00005555556edff5 in parse_object_buffer (r=0x5555558b8cc0
<the_repo>, oid=oid@entry=0x5555558b8980 <oi>, type=OBJ_COMMIT,
size=788, buffer=0x5555558d0080, eaten_p=eaten_p@entry=0x7fffffffcc0c)
    at object.c:214
#3  0x000055555571da42 in get_object (ref=ref@entry=0x7fffffffcf30,
deref=deref@entry=0, obj=obj@entry=0x7fffffffcc90,
oi=oi@entry=0x5555558b8980 <oi>, err=err@entry=0x7fffffffcf10)
    at ref-filter.c:1774
#4  0x000055555571fdc2 in populate_value
(ref=ref@entry=0x7fffffffcf30, err=err@entry=0x7fffffffcf10) at
ref-filter.c:1999
#5  0x00005555557202eb in get_ref_atom_value
(ref=ref@entry=0x7fffffffcf30, atom=0, v=v@entry=0x7fffffffcea8,
err=err@entry=0x7fffffffcf10) at ref-filter.c:2033
#6  0x00005555557212d6 in format_ref_array_item
(info=info@entry=0x7fffffffcf30, format=format@entry=0x7fffffffd0f0,
final_buf=final_buf@entry=0x7fffffffd060,
    error_buf=error_buf@entry=0x7fffffffcf10) at ref-filter.c:2627
#7  0x00005555555859d8 in batch_object_write (scratch=0x7fffffffd060,
opt=0x7fffffffd0d0, data=<optimized out>, obj_name=0x0) at
builtin/cat-file.c:224
```

After printing the call stack of `lookup_object()`, we can know that
the `parse_buffer()`
is calling them. A very straightforward idea, can we avoid calling
this function?

In `parse_object_buffer()`, `parse_blob_buffer()`, ``parse_tree_buffer()`,
`parse_commit_buffer()`, and `parse_tag_buffer()` parse the object
data, and then store
it in `struct object *obj`, finally return it to the caller.

`get_object()` will feed the `obj` to `grab_values()`, and then
`grab_values()` will feed the
`obj` to `grab_tag_values()`, `grab_commit_values()`, which can fill
the object info in `obj` to
implement some atom, e.g. `%(tag)`, `%(type)`, `%(object)`, `%(tree)`,
`%(numparent)`,`%(parent)`.
It is worth noting that `%(objectname)`, `%(objecttype)`,
`%(objectsize)`, `%(deltabase)`, `%(rest)`,
`%(raw)` are did not appear in them, this means that we can avoid
parsing object buffer when we
don't use those atoms which require `obj`'s information!

After some processing and adaptation, I made the patch which can skip
`parse_object_buffer()`
in some cases, this is the result of the performance test of
`t/perf/p1006-cat-file.sh`:

```
Test                                        HEAD~             HEAD
------------------------------------------------------------------------------------
1006.2: cat-file --batch-check              0.10(0.09+0.00)
0.11(0.10+0.00) +10.0%
1006.3: cat-file --batch-check with atoms   0.09(0.08+0.01)
0.09(0.06+0.03) +0.0%
1006.4: cat-file --batch                    0.62(0.58+0.04)
0.57(0.54+0.03) -8.1%
1006.5: cat-file --batch with atoms         0.63(0.60+0.02)
0.52(0.49+0.02) -17.5%
```

We can see that the performance of `git cat-file --batch` has been a
certain improvement!

Tell a joke: removing 1984531500 if checking can reduce the startup
time of GTA5 by 70%. :-D

Currently the patch has not been submitted to the mailing list, let us
wait a bit...

--
ZheNing Hu
