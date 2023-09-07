Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCC2EC874B
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 18:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbjIGS6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239251AbjIGS6f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 14:58:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99496A8
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 11:58:30 -0700 (PDT)
Received: (qmail 26974 invoked by uid 109); 7 Sep 2023 07:51:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Sep 2023 07:51:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24340 invoked by uid 111); 7 Sep 2023 07:51:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Sep 2023 03:51:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Sep 2023 03:51:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2023, #02; Tue, 5)
Message-ID: <20230907075148.GB1260471@coredump.intra.peff.net>
References: <xmqqtts8nl67.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtts8nl67.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2023 at 06:29:52PM -0700, Junio C Hamano wrote:

> * jk/ci-retire-allow-ref (2023-08-30) 2 commits
>   (merged to 'next' on 2023-08-31 at 5fe4861f16)
>  + ci: deprecate ci/config/allow-ref script
>  + ci: allow branch selection through "vars"
> 
>  CI update.
> 
>  Will merge to 'master'.
>  source: <20230830194919.GA1709446@coredump.intra.peff.net>

I think we should pause on this one. While I am excited to see it master
(since after all it really does nothing until branches actually
incorporate it), the comments from Phillip and Johannes make me think we
may be better off re-designing it as a JSON-formatted CI_CONFIG
variable.

I don't think we'd have to care about backwards compatibility with
CI_BRANCHES that made it into master, since our target audience is Git
developers. But it's nicer not to litter failed experiments into the
history.

I'll see if I can work up a CI_CONFIG patch to replace it, but in the
meantime let's not advance the topic any further.

-Peff
