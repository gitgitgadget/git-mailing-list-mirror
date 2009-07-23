From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 11:57:42 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907231153010.21520@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907221959330.21520@localhost.localdomain> <alpine.LFD.2.01.0907222009340.21520@localhost.localdomain> <alpine.LSU.2.00.0907231846190.30197@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu Jul 23 20:59:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU3WG-0007qP-En
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 20:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305AbZGWS6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 14:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754257AbZGWS6K
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 14:58:10 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37884 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754305AbZGWS6J (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jul 2009 14:58:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NIvhnH022639
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Jul 2009 11:57:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NIvgRn017236;
	Thu, 23 Jul 2009 11:57:42 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LSU.2.00.0907231846190.30197@hermes-2.csi.cam.ac.uk>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.46 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123886>



On Thu, 23 Jul 2009, Tony Finch wrote:

> On Wed, 22 Jul 2009, Linus Torvalds wrote:
> >
> > I suspect the old newton-raphson patches we had (Discussions and patches
> > back in April 2007 on this list) could be resurrected pretty easily.
> 
> That sounds interesting, but I can't find the thread you are referring to.
> Do you have a URL or a subject I can feed to Google?

Some googling found this:

	http://marc.info/?l=git&m=117537594112450&w=2

but what got merged (half a year later) was a much fancier thing by Junio. 
See sha1-lookup.c.

That original "single iteration of newton-raphson" patch was buggy, but 
it's perhaps interesting as a concept patch.

		Linus
