From: Don Zickus <dzickus@redhat.com>
Subject: Re: git-mailinfo munges the patch?
Date: Thu, 29 Mar 2007 17:52:48 -0400
Message-ID: <20070329215248.GG11029@redhat.com>
References: <7v1wj74xck.fsf@assigned-by-dhcp.cox.net> <20070329205357.GF11029@redhat.com> <Pine.LNX.4.64.0703291417250.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 29 23:54:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX2Ze-0006CE-C8
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 23:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934355AbXC2VyX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 17:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934357AbXC2VyX
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 17:54:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55458 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934355AbXC2VyW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 17:54:22 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2TLsHkM017237;
	Thu, 29 Mar 2007 17:54:17 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2TLsG2b004005;
	Thu, 29 Mar 2007 17:54:16 -0400
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2TLsGIe028096;
	Thu, 29 Mar 2007 17:54:16 -0400
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l2TLqmrn030527;
	Thu, 29 Mar 2007 17:52:48 -0400
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l2TLqmA6030526;
	Thu, 29 Mar 2007 17:52:48 -0400
X-Authentication-Warning: drseuss.boston.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703291417250.6730@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43478>

On Thu, Mar 29, 2007 at 02:19:26PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 29 Mar 2007, Don Zickus wrote:
> > 
> > Ok.  I see what you are saying with the old code.  Sorry about that.  Do
> > you have a sample file that I can play with to test my fix?
> 
> On that note - here's an unrelated simple case that the old mailinfo got 
> right, but the new one seems to screw up: multiple Subject: lines.
> 
> The old one would make later Subject: lines override the earlier ones, and 
> I depended on that when I fix up peoples emails to me manually (you 
> wouldn't believe how bad explanations or subject lines people use for 
> perfectly good patches ;)

I see what happened.  The old code allowed rewriting of the mail headers
but blocked rewriting of the inbody headers.  For some reason I thought it
was by accident that the mail headers were allow to be rewritten.  Oops.
:(

I wrote the code to have both header types block rewriting.  I'll change
that.  

Cheers,
Don
