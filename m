Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3491FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 12:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756333AbdDFM1S (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 08:27:18 -0400
Received: from mout.web.de ([212.227.15.3]:49454 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753497AbdDFM1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 08:27:16 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lwq0e-1c3Gtm1VMm-016O2d; Thu, 06
 Apr 2017 14:26:58 +0200
Subject: Re: [PATCH v2 1/2] Fix nonnull errors reported by UBSAN with GCC 7.
To:     =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Jeff King <peff@peff.net>
References: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
 <20170406083425.7psdmrploxar3h6v@sigill.intra.peff.net>
 <998bf391-7fc5-8329-db58-ef0f24517707@suse.cz>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <33c63fb9-281c-8fd2-66e7-b85f62f4f447@web.de>
Date:   Thu, 6 Apr 2017 14:26:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <998bf391-7fc5-8329-db58-ef0f24517707@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:4Um9aKYQMXZz7y4Q/zTI6S8Ws6Zu2lIS/1mh1xpZ6aIRIeBrueQ
 AYzM7EJf5FfyrsO2nSUJo9Xc0qWlHifS+pf7rai+vCSEFHF6dM1gPmgVWvWnCB3crUOWK57
 9TV9cKG/aEiKEVKeBeVzaWMqJkGZxDGSPHWgCmLLgN8Xp1D9fvOolJ+UwGpxZ1xxhvyUI3d
 RxMf9MH9uSrq0occ89nVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oSHvNS0jVQg=:UOt3DbKXQgd9vIl/g15Atc
 Lg7hqX1qewQeMhPj6JLowMv2qrZ56zRiqo4M8Czxdxe1U1Y4FVu1TQJxL50NkA14Yai+hz0q6
 kKF2oQUvg841E0vGJMPfoDSQPpmL/AbIztjEZ00eor0cB0yfDl/8g0WxhVKROJI6ElogN+rRn
 VOM5LGvvcfhr0sypBn15BKWcJ1mX4s48POUAEp0nk+H/GnLxzZ21OxtIAqRNqI6kMAfwi1vao
 j5SbMFrJdnA5BQpgvCC2JvX0AHK6h/KTRNzxjMG57JAdnH9TgqrMMpCBtaDQsBqX67IEeQcKc
 Y/wxbWkShAVo9cw31zsoXyyvA+EKoYr+gXZu4iDDa9YpILUkONT7EMsrLeCLQIFL0FN1NQzKq
 b6pJ7gh71ZvMKcK/fmu0hYkjaeMLAIblfQpg0nuK44gx29ds9Sys5jcSnCqdJQQWwEFI5lrFO
 FQOuvtA2BeLPyPSbOs6/x6BGGSPWq8KOqrdDm/VBrL3sktw14rZY2or6hD4zd4rbIRFT1vX9q
 oTHzf7OAY7uC/0LYSS5eL0q//IBHHPv4mQGLI4rGrAje1msXH8H6kczy6fduBxeY+FHBwQcT4
 0bzKFeolk73LUuAYuVGdtzyb+9ircigps+sDaa5O4+5gcPSsIi8g8OFBSeiC6wRDF2hyf4Fcj
 65jg5mdzOnxMH0EglyiE/M4TmfT85BOSSi7Y/SL949NtEhCU9zFgdF2MvfOBAj0VKgRB/tI9k
 IFFGdRbpo7OSzf3hmG+z0JX05XJrdS8JwGemN6a3850Xqbo5sjh+H5vBTumRLs09NvjLOgHTn
 Ia/T9ql
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.04.2017 um 11:52 schrieb Martin Liška:
> I'm sending (v2), where I updated commit message and wrapped 2 problematic
> places to newly introduced macros that do the check. Follow-up patch can
> change usages of memcpy and memove.

> diff --git a/apply.c b/apply.c
> index e6dbab26a..eacca29fa 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -2802,9 +2802,9 @@ static void update_image(struct apply_state *state,
>  			img->line + applied_pos + preimage_limit,
>  			(img->nr - (applied_pos + preimage_limit)) *
>  			sizeof(*img->line));
> -	memcpy(img->line + applied_pos,
> -	       postimage->line,
> -	       postimage->nr * sizeof(*img->line));
> +	MEMCPY(img->line + applied_pos,
> +		postimage->line,
> +		postimage->nr * sizeof(*img->line));

Using the existing macro COPY_ARRAY would yield a nicer result:

	COPY_ARRAY(img->line + applied_pos, postimage->line, postimage->nr);

>  	if (!state->allow_overlap)
>  		for (i = 0; i < postimage->nr; i++)
>  			img->line[applied_pos + i].flag |= LINE_PATCHED;
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index d449e46db..7caeeb6a6 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -391,7 +391,7 @@ static void prune_cache(const char *prefix, size_t prefixlen)
>  		}
>  		last = next;
>  	}
> -	memmove(active_cache, active_cache + pos,
> +	MEMMOVE(active_cache, active_cache + pos,
>  		(last - pos) * sizeof(struct cache_entry *));
>  	active_nr = last - pos;
>  }

Perhaps we should add MOVE_ARRAY to complement COPY_ARRAY.

René
