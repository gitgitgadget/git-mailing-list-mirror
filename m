Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D15C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 01:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B63382083E
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 01:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbgGaBDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:03:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:43228 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgGaBDI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 21:03:08 -0400
Received: (qmail 17808 invoked by uid 109); 31 Jul 2020 01:03:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 01:03:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22844 invoked by uid 111); 31 Jul 2020 01:03:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jul 2020 21:03:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jul 2020 21:03:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2020, #06; Thu, 30)
Message-ID: <20200731010307.GE240563@coredump.intra.peff.net>
References: <xmqqo8nw5zwn.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8nw5zwn.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 30, 2020 at 04:47:04PM -0700, Junio C Hamano wrote:

> * jk/strvec (2020-07-28) 11 commits
>  - strvec: rename struct fields
>  - strvec: drop argv_array compatibility layer
>  - strvec: update documention to avoid argv_array
>  - strvec: fix indentation in renamed calls
>  - strvec: convert remaining callers away from argv_array name
>  - strvec: convert more callers away from argv_array name
>  - strvec: convert builtin/ callers away from argv_array name
>  - quote: rename sq_dequote_to_argv_array to mention strvec
>  - strvec: rename files from argv-array to strvec
>  - argv-array: rename to strvec
>  - argv-array: use size_t for count and alloc
> 
>  The argv_array API is useful for not just managing argv but any
>  "vector" (NULL-terminated array) of strings, and has seen adoption
>  to a certain degree.  It has been renamed to "strvec" to reduce the
>  barrier to adoption.
> 
>  Will merge to 'next'.

Do we want to do the s/items/v/ thing before it gets merged to next? I
already posted a replacement top patch in the thread:

  https://lore.kernel.org/git/20200729003720.GA1653374@coredump.intra.peff.net/

and I don't think anything else needed a re-roll.

-Peff
