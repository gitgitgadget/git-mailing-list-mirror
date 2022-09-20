Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A559C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 19:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiITTHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiITTHO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 15:07:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AAF75493
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 12:07:12 -0700 (PDT)
Received: (qmail 30699 invoked by uid 109); 20 Sep 2022 19:07:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Sep 2022 19:07:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13715 invoked by uid 111); 20 Sep 2022 19:07:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Sep 2022 15:07:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Sep 2022 15:07:10 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] gc: don't translate literal commands
Message-ID: <YyoPXmNGAvl6p+C2@coredump.intra.peff.net>
References: <20220920050725.326383-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920050725.326383-1-alexhenrie24@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2022 at 11:07:25PM -0600, Alex Henrie wrote:

> These commands have no placeholders to be translated.

I think this is the right thing to do, but your commit message made me
pause for a second. When you say "placeholders", I think you mean %s,
etc. And yes there aren't any here, but that is not the reason not to
translate. The reason not to translate is that the strings are commands
which are given to a machine.

So maybe something like:

  There are no human-readable parts of these strings; the command you
  type is still "git maintenance" even in other languages.

Regardless, the patch looks good to me. Thanks for catching it.

-Peff
