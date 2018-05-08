Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79C6200B9
	for <e@80x24.org>; Tue,  8 May 2018 06:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753796AbeEHGIv (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 02:08:51 -0400
Received: from mout.web.de ([212.227.17.11]:38325 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752497AbeEHGIu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 02:08:50 -0400
Received: from [192.168.178.36] ([91.20.55.213]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MI5ze-1fJlYR0oLm-003tHf; Tue, 08
 May 2018 08:08:37 +0200
Subject: Re: [PATCH v4 2/7] grep.c: expose matched column in match_line()
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
References: <20180421034530.GB24606@syl.local>
 <cover.1525488108.git.me@ttaylorr.com>
 <5281d6bdc1f6614b9330315cd9931ec9b2232445.1525488108.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d030b4ee-5a92-4863-a29c-de2642bfae8d@web.de>
Date:   Tue, 8 May 2018 08:08:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5281d6bdc1f6614b9330315cd9931ec9b2232445.1525488108.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nnytVRLPJtx7ddz5iJlBJqYYiDvpurgjfcbxKsBfXjZEv1GkySJ
 evTF74jBE+9XuYaexqqs6Jevy0bo/x5biYPYUF2zrB/sXX7Dixot9fwtG/4SVhn3ghankV0
 1QtrTbGpd4yF4RhugZWKKx8gf7vl12ggncomnBR3ByGWbjKp7p7InZuen8DEWH2xqnRdHrf
 7++ZV7nfiJKgDaMgEdu9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jqm0TGqNHpw=:gF7M4RRNy8xqzY+YnTqwg3
 u9Wz/MvSOHG/fdeygDj8PB1LKA2+amccjjCoi76wJhpIJyQDVzs/v1EEC2BZBOEPo/jlAOpR1
 6y7lclhblMGx2Gw/yYyecJbgCJMl04ZmI7vqLwkFMIvRzQrSo/xLyHwfjidquGbQ/tmhYce+c
 RZbU/vO3iywa8iB8X103EJg/sa89fFQ64Q4BoZRmCrRKlQnbgHeMLlEiCAuA2GfQpNJvU7pNf
 HCn6z9Om+pXE5H9Vl98yySQMuIa3nt/FHae6JQS3kZ+4aDMrIel/Bb624KEOmV5r44ypemdjj
 R38fHBwrZ/lDNr7LCYRC4c+KszUmkzv1aujtpOFqgnabRY5Vn2YJ78VNURm+lQ0g+/VyfCnNu
 QG2jtYalUCgbpFyrxbrp53NIwulUoZvpqtUeQSPlR40WNdce1RqhEdU400dHIgWL0IHANkXaX
 ZjGXOE9DVDjLImtnZLBHgLJT7S+3CUisCoPVMIOduDxJkfrZUB84cJmA+AFb3BXDdso+rnMd4
 bfj3cubfGpeSwQP+FtWZQgP+LuCufPCXusIIwfIS35wg9bg4sKmIUB/zRZMuXTo54gK6G3WwB
 IAos1U7NfnaNlgSdHLg+3LmBkhTD0s/9SXIGBUdvzH/Tja7s7lKjCG0rDMISpPD2jObLAauvj
 vZ2/E+doxZc1c+a+n9lJHl4mVzpcavfBOK0JP5A8I9d5b0/5487O4CY77DTdPenSXzSif1VK7
 +CH8sHVqSiiirLOGH95lI/ISjYyJYI6ZHZi8Bg+qjhk0ROzTwLtQ5E2rEADK0F8O7C95qKxqK
 o/aqsxE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.05.2018 um 04:42 schrieb Taylor Blau:
> When calling match_line(), callers presently cannot determine the
> relative offset of the match because match_line() discards the
> 'regmatch_t' that contains this information.
> 
> Instead, teach match_line() to take in a 'regmatch_t *' so that callers
> can inspect the match's starting and ending offset from the beginning of
> the line. This additional argument has no effect when opt->extended is
> non-zero.
> 
> We will later pass the starting offset from 'regmatch_t *' to
> show_line() in order to display the column number of the first match.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>   grep.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/grep.c b/grep.c
> index 65b90c10a3..1c25782355 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1299,17 +1299,17 @@ static int match_expr(struct grep_opt *opt, char *bol, char *eol,
>   }
>   
>   static int match_line(struct grep_opt *opt, char *bol, char *eol,
> -		      enum grep_context ctx, int collect_hits)
> +		      regmatch_t *match, enum grep_context ctx,
> +		      int collect_hits)
>   {
>   	struct grep_pat *p;
> -	regmatch_t match;
>   
>   	if (opt->extended)
>   		return match_expr(opt, bol, eol, ctx, collect_hits);

If ->extended is set then match won't be touched...

>   
>   	/* we do not call with collect_hits without being extended */
>   	for (p = opt->pattern_list; p; p = p->next) {
> -		if (match_one_pattern(p, bol, eol, ctx, &match, 0))
> +		if (match_one_pattern(p, bol, eol, ctx, match, 0))
>   			return 1;
>   	}
>   	return 0;
> @@ -1699,6 +1699,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
>   	int try_lookahead = 0;
>   	int show_function = 0;
>   	struct userdiff_driver *textconv = NULL;
> +	regmatch_t match;
>   	enum grep_context ctx = GREP_CONTEXT_HEAD;
>   	xdemitconf_t xecfg;
>   
> @@ -1788,7 +1789,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
>   		if ((ctx == GREP_CONTEXT_HEAD) && (eol == bol))
>   			ctx = GREP_CONTEXT_BODY;
>   
> -		hit = match_line(opt, bol, eol, ctx, collect_hits);
> +		hit = match_line(opt, bol, eol, &match, ctx, collect_hits);
>   		*eol = ch;
>   
>   		if (collect_hits)
> 

... which leaves it uninitialized.

So at least the combination of extended matches and --column should error
out.  Supporting it would be better, of course.  That could get tricky for
negations, though (e.g. git grep --not -e foo).

René
