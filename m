From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] show_date(): rename the "relative" parameter to "mode"
Date: Tue, 27 Feb 2007 15:59:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702271554120.12485@woody.linux-foundation.org>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702271356300.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702272322590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslcrb3l8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:59:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMCEa-0005Ih-GQ
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbXB0X7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbXB0X7q
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:59:46 -0500
Received: from smtp.osdl.org ([65.172.181.24]:58167 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662AbXB0X7p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:59:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1RNxOhB023267
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 15:59:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1RNxNTO000714;
	Tue, 27 Feb 2007 15:59:23 -0800
In-Reply-To: <7vslcrb3l8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.445 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40856>



On Tue, 27 Feb 2007, Junio C Hamano wrote:
> 
> How about --ago as a synonym, and --my-date for obeying TZ?
> "show in UTC time" can be had by something like:
> 
> 	$ TZ=UTC git log --my-date

Yes, although I would suggest that at that point we also use a shorter 
date format, since the timezone (by definition) is no longer valid or 
interesting.

But in general, there are other date issues - if we start showing the date 
in other non-rfc2822 formats (like skipping the timezone), we migth as 
well also support denser times..

For example, I occasionally love seeing the seconds, especially when I 
apply a series of patches from Andrew, and I see myself committing 5-6 
patches per second - but it's just noise if you want a single-line thing. 
So showing dates as "yyyy-mm-dd hh:mm" makes sense (and sorts properly).

So instead of "--my-date", I'd suggest "--date[-format]=xyz" as an option, 
possibly even with a way to set some defaults for "git log" using the 
config file. 

		Linus
