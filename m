Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACBEC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 14:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C7A61206
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 14:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhIKOry (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 10:47:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:44902 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhIKOry (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 10:47:54 -0400
Received: (qmail 12455 invoked by uid 109); 11 Sep 2021 14:46:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Sep 2021 14:46:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20796 invoked by uid 111); 11 Sep 2021 14:46:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Sep 2021 10:46:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 11 Sep 2021 10:46:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH v3 0/9] post-v2.33 "drop support for ancient curl"
 follow-up
Message-ID: <YTzBUFY4p6obEqF+@coredump.intra.peff.net>
References: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
 <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 11:34:14AM +0200, Ævar Arnfjörð Bjarmason wrote:

> This has relatively minor changes against v2. This addresses Jeff
> King's comments about the INSTALL phrasing, I split up the more
> general improvements into another commit.
> 
> The CURL_SOCKOPT_OK is now defined in terms of LIBCURL_VERSION_NUM
> like everything else.

Thanks, this version looks good to me.

Probably not worth a re-roll, but maybe worth fixing up while applying:

>  2:  4b653cee2d3 !  3:  dce6520a5c9 INSTALL: mention that we need libcurl 7.19.4 or newer to build
>     @@ Commit message
>      
>       ## INSTALL ##
>      @@ INSTALL: Issues of note:
>     - 	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
>     - 	  the curl version >= 7.34.0, for git-imap-send.
>     + 	  not need that functionality, use NO_CURL to build without
>     + 	  it.
>       
>     -+	  Git version "7.19.4" of "libcurl" or later to build. This
>     -+	  version requirement may be bumped in the future.
>     ++	  Git requires version "7.19.4" or later of "libcurl", to
>     ++	  build (without NO_CURL). This version requirement may be
>     ++	  bumped in the future.

The comma after libcurl (before "to build") is extraneous (and IMHO
makes the sentence harder to read).

-Peff
