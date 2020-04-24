Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3242EC2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8AE2087E
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="atC4g6J/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgDXAvp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:51:45 -0400
Received: from avasout07.plus.net ([84.93.230.235]:34808 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbgDXAvo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 20:51:44 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id RmZCjRvdFsCJiRmZDjx4iZ; Fri, 24 Apr 2020 01:51:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1587689503; bh=3dFlfPt8+YeFRXBASIdkGduVtqU9Mz0KiEin0SgFZQ4=;
        h=Subject:To:References:From:Cc:Date:In-Reply-To;
        b=atC4g6J/zGI/Wd5dEpC3hPNAFBzLfka7RPg3p/0CNM41sCbdX7lSm2121ZUDCTpWz
         1m3acYlYGrPMAk5jKAVCwgbGg08DJRsq8IJQoqaMF7Qv8POxbN/RGuld2A8O3PU3g6
         GxptU7kMZRvYhwunFc7ELbDq/LYq/OMOQ4WGg0SaXxCcg/4ZrDl/qr5wG2bhFklMSg
         oMU+kQxYQ+bbEN753S6paWeyyJ5gFOSaWlQFRvKVXlbGZNyOq/cS61H3iVrACdXBSX
         45tcfSjng8L/6woPwso1VhczBzyyiw8Pyx5gbieMC7MPhlUk+RgPJkRe8rxi177MV0
         o8u8GwbLa+OoQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=BPIoUGYG c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=7wQ1BsViH98mBkXanZkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/4] compat/regex: silence `make sparse` warning
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <25f595f56f7f895ab31bf7269aabad9142c0590c.1587648870.git.congdanhqx@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Message-ID: <62642f8c-e885-9fb6-f13b-a9960a2172a5@ramsayjones.plus.com>
Date:   Fri, 24 Apr 2020 01:51:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <25f595f56f7f895ab31bf7269aabad9142c0590c.1587648870.git.congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLAtfQMPgWSdCgPYlW2CROaseybtI1PO8bZnX/qqr61AIFJzEkNokvxIxTaFkkVCArDOhb0aM2BCXcX+bsmtrfneHKWwc3NqU5NCJNqsBdr3QU63jOtw
 i3qsoPu1eoGRSm2mwZJL/G119Jfhj0S4rPB4WACalssHwTHE+NUNX7zcgeo9sLxle+zazsGwJ3+ogA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/04/2020 14:47, Đoàn Trần Công Danh wrote:
> * alloca: somewhere later in the code, we indirectly include alloca.h
> which will define alloca again, include it prior to define alloca in
> order to not define it against.
> 
> * Copy all attributes from the header to source file, and move the
>   attributes prior to function name. cgcc is very picky on the position
>   of attribute.

This patch is no longer needed (iff you use a bleeding edge version of
sparse), since this was fixed in commit 172f6a98 ("let function definition inherit prototype attributes", 2019-11-19).

  $ git describe 172f6a98
  v0.6.1-37-g172f6a98
  $ 

Ah, so this fix is not in any released version of sparse (v0.6.1 is the
current release - I always build/run the tip of the 'master' branch from
the sparse git repo).

I starred at this warning for years (on cygwin, I don't build with NO_REGEX
on Linux), but I didn't send a patch for it because it was a sparse fault.

ATB,
Ramsay Jones

> 
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>  compat/regex/regex.c          | 1 +
>  compat/regex/regex_internal.c | 2 +-
>  compat/regex/regex_internal.h | 5 ++---
>  3 files changed, 4 insertions(+), 4 deletions(-)
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
> diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
> index ec51cf3446..58504f795b 100644
> --- a/compat/regex/regex_internal.c
> +++ b/compat/regex/regex_internal.c
> @@ -921,7 +921,7 @@ re_string_destruct (re_string_t *pstr)
>  /* Return the context at IDX in INPUT.  */
>  
>  static unsigned int
> -internal_function
> +internal_function __attribute ((pure))
>  re_string_context_at (const re_string_t *input, int idx, int eflags)
>  {
>    int c;
> diff --git a/compat/regex/regex_internal.h b/compat/regex/regex_internal.h
> index 3ee8aae59d..c61a1e4971 100644
> --- a/compat/regex/regex_internal.h
> +++ b/compat/regex/regex_internal.h
> @@ -430,9 +430,8 @@ static reg_errcode_t build_wcs_upper_buffer (re_string_t *pstr)
>  # endif /* RE_ENABLE_I18N */
>  static void build_upper_buffer (re_string_t *pstr) internal_function;
>  static void re_string_translate_buffer (re_string_t *pstr) internal_function;
> -static unsigned int re_string_context_at (const re_string_t *input, int idx,
> -					  int eflags)
> -     internal_function __attribute ((pure));
> +static internal_function __attribute ((pure))
> +unsigned int re_string_context_at (const re_string_t *input, int idx, int eflags);
>  #endif
>  #define re_string_peek_byte(pstr, offset) \
>    ((pstr)->mbs[(pstr)->cur_idx + offset])
> 
