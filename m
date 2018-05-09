Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F321F42D
	for <e@80x24.org>; Wed,  9 May 2018 10:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934113AbeEIKlM (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 06:41:12 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:21415 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932570AbeEIKlL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 06:41:11 -0400
Received: from [192.168.2.240] ([92.22.23.119])
        by smtp.talktalk.net with SMTP
        id GMWwf1srQ3fRRGMWwfUZI2; Wed, 09 May 2018 11:41:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1525862469;
        bh=p3/jlOpvOZ4c9a8XLb3zCoHZQch67gYDxHWumQmeV8o=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lXQqsqf1UuqEPhDAmwgv8DmxF5pWn2MJqWwuF4A9BX5LaceqSRHdhRFbZUI5FMj/H
         6g4LvledcKVUdSYoFtwVeY8nPxFhCfcUQDdEMqI0yYhPtkbeF1bXeOBxtAPtcRX9HX
         1UvrSdaF6IDP1E9SmgyHvJ4UCnpj7i8JzLTqCPo8=
X-Originating-IP: [92.22.23.119]
X-Spam: 0
X-OAuthority: v=2.3 cv=YZWTGTZf c=1 sm=1 tr=0 a=oWXjcmuSLv9+fGSLdn2kqg==:117
 a=oWXjcmuSLv9+fGSLdn2kqg==:17 a=IkcTkHD0fZMA:10 a=3nsOOYR-AAAA:8
 a=fOT1JBd-rTNTm-NYrHIA:9 a=RnOvEgpLuGr8u_Dn:21 a=XZZcGjo2TuABbk_B:21
 a=QEXdDO2ut3YA:10 a=X8_4EP2Luv2hi8NvPz5g:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 5/7] builtin/grep.c: add '--column' option to
 'git-grep(1)'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, pclouds@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
References: <20180421034530.GB24606@syl.local>
 <cover.1525831201.git.me@ttaylorr.com>
 <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <882bdfe8-6caa-dd9c-7752-ee4884f135f9@talktalk.net>
Date:   Wed, 9 May 2018 11:41:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLhRAR1tSv4mTl19T1DXmwBD3LM157kv6MmYLM7DaECH21MK0aM9WXEOtpaujdkHotOVbPV05tPxEBF384p+7FF1xM21qInNgSgoCjaTZvYK5CiuvWm8
 laaHi5pyYP0OJ1fqbQprN+03gVn+buwhQbxGplmI7i7ehc65EM4xuGsybccr5XkcQ8NFGWiVG0xWIMagwjPpE++6vj0K/ulFi8NcBGdebZpd2qSLvL5pBaTk
 q7BOXyJB9jFvBzTS/J8Qn1vIoZ9GWScXRDCkl/YDs+sJM2C/OWDyRiKpqNzsPPq79Xa7Agsx8ypdDabnDg6sRAV5qqY62T6jkfIZbgZMjXyGyL6qdyUnEODv
 lIZhaeD+di8EdWIKiZmgAR1VWJlWLwxK0816k66CAzQvaOqxl0U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor

On 09/05/18 03:13, Taylor Blau wrote:
> Teach 'git-grep(1)' a new option, '--column', to show the column
> number of the first match on a non-context line. This makes it possible
> to teach 'contrib/git-jump/git-jump' how to seek to the first matching
> position of a grep match in your editor, and allows similar additional
> scripting capabilities.
> 
> For example:
> 
>    $ git grep -n --column foo | head -n3
>    .clang-format:51:14:# myFunction(foo, bar, baz);
>    .clang-format:64:7:# int foo();
>    .clang-format:75:8:# void foo()
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>   Documentation/git-grep.txt |  6 +++++-
>   builtin/grep.c             |  4 ++++
>   grep.c                     |  3 +++
>   t/t7810-grep.sh            | 32 ++++++++++++++++++++++++++++++++
>   4 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 18b494731f..75f1561112 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>   	   [-v | --invert-match] [-h|-H] [--full-name]
>   	   [-E | --extended-regexp] [-G | --basic-regexp]
>   	   [-P | --perl-regexp]
> -	   [-F | --fixed-strings] [-n | --line-number]
> +	   [-F | --fixed-strings] [-n | --line-number] [--column]
>   	   [-l | --files-with-matches] [-L | --files-without-match]
>   	   [(-O | --open-files-in-pager) [<pager>]]
>   	   [-z | --null]
> @@ -169,6 +169,10 @@ providing this option will cause it to die.
>   --line-number::
>   	Prefix the line number to matching lines.
>   
> +--column::
> +	Prefix the 1-indexed byte-offset of the first match on non-context lines. This
> +	option is incompatible with '--invert-match', and extended expressions.
> +

