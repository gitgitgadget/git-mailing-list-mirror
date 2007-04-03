From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 15:14:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031511580.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704031322490.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031657130.28181@xanadu.home>
 <Pine.LNX.4.64.0704031413200.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031735470.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:15:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYrHg-0002T9-Qd
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 00:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946007AbXDCWPV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 18:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946012AbXDCWPV
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 18:15:21 -0400
Received: from smtp.osdl.org ([65.172.181.24]:46014 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946007AbXDCWPU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 18:15:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33METPD024583
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 15:14:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33MESZn004781;
	Tue, 3 Apr 2007 15:14:29 -0700
In-Reply-To: <alpine.LFD.0.98.0704031735470.28181@xanadu.home>
X-Spam-Status: No, hits=-0.454 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43681>



On Tue, 3 Apr 2007, Nicolas Pitre wrote:
> > 
> > It could be as simple as just the index file itself. That's 11MB for the 
> > kernel. Imagine if the index file was 20 times bigger - 200MB of memory 
> > paged in with bad access patterns just for unnecessary lookups.
> 
> Again that presumes you have to page in the whole index, which should 
> not happen when pulling (much smaller packs) and with a better lookup 
> algorithm.

Actually, since SHA1's are randomly distributed, together with the binary 
search, you probably *will* pull in the bulk of the index, even with a 
fairly small set of SHA1's that you check.

> Make it conditionnal on --stdin then.  This covers all cases where we 
> really want the secure thing to happen, and the --stdin case already 
> perform the atomic rename-and-move thing when the pack is fully indexed.

I don't care *what* it is conditional on, but your arguments suck. You 
claim that it's not a normal case to already have the objects, when it 
*is* a normal case for alternates, etc.

I don't understand why you argue against hard numbers. You have none of 
your own.

		Linus
