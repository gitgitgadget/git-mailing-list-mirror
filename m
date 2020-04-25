Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1625DC54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 20:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2388206D4
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 20:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="IpJLuzdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgDYU2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 16:28:11 -0400
Received: from avasout04.plus.net ([212.159.14.19]:38835 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgDYU2K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 16:28:10 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id SRPDjlJdvpB7ISRPEj6Xp1; Sat, 25 Apr 2020 21:28:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1587846488; bh=WQ6p/CjZPjT+36Fl5/EqPjpFQ4Im+N+cjX6qaLStIIM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IpJLuzdoArNS/eUTobZp91kWFr4puSpn3aYT3PyRUyPMtg+AvuRxF2CkDifd/5DkC
         nOeYykwD931TKhHgMzu0cm2RoYie5O1YMmbFGJiJLgoRLiyLIOZnSnNIgiW91RtS8N
         BEXKHrxwGaw3BIqR6ljtvBYnB8uP9YpqgbnojvqwkpsQ0P+5gElV+ZaH+MEas4kfeH
         pA6J3pPyq1yG7+p9PQuKIky0/cVtUDH6maFLi6VzSG+ggK9h2dhtehvqId9ASWn0Cz
         8DlxwZ4eeg0REFaVRE1f0VjnTmxlDAmGrNGtol3NyU42YmbcBzkLnEztBomZ0ejoiE
         fVyoG/E+BgqBA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=MKb7ZPRl c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=hdo54r8NIkdiOvKiiioA:9 a=QEXdDO2ut3YA:10
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
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ffcaaf4f-a43f-2d20-b70d-dfb8b1d7c687@ramsayjones.plus.com>
Date:   Sat, 25 Apr 2020 21:28:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424223440.GC721@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCDgqM+RJsEouV2Z44KBPNqUSjmZFnLa5JAZPIwkMKemakqPhGMpEPGX31YpiOxIIZWyIuSdMjY7EIy9PrOiJQX8XIHe/6Zjymm5wzcYM+UDYGBSe48b
 VwOQ1w2ZKifgH2kRZif2wB/bxjpp4W56r5W5J8mgLpU6W5sTUPs4nxHH0DqyWFimh6R+Dw1uKPAr1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/04/2020 23:34, Danh Doan wrote:
[snip]

> OK, I've tried with my glibc box, it doesn't have that warning.
> On musl, it warns:
> 
> 	$ make compat/regex/regex.sp
> 	GIT_VERSION = 2.26.2
> 	    * new build flags
> 	    SP compat/regex/regex.c
> 	/usr/include/alloca.h:14:9: warning: preprocessor token alloca redefined
> 	compat/regex/regex.c:66:9: this was the original definition
> 	compat/regex/regex_internal.c:925:1: error: symbol 're_string_context_at' redeclared with different type (originally declared at compat/regex/regex_internal.h:433) - different modifiers
> 
> 

OK, I had a quick look at the <alloca.h> header file on a glibc
system (linux) and new-lib system (cygwin) and they both do
(more or less) the same thing: first #undef alloca, and then
if being compiled by gcc, define alloca(size) to be __builtin_alloca(size).

So, even if <alloca.h> is #included after regex.c:66, it wouldn't
be a problem. Since I don't have access to a musl based system,
I don't know what that system header is doing.

However, I said *even if* above, because I don't see why it is trying
to #include <alloca.h> in the first place! ;-)

Note that the three calls to alloca in compat/regex:

  $ git grep -n '\<alloca\>' -- compat/regex
  compat/regex/regex.c:65:#undef alloca
  compat/regex/regex.c:66:#define alloca alloca_is_bad_you_should_never_use_it
  compat/regex/regex_internal.h:460:#   include <alloca.h>
  compat/regex/regex_internal.h:468:/* alloca is implemented with malloc, so just use malloc.  */
  compat/regex/regexec.c:1428:    prev_idx_match = (regmatch_t *) alloca (nmatch * sizeof (regmatch_t));
  compat/regex/regexec.c:3338:    dests_alloc = (struct dests_alloc *) alloca (sizeof (struct dests_alloc));
  compat/regex/regexec.c:3385:      alloca (ndests * 3 * sizeof (re_dfastate_t *));
  $ 

... in compat/regex/regexec.c are all protected by '#ifdef HAVE_ALLOCA', as
indeed is the #include of the header file in compat/regex/regex_internal.h
at line 460. Since HAVE_ALLOCA should not be defined, where is that file
being included?

Note that HAVE_ALLOCA
 
  $ git grep -n HAVE_ALLOCA -- compat
  compat/regex/regex_internal.h:455:# if HAVE_ALLOCA
  compat/regex/regexec.c:1426:#ifdef HAVE_ALLOCA
  compat/regex/regexec.c:3336:#ifdef HAVE_ALLOCA
  compat/regex/regexec.c:3381:#ifdef HAVE_ALLOCA
  $ 

... is not the same as HAVE_ALLOCA_H

  $ git grep -n HAVE_ALLOCA
  Makefile:45:# Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
  Makefile:1349:ifdef HAVE_ALLOCA_H
  Makefile:1350:  BASIC_CFLAGS += -DHAVE_ALLOCA_H
  compat/regex/regex_internal.h:455:# if HAVE_ALLOCA
  compat/regex/regexec.c:1426:#ifdef HAVE_ALLOCA
  compat/regex/regexec.c:3336:#ifdef HAVE_ALLOCA
  compat/regex/regexec.c:3381:#ifdef HAVE_ALLOCA
  config.mak.uname:47:    HAVE_ALLOCA_H = YesPlease
  config.mak.uname:63:    HAVE_ALLOCA_H = YesPlease
  config.mak.uname:147:   HAVE_ALLOCA_H = YesPlease
  config.mak.uname:206:   HAVE_ALLOCA_H = YesPlease
  config.mak.uname:310:   HAVE_ALLOCA_H = YesPlease
  config.mak.uname:395:   HAVE_ALLOCA_H = YesPlease
  config.mak.uname:586:   HAVE_ALLOCA_H = YesPlease
  configure.ac:320:# Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
  configure.ac:323:    yes)    HAVE_ALLOCA_H=YesPlease;;
  configure.ac:324:    *)      HAVE_ALLOCA_H='';;
  configure.ac:326:GIT_CONF_SUBST([HAVE_ALLOCA_H])
  git-compat-util.h:840:#ifdef HAVE_ALLOCA_H
  $ 

