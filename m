Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2860AC7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 04:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjDFD76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 23:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjDFD75 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 23:59:57 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E539769
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 20:59:54 -0700 (PDT)
Received: (qmail 12099 invoked by uid 109); 6 Apr 2023 03:59:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Apr 2023 03:59:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22011 invoked by uid 111); 6 Apr 2023 03:59:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Apr 2023 23:59:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Apr 2023 23:59:53 -0400
From:   Jeff King <peff@peff.net>
To:     Eugen Konkov <kes-kes@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Can see log for a renamed file
Message-ID: <20230406035953.GB2092667@coredump.intra.peff.net>
References: <909508822.20230405191602@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <909508822.20230405191602@yandex.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2023 at 07:16:02PM -0400, Eugen Konkov wrote:

> Hello, folks.
> 
> ```
> git log 9ce3e165f284d55503eff9b627ef3723854c53bb^ -- lib/Invoice/Schema/Result/Company.pm
> fatal: ambiguous argument 'lib/Invoice/Schema/Result/Company.pm': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> ```

Are you sure you've cut and paste accurately here? You _do_ have a "--"
in the command you showed, so it should not print the "ambiguous
argument" error. It should behave exactly as you're expecting (accepting
the path as-is).

If that is what you typed, then something very funny is going on in your
Git build, where it is ignoring some arguments. Is "git" a wrapper
script or something?

-Peff
