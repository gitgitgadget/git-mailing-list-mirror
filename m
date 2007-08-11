From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and larger trees, not so fast?
Date: Sat, 11 Aug 2007 11:47:42 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708111137250.30176@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: moe <moe-git@mbox.bz>
X-From: git-owner@vger.kernel.org Sat Aug 11 20:48:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJw0R-0004FP-SW
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 20:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335AbXHKSrz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 14:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756140AbXHKSrz
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 14:47:55 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54992 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754429AbXHKSry (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 14:47:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7BIlm8E012705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 11 Aug 2007 11:47:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7BIlgYW020671;
	Sat, 11 Aug 2007 11:47:43 -0700
In-Reply-To: <20070809163026.GD568@mbox.bz>
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55620>



On Thu, 9 Aug 2007, moe wrote:
> 
> here's a test-case (should be safe to
> copy/paste on linux, bash):

moe: with current git (and thus the 1.5.3 release), the "git status" 
commands now take half a second for me, and the git commit takes just 
under a second.

The *initial* commit that adds everything still takes almost 5 seconds, 
but that was due to generating the diffstat summary - with a "-q" on the 
commit line that too drops down to just under a second.

In fact, the only thing that took more than a second for me with the 
current git is that initial "git add .", which took 1.791s for me. 
Considering that it had to hash all the 100,000 objects, I'm not 
surprised.

Anyway, it would be good if you re-did your real work tree with current 
commit, just to verify. You have slower hardware than I do, but hopefully 
it is now just about as fast as it can be.

			Linus
