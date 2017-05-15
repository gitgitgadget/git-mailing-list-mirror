Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C71BA201A4
	for <e@80x24.org>; Mon, 15 May 2017 06:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759327AbdEOGOI (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 02:14:08 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35423 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757167AbdEOGOH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 02:14:07 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so14550430pfd.2
        for <git@vger.kernel.org>; Sun, 14 May 2017 23:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=mJxgEqGkouHh/fd+1UgbHNyBzqfVT1oQb/s89UpyARk=;
        b=fI7H0lpQNog5V9q4QeN0fpmihVSsyzvlbPlpVdvQe1GSDWnQmom9GvKxHDirtmuX7d
         8w2/SLEZkKk5cdRGfjov91jqxnDBS+tpHUfnfAGw0F9pGf2JBwZ4pjG07ya3H6f+p6sS
         BxcMjO9jmyRvdXFoJAiBVu9FZiFfMm30dqLpdBfFuPym0Ez7tGSueR88d2ls/14DtR0Q
         EFd0grCEep4nfaVB/rbvuCnBlaaL8CdEnrnvhiVb9TsYksUOb/WCj71UWuGh+7VNLdhd
         hgXlb9W7CsXit/DPaxs9l2hllCTYXUPFzFIzqe8i2hN/yP1gJU+3V/p49iDfCvLf0ZPQ
         Ng7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=mJxgEqGkouHh/fd+1UgbHNyBzqfVT1oQb/s89UpyARk=;
        b=B6Tyrr4GR+7r+V0OeokcRNPnQQmOCcuZNfTwNdI8qjicEbdcDf/xc0WBU3SJCbAJ2n
         njkQ6U03QFG0fsMOFo0GRnQ9sK/k5dVtHCssOD+gg9FWK4ARH2ruOyf1hnuD9SF0eXQD
         Fk8BrYW/hl5faSKVtk8tvvnoe9EGSmZcOzi6Swis+l03uJDnb1qgsps38vwdxdMGymLa
         3VzqrcnzdKvAK8FDxAkvpmcScIDlqa6e3DBtnljp+F2YGgcaxmDNTMb6IVGZQCpvIRDf
         uC5s0onSiwYs1162dWaxs2xaNtSi1Nc1EV02hVNaj+uS/70gvsrGQklb6cQTSkXt7NGd
         Zmgw==
X-Gm-Message-State: AODbwcDtlcxFLoghB+BK1grmIcQnjoe5XVFmHQnZCGZTeYMMUqGiNujj
        w/zPTn10vT87xw==
X-Received: by 10.98.150.211 with SMTP id s80mr4494763pfk.15.1494828846523;
        Sun, 14 May 2017 23:14:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id p84sm17812462pfi.25.2017.05.14.23.14.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 23:14:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 20/29] grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
References: <20170513231509.7834-1-avarab@gmail.com>
        <20170513231509.7834-21-avarab@gmail.com>
Date:   Mon, 15 May 2017 15:14:03 +0900
In-Reply-To: <20170513231509.7834-21-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 13 May 2017 23:15:00 +0000")
Message-ID: <xmqqshk6ve8k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Remove redundant assignments to the "regflags" variable. There are no
> code paths that have previously set the regflags to anything, and
> certainly not to `|= REG_EXTENDED`.
>
> This code gave the impression that it had to reset its environment,
> but it doesn't. This dates back to the initial introduction of
> git-grep in commit 5010cb5fcc ("built-in "git grep"", 2006-04-30).

Back in 5010cb5fcc, we did do "opt.regflags &= ~REG_EXTENDED" upon
seeing "-G" on the command line and flipped the bit on upon seeing
"-E", but I think that was perfectly sensible and it would have been
a bug if we didn't.  They were part of the command line parsing that
could have seen "-E" on the command line earlier.

If we want to find a commit to assign blame to, I think it is more
correct to say that this came from the same one as 19/29 fixes.

When cca2c172 ("git-grep: do not die upon -F/-P when
grep.extendedRegexp is set.", 2011-05-09) switched the command line
parsing to "read into a 'tentatively this is what we saw the last'
variable and then finally commit just once", we didn't touch
opt.regflags for PCRE and FIXED, but we still had to flip regflags
between BRE and ERE, because parsing of grep.extendedregexp
configuration variable directly touched opt.regflags back then,
which was done by b22520a3 ("grep: allow -E and -n to be turned on
by default via configuration", 2011-03-30).  When 84befcd0 ("grep:
add a grep.patternType configuration setting", 2012-08-03)
introduced extended_regexp_option field, we stopped flipping
regflags while reading the configuration, and that was when we
should have noticed and stopped dropping REG_EXTENDED bit in the
"now we can commit what type to use" helper function.

In any case, I think this change is safe to do in the current
codebase.  I wonder if this and 19/29 should be a single patch,
though, as the unnecessary bit-flipping all are blamed to the same
origin.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  grep.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 59ae7809f2..bf6c2494fd 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -179,7 +179,6 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
>  	case GREP_PATTERN_TYPE_BRE:
>  		opt->fixed = 0;
>  		opt->pcre = 0;
> -		opt->regflags &= ~REG_EXTENDED;
>  		break;
>  
>  	case GREP_PATTERN_TYPE_ERE:
> @@ -191,7 +190,6 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
>  	case GREP_PATTERN_TYPE_FIXED:
>  		opt->fixed = 1;
>  		opt->pcre = 0;
> -		opt->regflags &= ~REG_EXTENDED;
>  		break;
>  
>  	case GREP_PATTERN_TYPE_PCRE:
> @@ -414,10 +412,9 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  	int err;
> -	int regflags;
> +	int regflags = opt->regflags;
>  
>  	basic_regex_quote_buf(&sb, p->pattern);
> -	regflags = opt->regflags & ~REG_EXTENDED;
>  	if (opt->ignore_case)
>  		regflags |= REG_ICASE;
>  	err = regcomp(&p->regexp, sb.buf, regflags);
