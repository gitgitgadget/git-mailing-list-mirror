Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 363E61F51C
	for <e@80x24.org>; Fri, 18 May 2018 04:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750788AbeEREAJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 00:00:09 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:59091 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeEREAI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 00:00:08 -0400
Received: from localhost (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Fri, 18 May 2018 06:00:22 +0200
  id 00000000000000A6.000000005AFE4FD6.00001100
Date:   Fri, 18 May 2018 06:00:06 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH 6/8] diff.c: decouple white space treatment from move
 detection algorithm
Message-ID: <20180518040006.GA31451@ruderich.org>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
 <20180517194653.48928-1-sbeller@google.com>
 <20180517194653.48928-7-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20180517194653.48928-7-sbeller@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 17, 2018 at 12:46:51PM -0700, Stefan Beller wrote:
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index bb9f1b7cd82..7b2527b9a19 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -292,6 +292,19 @@ dimmed_zebra::
>  	blocks are considered interesting, the rest is uninteresting.
>  --
>
> +--color-moved-[no-]ignore-space-at-eol::
> +	Ignore changes in whitespace at EOL when performing the move
> +	detection for --color-moved.
> +--color-moved-[no-]ignore-space-change::
> +	Ignore changes in amount of whitespace when performing the move
> +	detection for --color-moved.  This ignores whitespace
> +	at line end, and considers all other sequences of one or
> +	more whitespace characters to be equivalent.
> +--color-moved-[no-]ignore-all-space::
> +	Ignore whitespace when comparing lines when performing the move
> +	detection for --color-moved.  This ignores differences even if
> +	one line has whitespace where the other line has none.
> +
>  --word-diff[=<mode>]::
>  	Show a word diff, using the <mode> to delimit changed words.
>  	By default, words are delimited by whitespace; see

Hello,

I think it would be better to specify the options unabbreviated.
Not being able to search the man page for
"--color-moved-ignore-space-at-eol" or
"--color-moved-no-ignore-space-at-eol" can be a major pain when
looking for documentation. So maybe something like this instead:

> +--color-moved-ignore-space-at-eol::
> +--color-moved-no-ignore-space-at-eol::
> +	Ignore changes in whitespace at EOL when performing the move
> +	detection for --color-moved.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
