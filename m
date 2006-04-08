From: Peter Baumann <peter.baumann@gmail.com>
Subject: How to create independent branches
Date: Sat, 8 Apr 2006 20:02:44 +0200
Message-ID: <20060408180244.GA4807@xp.machine.de>
References: <20060407184701.GA6686@xp.machine.de> <7vr749i48s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 08 20:02:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSHlV-00056V-Rc
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 20:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWDHSCL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 14:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWDHSCL
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 14:02:11 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:51076 "HELO
	mail.hofmann.stw.uni-erlangen.de") by vger.kernel.org with SMTP
	id S1751307AbWDHSCK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Apr 2006 14:02:10 -0400
Received: (qmail 8899 invoked by uid 0); 8 Apr 2006 18:02:03 -0000
Received: from oed5e.o.pppool.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@89.51.237.94)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 8 Apr 2006 18:02:03 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vr749i48s.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18520>

On Fri, Apr 07, 2006 at 12:18:27PM -0700, Junio C Hamano wrote:
> Peter Baumann <peter.baumann@gmail.com> writes:
> 
> > How can I get the inital commit as a patch?
> 
> format-patch is designed to get a patch to send to upstream, and
> does not handle the root commit.  In your two revisions
> repository, you could do something like this:
> 
> 	$ git diff-tree -p --root master~1
> 
> Or more in general:
> 
> 	$ git rev-list master |
>           git diff-tree --stdin --root --pretty=fuller -p
> 
> BTW, I've been meaning to add --pretty=patch to give
> format-patch compatible output to diff-tree, but haven't got
> around to actually do it.  Another thing I've been meaning to do
> is "git log --diff" which is more or less "git whatchanged".
> 

Ok. That did it.

Another question. I'd like to create a totaly independent branch (like
the "todo" branch in git). Is there a more user friendly way than doing

git-checkout -b todo
rm .git/refs/heads/todo
rm .git/index
rm <all_files_in_your_workdir>

... hack hack hack ...
git-commit -a

I looked all over the docs, but can't find anything obvious.

-Peter
