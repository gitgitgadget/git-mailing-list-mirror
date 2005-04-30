From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 16:18:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504301607570.2296@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
 <42730061.5010106@zytor.com> <Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
 <Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org> <87zmvganq9.fsf@windlord.stanford.edu>
 <1114848175.24014.35.camel@localhost.localdomain> <20050430124048.79119cac.froese@gmx.de>
 <87r7gs87a9.fsf@windlord.stanford.edu> <Pine.LNX.4.58.0504301322130.2296@ppc970.osdl.org>
 <20050501005434.2d47131a.froese@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 03:59:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DS3jC-0001qL-Ve
	for gcvg-git@gmane.org; Sun, 01 May 2005 03:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVD3XQ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 19:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVD3XQ2
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 19:16:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:59298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261451AbVD3XQ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 19:16:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3UNGCs4022282
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Apr 2005 16:16:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3UNGBDR023372;
	Sat, 30 Apr 2005 16:16:12 -0700
To: Edgar Toernig <froese@gmx.de>
In-Reply-To: <20050501005434.2d47131a.froese@gmx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 1 May 2005, Edgar Toernig wrote:
> 
> > I'll probably tweak it a bit more (make "no timezone means local 
> > timezone", for example, rather than UTC like it is now).
> 
> Here's my try on that.  But whether it works everywhere ...

I already did that part.

> Btw, your %+03d%02d printf gave wrong results for i.e. -0130 (-01-30).

Dang. Oh, well. That's what I get for not testing.

I don't much like that "%+05s" trick either, since that one also depends 
on the direction of rounding for negative division (it just gets it right 
for the normal case, and I guess C90 finally specified it precisely).

Let's just do unsigned arithmetic and check the sign specially. I already 
did that on input, just not on output.

		Linus
