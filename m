Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAEA220281
	for <e@80x24.org>; Mon, 22 May 2017 11:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757621AbdEVLxF (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 07:53:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:61984 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757562AbdEVLxC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 07:53:02 -0400
Received: from virtualbox ([95.208.58.16]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LyEqr-1e0MHO36jF-015Znn; Mon, 22
 May 2017 13:52:59 +0200
Date:   Mon, 22 May 2017 13:52:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] mingw.h: permit arguments with side effects for
 is_dir_sep
In-Reply-To: <69bafb7c9e08ba837a9b92573bef165a62c5bf92.1495261020.git.j6t@kdbg.org>
Message-ID: <alpine.DEB.2.21.1.1705221349200.3610@virtualbox>
References: <cover.1495261020.git.j6t@kdbg.org> <69bafb7c9e08ba837a9b92573bef165a62c5bf92.1495261020.git.j6t@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XTXUOJEulzqWVGF8EvoWoMk9gMtNjz5jvPS5CNgngicr3gvGyS4
 E8NQukZr1LuATy83orasyGlPyzBO52q7a975EpHrHeNr+ESHWi+oSmGGs2fOOzfrZKLZJeB
 tdZpEyOnR0xDWSFj921p+AC+FhiQq/pgRSiY9yooBGq9DofpVxbrVyl6DZWCgEyzCLuj1wH
 ReUXsTxkG/R3MNIxfEkyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lFJuefFWyyw=:006p0yajWykLREKFRQnd9l
 jYLcg8TjT1vG/AdyGe19yYUcYC3mndbMjk+AlhYldfbOO7O3o9oNw++z8gj35DOAF7zIvqZRX
 ee+zdUxd8q7Z+ZNoO+XnfSNmoDwgx5d/piIKBacsjM/bqKvDl2Um2Tt6pPx4RdMIvMoQsUlt4
 yXl6F0A2yIukb9ffDD7PJ/RB/AV4ecFjq3bnHepZSgbqc5ZcP0C1hr5oLQkpEntLbjxzz9j30
 3PGZND5UfnxbPVoOEm+GqYko+d3iSgLuTT+W0yNhPKzU+3hQ8oiH/yo/ZtY9Q0woj6Hm8wrGy
 TtZ846a8cf8XCDtxV3IaIUIwaVmNeTin7KwjaV8pAsS3ID7k95/udG6c5NifhJ65fU8Ok71bG
 Ggz9/NEXMov0H8M0DY4nVPWy75RPAKFGgIQSKDEOEIyQDBNe5BQhCLmmHlVNaXR1NA5KfTtOE
 ZZwST/CDISDkYAsdcm0FuEY8KW11Q4LSFLaaOqfJbuk17UmypLcUnxDab3mVq+dSp6s14vmFj
 AeeYN0g0HqgzoPngzXM7oJ/fGKaF5d/nh62hGKcd7kAKk2FgIWYovIP8p7kG5W22wVUAdOPVy
 0pTvFG/apvgsP72Z3zIM7qljqlUssL2Jh5HI9LeT3DSgSmzKfXtoiQJKVT+yBfx8H2kzjuAMS
 k9YawPdeyYXb+hRx6aDBzf39rL0t0C6NMyhZsqYWLL350ppnwMEtcqNirPa0CJZ4y058XVuAE
 YgGNJXy5xV68KmbMOr+ZdoZOjrXQMZP10kJP22BoSFYk8uCoz0AwWAfD8KorKK2sc8R22c9hI
 PS9Xavr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,


On Sat, 20 May 2017, Johannes Sixt wrote:

> The implementation of is_dir_sep in git-compat-util.h uses an inline
> function. Use one also for the implementation in compat/mingw.h to support
> non-trivial argument expressions.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

I was a bit confused by the oneline. Maybe something like

	mingw.h: avoid side effects with is_dir_sep()'s argument

	Taking git-compat-util.h's cue (which uses an inline function
	to back is_dir_sep()), let's use an inline function to back
	also the Windows version of is_dir_sep(); This avoids problems
	when calling the function with arguments that do more than just
	provide a single character, e.g. incrementing a pointer. Example:

		is_dir_sep(*(p++))

> diff --git a/compat/mingw.h b/compat/mingw.h
> index cdc112526a..5e8447019b 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -398,7 +398,11 @@ HANDLE winansi_get_osfhandle(int fd);
>  	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
>  int mingw_skip_dos_drive_prefix(char **path);
>  #define skip_dos_drive_prefix mingw_skip_dos_drive_prefix
> -#define is_dir_sep(c) ((c) == '/' || (c) == '\\')
> +static inline int mingw_is_dir_sep(int c)
> +{
> +	return c == '/' || c == '\\';
> +}
> +#define is_dir_sep mingw_is_dir_sep
>  static inline char *mingw_find_last_dir_sep(const char *path)
>  {
>  	char *ret = NULL;

The patch is very good, of course.

ACK,
Dscho
