From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] shortlog: prompt when reading from terminal by mistake
Date: Thu, 8 Mar 2007 09:31:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703080928580.10832@woody.linux-foundation.org>
References: <7vhcsw9h8p.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0703080827170.10832@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703081755500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 08 18:32:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPMTm-0002Hn-90
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 18:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbXCHRcG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 12:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbXCHRcG
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 12:32:06 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53701 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590AbXCHRcE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 12:32:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l28HVuq8006934
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 8 Mar 2007 09:31:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l28HVtXu000692;
	Thu, 8 Mar 2007 09:31:55 -0800
In-Reply-To: <Pine.LNX.4.63.0703081755500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.489 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41764>



On Thu, 8 Mar 2007, Johannes Schindelin wrote:
> 
> How about something totally different: "git log --shortlog". I.e.

Sure, but this is even worse, because the way you wrote the patch, now

	git log --shortlog

will act as a filter too, which is even *more* confusing.

You also broke something even more fundamental. Try this:

	git log -- --shortlog

with your patch ;)

But yeah, if "cmd_shortlog()" worked like "git log" (at least if it sees 
the "--shortlog" flag) and with that obvious filename parsing thing fixed, 
that thing would be fine.

			Linus
