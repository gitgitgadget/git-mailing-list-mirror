From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Thu, 15 Mar 2007 09:08:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703150900020.3816@woody.linux-foundation.org>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net> <7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
 <81b0412b0703141614m70f4a565qc001e06e60b0ffd5@mail.gmail.com>
 <7v8xdz5qn0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703141728350.9690@woody.linux-foundation.org>
 <7v4pon5mg3.fsf@assigned-by-dhcp.cox.net> <7vy7lz3svl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 17:09:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRsV4-00057l-G5
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 17:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422930AbXCOQIK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 12:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422938AbXCOQIJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 12:08:09 -0400
Received: from smtp.osdl.org ([65.172.181.24]:58123 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422930AbXCOQII (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 12:08:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2FG83Ob014588
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Mar 2007 09:08:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2FG823p020053;
	Thu, 15 Mar 2007 08:08:03 -0800
In-Reply-To: <7vy7lz3svl.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.988 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42290>



On Wed, 14 Mar 2007, Junio C Hamano wrote:
> >
> > The code is supposed to be there, but I haven't benched.
> 
> Now I have.

You da man!

> In the kernel repository, I ran this with 'master' version and 'next'
> version.  The latter uses the --quick mechanism in try_to_simplify.
> 
> $ /usr/bin/time git log -r --raw v2.6.19..master -- drivers/ | wc -l

> Three runs on a reasonably quiescent machine (hot cache).

Impressive, although not entirely surprising. "try_to_simplify()" is 
really the most performance-sensitive part of git.

I get a similar reduction for that load: 0:04.63 to 0:03.43 elapsed.

Good job.

		Linus