... used by the rest of git, outside of the compat/regex directory.

Once again, you can see that HAVE_ALLOCA

  $ make V=1 NO_REGEX=1 compat/regex/regex.sp
  cgcc -no-compile -Werror -Wall -Wdeclaration-after-statement -Wformat-security -Wold-style-definition -Woverflow -Wpointer-arith -Wstrict-prototypes -Wunused -Wvla -DENABLE_SHA256 -Wextra -Wmissing-prototypes -Wno-empty-body -Wno-missing-field-initializers -Wno-sign-compare -Wno-unused-parameter  -g -O2 -Wall -I. -DHAVE_SYSINFO -DGIT_HOST_CPU="\"x86_64\"" -DHAVE_ALLOCA_H  -DUSE_CURL_FOR_IMAP_SEND -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH="/proc/self/exe"'  -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -Icompat/regex -DSHELL_PATH='"/bin/sh"' -DPAGER_ENV='"LESS=FRX LV=-c"' -DGAWK -DNO_MBSUPPORT \
  	  compat/regex/regex.c
  $ 
  
... is not being set on the command-line.

Hmm, do you have this set in config.mak, config.mak.autogen, or some other
source? puzzled! ;-)

BTW, why are you compiling with NO_REGEX set anyway?


ATB,
Ramsay Jones

