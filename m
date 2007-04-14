From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GIT and the current -stable
Date: Sat, 14 Apr 2007 10:34:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704141028460.5473@woody.linux-foundation.org>
References: <46206842.80203@gmail.com> <7vfy73bhik.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rene Herman <rene.herman@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 14 19:34:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hcm8u-0008Tx-2O
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 19:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbXDNRe0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 13:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbXDNRe0
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 13:34:26 -0400
Received: from smtp.osdl.org ([65.172.181.24]:58267 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635AbXDNReZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 13:34:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3EHYLIs002115
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 14 Apr 2007 10:34:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3EHYKuL029416;
	Sat, 14 Apr 2007 10:34:20 -0700
In-Reply-To: <7vfy73bhik.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.455 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44465>



On Fri, 13 Apr 2007, Junio C Hamano wrote:
> 
> I think adding these lines to .git/config would do the trick,
> after you have done the "checkout -b v2.6.20 v2.6.20" step:
> 
> [branch "v2.6.20"]
> 	remote = stable
> 	merge = refs/heads/master

Please don't do this. Using the same name for a branch as for a tag is 
madness. Call it "v2.6.20-stable" or anything else, but don't re-use the 
same naming as for tags.

Sure, git will have some random well-defined order of parsing which one 
"v2.6.20" actually means in any particular context (usually the tag-name 
will take precedence, except for contexts where the branchname is 
required!), and yeah, you can always make things unambiguous by specifying 
the full name (ie say "[refs/]tags/v2.6.20" when you want to make sure 
it's unambiguously the tag, not the branch) but it's still guaranteed to 
cause confusion at *some* level, if only for the user.

So just don't do it. 

		Linus
