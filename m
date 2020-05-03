Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5355FC28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 06:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE172073E
	for <git@archiver.kernel.org>; Sun,  3 May 2020 06:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgECG63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 02:58:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:34960 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726974AbgECG62 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 02:58:28 -0400
Received: (qmail 19413 invoked by uid 109); 3 May 2020 06:58:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 May 2020 06:58:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4412 invoked by uid 111); 3 May 2020 06:58:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 03 May 2020 02:58:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 3 May 2020 02:58:26 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [RFC PATCH] credential: minor documentation fixes
Message-ID: <20200503065826.GB1829906@coredump.intra.peff.net>
References: <20200503063423.83152-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200503063423.83152-1-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 02, 2020 at 11:34:23PM -0700, Carlo Marcelo Arenas Belón wrote:

> c44088ecc4 (credential: treat URL without scheme as invalid, 2020-04-18)
> changes the implementation for creential_from_url_gently to retun -1 if
> protocol is missing, but didn't update this blurb.

Yeah, this makes sense. s/creential/credential/.

> the order of parameters used in credential_match was inconsistent
> between credential.c and credential.h as well, so update both to
> match the current implementation.

Yes, looks like this has been wrong since the beginning in 118250728e
(credential: apply helper config, 2011-12-10). I checked the callers to
make sure none of them had gotten it backwards, but they all look right
(and just the declaration is wrong).

-Peff
