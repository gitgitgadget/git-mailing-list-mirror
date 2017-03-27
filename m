Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A8FB20958
	for <e@80x24.org>; Mon, 27 Mar 2017 02:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbdC0CyU (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 22:54:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:52188 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751811AbdC0CyT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 22:54:19 -0400
Received: (qmail 4172 invoked by uid 109); 27 Mar 2017 02:53:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Mar 2017 02:53:50 +0000
Received: (qmail 27042 invoked by uid 111); 27 Mar 2017 02:54:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Mar 2017 22:54:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Mar 2017 22:53:47 -0400
Date:   Sun, 26 Mar 2017 22:53:47 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/3] rev-parse: add @{p} as a synonym for @{push}
Message-ID: <20170327025346.cwig3ulmyqcgqx7n@sigill.intra.peff.net>
References: <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>
 <20170326121654.22035-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170326121654.22035-3-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 26, 2017 at 12:16:53PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Add @{p} as a shorthand for @{push} for consistency with the @{u}
> shorthand for @{upstream}.
> 
> This wasn't added when @{push} was introduced in commit
> adfe5d0434 ("sha1_name: implement @{push} shorthand", 2015-05-21), but
> it can be added without any ambiguity and saves the user some typing.

It _can_ be added, but it was intentionally avoided at the time because
there was discussion of adding other p-words, including:

  - @{pull} as a synonym for @{upstream} (and to better match @{push})

  - @{publish}, which was some similar-ish system that was based on
    per-branch config, but the patches were never merged.

It's been a few years with neither of those things happening, so in a
sense it may be safe to add it now. OTOH, if users are not clamoring for
@{p} and it is just being added "because we can", maybe that is not a
good reason.

> -'<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
> -  The suffix '@\{push}' reports the branch "where we would push to" if
> +'<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{p\}'::
> +  The suffix '@\{push}' (short form '@\{push}') reports the branch "where we would push to" if

Did you mean to say "short form '@\{p}'"?

-Peff
