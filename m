From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: gitk patch collection pull request
Date: Fri, 19 Oct 2007 12:31:47 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710191227340.26902@woody.linux-foundation.org>
References: <20071019052823.GI14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 21:32:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IixZn-00087s-2S
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 21:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762527AbXJSTb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 15:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760097AbXJSTb4
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 15:31:56 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57696 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759584AbXJSTbz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 15:31:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9JJVmq8026131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Oct 2007 12:31:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9JJVlO6016359;
	Fri, 19 Oct 2007 12:31:47 -0700
In-Reply-To: <20071019052823.GI14735@spearce.org>
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61743>



On Fri, 19 Oct 2007, Shawn O. Pearce wrote:
>
> The following changes since commit 719c2b9d926bf2be4879015e3620d27d32f007b6:
>   Paul Mackerras (1):
>         gitk: Fix bug causing undefined variable error when cherry-picking

The biggest problem I have with gitk is that it is almost totally useless 
for when you have a file limit.

I do "gitk --merge" (which has an implicit file limit of the list 
of unmerged files) or just "gitk ORIG_HEAD.. Makefile" and the *history* 
of gitk looks fine.

But the diffs are crap and useless, because they contain all the stuff I 
did *not* want, and hides all the relevant information.

So then I might use the nice gitk history window to see the commits, but I 
will fall back on "git log -p --merge" and "git log -p ORIG_HEAD.. Makefile"
for the real work. 

I had that happen unusually many times lately, since we had a fair number 
of (mostly trivial) conflicts during this merge window. And it's sad. Gitk 
is so good in so many other ways, and then it is so *totally* useless when 
it comes to something as fundamental as just looking at the history of a 
few files.

			Linus
