Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2830420281
	for <e@80x24.org>; Wed, 24 May 2017 06:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966284AbdEXGAj (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 02:00:39 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35176 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966241AbdEXGAh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 02:00:37 -0400
Received: by mail-yw0-f196.google.com with SMTP id p144so12230875ywp.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 23:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6wsn5WkmwUVgezc0LCy5jRqM6LKxpaUc6fE6j/Xb8hQ=;
        b=lFXx+UWhMyhTXvfaXZdjLcTrT8TgVP8VENby72/EhY7fQzpfKTKAGoOPMK99k38eS7
         PK78d4WzlwI1im0se++woYwJZ2p9ZPoBwwvT6FtBO8QV0QXgH+4lpY0B2siJxSQUCl2e
         x43Y/BaCoT2Jytn/ec5e8AOFoM3hH6nU4v/gGiVQidBuGI9h8WLjP/OGX9tE//AZtPMV
         J+mblVfMFEaYrGb/rCeWQz+nOa5y4zOQNjDbemwFieOBE53Pwi7BMCi/7Lxu9h0ExdBB
         RU8hRcoCU7vLzUi3yZOUG/8aLQkBrJEfaidWxa9V8tACEZfQm6KlA82djPqSGq61fxaT
         lQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6wsn5WkmwUVgezc0LCy5jRqM6LKxpaUc6fE6j/Xb8hQ=;
        b=bo9wXNY841HiSdl2cvDfY3qt77RxiaxCX6hhf52weLk4aeZsxJalCDs2N7iHVZ0ZXw
         jxN73ijjXgBvQavRYWC7BKjE4zpnhVxTGGHZAgV83glqBVzqeHZ950J+dSbwSYta9vYs
         ZuNVuhEcvW8mVI+QAxCOHq2YwxfqOYgBL6E7Dq5tnEKfhv37/ZYaP4NIr01YdH7qFDU7
         HqhqRo4pBG6xleCYYMMQzG/+5+KoJjoWcsAkkjhNdDaEgOpa04//YUeRCWIcWrfZS1Jw
         gc2Pzx0S2unc1YgvCcY8lqZQH9iyvxmeQPUIZRTSxwyY6SU5pBzUqATLt/cHhfZHMAv4
         ezFw==
X-Gm-Message-State: AODbwcDbJJCVYnNPfaLRgLJ1Nks/X6viVHm9xnfHh/+lwi9pnfQcQ7bI
        SMDYq4NE+Urt3w==
X-Received: by 10.13.255.71 with SMTP id p68mr19524318ywf.214.1495605636152;
        Tue, 23 May 2017 23:00:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:167:7063:293b:a24d])
        by smtp.gmail.com with ESMTPSA id v14sm1531223ywh.45.2017.05.23.23.00.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 23:00:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v2 5/7] grep: un-break building with PCRE < 8.32
References: <20170523192453.14172-1-avarab@gmail.com>
        <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
        <20170523192453.14172-6-avarab@gmail.com>
Date:   Wed, 24 May 2017 15:00:33 +0900
In-Reply-To: <20170523192453.14172-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 23 May 2017 19:24:51 +0000")
Message-ID: <xmqqh90ahjzy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Amend my change earlier in this series ("grep: add support for the
> PCRE v1 JIT API", 2017-04-11) to un-break the build on PCRE v1
> versions earlier than 8.32.
> ...
> So just take the easy way out and disable the JIT on any version older
> than 8.32.

The above were very understandable, but I had quite a hard time
parsing first sentence of the next paragraph, especially everything
after "because".  In the end I think I figured out what you wanted
to say (so you do not have to explain it to me in a response), but I
wish there were an easier-to-understand way to write the same thing.

> The reason this change isn't part of the initial change PCRE JIT
> support is because possibly slightly annoying someone who's bisecting
> with an ancient PCRE is worth it to have a cleaner history showing
> which parts of the implementation are only used for ancient PCRE
> versions. This also makes it easier to revert this change if we ever
> decide to stop supporting those old versions.
>
> 1. http://www.pcre.org/original/changelog.txt ("28. Introducing a
>    native interface for JIT. Through this interface, the
>    compiled[...]")
> 2. https://bugs.exim.org/show_bug.cgi?id=2121
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  grep.c | 8 ++++----
>  grep.h | 5 +++++
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 49e9aed457..3c0c30f033 100644
> --- a/grep.c
> +++ b/grep.c
> ...
> @@ -418,7 +418,7 @@ static void free_pcre1_regexp(struct grep_pat *p)
>  {
>  	pcre_free(p->pcre1_regexp);
>  
> -#ifdef PCRE_CONFIG_JIT
> +#ifdef GIT_PCRE1_CAN_DO_MODERN_JIT
>  	if (p->pcre1_jit_on) {
>  		pcre_free_study(p->pcre1_extra_info);
>  		pcre_jit_stack_free(p->pcre1_jit_stack);
> diff --git a/grep.h b/grep.h
> index 14f47189f9..73ef0ef8ec 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -3,6 +3,11 @@
>  #include "color.h"
>  #ifdef USE_LIBPCRE1
>  #include <pcre.h>
> +#ifdef PCRE_CONFIG_JIT
> +#if PCRE_MAJOR >= 8 && PCRE_MINOR >= 32
> +#define GIT_PCRE1_CAN_DO_MODERN_JIT
> +#endif
> +#endif
>  #ifndef PCRE_STUDY_JIT_COMPILE
>  #define PCRE_STUDY_JIT_COMPILE 0
>  #endif

After reading the patch, I do not necessarily agree with your
pros-and-cons between keeping the patches as separate steps and
squashing them into one, though.  Even if this were squashed into
[PATCH 4/7], the logic to set GIT_PCRE1_CAN_DO_MODERN_JIT based on
PCRE_CONFIG_JIT and PCRE's version in this patch is well isolated to
a single place, and it is easy to spot what needs to be done when we
decide to lose the version-based GIT_PCRE1_CAN_DO_MODERN_JIT from
our code after making sure that nobody uses versions older than
8.32.

By the time we will make such a decision, it is likely that we no
longer remember if "#ifdef GIT_PCRE1_CAN_DO_MODERN_JIT" we have in
our code at that moment in the future were all already present in
this patch.  An update to drop support for older PCRE is likely to
be done by finding the above part in grep.h to remove the
version-dependent part, while still keeping #ifdef based on
GIT_PCRE1_CAN_DO_MODERN_JIT in the *.c code.  Being able to revert
this patch does not help there.

We might also do a find-and-replace of GIT_PCRE1_CAN_DO_MODERN_JIT
to PCRE_CONFIG_JIT when we drop support for older PCRE, but I do not
think we would assume that it is sufficient to revert this patch
when we do so.  We may have added more #ifdef on the GIT_MODERN_JIT
symbol we now need to change to PCRE_CONFIG_JIT, so that will be
done by find-and-replace of the then-current code, not by reverting
this patch.

So in that sense, I do not think keeping them separate in practice
has the "makes it easier to revert this change" benefit.

If I were doing these two patches, I'd squash them together into
one, rename GIT_PCRE1_CAN_DO_MODERN_JIT to GIT_PCRE1_USE_JIT, and
explain in the log message why we turn it off for versions older
than 8.32 like you did in the log message for thsi patch.  

The reason for the "rename" is because I might also be tempted to
allow users of newer version to manually decline GIT_PCRE1_USE_JIT
in Makefile/config.mak; i.e. we may decide not to USE something even
if we CAN, and the #ifdef symbol you are using is about the decision
to USE or not USE, not necessarily if the library CAN.

Thanks.
