Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3088C54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 19:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F232064A
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 19:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="gQnbxinX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgDZTia (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 15:38:30 -0400
Received: from avasout04.plus.net ([212.159.14.19]:56054 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgDZTia (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 15:38:30 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id Sn6hjmHdjpB7ISn6ij6qeg; Sun, 26 Apr 2020 20:38:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1587929909; bh=j+yXMbXcgB47FXEErGHiHTKU64jKRA7V1UTSllWmMY4=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=gQnbxinXS6D7u5mr+VAnX/Q2gwTy202lPssBtPlPAL3ZB6lHdklRODsxfOF6ea5HO
         oJdmmX8Xk5H0tA8ltxxrnDZx0bEsJuIbz2CA8V9iBJa8x9nNPCQlTxnoqrg5nPdYGE
         yjhH4qLTEkxm7teWK3geUqEwYjJ3Gy93s9DsAcutbFbWVj7nOGOz/WurYiKyQqfqku
         /bn3zf3OpV2f7/iGXx3o9ciNuD2V76DFt7z15RGl2OJyoR7HrIXrJJe3Hh00ArZe45
         7UlbtmcVNeFL14GivdYkNM8WpIfQMJ0zdjwVyP/GcdKydcYwaTm1zu5lmtR68qmcWE
         20ZQBoQMBRIDg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=MKb7ZPRl c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=jQH66FUFUUhpHdAUnLkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 2/4] compat/regex: include alloca.h before undef it
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
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
Message-ID: <1a0c2b25-e283-9936-1fa2-ce51df1404dc@ramsayjones.plus.com>
Date:   Sun, 26 Apr 2020 20:38:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e9163e0d-2572-e7e0-6aa3-09ce04750b22@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAz4QjLz/KOsjTxZLySXiyCWsJ4CS0SIKi/6xSv0vHeiBgm3zdbgFYAVrrc+BzNDhrJcJ3tMJGiK/lY1bGfHR1Mcz2c0VwhTv5flEBz06QULwUEK0B+a
 2eHXvhqLEw4qNd2dElayXW16EFeuGobTGNPuorY3IHb/xpw9snoVlZeYmUt5RCn4vmdOWUCz4rI3Lw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 26/04/2020 17:17, Ramsay Jones wrote:
[snip]

> Hmm, whatever patch you decide to send (even the original one) I think
> you need to add an explanation of the problem to the commit message,
> including why the patch provides a solution. (You don't have to type
> a novel - see commit bd8f005583 :-P ).
> 
> I haven't thought about this too much, but some options:
> 
>   - iff the musl library sets some kind of identifying pp variable
>     (_MUSL_LIBC_ or somesuch - I haven't looked), then you could
>     make the '#include <alloca.h>' conditional on that variable.
>     This has the benefit of making it obvious to people reading the
>     code that this is specific to musl-libc.
> 
>   - you could simply remove that '#ifdef GAWK' block completely (Lines
>     64->67). We set GAWK and NO_MBSUPPORT  unconditionally in the Makefile
>     so that it compiles (see commit a997bf423d), but these particular
>     lines simply reflect the gawk projects dislike of alloca (along with
>     the desire to catch any attempts to add new calls which are not protected
>     by HAVE_ALLOCA). Given that we are very unlikely to add new calls ...
> 
>   - change the conditional on this block to (totally untested, just typing
>     into my email client) '#if defined(GAWK) && defined(HAVE_ALLOCA)'.
>     This should work, but it does disable the 'catch any attempts to add
>     new _unintentional_ calls' aspect of that block; so you may as well
>     remove it ...
> 
> Just some 'off the top of my head ideas', ... ;-)

Another option I thought about, but didn't mention above, is given by
the patch below. I didn't mention it because it has the potential to
cause problems on non musl-libc systems (and I was feeling too lazy at
the time to go and test ...). Again, see commit bd8f005583.

So, I have now tested this patch on (glibc) linux and it seems to work
just fine; compile, sparse, test-suite passed. It also compiles clean
(and sparse clean) on cygwin (new-lib) - I didn't run the test-suite
on cygwin, since it takes about 3.5 to 4 hours to run.

I don't have any other systems to test this on, so I can't say that it
won't cause problems somewhere. In practice, I think the chances of that
are rather low, but don't quote me on that! :-P

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] regex: fix up musl-libc builds

---
 compat/regex/regex.c          | 1 +
 compat/regex/regex_internal.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index f3e03a9eab..e6f4a5d177 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -60,6 +60,7 @@
    #undefs RE_DUP_MAX and sets it to the right value.  */
 #include <limits.h>
 #include <stdint.h>
+#include <stdlib.h>
 
 #ifdef GAWK
 #undef alloca
diff --git a/compat/regex/regex_internal.h b/compat/regex/regex_internal.h
index 3ee8aae59d..0bad8b841e 100644
--- a/compat/regex/regex_internal.h
+++ b/compat/regex/regex_internal.h
@@ -23,7 +23,6 @@
 #include <assert.h>
 #include <ctype.h>
 #include <stdio.h>
-#include <stdlib.h>
 #include <string.h>
 
 #if defined HAVE_LANGINFO_H || defined HAVE_LANGINFO_CODESET || defined _LIBC
-- 
2.26.2

