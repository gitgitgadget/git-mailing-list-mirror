From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Listing of branch creation time?
Date: Tue, 27 Mar 2007 18:06:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703271759510.6730@woody.linux-foundation.org>
References: <17929.37382.984339.742025@lisa.zopyra.com>
 <20070327233552.GA7186@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 03:06:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWMcM-0003HC-7N
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 03:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965525AbXC1BGS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 21:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965539AbXC1BGS
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 21:06:18 -0400
Received: from smtp.osdl.org ([65.172.181.24]:49348 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965525AbXC1BGR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 21:06:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2S16CU2019996
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Mar 2007 18:06:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2S16BYM032135;
	Tue, 27 Mar 2007 18:06:12 -0700
In-Reply-To: <20070327233552.GA7186@coredump.intra.peff.net>
X-Spam-Status: No, hits=-0.468 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43338>



On Tue, 27 Mar 2007, Jeff King wrote:
>
> You have to look at the latest merge-base, but that tells you the last 
> time you merged with master, not necessarily the first time.

Well, if you know which branch it is a branch off of, don't use 
merge-base, just do

	git log --reverse -1 origin..branch

which should pick up the first commit that is on that branch but haven't 
been merged back to the original branch.

The merge-base is the right thing to do for *merging*, but if you keep 
merging into the branch you are developing on (to keep up-to-date), the 
above "what is on the branch but not in the origin" is definitely the 
right thing to do.

Of course, people already pointed out "gitk". And I agree. Quite often, 
it's worth the full graphical output to do

	gitk origin..branch

to see the big picture. But if you want to work on the command line, the 
above "git log" command line isn't really that bad to type..

(Personally, if I didn't want the graphical version, I'd likely just do

	git log origin..branch

and then do '>' in the pager to get to the bottom. That way I can then 
scroll up and down if I decide I want to get a bigger picture)

		Linus
