Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72727201A7
	for <e@80x24.org>; Mon, 15 May 2017 14:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965496AbdEOOOU (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 10:14:20 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:37714 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965353AbdEOOOT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 10:14:19 -0400
Received: by mail-it0-f48.google.com with SMTP id g126so69258063ith.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 07:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0+FMSmbX35mEn6QLsLcuL6l4Is8oYqP0iRwFZlQapnc=;
        b=OLxoBsesHI4PxbeNlyaElI61WaypmzzkVHVAdNAxF1/xhzVhhtm6PH5UGU+jSftyWn
         JuI2fX6oyb6+W1MR+VfnKDqVQX1FH5PIT1qd2Ix3t3p2rBkLkkqiEQQkWSnbJm85HbOi
         JKqwcWy4l8WkIwCUlAN09xn7MXdQNsW/jjrYx+9C5ZJbF61w7AnL8hOHwmq7nKeqTRGf
         irGLMgcT3ezdKIeMzlBGxUVQ9GmkoKebeh9fPi7gEQ4NqTBWctiy9sWAIeAPrmqCUCCC
         i0XO+rK3Rl86EYlNNhI5KvYalYNLdxEYGjq6pC2vOKcIqvCxlVnnr+GO/dM3ju/Bx6d8
         0Y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0+FMSmbX35mEn6QLsLcuL6l4Is8oYqP0iRwFZlQapnc=;
        b=TckeR+IaDoOvpT5PbJYi72detpvyg68fAtSsLPqQm/i+5uXomJxzlQ6vEidNbfYBaf
         cwLara35lWwRkmD8TRLGDyR2adQwze1kuIlEE4WvP5aQLGZYYKKeKEgdNgIZSHuQc9le
         TVq5s6hXaXQuP+qryB96+4IOlL/7vmer6y14Ax3R7Wr+1j9AUsQIXjjPA9ZoOTT4og0U
         /8oQ0J9TtZQ+gGnY8fVn82aePUSET04aEWDJ19JDcG0dWCQbjyB5rocQHMVINxvcV02/
         bnObXzJWY5RJxSIMB2fDDf16KAIwimu18RFguG/gZNxaVDt1/dfruc1FSAYej31P2G/Q
         +fog==
X-Gm-Message-State: AODbwcAvWQ8VdWszqZk3MGqZD6K2QTWq9jt31+YkJ/A2IeJ1Fv3SqyPL
        if+f3JGJlyIP0EnR3vMvFTvT1n7Bsw==
X-Received: by 10.36.166.4 with SMTP id q4mr5599661ite.66.1494857658773; Mon,
 15 May 2017 07:14:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 15 May 2017 07:13:58 -0700 (PDT)
In-Reply-To: <006301d2cd83$663b5520$32b1ff60$@marc-stevens.nl>
References: <CACBZZX6nmKK8af0-UpjCKWV4R+hV-uk2xWXVA5U+_UQ3VXU03g@mail.gmail.com>
 <006301d2cd83$663b5520$32b1ff60$@marc-stevens.nl>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 15 May 2017 16:13:58 +0200
Message-ID: <CACBZZX5Q9paMbYWH47fdK9GuNrE=F=FwR__E1yZ32EOAMw_w6w@mail.gmail.com>
Subject: Re: Git 2.13.0 segfaults on Solaris SPARC due to DC_SHA1=YesPlease
 being on by default
To:     Marc Stevens <marc@marc-stevens.nl>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 3:58 PM, Marc Stevens <marc@marc-stevens.nl> wrote:
> Hi Aevar,
>
> Thank you for notifying us of this issue.
> Big endianness is a tricky issue, also since I don't have access or accur=
ate knowledge about all big endian systems.
> Our github repo does check correct functioning, including an endianness m=
istake, with 'make test'.
> But I guess this is not included for SHA1DC in Git.
>
> Anyway, we can easily add the _BIG_ENDIAN macrotest to the git repo and w=
ill do so soon.
>
> I don't think the segfault is caused by buffer overflow, inproper access,=
 or the endianness issue.
> But I did notice an unexpected issue: the message block pointer m=3D0x398=
ad5 is odd.
> Can you confirm whether loading an uint32_t from an odd address triggers =
a hardware interrupt on your platform?
> This is not problem for x86, but maybe for your platform it is?
> If it is then we should always copy buffer contents to the sha1context to=
 avoid this issue.

I don't have access to the box in question, Michael was testing this
code for me. But unaligned access is probably the cause, although
according to some info I found online that should give a SIGBUS not a
SIGSEGV, but that may have changed:

https://bugs.python.org/issue12181
https://github.com/magnumripper/JohnTheRipper/issues/2187

> Best regards,
> Marc Stevens
>
> -----Oorspronkelijk bericht-----
> Van: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason [mailto:avarab@gmail.com]
> Verzonden: maandag 15 mei 2017 14:49
> Aan: Git Mailing List <git@vger.kernel.org>
> CC: michael.kebe@gmail.com; Jeff King <peff@peff.net>; Marc Stevens <marc=
@marc-stevens.nl>
> Onderwerp: Git 2.13.0 segfaults on Solaris SPARC due to DC_SHA1=3DYesPlea=
se being on by default
>
> Since 2.13.0 just running "git status" on a newly init'd repo on Solaris =
SPARC[1] segfaults. Michael (CC'd) reported this issue on #git and I helped=
 him debug it.
>
> Just compiling with BLK_SHA1=3DYesPlease solves the issue.
>
> There are at least two different issues with DC_SHA1 here:
>
>  * We don't properly detect that this platform is big endian. The check a=
t the top of sha1dc/sha1.c needs to test for _BIG_ENDIAN. This comes from s=
ys/isa_defs.h which (I'm told by #solaris) is included on Solaris by defaul=
t, at least by stdio.h.
>
> Hacking the endian detection makes t0013-sha1dc.sh pass.
>
>   * Even with that & the test passing just a plain "git init x && cd x &&=
 touch A && git add A && git commit" will segfault.
>
> This is some bug in the sha1dc code, presumably some big endian issue tha=
t's not resolved by the change above. Backtrace for that (censored actual a=
uthor info):
>
>  Program received signal SIGSEGV, Segmentation fault.
>  [Switching to Thread 1 (LWP 1)]
>  0x002f8c84 in sha1_compression_states (ihv=3D0xffbf8268, m=3D0x398ad5, W=
=3D0xffbf82fc, states=3D0xffbf857c) at sha1dc/sha1.c:291
>  291             SHA1COMPRESS_FULL_ROUND1_STEP_LOAD(a, b, c, d, e, m,
> W, 0, temp);
>  (gdb) bt
>  #0  0x002f8c84 in sha1_compression_states (ihv=3D0xffbf8268, m=3D0x398ad=
5, W=3D0xffbf82fc, states=3D0xffbf857c) at sha1dc/sha1.c:291
>  #1  0x00300b60 in sha1_process (ctx=3D0xffbf8260, block=3D0x398ad5) at
> sha1dc/sha1.c:1616
>  #2  0x00301188 in SHA1DCUpdate (ctx=3D0xffbf8260,
>      buf=3D0x398ad5 "deadbeefdeadbeefdeadbeefdeadbeefdeadbeef\nauthor Au =
Thor <au.thor@example.com> 123456789 +0000\ncommitter Au Thor <au.thor@exam=
ple.com> 123456789
>                   +0000\n\nBlah Blah"..., len=3D220)
>      at sha1dc/sha1.c:1731
>  #3  0x0030168c in git_SHA1DCUpdate (ctx=3D0xffbf8260, vdata=3D0x398aa0,
> len=3D273) at sha1dc/sha1.c:1808
>  #4  0x002a6f7c in write_sha1_file_prepare (buf=3D0x398aa0, len=3D273,
> type=3D0x959c8 "commit", sha1=3D0xffbfd630 "",
>      hdr=3D0xffbf8c28 "commit 273", hdrlen=3D0xffbf8c24) at sha1_file.c:3=
207
>  #5  0x002a71ac in hash_sha1_file (buf=3D0x398aa0, len=3D273, type=3D0x95=
9c8 "commit", sha1=3D0xffbfd630 "") at sha1_file.c:3266
>  #6  0x002a25f8 in check_sha1_signature (sha1=3D0xffbfdbb8 "\375\067\356\=
337\002", map=3D0x398aa0, size=3D273, type=3D0x959c8 "commit")
>      at sha1_file.c:1644
>  #7  0x0022816c in parse_object (sha1=3D0xffbfdbb8
> "\375\067\356\337\002") at object.c:269
>  #8  0x0027c258 in get_reference (revs=3D0xffbfdc88, name=3D0xa87f0 "HEAD=
", sha1=3D0xffbfdbb8 "\375\067\356\337\002", flags=3D0)
>      at revision.c:196
>  #9  0x00284714 in setup_revisions (argc=3D0, argv=3D0x0, revs=3D0xffbfdc=
88,
> opt=3D0xffbfdc74) at revision.c:2295
>  #10 0x002ee4d8 in wt_status_collect_changes_index (s=3D0x348ea8
> <s.24114>) at wt-status.c:585
>  #11 0x002eeae8 in wt_status_collect (s=3D0x348ea8 <s.24114>) at wt-statu=
s.c:701
>  #12 0x000db4fc in cmd_status (argc=3D0, argv=3D0xffbfe6fc, prefix=3D0x0)=
 at
> builtin/commit.c:1393
>  #13 0x000acc24 in run_builtin (p=3D0x340ccc <commands+1200>, argc=3D1,
> argv=3D0xffbfe6fc) at git.c:371
>  #14 0x000acf98 in handle_builtin (argc=3D1, argv=3D0xffbfe6fc) at git.c:=
572
>  #15 0x000ad1a4 in run_argv (argcp=3D0xffbfe66c, argv=3D0xffbfe670) at gi=
t.c:624
>  #16 0x000ad3fc in cmd_main (argc=3D1, argv=3D0xffbfe6fc) at git.c:701
>  #17 0x001747a0 in main (argc=3D5, argv=3D0xffbfe6ec) at common-main.c:43
>
> 1. Relevant part of uname -a: "SunOS <hostname> 5.11 11.3 sun4v sparc sun=
4v".
>
