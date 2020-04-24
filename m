Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9ADC54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 16:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9CB20728
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 16:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="bL+sWD9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgDXQ4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:56:49 -0400
Received: from avasout04.plus.net ([212.159.14.19]:58727 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgDXQ4t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 12:56:49 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id S1d8jk4KEpB7IS1dAj64Kq; Fri, 24 Apr 2020 17:56:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1587747408; bh=PhiMnV1tsO+oG/ggBqMGFVQlP2BirW5NaxCBwqI8JWk=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=bL+sWD9Rm8Xc/W+Q/IV7J+gPJO/lqx5jWNLCSUkBe904Es9NqOuEyihRoqJpQdiOT
         1uq7kjB08zzwc+V3QeSMNFpwbUq0ZzJxpldU+PQ0H1HboIpiXde5Fx5Nwdcp95h7Ha
         1TVAJFTc8+zI06OqQrvuckKQLxa9IQIT2NZVjdF/cNLBnBWgPDbZxpzkD15yrfoIqQ
         ogu4Z+Cyiw9Qqf6U2BqxlwLKAJzfqE/XpoCqD7NTHVnW4QaX3T7g6Uj51am/zZhdYL
         UyPF9bx3Ctj4WFTikbPOwOof0K/k3Hh/ydoY9/DNmaEwRzaPkozylW3yVQ0oYC9max
         TcSNqsa68bHoA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=MKb7ZPRl c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=IV6zVFhp2VCHSBWG5AkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 2/4] compat/regex: include alloca.h before undef it
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <cover.1587740959.git.congdanhqx@gmail.com>
 <290ba923b5ee5bcaa4801454b6692deb532bd681.1587740959.git.congdanhqx@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <820d44c5-5852-fa83-a814-8e58dd120565@ramsayjones.plus.com>
Date:   Fri, 24 Apr 2020 17:56:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <290ba923b5ee5bcaa4801454b6692deb532bd681.1587740959.git.congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJRN9bUKLQsuGNtjDBWB8wIbFJQ9JM+c5BeJaSuJkndzkbP/SfHDo9V0f/ZGYLwn8ilOYfRLn+htKCJ3gkmU5OdKpiGLk1DSvdJqDKTIY+NFV1UfL0t6
 IAHzNX2BV0ZkPerqoId5TaldmPyw4d9tOMtdOkw0z+5CHBzXld4h00U0K1DQBqki3GzW4+iNupsM0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/04/2020 16:12, Đoàn Trần Công Danh wrote:
> Somewhere later in the code, we indirectly include alloca.h
> which will define alloca again, thus create a warning about
> redefinition of a preprocessor.
> 
> Include it prior to define alloca in order to not define it again.

So, on cygwin, this patch is not required. ie. I don't see any sparse
errors/warnings for compat/regex/regex.c.

Since cygwin uses a different c library (new-lib rather than glibc),
I did a quick test on Linux, thus:

  $ sparse --version
  v0.6.1-191-gc51a0382
  $ 
  $ git checkout master
  Switched to branch 'master'
  Your branch is up-to-date with 'origin/master'.
  $ 
  $ make clean
  GIT_VERSION = 2.26.2.266.ge870325ee8
  ...
  $ 
  $ make NO_REGEX=1 sparse >sp-out1 2>&1
  $ 
  $ diff sp-out sp-out1
  0a1,2
  > GIT_VERSION = 2.26.2.266.ge870325ee8
  >     * new build flags
  12a15
  >     * new prefix flags
  72a76
  >     GEN command-list.h
  226a231
  >     SP compat/regex/regex.c
  $ 
  $ make V=1 NO_REGEX=1 compat/regex/regex.sp
  cgcc -no-compile -Werror -Wall -Wdeclaration-after-statement -Wformat-security -Wold-style-definition -Woverflow -Wpointer-arith -Wstrict-prototypes -Wunused -Wvla -DENABLE_SHA256 -Wextra -Wmissing-prototypes -Wno-empty-body -Wno-missing-field-initializers -Wno-sign-compare -Wno-unused-parameter  -g -O2 -Wall -I. -DHAVE_SYSINFO -DGIT_HOST_CPU="\"x86_64\"" -DHAVE_ALLOCA_H -DUSE_CURL_FOR_IMAP_SEND -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH="/proc/self/exe"'  -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -Icompat/regex -DSHELL_PATH='"/bin/sh"' -DPAGER_ENV='"LESS=FRX LV=-c"' -DGAWK -DNO_MBSUPPORT \
  	  compat/regex/regex.c
  $ 
   
So, again I don't see a problem. I guess it is possible that the
version of sparse I am using (see above) has _also_ fixed this
problem, in addition to the prototype attribute placement fix.

Another option is that the version of glibc also matters. (I am
on Linux Mint, which is based on Ubuntu 18.04 LTS) It would not
be the first time that I have seen errors in system header files
change from one release to the next ...

[Hmm, I have a fedora 31 system I could try - much more up-to-date! :D ]

ATB,
Ramsay Jones

> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>  compat/regex/regex.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/compat/regex/regex.c b/compat/regex/regex.c
> index f3e03a9eab..4bef75a716 100644
> --- a/compat/regex/regex.c
> +++ b/compat/regex/regex.c
> @@ -62,6 +62,7 @@
>  #include <stdint.h>
>  
>  #ifdef GAWK
> +#include <alloca.h>
>  #undef alloca
>  #define alloca alloca_is_bad_you_should_never_use_it
>  #endif
> 
