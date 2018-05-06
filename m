Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D7662023D
	for <e@80x24.org>; Sun,  6 May 2018 17:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbeEFRnq (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 13:43:46 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:20712 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeEFRnp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 13:43:45 -0400
Received: from [192.168.2.201] ([92.22.23.119])
        by smtp.talktalk.net with SMTP
        id FNhFfh1BM51uyFNhFf76eW; Sun, 06 May 2018 18:43:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1525628623;
        bh=74zzyP7AovMQbPIEgnaxQBZjmjD5cRqbCFZ7Zp6APWw=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NP170qKdgFmLJcsl6/1OBZGV3WodXKEUlSA2teGAyKUTqqoD9ApfYt4d2OkJtDWQg
         tpn0vdh6ewxD5x1auD/fVDpyR28JwtO0Ajsk0blbiRCZQquEoq6WjytBckZrwjdQqm
         YIHU0QNv2Z6xMt9W5Oj5b/bjmPLACv2f3aXLlA+g=
X-Originating-IP: [92.22.23.119]
X-Spam: 0
X-OAuthority: v=2.3 cv=d9PbNyrE c=1 sm=1 tr=0 a=oWXjcmuSLv9+fGSLdn2kqg==:117
 a=oWXjcmuSLv9+fGSLdn2kqg==:17 a=IkcTkHD0fZMA:10 a=3nsOOYR-AAAA:8
 a=lTYt-KdAu6lZn_4B6A8A:9 a=RvFzwDBRKJjarF9_:21 a=bqPO4bYPWI0Gld9X:21
 a=QEXdDO2ut3YA:10 a=X8_4EP2Luv2hi8NvPz5g:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 5/7] builtin/grep.c: add '--column' option to
 'git-grep(1)'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
References: <20180421034530.GB24606@syl.local>
 <cover.1525488108.git.me@ttaylorr.com>
 <9a596d53d6b2523bc94e58678aa43e68068859b6.1525488108.git.me@ttaylorr.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <20bc9baf-a85e-f00e-859e-e796ab4324f6@talktalk.net>
Date:   Sun, 6 May 2018 18:43:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9a596d53d6b2523bc94e58678aa43e68068859b6.1525488108.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIxZTAtTNb7HeRnpcSUbTy6RvxcwmAhcQmomHXe/ZKVLsJdIGhuTEGUBbTQsQPoS3NvRZJJPmkISSqSb+nMxrv1QHLpNzSlJPSH8PDta+A9yiO4DnBWG
 9HLKj7Ew4O5CqMU1aCJks3nUgsz5z3hLQ2EoNHluYVWWFndKWRuUHSvpUo7ETkRQe9nOgEI1CSgvj9Yjoj6g6pODJAr/dvj6WMbdFsVYG+oPVuhTZHsyfgkF
 jfVrB1Fw5kJFw5lMDI9dKTo1yv1AcLKdG4903sMWz3KHeCOv0PhUCe6Q3D51A9kDuEjT4NYXqE/Wxj0+KSIBYybBsuoiaM+7SB2fT5c+6v5qGsOdRTkvX00X
 PdRBEb2LsaAhmkD8EWrSh18mwn/eeg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor

On 05/05/18 03:43, Taylor Blau wrote:
> 
> Teach 'git-grep(1)' a new option, '--column', to show the column
> number of the first match on a non-context line.
> 
> For example:
> 
>   $ git grep -n --column foo | head -n3
>   .clang-format:51:14:# myFunction(foo, bar, baz);
>   .clang-format:64:7:# int foo();
>   .clang-format:75:8:# void foo()
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-grep.txt |  5 ++++-
>  builtin/grep.c             |  1 +
>  t/t7810-grep.sh            | 22 ++++++++++++++++++++++
>  3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 18b494731f..5409a24399 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  	   [-v | --invert-match] [-h|-H] [--full-name]
>  	   [-E | --extended-regexp] [-G | --basic-regexp]
>  	   [-P | --perl-regexp]
> -	   [-F | --fixed-strings] [-n | --line-number]
> +	   [-F | --fixed-strings] [-n | --line-number] [--column]
>  	   [-l | --files-with-matches] [-L | --files-without-match]
>  	   [(-O | --open-files-in-pager) [<pager>]]
>  	   [-z | --null]
> @@ -169,6 +169,9 @@ providing this option will cause it to die.
>  --line-number::
>  	Prefix the line number to matching lines.
>  
> +--column::
> +	Prefix the 1-indexed column number of the first match on non-context lines.
> +

I think it would be useful to explain what the column number actually is
so that users know how to consume it. Is it a count of bytes, multi-byte
characters or graphemes? It would probably be worth testing with a file
that contains multi-byte characters to check for future regressions.

Best Wishes

Phillip

>  -l::
>  --files-with-matches::
>  --name-only::
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 5f32d2ce84..5c83f17759 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -829,6 +829,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  			    GREP_PATTERN_TYPE_PCRE),
>  		OPT_GROUP(""),
>  		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
> +		OPT_BOOL(0, "column", &opt.columnnum, N_("show column number of first match")),
>  		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
>  		OPT_BIT('H', NULL, &opt.pathname, N_("show filenames"), 1),
>  		OPT_NEGBIT(0, "full-name", &opt.relative,
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 1797f632a3..a03c3416e7 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -99,6 +99,28 @@ do
>  		test_cmp expected actual
>  	'
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
> +	test_expect_success "grep -w $L (with --{line,column}-number)" '
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
>  	test_expect_success "grep -w $L" '
>  		{
>  			echo ${HC}file:1:foo mmap bar
> 

