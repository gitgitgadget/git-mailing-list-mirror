Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD80200B9
	for <e@80x24.org>; Tue,  8 May 2018 00:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753338AbeEHAJH (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 20:09:07 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:36251 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753416AbeEHAI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 20:08:56 -0400
Received: by mail-pl0-f44.google.com with SMTP id v24-v6so1095200plo.3
        for <git@vger.kernel.org>; Mon, 07 May 2018 17:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OPOqlMMgswfHKUeXvy5TrrU8luFBqOKigk+ZTROdJbo=;
        b=0LIirL2TpwT8LfJSt94i204B4Q7KWNU2jvaHE/v5jC/lvaz169N9TNK3n8cYL2fiTn
         hSYOIAybAadWxGEOssYOO0+wrN0wCZLsxMnqZV0msnX2pMX+4sQOqPWwy3oPZQSr6T7P
         f4ynRAFgoTowVN80CYrgMnnTCH1Si0vtnMjkMQY+x4ynEVfwC9nGuoAkgmph+vRr9i78
         H1T8Kl43nXnNjl8lqElqYxr24QNUthFYA1hXHXIKUdwOR9cdhY6dLRVGMLKs1XFBJWFD
         zRiocIm2XX1ErllOlAhVElh0m2BxRX8biQP5OoDZ96ySHSSh3W2OM8M38MNVziT0T50g
         3E1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OPOqlMMgswfHKUeXvy5TrrU8luFBqOKigk+ZTROdJbo=;
        b=tMLybRHG+J+QUG0hQ7rpgxswmQsrKpwWG/WpLWfHA3Fe/DEN6Fy3LfTBCwmb3OEDj0
         jDhVxG4U5e0ImuqvgYJdOwlyyLYOFwpsfl4Zq4j9ociaoEs1oAjJYmN2VyezkUOEbar/
         naRo9ce9TXYwwcJ5oAqkYNSsujZTiocgZYBiLObrDoSta1O+mAICbu7mCrZkjeHtV3EM
         CfoAG82VykoXhBobsyz27uBGpk7Nsudqc6BGzf4HfB5ctXnkFpI/if9/X+5KIxLmqgu3
         NRx334pFCK7oT222dXcs+RNhDllvi8fBzNeeWFgpU8nrYOPWBKZP41D3tX+/H3sDiZV/
         U2OA==
X-Gm-Message-State: ALQs6tCmSwV7YRIfdYf7DzQgHkIhnRv94FY3e5+F2ppIeD6EFsMU3oLM
        xkJQR9x9+jgSijts190TLFNMmQ==
X-Google-Smtp-Source: AB8JxZq/rtUVJsRORr+WL2kz4wsSXmWKmZtJjm5wEj6nKQCgOkNyGZheqvqQO/1h/Io+zGK2MYEPAQ==
X-Received: by 2002:a17:902:44c:: with SMTP id 70-v6mr38768218ple.354.1525738135467;
        Mon, 07 May 2018 17:08:55 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e0dd:ed95:919f:45e6])
        by smtp.gmail.com with ESMTPSA id d72sm33789145pfe.150.2018.05.07.17.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 17:08:54 -0700 (PDT)
Date:   Mon, 7 May 2018 17:08:53 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: Re: [PATCH v4 5/7] builtin/grep.c: add '--column' option to
 'git-grep(1)'
Message-ID: <20180508000853.GD77370@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1525488108.git.me@ttaylorr.com>
 <9a596d53d6b2523bc94e58678aa43e68068859b6.1525488108.git.me@ttaylorr.com>
 <xmqqk1sfpn9j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk1sfpn9j.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 07, 2018 at 11:13:12PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> > index 18b494731f..5409a24399 100644
> > --- a/Documentation/git-grep.txt
> > +++ b/Documentation/git-grep.txt
> > @@ -13,7 +13,7 @@ SYNOPSIS
> >  	   [-v | --invert-match] [-h|-H] [--full-name]
> >  	   [-E | --extended-regexp] [-G | --basic-regexp]
> >  	   [-P | --perl-regexp]
> > -	   [-F | --fixed-strings] [-n | --line-number]
> > +	   [-F | --fixed-strings] [-n | --line-number] [--column]
> >  	   [-l | --files-with-matches] [-L | --files-without-match]
> >  	   [(-O | --open-files-in-pager) [<pager>]]
> >  	   [-z | --null]
> > @@ -169,6 +169,9 @@ providing this option will cause it to die.
> >  --line-number::
> >  	Prefix the line number to matching lines.
> >
> > +--column::
> > +	Prefix the 1-indexed column number of the first match on non-context lines.
> > +
>
> Two questions.
>
>  - It is fine that the leftmost column is 1, but what does this
>    number count?  The number of bytes on the same line before the
>    first byte of the hit (plus 1)?  The display width of the initial
>    non-matching part of the line (plus 1) on a fixed-width terminal?
>    The number of "characters"?  Something else?

The count is the byte offset from the 1-index (which is the beginning of
the line, as you noted).

Incidentally, Peff and I chatted briefly offline about this, and agree
that it makes the most sense, since (1) Vim treats it correctly, and (2)
we can't be sure of options like display width, character count, etc.,
without knowing the character encoding.

Nonetheless, other folks in this thread seem to be curious about this
as well. I'll add it to the documentation for --column in
Documentation/git-grep.txt.

>  - Does --column combined with -v make any sense?  If not, shouldn't
>    the command error out when both are given at the same time?

I hadn't thought of this. They do not work together, since 'git grep -v
--column' would require us to either (1) not output the column number,
or (2) output '0', or some other non-value.

I think that both (1) and (2) require callers to complicate their
scripts to understand either approach. As such, I think that we should
die() here, and add a test in t7810 to ensure that that's indeed what
happens.

Does this seem sensible to include in v5?


Thanks,
Taylor
