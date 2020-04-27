Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68057C5519A
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B34E20728
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="KRMhrKUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgD0Q2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:28:08 -0400
Received: from avasout07.plus.net ([84.93.230.235]:38050 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgD0Q2H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 12:28:07 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id T6bzjVxZSsCJiT6c1jykjp; Mon, 27 Apr 2020 17:28:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1588004885; bh=pincmBbh0BysKiBlGiyEPmWV+K4KzpVJ15U5Iba+axw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KRMhrKUE+sEuUa+Lr4IcikSRQAZQSNyPknC9ODjDiNsBReyiGGgi1wtV247+noggv
         PuCJzRFjQG2B4fcXLzvS1GrKEzh4kv00kqDkKanl/+fGaO76/VYNdiZN1g6WHo8VVW
         5sdaw2tKlDGXUVcbp6Z4iQGK1+FMKk2DnxPCD3Xk6zaWc0gIcau+eUi/KLBM+xTSMa
         2PJOzyIyFRPcg5NyX0etRK7WyhzM21msc4NoiCSd6lWgmemG/2A0zv6Pt0lL5KZ5PK
         mCzTIguYDYXwnSB6cs0gHVDlYHdPRITA4Uvpigl3r6rB8MlM18ImD/R/fOazYRmS2T
         44F3MfRppXwvw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=BPIoUGYG c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=5KEJ3k9QAAAA:8 a=mDV3o1hIAAAA:8 a=Sw4BfdOMRlDJS9s9DWwA:9
 a=QEXdDO2ut3YA:10 a=zlJ5AU5v9O4A:10 a=olg2BfGzmf2haRflzj8J:22
 a=_FVE-zBwftR9WsbkzFJk:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 2/4] compat/regex: include alloca.h before undef it
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <cover.1587740959.git.congdanhqx@gmail.com>
 <290ba923b5ee5bcaa4801454b6692deb532bd681.1587740959.git.congdanhqx@gmail.com>
 <820d44c5-5852-fa83-a814-8e58dd120565@ramsayjones.plus.com>
 <20200424170916.GA29153@danh.dev>
 <0bee8daa-99d0-4939-e225-8783bc0457f8@ramsayjones.plus.com>
 <20200424223440.GC721@danh.dev>
 <ffcaaf4f-a43f-2d20-b70d-dfb8b1d7c687@ramsayjones.plus.com>
 <20200426005451.f7pyoiijgbk4hpsj@danh.dev>
 <e9163e0d-2572-e7e0-6aa3-09ce04750b22@ramsayjones.plus.com>
 <20200427010821.GD14800@danh.dev>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <f3af49c7-6c35-d2f6-c87c-e7342b1c2b6f@ramsayjones.plus.com>
Date:   Mon, 27 Apr 2020 17:28:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427010821.GD14800@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfK4hRpUie5SNMjJ55kN7CBodv9UEKc8GlUgFXJXAUOp4pSfpE+0d/zXZvoK4p0Ny1sWqZTrhgy/LpF2kFUzF1WON2GyI6N6+DCy7rYoRpXia7NahwMCP
 pHEBbEZ6BjzODbEBoY/nZpB5SJfJaThwMy3oPmWnOOWkQXV1+z2LE9p2Rhj9xD+hQU+EuFFbRYHRyA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/04/2020 02:08, Danh Doan wrote:
[snip]

>>> musl's alloca.h is available here:
>>>
>>> https://git.musl-libc.org/cgit/musl/tree/include/alloca.h
>>
>> Hmm, OK, so that partly explains the problem. I wonder if the
>> musl guys would accept a bug report?
> 
> I don't think they have a policy of no `#undef` whatsoever.

That's fair enough.

> But, I think they're picky when come to C-correctly and
> POSIX-correctly.
> Does C or POSIX define alloca(3) at all?

No alloca() is not in either the POSIX or C standard(s).
This was an extension from the early days of BSD Unix.

For some reason, I thought you had to explicitly '#include <alloca.h>'
to use it, but it appears that (by default) you get a bonus include
from the <stdlib.h> header, unless you restrict the headers using the
various macros and/or compiler command-line options.

As it happens, even on glibc systems, the <alloca.h> header is included
by the <stdlib.h> header, unless you take steps to suppress it. So, we
would have had the same issue, if it wasn't for the aforementioned
'#undef alloca' the the glibc header file.

When I need to look at pp output, while debugging things like this,
I cherry-pick a patch to the Makefile:

  $ git diff
  diff --git a/Makefile b/Makefile
  index 6d5cee270c..cd8753bf54 100644
  --- a/Makefile
  +++ b/Makefile
  @@ -2423,6 +2423,9 @@ $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs)
   %.s: %.c GIT-CFLAGS FORCE
          $(QUIET_CC)$(CC) -o $@ -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
   
  +%.i: %.c GIT-CFLAGS FORCE
  +       $(QUIET_CC)$(CC) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) -E $< >$*.i
  +
   ifdef USE_COMPUTED_HEADER_DEPENDENCIES
   # Take advantage of gcc's on-the-fly dependency generation
   # See <http://gcc.gnu.org/gcc-3.0/features.html>.
  @@ -2474,7 +2477,7 @@ http-walker.sp http-walker.s http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
   endif
   
   ifdef NO_REGEX
  -compat/regex/regex.sp compat/regex/regex.o: EXTRA_CPPFLAGS = \
  +compat/regex/regex.i compat/regex/regex.sp compat/regex/regex.o: EXTRA_CPPFLAGS = \
          -DGAWK -DNO_MBSUPPORT
   endif
   
  $ 

[The second hunk above is not actually part of the cherry-picked patch,
but I needed it in this instance to get GAWK and NO_MBSUPPORT passed to
the compiler!]

  $ make NO_REGEX=1 compat/regex/regex.i
      CC compat/regex/regex.i
  $ vim compat/regex/regex.i
  $ 

... which shows <alloca.h> is indeed being #included from <stdlib.h>.
[it is protected by a __USE_MISC pp variable, but I didn't bother to
track it down! ;-)]

ATB,
Ramsay Jones

  
