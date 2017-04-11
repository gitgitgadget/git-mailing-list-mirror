Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB7061FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbdDKKh6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:37:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:59808 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753837AbdDKKht (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:37:49 -0400
Received: (qmail 24369 invoked by uid 109); 11 Apr 2017 10:37:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 10:37:48 +0000
Received: (qmail 890 invoked by uid 111); 11 Apr 2017 10:38:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 06:38:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 06:37:46 -0400
Date:   Tue, 11 Apr 2017 06:37:46 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 11/12] grep: change the internal PCRE code & header names
 to be PCRE1
Message-ID: <20170411103746.bth3rof753gbjtjf@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com>
 <20170408132506.5415-12-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170408132506.5415-12-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 01:25:05PM +0000, Ævar Arnfjörð Bjarmason wrote:

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 9478ab5dff..dffb9743b8 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -490,7 +490,7 @@ static void compile_submodule_options(const struct grep_opt *opt,
>  	case GREP_PATTERN_TYPE_FIXED:
>  		argv_array_push(&submodule_options, "-F");
>  		break;
> -	case GREP_PATTERN_TYPE_PCRE:
> +	case GREP_PATTERN_TYPE_PCRE1:
>  		argv_array_push(&submodule_options, "-P");
>  		break;

Hmm. This isn't a problem yet, but wouldn't this need to pass some
pcre1-specific option instead of just "-P"?

-Peff
