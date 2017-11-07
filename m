Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E411320A10
	for <e@80x24.org>; Tue,  7 Nov 2017 12:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbdKGMpF (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 07:45:05 -0500
Received: from mout.gmx.net ([212.227.15.18]:53089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750704AbdKGMpE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 07:45:04 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmbVT-1elNvs00Z9-00aCcE; Tue, 07
 Nov 2017 13:44:59 +0100
Date:   Tue, 7 Nov 2017 13:44:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] xdiff: reassign xpparm_t.flags bits
In-Reply-To: <20171107064011.18399-2-gitster@pobox.com>
Message-ID: <alpine.DEB.2.21.1.1711071336120.6482@virtualbox>
References: <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com> <20171107064011.18399-1-gitster@pobox.com> <20171107064011.18399-2-gitster@pobox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RRQnZC9O+ZbgXakQX0WKKL4sDFifV8zCxdyj0BkD53pKCr9PTHq
 sGDSDEBUUvaKngvxmkiqBzlERIFbd/paIBljNrTVZdRTdkdp4VhstiC1kzUlfaiHZIDwbFB
 O8+cC3e00LZMG1kePrHQ0XK1XwvbWGXuTPE2J44Kwk9FJHJ7DmRmj46nm0ZfD2PiIg9Qjbp
 0Z6BLdKlg8yJC33EgYsGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iZcx66m9yNo=:U3c2Lm2L/OCNCgrU/wVhHx
 Mmqi1BCStSddzwHlsyW/nxy4SC8ea6m4OFTAd4GDG7ZAWlSWQJiaFgmkMNjdEu3+UBf4VMD4P
 sK4xELwwAqLkFZlPiCd7ULrSoxjupUGqNHc7WqUuVSsFN+nqNOYq6N7cOviSEkkaWw+4cUXDE
 IN8N9gKVclWKNZgHuAefI2h1Yq65p1UiRzKUYT1+vPN027MoiR3PCD5vspUtFcQn44mM3DuGE
 sEJtHS/QoRaGDdjzTvJXa7uOw5bUv7Jz0SU5nDCQCCw0W9L+0PsnzBPgwtAsnfPEh71BjPxDt
 bHB4RVdCoPWRHlJdPkhQOhINe1NhIK858rU5kiPN5pJa3Ik4etfivq7fxKqPKHhOASpMgreFG
 e2uEud6Jh799YARWsqAEa61xeG1DvsvlTL1wvxhvV4iv/RJTM0Ksu/LZ+wNPKhkQ8ofRPzLGv
 QzlP7U4LwlyNqfS7p9EGk4LCc7lVUrEiQYgOf7QsDJ8H9tPY7Vv8WP91eTj1A41DjJQoSuNS7
 6oSZyDAOKKcdTPsBwKybuUWq/x6PegKQE8lGFi5+9dEpdNLjWh+E3DuiYBJz3nGqoNBmDuS/t
 lKV8EUDKruHeVzdsXhruvAsIftntGvtDgmdEOUX7DMVQTA6Tr070QM3RwgfONySud3yQ4yhFS
 0APXoXYQ2oll+0zpxRhG7DmTPlDM7rvsAf/Y6Wd7zw6U7+p4xyfww5T88fR/hpydOolvzoLij
 hiN7zBxKeh7k6u10pZVY8XyKMLYOO0MC1RwTWNf93+M/Bum7pVMSyPDv1hxPaZa/XMrkfGhSK
 NHcqQhoEET1xhnnRupzgXRzyo8J2BEjc4lVE0ccxEO0EQD9yTM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 7 Nov 2017, Junio C Hamano wrote:

> We have packed the bits too tightly in such a way that it is not
> easy to add a new type of whitespace ignoring option, a new type
> of LCS algorithm, or a new type of post-cleanup heuristics.
> 
> Reorder bits a bit to give room for these three classes of options
> to grow.  Also make use of XDF_WHITESPACE_FLAGS macro where we check
> any of these bits are on, instead of using DIFF_XDL_TST() macro on
> individual possibilities.  That way, the "is any of the bits on?"
> code does not have to change when we add more ways to ignore
> whitespaces.
> 
> While at it, add a comment in front of the bit definitions to
> clarify in which structure these defined bits may appear.

Makes sense.

> diff --git a/diff.c b/diff.c
> index 74283d9001..790250fe86 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3434,9 +3434,7 @@ void diff_setup_done(struct diff_options *options)
>  	 * inside contents.
>  	 */
>  
> -	if (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
> -	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
> -	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL))
> +	if ((options->xdl_opts & XDF_WHITESPACE_FLAGS))

Not only shorter now, but a lot clearer, too: nobody needs to wonder now
whether one whitespace flag was excluded on purpose.

>  		DIFF_OPT_SET(options, DIFF_FROM_CONTENTS);
>  	else
>  		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index b090ad8eac..cbf5d8e166 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -27,22 +27,26 @@
>  extern "C" {
>  #endif /* #ifdef __cplusplus */
>  
> +/* xpparm_t.flags */
> +#define XDF_NEED_MINIMAL (1 << 0)
>  
> -#define XDF_NEED_MINIMAL (1 << 1)

This change makes me wonder whether the least significant bit was omitted
on purpose originally. You probably looked at that? May be worth
mentioning in the commit message.

> -#define XDF_IGNORE_WHITESPACE (1 << 2)
> -#define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
> -#define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
> -#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
> +#define XDF_IGNORE_WHITESPACE (1 << 1)
> +#define XDF_IGNORE_WHITESPACE_CHANGE (1 << 2)
> +#define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 3)
> +#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | \
> +			      XDF_IGNORE_WHITESPACE_CHANGE | \
> +			      XDF_IGNORE_WHITESPACE_AT_EOL)
>  
> -#define XDF_PATIENCE_DIFF (1 << 5)
> -#define XDF_HISTOGRAM_DIFF (1 << 6)
> +#define XDF_IGNORE_BLANK_LINES (1 << 7)
> +
> +#define XDF_PATIENCE_DIFF (1 << 14)
> +#define XDF_HISTOGRAM_DIFF (1 << 15)
>  #define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF)
>  #define XDF_DIFF_ALG(x) ((x) & XDF_DIFF_ALGORITHM_MASK)
>  
> -#define XDF_IGNORE_BLANK_LINES (1 << 7)
> -
> -#define XDF_INDENT_HEURISTIC (1 << 8)
> +#define XDF_INDENT_HEURISTIC (1 << 23)
>  
> +/* xdemitconf_t.flags */
>  #define XDL_EMIT_FUNCNAMES (1 << 0)
>  #define XDL_EMIT_FUNCCONTEXT (1 << 2)

It is a pity that this diff is not easier to review, but it shows how much
it was in need of cleaning up. Looks much nicer now.

I wonder, however, what your guiding principle was in determining the
gaps? I would have expected consecutive bits, except for the one gap to
make room for the upcoming flag, of course.

Future patch series could always start by making room for new flags, as
needed, after all.

Ciao,
Dscho
