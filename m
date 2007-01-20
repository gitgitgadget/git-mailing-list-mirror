From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] show-branch --reflog: show the reflog message at
 the top.
Date: Sat, 20 Jan 2007 01:42:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701200135500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7virf2d190.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200116280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4pqmczqa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 01:42:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H84JX-0000Iq-RB
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 01:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbXATAmd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 19:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbXATAmd
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 19:42:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:57928 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965040AbXATAmc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 19:42:32 -0500
Received: (qmail invoked by alias); 20 Jan 2007 00:42:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp013) with SMTP; 20 Jan 2007 01:42:30 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pqmczqa.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37232>

Hi,

On Fri, 19 Jan 2007, Junio C Hamano wrote:

> I still am having a hard time trying to explain what these
> commands would do, and why they might be useful:
> 
> 	git-log --walk-reflogs master..next

I had less problems explaining that when walking fell back to walking the 
parents.

It could even make sense to walk reflogs instead of parents _only_ for 
interesting commits (i.e. "next" in your example, but not "master"), so 
that you can ask for commits made to a certain in your local repository, 
which are not (yet) in some other branch.

Which would include commits which were ammended (and thus are no longer 
in the ancestry of the branch).

Of course, you could always say: if you ask for strange things, you will 
get strange things.

> 	git-log --walk-reflogs master -- Documentation/

Ah, but that is way easier!

For example: I _know_ that something worked some time ago, and it was 
probably in git.c. So ask "git-log --walk-reflogs -- git.c", and you will 
soon find out where to start bisecting.

> On the other hand I can understand why this might be useful:
> 
> 	git-log --walk-reflogs master

I like it already. But of course, I also like your patch saying "3 days 
ago" instead of a date.

Ciao,
Dscho
