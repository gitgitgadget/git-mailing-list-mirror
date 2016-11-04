Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B594E203C1
	for <e@80x24.org>; Fri,  4 Nov 2016 16:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932389AbcKDQww (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 12:52:52 -0400
Received: from sym2.noone.org ([178.63.92.236]:37007 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755624AbcKDQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 12:52:50 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Nov 2016 12:52:49 EDT
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 3t9SZ80YBSzQWdN; Fri,  4 Nov 2016 17:52:45 +0100 (CET)
Date:   Fri, 4 Nov 2016 17:52:43 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] branch: remove unused parameter to create_branch()
Message-ID: <20161104165236.GC819@distanz.ch>
References: <20161104151949.13384-1-tklauser@distanz.ch>
 <20161104163012.5r3uivnub3bdkqgr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161104163012.5r3uivnub3bdkqgr@sigill.intra.peff.net>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-11-04 at 17:30:12 +0100, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 04, 2016 at 04:19:49PM +0100, Tobias Klauser wrote:
> 
> > The name parameter to create_branch() has been unused since commit
> > 55c4a673070f ("Prevent force-updating of the current branch"). Remove
> > the parameter and adjust the callers accordingly. Also remove the
> > parameter from the function's documentation comment.
> 
> This seemed eerily familiar, and it turns out I wrote this as a
> preparatory step for a different topic a while back, but never finished
> it.
> 
> So clearly a good change, though we might want to explain a bit more why
> it's correct that the parameter is unused. Here's what I wrote:
> 
>   This function used to have the caller pass in the current value of
>   HEAD, in order to make sure we didn't clobber HEAD.  In 55c4a6730,
>   that logic moved to validate_new_branchname(), which just resolves
>   HEAD itself. The parameter to create_branch is now unused.

Ah, I didn't know about the history of this parameter. It clearly makes
sense to explain this in the patch description.

> I also ended up reformatting the documentation comment, but that's
> purely optional. My patch is below for reference. Feel free to grab any
> bits of it that you agree with.

I like your documentation comment much better as IMO it's easier to read
and to identify the individual parameters.

Given these facts, I guess it's better if my patch is dropped and yours
is applied instead :)

Thanks a lot!
