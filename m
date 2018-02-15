Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54641F404
	for <e@80x24.org>; Thu, 15 Feb 2018 06:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754785AbeBOGAf (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 01:00:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:53460 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752423AbeBOGAf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 01:00:35 -0500
Received: (qmail 3014 invoked by uid 109); 15 Feb 2018 06:00:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 06:00:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7557 invoked by uid 111); 15 Feb 2018 06:01:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 01:01:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 01:00:33 -0500
Date:   Thu, 15 Feb 2018 01:00:33 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 23/23] cat-file: update of docs
Message-ID: <20180215060033.GR18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4391-9f76231a-4768-461b-80b9-02cada27a943-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020161890f4391-9f76231a-4768-461b-80b9-02cada27a943-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:

> Update the docs for cat-file command. Some new formatting atoms added
> because of reusing ref-filter code.
> We do not support cat-file atoms in general formatting logic
> (there is just the support for cat-file), that is why some of the atoms
> are still explained in cat-file docs.
> We need to move these explanations when atoms will be supported
> by other commands.

OK, so I've read through the whole series now. I still think it really
needs some squashing in the middle to turn into a more comprehensible
series.

And I think by the end we need to address the atoms here that don't work
in ref-filter. We certainly want them to work in the long term, and the
fact that they don't is I think pointing to having the wrong
architecture here in the intermediate step. We should just have a single
set of placeholders, with no special "cat_file_data". If I understand
correctly, that's what's causing those atoms not to work in
for-each-ref.

-Peff
