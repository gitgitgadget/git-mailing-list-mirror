Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2ED20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 20:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdASUoe convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 19 Jan 2017 15:44:34 -0500
Received: from sauhun.de ([89.238.76.85]:49552 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751263AbdASUoc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 15:44:32 -0500
Received: from localhost (p54B33BE7.dip0.t-ipconnect.de [84.179.59.231])
        by pokefinder.org (Postfix) with ESMTPSA id D7EB231C0A6;
        Thu, 19 Jan 2017 21:43:45 +0100 (CET)
Date:   Thu, 19 Jan 2017 21:43:45 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC for GIT] pull-request: add praise to people doing QA
Message-ID: <20170119204343.xtotmjddhbum2mvr@ninjato>
References: <20170115183051.3565-1-wsa@the-dreams.de>
 <xmqqlgubc04z.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <xmqqlgubc04z.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> So the idea is to have list of those whose names appear on
> Reviewed-by: and Tested-by: collected and listed after the list of
> commit titles and author names.  I personally do not see much
> downsides in doing so, but I do not consume that many PRs myself, so
> let's hear from those who actually do process many of them.

Sadly, no further responses so far. Let's see if they will come if I
keep posting my pull requests with that information attached.

> As to the implementation, I am wondering if we can make this somehow
> work well with the "trailers" code we already have, instead of
> inventing yet another parser of trailers.  
> 
> In its current shape, "interpret-trailers" focuses on "editing" an
> existing commit log message to tweak the trailer lines.  That mode
> of operation would help amending and rebasing, and to do that it
> needs to parse the commit log message, identify trailer blocks,
> parse out each trailer lines, etc.  
> 
> There is no fundamental reason why its output must be an edited
> original commit log message---it should be usable as a filter that
> picks trailer lines of the selected trailer type, like "Tested-By",
> etc.

I didn't know about trailers before. As I undestand it, I could use
"Tested-by" as the key, and the commit subject as the value. This list
then could be parsed and brought into proper output shape. It would
simplify the subject parsing, but most things my AWK script currently
does would still need to stay or to be reimplemented (extracting names
from tags, creating arrays of tags given by $name). Am I correct?

All under the assumption that trailers work on a range of commits. I
have to admit that adding this to git is beyond my scope.

Thanks for looking into it,

   Wolfram

