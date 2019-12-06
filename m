Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1605DC43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 02:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51C320706
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 02:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfLFCkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 21:40:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:39880 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726174AbfLFCkv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 21:40:51 -0500
Received: (qmail 14883 invoked by uid 109); 6 Dec 2019 02:40:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Dec 2019 02:40:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23996 invoked by uid 111); 6 Dec 2019 02:45:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Dec 2019 21:45:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Dec 2019 21:40:50 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?5ZC05L6D?= <kan.wu@genetalks.com>
Cc:     gitster <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: How to redirect git std input in Python?
Message-ID: <20191206024050.GA1223222@coredump.intra.peff.net>
References: <f3b45643-6ca5-4f7f-aec2-8438d1451629.kan.wu@genetalks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3b45643-6ca5-4f7f-aec2-8438d1451629.kan.wu@genetalks.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 06, 2019 at 09:34:30AM +0800, 吴侃 wrote:

> To: gitster <gitster@pobox.com>, peff <peff@peff.net>

Please send questions to the public mailing list at git@vger.kernel.org.
Then more people will see your question, and everyone will benefit from
seeing the answer.

> I want to develop a git plugin in a Python IDE.when i clone a private
> git project,it needs to input username and passward in terminal.
> [...]
> so i want to redirect the username or password input to a dialog use
> Python in my plugin.

Look into either the GIT_ASKPASS environment variable described in "git
help git", or if you want something a little nicer, the credential
subsystem (described in https://git-scm.com/docs/gitcredentials, but
especially the "custom helpers" part at the end).

-Peff
