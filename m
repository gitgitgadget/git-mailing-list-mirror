Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DA7C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F2D61A8D
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhKQDDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 22:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhKQDDe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 22:03:34 -0500
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21BDC061746
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 19:00:36 -0800 (PST)
Received: from [2400:4160:1877:2b00:29f9:f15d:e50b:8944] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnBBa-005WU7-7J; Wed, 17 Nov 2021 03:00:34 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnBBW-009hMX-9F; Wed, 17 Nov 2021 12:00:30 +0900
Date:   Wed, 17 Nov 2021 12:00:30 +0900
From:   Mike Hommey <mh@glandium.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 21/23] Makefile: disable GNU make built-in wildcard
 rules
Message-ID: <20211117030030.nru2ntuxk63lhwqx@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
 <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
 <patch-v3-21.23-cb3ae5ce00b-20211116T114334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-21.23-cb3ae5ce00b-20211116T114334Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 01:00:21PM +0100, Ævar Arnfjörð Bjarmason wrote:
> +### Remove GNU make implicit rules
> +
> +## This speeds things up since we don't need to look for and stat() a
> +## "foo.c,v" every time a rule referring to "foo.c" is in play. See
> +## "make -p -f/dev/null | grep ^%::'".
> +%:: %,v
> +%:: RCS/%,v
> +%:: RCS/%
> +%:: s.%
> +%:: SCCS/s.%

`MAKEFLAGS += -r` should have the same effect (and more)
