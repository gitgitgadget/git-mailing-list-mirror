Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CA8C201A7
	for <e@80x24.org>; Mon, 15 May 2017 13:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965238AbdEON7C (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 09:59:02 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33259 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934373AbdEON7A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 09:59:00 -0400
Received: by mail-qk0-f175.google.com with SMTP id y201so95945542qka.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 06:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marc-stevens-nl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=IxciqIB5PYGbMtY1cbS+GyrPQ6jZ1vb3y9p7h1wPJso=;
        b=u8O3JPIZiOqZ3opC8IrH1eL8jY2gOqcIHbMctdDbesLEj6Up/xhoQkNIvwj3tLzJ+4
         LxQ56Whpo8pr/vs8ACN6d6frvdfIjIHakIHXi4IWIQc/7TVZIy4Q0J/8gkQvcGqXJiYq
         IDxxrs9ZFUU+8gZ1HyxzGZzNEuLMOrwfxXKXRZDQerl8OIpzLT4GP9nFGUGsBuwfPwKq
         RiiGiY2d25G+tZeWSa+jh3+6wwkL7akxzy4gJJ9D4Rp8Bzwu8SNInPqGIM2HBgBHhZqE
         PHZV3rBry3/V4mhXfB515cNPdniLDII0mjb3FW68+x+NNiE1oufNQRiCr5GjV2Glqir8
         ZCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=IxciqIB5PYGbMtY1cbS+GyrPQ6jZ1vb3y9p7h1wPJso=;
        b=Syt5ocE0qQaJdbWF3kL2IpnpxYRD8u0UJXBegY33ugQWnxzw4AaN0idTqmhwiHM2MI
         9oDnVa7SuQADayRPoLm/OhhaZcYAvqG3v0hi/T2OVMvGwCZrYYnmOMlIrng8wBHmEQJN
         1WS0GaOzYf3XNtrzAQFEvHj8gpImWZXlg550727Zcla4/rHCGPI71izNnLQImOmmp7+H
         kmN41ALw2QUen/8eWQ5iYoUJqobL+Ur0SQ8sNPYXDpKgXXBB7AR0ecVnWNeo/hGL5R/y
         /XvRVfb1oMtZ46NhogxjYuPljetNfbX2DJ1s+cv/9zjd/1gmJ6Y3mGFaO7BEBaHqSRtB
         wzxA==
X-Gm-Message-State: AODbwcAinUy+FagfdM7X2/wb+hp71HLeTL+GT0Ql+4gPHFLnyZSQMtTk
        dLEOIfMU99nRyA==
X-Received: by 10.80.158.99 with SMTP id z90mr4912862ede.50.1494856739458;
        Mon, 15 May 2017 06:58:59 -0700 (PDT)
Received: from XPSCRMS (541FB48C.cm-5-8c.dynamic.ziggo.nl. [84.31.180.140])
        by smtp.googlemail.com with ESMTPSA id k17sm6345886eda.61.2017.05.15.06.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2017 06:58:58 -0700 (PDT)
From:   "Marc Stevens" <marc@marc-stevens.nl>
To:     =?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?= 
        <avarab@gmail.com>, "'Git Mailing List'" <git@vger.kernel.org>
Cc:     <michael.kebe@gmail.com>, "'Jeff King'" <peff@peff.net>
References: <CACBZZX6nmKK8af0-UpjCKWV4R+hV-uk2xWXVA5U+_UQ3VXU03g@mail.gmail.com>
In-Reply-To: <CACBZZX6nmKK8af0-UpjCKWV4R+hV-uk2xWXVA5U+_UQ3VXU03g@mail.gmail.com>
Subject: RE: Git 2.13.0 segfaults on Solaris SPARC due to DC_SHA1=YesPlease being on by default
Date:   Mon, 15 May 2017 15:58:57 +0200
Message-ID: <006301d2cd83$663b5520$32b1ff60$@marc-stevens.nl>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: nl
Thread-Index: AQHnRh/WXWCtn9afY9bzatRJpTA63KHMd35g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Aevar,

Thank you for notifying us of this issue.
Big endianness is a tricky issue, also since I don't have access or =
accurate knowledge about all big endian systems.
Our github repo does check correct functioning, including an endianness =
mistake, with 'make test'.
But I guess this is not included for SHA1DC in Git.

Anyway, we can easily add the _BIG_ENDIAN macrotest to the git repo and =
will do so soon.

I don't think the segfault is caused by buffer overflow, inproper =
access, or the endianness issue.
But I did notice an unexpected issue: the message block pointer =
m=3D0x398ad5 is odd.=20
Can you confirm whether loading an uint32_t from an odd address triggers =
a hardware interrupt on your platform?
This is not problem for x86, but maybe for your platform it is?
If it is then we should always copy buffer contents to the sha1context =
to avoid this issue.

Best regards,
Marc Stevens

-----Oorspronkelijk bericht-----
Van: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason [mailto:avarab@gmail.com]=20
Verzonden: maandag 15 mei 2017 14:49
Aan: Git Mailing List <git@vger.kernel.org>
CC: michael.kebe@gmail.com; Jeff King <peff@peff.net>; Marc Stevens =
<marc@marc-stevens.nl>
Onderwerp: Git 2.13.0 segfaults on Solaris SPARC due to =
DC_SHA1=3DYesPlease being on by default

Since 2.13.0 just running "git status" on a newly init'd repo on Solaris =
SPARC[1] segfaults. Michael (CC'd) reported this issue on #git and I =
helped him debug it.

Just compiling with BLK_SHA1=3DYesPlease solves the issue.

There are at least two different issues with DC_SHA1 here:

 * We don't properly detect that this platform is big endian. The check =
at the top of sha1dc/sha1.c needs to test for _BIG_ENDIAN. This comes =
from sys/isa_defs.h which (I'm told by #solaris) is included on Solaris =
by default, at least by stdio.h.

Hacking the endian detection makes t0013-sha1dc.sh pass.

  * Even with that & the test passing just a plain "git init x && cd x =
&& touch A && git add A && git commit" will segfault.

This is some bug in the sha1dc code, presumably some big endian issue =
that's not resolved by the change above. Backtrace for that (censored =
actual author info):

 Program received signal SIGSEGV, Segmentation fault.
 [Switching to Thread 1 (LWP 1)]
 0x002f8c84 in sha1_compression_states (ihv=3D0xffbf8268, m=3D0x398ad5, =
W=3D0xffbf82fc, states=3D0xffbf857c) at sha1dc/sha1.c:291
 291             SHA1COMPRESS_FULL_ROUND1_STEP_LOAD(a, b, c, d, e, m,
W, 0, temp);
 (gdb) bt
 #0  0x002f8c84 in sha1_compression_states (ihv=3D0xffbf8268, =
m=3D0x398ad5, W=3D0xffbf82fc, states=3D0xffbf857c) at sha1dc/sha1.c:291
 #1  0x00300b60 in sha1_process (ctx=3D0xffbf8260, block=3D0x398ad5) at
sha1dc/sha1.c:1616
 #2  0x00301188 in SHA1DCUpdate (ctx=3D0xffbf8260,
     buf=3D0x398ad5 "deadbeefdeadbeefdeadbeefdeadbeefdeadbeef\nauthor Au =
Thor <au.thor@example.com> 123456789 +0000\ncommitter Au Thor =
<au.thor@example.com> 123456789
                  +0000\n\nBlah Blah"..., len=3D220)
     at sha1dc/sha1.c:1731
 #3  0x0030168c in git_SHA1DCUpdate (ctx=3D0xffbf8260, vdata=3D0x398aa0,
len=3D273) at sha1dc/sha1.c:1808
 #4  0x002a6f7c in write_sha1_file_prepare (buf=3D0x398aa0, len=3D273,