Sorry to be fussy, but while this is clearer I think to could be 
improved to make it clear that it is the offset from the start of the 
matching line. Also the mention of 'extended expressions' made me think 
of 'grep -E' but I think (correct me if I'm wrong) you mean the boolean 
options '--and', '--not' and '--or'. The man page only uses the word 
extended when talking about extended regexes. I think something like

Print the 1-indexed byte-offset of the first match from the start of the 
matching line. This option is incompatible with '--invert-match', 
'--and', '--not' and '--or'.

would be clearer

Best Wishes

Phillip


>   -l::
>   --files-with-matches::
>   --name-only::
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 5f32d2ce84..f9f516dfc4 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -829,6 +829,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>   			    GREP_PATTERN_TYPE_PCRE),
>   		OPT_GROUP(""),
>   		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
> +		OPT_BOOL(0, "column", &opt.columnnum, N_("show column number of first match")),
>   		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
>   		OPT_BIT('H', NULL, &opt.pathname, N_("show filenames"), 1),
>   		OPT_NEGBIT(0, "full-name", &opt.relative,
> @@ -1111,6 +1112,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>   		hit = grep_objects(&opt, &pathspec, the_repository, &list);
>   	}
>   
> +	if (opt.columnnum && opt.invert)
> +		die(_("--column and --invert-match cannot be combined"));
> +
>   	if (num_threads)
>   		hit |= wait_all();
>   	if (hit && show_in_pager)
> diff --git a/grep.c b/grep.c
> index f3fe416791..f4228c23ac 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -995,6 +995,9 @@ static void compile_grep_patterns_real(struct grep_opt *opt)
>   	else if (!opt->extended && !opt->debug)
>   		return;
>   
> +	if (opt->columnnum && opt->extended)
> +		die(_("--column and extended expressions cannot be combined"));
> +
>   	p = opt->pattern_list;
>   	if (p)
>   		opt->pattern_expression = compile_pattern_expr(&p);
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 1797f632a3..aa56b21ed9 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -99,6 +99,28 @@ do
>   		test_cmp expected actual
>   	'
>   
> +	test_expect_success "grep -w $L (with --column)" '
> +		{
> +			echo ${HC}file:5:foo mmap bar
> +			echo ${HC}file:14:foo_mmap bar mmap
> +			echo ${HC}file:5:foo mmap bar_mmap
> +			echo ${HC}file:14:foo_mmap bar mmap baz
> +		} >expected &&
> +		git grep --column -w -e mmap $H >actual &&
> +		test_cmp expected actual
> +	'
> +
> +	test_expect_success "grep -w $L (with --line-number, --column)" '
> +		{
> +			echo ${HC}file:1:5:foo mmap bar
> +			echo ${HC}file:3:14:foo_mmap bar mmap
> +			echo ${HC}file:4:5:foo mmap bar_mmap
> +			echo ${HC}file:5:14:foo_mmap bar mmap baz
> +		} >expected &&
> +		git grep -n --column -w -e mmap $H >actual &&
> +		test_cmp expected actual
> +	'
> +
>   	test_expect_success "grep -w $L" '
>   		{
>   			echo ${HC}file:1:foo mmap bar
> @@ -1590,4 +1612,14 @@ test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
>   	test_cmp expected actual
>   '
>   
> +test_expect_success 'grep does not allow --column, --invert-match' '
> +	test_must_fail git grep --column --invert-match pat 2>err &&
> +	test_i18ngrep "\-\-column and \-\-invert-match cannot be combined" err
> +'
> +
> +test_expect_success 'grep does not allow --column, extended' '
> +	test_must_fail git grep --column --not -e pat 2>err &&
> +	test_i18ngrep "\-\-column and extended expressions cannot be combined" err
> +'
> +
>   test_done
> 

