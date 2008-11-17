From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-bisect not working correctly in the kvm.git repository?
Date: Mon, 17 Nov 2008 12:34:44 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811171230500.18283@nehalem.linux-foundation.org>
References: <gfs9hn$hq9$1@ger.gmane.org> <alpine.LFD.2.00.0811171131330.18283@nehalem.linux-foundation.org> <gfsjjp$o42$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: walt <w41ter@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 21:36:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Apl-0005vQ-Dz
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 21:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbYKQUfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 15:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbYKQUfQ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 15:35:16 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33271 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751911AbYKQUfP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Nov 2008 15:35:15 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAHKYikM028625
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Nov 2008 12:34:46 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAHKYiaJ028858;
	Mon, 17 Nov 2008 12:34:44 -0800
In-Reply-To: <gfsjjp$o42$1@ger.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.439 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101240>



On Mon, 17 Nov 2008, walt wrote:
> 
> Okay, that's clearly what's happening to me.  The kvm.git repo
> contains hundred of commits just like that.  How would you deal
> with the same situation?  Is git-bisect skip the easiest way?

Yeah. A much fancier alternative is to do a (temporary) branch that 
rewrites the history using the same sub-tree merge strategy, so that you 
can actually build the whole thing in that branch. 

This, btw, is why I asked Chris Mason to not do a subtree merge for the 
btrfs code. I wrote him a helper script to do exactly that with a nice 
index script for 'git filter-branch'. That way his whole tree is nicely 
bisectable when merged into the rest of the kernel.

But that's really a rather bigger thing to do, and I'd suggest that only 
if you really can't find things any other way.

		Linus
