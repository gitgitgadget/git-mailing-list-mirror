From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 12:07:55 -0400
Message-ID: <20070917160755.GA11287@pe.Belkin>
References: <11900314321506-git-send-email-hjemli@gmail.com> <46EE7584.8010202@op5.se> <8c5c35580709170616i49a8836hb60423c5eebf601d@mail.gmail.com> <Pine.LNX.4.64.0709171422340.28586@racer.site> <8c5c35580709170638mc0c8279pa86d71bd79fd3084@mail.gmail.com> <Pine.LNX.4.64.0709171454031.28586@racer.site> <8c5c35580709170712v2f5df7b1w8fa0377b69f24988@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 18:08:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXJ8k-0003gR-2S
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 18:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480AbXIQQH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 12:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754276AbXIQQH5
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 12:07:57 -0400
Received: from eastrmmtao107.cox.net ([68.230.240.59]:65383 "EHLO
	eastrmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbXIQQH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 12:07:56 -0400
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070917160756.CACD25010.eastrmmtao107.cox.net@eastrmimpo01.cox.net>;
          Mon, 17 Sep 2007 12:07:56 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo01.cox.net with bizsmtp
	id pU7v1X00N0epFYL0000000; Mon, 17 Sep 2007 12:07:56 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1IXJ8d-0003Du-Rk; Mon, 17 Sep 2007 12:07:55 -0400
Content-Disposition: inline
In-Reply-To: <8c5c35580709170712v2f5df7b1w8fa0377b69f24988@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58454>

On Mon, Sep 17, 2007 at 04:12:56PM +0200, Lars Hjemli wrote:
> On 9/17/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > But then, I do not use svn branches here, and that might be the problem?
> 
> Probably. The case I'm trying to solve is:
>   -git-svn branch A is merged into git-svn branch B
>   -A is a fast-forward of B

Ah, now I see what you mean.  But, IIUC, if you want to dcommit your
merge, you should treat it the way svn treats it, with git-merge
--squash.  Then, dcommit won't be confused about the branch you're
committing to.

-chris

> 
> This might look unrealistic, but it happened to me today when I wanted
> to merge a feature-branch into a relase-branch. The release-branch had
> previously been merged into the feature-branch (to get a few
> bugfixes), but the release-branch had not changed since this merge. So
> when merging the feature-branch into the release-branch it just
> fast-forwarded, leaving me with an 'un-dcomittable' release-branch. I
> obviously could have done the merge in subversion (haha!), but doing
> it in git preserves the correct history.
> 
> Btw: I have redone the merge with --no-ff, and dcommit then worked
> like a charm ;-)
> 
> -- 
> larsh
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
