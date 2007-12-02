From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Corrupted (?) commit 6e6db85e confusing gitk
Date: Sun, 2 Dec 2007 13:49:40 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712021348020.8458@woody.linux-foundation.org>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de> <7vir3hx70y.fsf@gitster.siamese.dyndns.org> <20071202193918.GQ6212@lavos.net> <Pine.LNX.4.64.0712022132060.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Downing <bdowning@lavos.net>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 02 22:50:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IywhW-0000KU-9B
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 22:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbXLBVtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 16:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbXLBVtu
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 16:49:50 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43925 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750914AbXLBVtu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2007 16:49:50 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB2Lnf8S015451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 2 Dec 2007 13:49:42 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB2Lnen6001437;
	Sun, 2 Dec 2007 13:49:40 -0800
In-Reply-To: <Pine.LNX.4.64.0712022132060.27959@racer.site>
X-Spam-Status: No, hits=-2.426 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_53
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66823>



On Sun, 2 Dec 2007, Johannes Schindelin wrote:
> 
> Darn.  But when can "GIT_AUTHOR_DATE" be set to the empty string?  I mean, 
> I understand unset'ing it.  But setting it to ""?

Well, regardless, I think we should make sure that git-commit-tree never 
writes out an invalid commit - no matter *how* insane input it gets. 
Making it complain loudly (with a 'die("Oh, no, you don't!")') would be a 
good idea.

		Linus
