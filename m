Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 366191F461
	for <e@80x24.org>; Wed, 21 Aug 2019 21:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfHUVse (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 17:48:34 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:39969 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfHUVse (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 17:48:34 -0400
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 0B92D240004;
        Wed, 21 Aug 2019 21:48:31 +0000 (UTC)
Date:   Thu, 22 Aug 2019 03:18:29 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-gui: Add the ability to revert selected lines
Message-ID: <20190821214829.2dzat2quo3h2s3z2@localhost.localdomain>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190819214110.26461-3-me@yadavpratyush.com>
 <73e63382-4f79-cfd0-47f4-812f9cd4f88b@kdbg.org>
 <20190820192944.gzfwnm52fvb5refq@localhost.localdomain>
 <93095b5a-6e15-ce4a-eb9b-22f9528312e1@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93095b5a-6e15-ce4a-eb9b-22f9528312e1@kdbg.org>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/08/19 11:19PM, Johannes Sixt wrote:
> Am 20.08.19 um 21:29 schrieb Pratyush Yadav:
> > On 20/08/19 09:21PM, Johannes Sixt wrote:
> >> Please don't do this. This confirmation dialog is unacceptable in my
> >> workflow. I use reversals of hunks and lines frequently, almost like a
> >> secondary code editor. My safety net is the undo function of the IDE,
> >> which works across reloads that are triggered by these external edits.
> >> These confirmations get in the way.
> >  
> > But not everyone uses an IDE. I use vim and it does not have any such 
> > undo feature that works across reloads. Not one I'm aware of anyway. It 
> > is absolutely necessary IMO to ask the user for confirmation before 
> > deleting their work, unless we have a built in safety net.
> 
> But you have a safety net built-in: Commit the work, then do the
> reversals in amend-mode. Now you can recover old state to your heart's
> content. That's recommended anyway if stuff is potentially precious.

I suppose we disagree on this. I feel very uncomfortable removing the 
prompt by default, because it is pretty easy to mis-click revert instead 
of stage, and all of a sudden lots of your work is gone. It is a pretty 
common workflow to make some changes, stage some hunks in one commit and 
then some others in the next. Not everyone (including me) will first 
commit changes, then amend them, especially if they are not that big or 
complicated. Accidentally deleting your work, no matter how small, 
because of a misclick sucks.

So, I feel strongly in favor of keeping the prompt on by default. I will 
add a config option to disable it for people who are willing to accept 
misclicks. That keeps both sides of the argument happy. You just have to 
disable it once in your global config and you're good to go.

> > So how about adding a config option that allows you to disable the 
> > confirmation dialog? Sounds like a reasonable compromise to me.
> 
> That's always an option. Needless to say that I'd prefer it off by
> default; I don't need three safety nets.
> 
> -- Hannes

-- 
Regards,
Pratyush Yadav
