Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F0901FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbdDKKO0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:14:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:59742 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752046AbdDKKOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:14:16 -0400
Received: (qmail 21910 invoked by uid 109); 11 Apr 2017 10:14:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 10:14:15 +0000
Received: (qmail 391 invoked by uid 111); 11 Apr 2017 10:14:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 06:14:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 06:14:13 -0400
Date:   Tue, 11 Apr 2017 06:14:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/12] Makefile & configure: reword outdated comment
 about PCRE
Message-ID: <20170411101412.jjzdscnirh5yerbn@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com>
 <20170408132506.5415-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170408132506.5415-4-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 01:24:57PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Reword an outdated comment which suggests that only git-grep can use
> PCRE.

Makes sense.

> -# Define USE_LIBPCRE if you have and want to use libpcre. git-grep will be
> -# able to use Perl-compatible regular expressions.
> +# Define USE_LIBPCRE if you have and want to use libpcre. Various
> +# commands such as like log, grep offer runtime options to use
> +# Perl-compatible regular expressions instead of standard or extended
> +# POSIX regular expressions.

s/such as like log, grep/such as log and grep/ ?

> diff --git a/configure.ac b/configure.ac
> [...]
> -# Define USE_LIBPCRE if you have and want to use libpcre. git-grep will be
> -# able to use Perl-compatible regular expressions.
> +# Define USE_LIBPCRE if you have and want to use libpcre. Various
> +# commands such as like log, grep offer runtime options to use
> +# Perl-compatible regular expressions instead of standard or extended
> +# POSIX regular expressions.

Ditto.

> @@ -499,8 +501,10 @@ GIT_CONF_SUBST([NEEDS_SSL_WITH_CRYPTO])
>  GIT_CONF_SUBST([NO_OPENSSL])
>  
>  #
> -# Define USE_LIBPCRE if you have and want to use libpcre. git-grep will be
> -# able to use Perl-compatible regular expressions.
> +# Define USE_LIBPCRE if you have and want to use libpcre. Various
> +# commands such as like log, grep offer runtime options to use
> +# Perl-compatible regular expressions instead of standard or extended
> +# POSIX regular expressions.

And again. It's weird that the text appears twice in configure.ac.
Apparently you can use --with-libpcre or USE_LIBPCRE in the environment?
Configure is weird.

-Peff