type=3D0x959c8 "commit", sha1=3D0xffbfd630 "",
     hdr=3D0xffbf8c28 "commit 273", hdrlen=3D0xffbf8c24) at =
sha1_file.c:3207
 #5  0x002a71ac in hash_sha1_file (buf=3D0x398aa0, len=3D273, =
type=3D0x959c8 "commit", sha1=3D0xffbfd630 "") at sha1_file.c:3266
 #6  0x002a25f8 in check_sha1_signature (sha1=3D0xffbfdbb8 =
"\375\067\356\337\002", map=3D0x398aa0, size=3D273, type=3D0x959c8 =
"commit")
     at sha1_file.c:1644
 #7  0x0022816c in parse_object (sha1=3D0xffbfdbb8
"\375\067\356\337\002") at object.c:269
 #8  0x0027c258 in get_reference (revs=3D0xffbfdc88, name=3D0xa87f0 =
"HEAD", sha1=3D0xffbfdbb8 "\375\067\356\337\002", flags=3D0)
     at revision.c:196
 #9  0x00284714 in setup_revisions (argc=3D0, argv=3D0x0, =
revs=3D0xffbfdc88,
opt=3D0xffbfdc74) at revision.c:2295
 #10 0x002ee4d8 in wt_status_collect_changes_index (s=3D0x348ea8
<s.24114>) at wt-status.c:585
 #11 0x002eeae8 in wt_status_collect (s=3D0x348ea8 <s.24114>) at =
wt-status.c:701
 #12 0x000db4fc in cmd_status (argc=3D0, argv=3D0xffbfe6fc, =
prefix=3D0x0) at
builtin/commit.c:1393
 #13 0x000acc24 in run_builtin (p=3D0x340ccc <commands+1200>, argc=3D1,
argv=3D0xffbfe6fc) at git.c:371
 #14 0x000acf98 in handle_builtin (argc=3D1, argv=3D0xffbfe6fc) at =
git.c:572
 #15 0x000ad1a4 in run_argv (argcp=3D0xffbfe66c, argv=3D0xffbfe670) at =
git.c:624
 #16 0x000ad3fc in cmd_main (argc=3D1, argv=3D0xffbfe6fc) at git.c:701
 #17 0x001747a0 in main (argc=3D5, argv=3D0xffbfe6ec) at =
common-main.c:43

1. Relevant part of uname -a: "SunOS <hostname> 5.11 11.3 sun4v sparc =
sun4v".

