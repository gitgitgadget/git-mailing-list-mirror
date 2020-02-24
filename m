Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DB5C11D2F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD3020838
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBXSXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:23:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:52864 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727426AbgBXSXx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 13:23:53 -0500
Received: (qmail 8608 invoked by uid 109); 24 Feb 2020 18:23:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 18:23:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11781 invoked by uid 111); 24 Feb 2020 18:32:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Feb 2020 13:32:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Feb 2020 13:23:51 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 01/10] nth_packed_object_oid(): use customary integer
 return
Message-ID: <20200224182351.GA2182592@coredump.intra.peff.net>
References: <20200224042625.GA1015553@coredump.intra.peff.net>
 <20200224042736.GA1018190@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224042736.GA1018190@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 23, 2020 at 11:27:37PM -0500, Jeff King wrote:

> Since we are changing the interface in a subtle way that the compiler
> wouldn't catch, let's also change the name to catch any topics in
> flight. We can drop the 'o' and make it nth_packed_object_id(). That's
> slightly shorter, but also less redundant since the 'o' stands for
> "object" already.

Note that this does catch one topic that's in next:
jk/object-filter-with-bitmap. Since the newly added call there doesn't
check the return value, it just needs s/oid/id/ in the function name.

-Peff
