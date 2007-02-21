From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 10:13:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702211009520.4043@woody.linux-foundation.org>
References: <20070221164527.GA8513@ginosko.local>
 <Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org>
 <alpine.LRH.0.82.0702211236180.31945@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 19:14:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJvz8-0000ta-Pr
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 19:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422702AbXBUSN1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 13:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422752AbXBUSN1
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 13:13:27 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36097 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422702AbXBUSNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 13:13:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1LID7hB030248
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Feb 2007 10:13:08 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1LID77n021583;
	Wed, 21 Feb 2007 10:13:07 -0800
In-Reply-To: <alpine.LRH.0.82.0702211236180.31945@xanadu.home>
X-Spam-Status: No, hits=-0.463 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40312>



On Wed, 21 Feb 2007, Nicolas Pitre wrote:
> 
> If your goal is to remove content froma repository then the only 
> sensible way is to rewrite history before publishing.  It is pointless 
> to add mechanisms to remove content after it has been distributed.

I'm not entirely in disagreement, but I can see the model where some 
company wants to make their work available (with the same history as their 
own internal stuff), but doesn't want to make a single file available for 
some reason.

So they'd have an external thing that just has the file excised.

Now, arguably, it's a lot better to use a "supermodule" approach for 
something like this: have two separate git trees, publish the public one, 
and use an internal supermodule that ties the public and internal trees 
together.

So supermodules might be a way to solve it in a better (and safer - the 
"remove objects from the public tree" thing is very error prone, since if 
you *ever* expose the object by mistake, its now public) way. But I don't 
think the "filter out objects" thing is necessarily fundamentally flawed 
as an approach.

			Linus
