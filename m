Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D13C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 02:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C2961507
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 02:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhKQCFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 21:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKQCFF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 21:05:05 -0500
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7058EC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 18:02:07 -0800 (PST)
Received: from [2400:4160:1877:2b00:29f9:f15d:e50b:8944] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnAGw-005Pad-CL; Wed, 17 Nov 2021 02:02:02 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnAGs-009gpQ-PO; Wed, 17 Nov 2021 11:01:58 +0900
Date:   Wed, 17 Nov 2021 11:01:58 +0900
From:   Mike Hommey <mh@glandium.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 05/23] Makefile: remove "mv $@ $@+" dance redundant to
 .DELETE_ON_ERROR
Message-ID: <20211117020158.4p3iwlrdf2v4nc55@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
 <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
 <patch-v3-05.23-e38c90ad0b6-20211116T114334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-05.23-e38c90ad0b6-20211116T114334Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 01:00:05PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Since 7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR" flag,
> 2021-06-29) we don't need to guard the clobbering of $@ with this sort
> of "mv $@+ $@" pattern in these cases where we're merely generating a
> file that'll be used as a dependency for other files, as in this case
> for GIT-PERL-HEADER.

.DELETE_ON_ERROR is, as far as I know, a GNUism. Does building git require
the use of GNU make?

Mike
