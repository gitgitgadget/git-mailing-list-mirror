Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
	SPF_NONE shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCCB41F4C0
	for <e@80x24.org>; Sun, 20 Oct 2019 05:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfJTFul (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 01:50:41 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48812 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfJTFuk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 01:50:40 -0400
Received: from pendragon.ideasonboard.com (unknown [212.213.198.112])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 66BF8A2C;
        Sun, 20 Oct 2019 07:50:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1571550638;
        bh=7Bk/ZTwMGwtci2VkP4q2rQaUIHD/GalarqM+dWqGGtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEEwYN4vYb+/LNKl1wLKM1fll4fUCa0JXc9ZbctJy/f2WuaZDzMeXI0/q2imsRSp9
         Obr1xUdEt2gJJ4/Lpvd6F6q5Xl7Oh0BTC3JsN20jzt+DUAvZMjY+R6H1Qm7q8t8MMN
         ga20I6Yro/J19fatbh7SNfjoj1eICyFvmIW7hZAc=
Date:   Sun, 20 Oct 2019 08:50:33 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Greg KH <greg@kroah.com>
Cc:     Santiago Torres Arias <santiago@nyu.edu>, Willy Tarreau <w@1wt.eu>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191020055033.GD4991@pendragon.ideasonboard.com>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <20191017204343.GA1132188@kroah.com>
 <20191017204532.GA6446@chatter.i7.local>
 <20191018013029.GA1167832@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018013029.GA1167832@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 06:30:29PM -0700, Greg KH wrote:
> On Thu, Oct 17, 2019 at 04:45:32PM -0400, Konstantin Ryabitsev wrote:
> > On Thu, Oct 17, 2019 at 01:43:43PM -0700, Greg KH wrote:
> >>> I wonder if it'd be also possible to then embed gpg signatures over
> >>> send-mail payloads so as they can be transparently transferred to the
> >>> commit.
> >> 
> >> That's a crazy idea.  It would be nice if we could do that, I like it :)
> > 
> > It could only possibly work if nobody ever adds their own "Signed-Off-By" or
> > any other bylines. I expect this is a deal-breaker for most maintainers.
> 
> Yeah it is :(
> 
> But, if we could just have the signature on the code change, not the
> changelog text, that would help with that issue.

I ran into a related issue recently when thinking about how to implement
server-side workflows (for a non-kernel project). My goal is to ensure a
patch can only be pushed to the master branch if it has received review.
The easy way to do so it to check the Reviewed-by tags, but those can
easily be forged. I was thus wondering if we should have a way to sign
tags (as in commit message tags, not git tags).

-- 
Regards,

Laurent Pinchart
