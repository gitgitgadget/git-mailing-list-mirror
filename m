From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: gitk from subdirectory
Date: Thu, 30 Aug 2007 22:08:26 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708302200160.25853@woody.linux-foundation.org>
References: <7vabs85ntg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 07:08:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQykG-00049t-69
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 07:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289AbXHaFIc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 01:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754968AbXHaFIc
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 01:08:32 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37449 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754523AbXHaFIb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 01:08:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7V58RCB003311
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 30 Aug 2007 22:08:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7V58Q5X024783;
	Thu, 30 Aug 2007 22:08:27 -0700
In-Reply-To: <7vabs85ntg.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.746 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.30__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57113>



On Thu, 30 Aug 2007, Junio C Hamano wrote:
> 
> I am wondering if this was intended behaviour change.  I think
> it makes sense to want an easy way to say "what changed stuff in
> the directory I am in?" because presumably you are there because
> you are interested in stuff in there.  But if you hard code "--"
> it is not easy to disable that and get the global log.

Hmm. My reaction to this would be that it was a mistake to have a 
difference between 

	git log --

and

	git log

and that we should instead fix this at the argument parsing level. 

And then anybody who depended on the old "--" behaviour can just add a "." 
at the end.

That way there are no special cases.

I realize that the "--" behaviour of git log was intentional, but seeing 
what it results in I think the intention was good, but stupid.

		Linus
