From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCH] git-svn: add support for --first-parent
Date: Thu, 6 Sep 2007 00:51:04 -0700
Message-ID: <20070906075104.GA10192@hand.yhbt.net>
References: <1188984929315-git-send-email-hjemli@gmail.com> <20070905101929.GB11074@soma> <8c5c35580709060018p50398071s32b271d52f4dc7e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 09:51:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITC9C-0005a0-TI
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 09:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbXIFHvI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 03:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752474AbXIFHvH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 03:51:07 -0400
Received: from hand.yhbt.net ([66.150.188.102]:58679 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226AbXIFHvG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 03:51:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 8FA062DC08D;
	Thu,  6 Sep 2007 00:51:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8c5c35580709060018p50398071s32b271d52f4dc7e3@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57837>

Lars Hjemli <hjemli@gmail.com> wrote:
> On 9/5/07, Eric Wong <normalperson@yhbt.net> wrote:
> > Lars Hjemli <hjemli@gmail.com> wrote:
> > > When git-svn uses git-log to find embedded 'git-svn-id'-lines in commit
> > > messages, it can get confused when local history contains merges with
> > > other git-svn branches. But if --first-parent is supplied to git-log,
> > > working_head_info() will only see 'branch-local' commits and thus the
> > > first commit containing a 'git-svn-id' line should refer to the correct
> > > subversion branch.
> >
> > Ideally, we'd probably stop, say something and give the user the choice
> > of branches if multiple parents available.
> 
> Could you elaborate? (I don't understand how following the first
> parent of a merge could end up at the wrong svn branch)

Well, if the user didn't know about --first-parent (like me yesterday
:), they could still end up miscommitting to any branch.  That's been a
complaint of users for a while now.  Thinking more about it,
--first-parent should probably be the default.

But, if they want to commit a different branch instead of the one they
merged into (so the second/third/fourth parent), --first-parent would
never give them that chance.

-- 
Eric Wong
