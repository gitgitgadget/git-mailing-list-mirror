From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge time
Date: Sun, 29 Jul 2007 20:06:27 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707292000190.4161@woody.linux-foundation.org>
References: <498048.62681.qm@web51002.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 05:07:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFLbL-00086o-Gr
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 05:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965681AbXG3DHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 23:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936601AbXG3DHG
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 23:07:06 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58953 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756867AbXG3DHE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 23:07:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6U36XAu001035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 Jul 2007 20:06:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6U36Re3022593;
	Sun, 29 Jul 2007 20:06:28 -0700
In-Reply-To: <498048.62681.qm@web51002.mail.re2.yahoo.com>
X-Spam-Status: No, hits=-2.727 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54172>



On Sun, 29 Jul 2007, Matthew L Foster wrote:
> 
> --- Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > The fact is, distributed history isn't one-dimensional. You *cannot* 
> > linearize it as some one-dimensional time. Impossible. Any system that 
> > tries is broken. 
> 
> I don't want distributed history, I want what local time changes were 
> merged locally.

The point is, there is no "locally".

Do you mean locally on my machine? That's actually *different* from the 
locally on the public machines, and no, I wouldn't give you that 
information anyway (since that information would include the mistakes that 
I fixed up ;)

And in fact, even on the public machines, the "locally" would be different 
depending on things like mirroring delays, although that is currently 
hidden by the fact that kernel.org uses rsync for mirroring rather than 
using git natively.

So in theory, we could pick one particular public kernel.org machine, and 
use the times as _that_ machine sees it, but the fact is, that isn't how 
git works. No normal git command will ever show you such a senseless 
ordering.

I suspect that the closest you could get to what you want would be to 
actually run git-cvsserver on kernel.org to export the git data as "CVS" 
data, and then you could use a CVS client that gets a linearized model of 
history. That is, afaik, the only way to give you what you want.

And quite frankly, I'd never ask the kernel.org maintainers to do 
something that perverse. You could ask them, and maybe they would do so 
out of some really perverse self-destructive death-wish, but quite 
frankly, you'd probably be better off setting up such a git->CVS gateway 
on some local machine yourself.

			Linus
