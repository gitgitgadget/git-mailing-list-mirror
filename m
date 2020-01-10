Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2E7C33CA2
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 11:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85EF20838
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 11:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgAJLzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:55:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:33522 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728279AbgAJLzH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 06:55:07 -0500
Received: (qmail 4585 invoked by uid 109); 10 Jan 2020 11:55:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Jan 2020 11:55:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25302 invoked by uid 111); 10 Jan 2020 12:00:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Jan 2020 07:00:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Jan 2020 06:55:05 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v2 1/4] config: fix typo in variable name
Message-ID: <20200110115505.GA979160@coredump.intra.peff.net>
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
 <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
 <b40480f03a5643761bd06d4b9c495a99b98a1ac8.1578565001.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b40480f03a5643761bd06d4b9c495a99b98a1ac8.1578565001.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 09, 2020 at 10:16:38AM +0000, Matthew Rogers via GitGitGadget wrote:

> -	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
> +	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),

The user-facing option is still spelled "null". Obviously we can't just
change that, but if we are trying to prefer "nul", should we offer both?

I think we actually _do_ allow "--nul" because of parse-option's
willingness to accept a partial name. But if we wanted to advertise one
over the other in "-h", then we'd have to set up the alias ourselves.

Interestingly, "xargs" (and GNU grep) spells it as "--null", so perhaps
that's an argument to keep it as-is. Likewise if we accept that "null
termination" is a correct name, I suppose.

-Peff
