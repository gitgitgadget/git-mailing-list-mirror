Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9ED1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbeHMOgV (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:36:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:52549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbeHMOgV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:36:21 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMYZG-1fodCH20D8-008M3l; Mon, 13
 Aug 2018 13:54:19 +0200
Date:   Mon, 13 Aug 2018 13:54:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 4/4] range-diff: indent special lines as context
In-Reply-To: <20180810224923.143625-5-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1808131353280.71@tvgsbejvaqbjf.bet>
References: <20180810224923.143625-1-sbeller@google.com> <20180810224923.143625-5-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:c5eUVE137L05HvdvdS7bxudLL80XoNX2JYtV65ZUxyBNNoJcvEL
 xKSxXskQrE+zQEkzuVrDWjXN3KLhZ0g1O7ab0RHSTCY8MfMJFnR/m9ndEhQgY1+1Fq7SuJo
 RjUsiBD1Y4nSIBECEs3wvQ79KqYm3hqRDWhlFLGX1Ybf8rUh3wwR+p1nrboayJqvn0x7pZ0
 kcaOFvcQG9Y+iQ47iNyjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:52jwCAqDVVE=:5xnyczvTe7N8weHA4rkyrN
 Jq9gs4Qu7tF4J0nVhbz66qBhZ2KVcgIfxgUAL0+/LVppPrDon4/O4GbuDxn5HQtYUhiCGv0Aw
 71ugTJbc23i+FzB74IhHVXbJ83+xglcqx7fYuzZAC2shEKnyCw/tBYen+FWxyUfs0/xhO4nvZ
 h7iTXBW9Z56YBWdtsKiw+g9raQ41z11m9zwdj2MN8AezBEeLFwfXmSeKHLkxEY8iJla2P7apU
 MtE8J6XLnEg/TwWtxa3BsuhB016jQBWfQmhciHYtZLePHkNtmkyMiWIyVXHA7YT2DmuOf3Um4
 nU5S4r3CCaLaqmSTeApB6Wg2AbOlhvcyy6ArVB1nMdb4Sm6mtDyRzKomp9L07ylilGTR9AI4x
 rIrSkPsaRkwMjZugRnnSEx0GsJbKRNkspDPVEdRCZOw3y/wT/80aL0elT6lC5TzB+P2OJYQwh
 TLaH++bzV2RdAZJbcMbUZ1wOQBcsofFlNHNEbFrqb8lRPqDL5KhsMKkkDzLp6z7LQ+OAJU3mF
 13AYz1kOaTiuC7nGBKyIT8JGRaXlNmWizrW8HhucRwt5HWq4CMv7SfTF7NR1/tXJ4v4nOieaE
 ldiJCX+00MxbvC3m0Qy1NDgFM+dfZwvnUG4WMMhl6iPB6GPEhyrvtZUfr3aSblbvGTMNn8HKg
 uwMgdx0seKDgJ1GVo60zC6pbTkm9/w2480w6KHJA7LDx2VklVla9wV7OFbtBrT70I1yn2aBy9
 Yg0HrKBzchuPvYMAO866P/FnFbq/NE9OBCqlQ5WxCp6Qa/1KJYi8U5ttMaEIKOT5OAhtoVtZP
 a7S+Y+d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 10 Aug 2018, Stefan Beller wrote:

> The range-diff coloring is a bit fuzzy when it comes to special lines of
> a diff, such as indicating new and old files with +++ and ---, as it
> would pickup the first character and interpret it for its coloring, which
> seems annoying as in regular diffs, these lines are colored bold via
> DIFF_METAINFO.
> 
> By indenting these lines by a white space, they will be treated as context
> which is much more useful, an example [1] on the range diff series itself:
> 
> [...]
>     + diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
>     + new file mode 100644
>     + --- /dev/null
>     + +++ b/Documentation/git-range-diff.txt
>     +@@
>     ++git-range-diff(1)
> [...]
>     +
>       diff --git a/Makefile b/Makefile
>       --- a/Makefile
>       +++ b/Makefile
> [...]
> 
> The first lines that introduce the new file for the man page will have the
> '+' sign colored and the rest of the line will be bold.
> 
> The later lines that indicate a change to the Makefile will be treated as
> context both in the outer and inner diff, such that those lines stay
> regular color.

While I am a fan of having those lines colored correctly, I have to admit
that I am not exactly enthusiastic about that extra indentation...

Otherwise, this looks good to me.

Thanks,
Dscho

> 
> [1] ./git-range-diff pr-1/dscho/branch-diff-v3...pr-1/dscho/branch-diff-v4
>     These tags are found at https://github.com/gitgitgadget/git
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  range-diff.c          |  2 ++
>  t/t3206-range-diff.sh | 12 ++++++------
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/range-diff.c b/range-diff.c
> index 6e4192c8e79..a8db7c4f8d3 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -85,6 +85,7 @@ static int read_patches(const char *range, struct string_list *list)
>  			strbuf_addch(&buf, '\n');
>  			if (!util->diff_offset)
>  				util->diff_offset = buf.len;
> +			strbuf_addch(&buf, ' ');
>  			strbuf_addbuf(&buf, &line);
>  		} else if (in_header) {
>  			if (starts_with(line.buf, "Author: ")) {
> @@ -121,6 +122,7 @@ static int read_patches(const char *range, struct string_list *list)
>  			strbuf_addch(&buf, ' ');
>  			strbuf_add(&buf, line.buf + 1, line.len - 1);
>  		} else {
> +			strbuf_addch(&buf, ' ');
>  			strbuf_addbuf(&buf, &line);
>  		}
>  
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 7dc7c80a1de..c94f9bf5ee1 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -133,9 +133,9 @@ test_expect_success 'changed message' '
>  	    Z
>  	    +    Also a silly comment here!
>  	    +
> -	    Zdiff --git a/file b/file
> -	    Z--- a/file
> -	    Z+++ b/file
> +	    Z diff --git a/file b/file
> +	    Z --- a/file
> +	    Z +++ b/file
>  	3:  147e64e = 3:  b9cb956 s/11/B/
>  	4:  a63e992 = 4:  8add5f1 s/12/B/
>  	EOF
> @@ -152,9 +152,9 @@ test_expect_success 'dual-coloring' '
>  	:     <RESET>
>  	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
>  	:    <REVERSE><GREEN>+<RESET>
> -	:     diff --git a/file b/file<RESET>
> -	:    <RED> --- a/file<RESET>
> -	:    <GREEN> +++ b/file<RESET>
> +	:      diff --git a/file b/file<RESET>
> +	:      --- a/file<RESET>
> +	:      +++ b/file<RESET>
>  	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
>  	:    <REVERSE><CYAN>@@ -10,7 +10,7 @@<RESET>
>  	:      9<RESET>
> -- 
> 2.18.0.865.gffc8e1a3cd6-goog
> 
> 
