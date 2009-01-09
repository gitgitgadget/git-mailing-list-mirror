From: Tim Shepard <shep@alum.mit.edu>
Subject: 1.5.6.5 fails to clone git.kernel.org/[...]/rostedt/linux-2.6-rt
Date: Fri, 09 Jan 2009 01:24:19 -0500
Message-ID: <E1LLAn5-0001JM-00@alva.home>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 09 07:54:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLBGE-0002eV-L9
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 07:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbZAIGxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 01:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbZAIGxG
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 01:53:06 -0500
Received: from dsl092-066-146.bos1.dsl.speakeasy.net ([66.92.66.146]:41281
	"EHLO alva.home" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752900AbZAIGxF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 01:53:05 -0500
X-Greylist: delayed 1722 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jan 2009 01:53:04 EST
Received: from shep (helo=alva.home)
	by alva.home with local-esmtp (Exim 3.36 #1 (Debian))
	id 1LLAn5-0001JM-00
	for <git@vger.kernel.org>; Fri, 09 Jan 2009 01:24:19 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104982>



I have git 1.5.6.5 installed from the Debian/lenny package.

Poking around in http://git.kernel.org/ looking for a git repository
that might have the latest -rt development happening, I found

  http://git.kernel.org/?p=linux/kernel/git/rostedt/linux-2.6-rt.git

which looked promising.

But when I tried cloning it using:

    git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-rt.git linux-2.6-rt

it pulled several hundred megabytes through my (rather slow) DSL line
and then printed out

  error: Trying to write ref refs/tags/v2.6.11 with nonexistant object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
  fatal: Cannot update the ref 'refs/tags/v2.6.11'.

and then removed everything it had just pulled.


Looking at http://git.kernel.org/?p=linux/kernel/git/rostedt/linux-2.6-rt.git;a=tags
I see that apparently v2.6.11 and v.2.6.11-tree both point at a tree
object and not a commit.

Is this a bug in git?    (Even if there is something wrong with the
git repository I was trying to clone, the fact that it removed all the
work that took a long time to pull is annoying.)

Is this problem already fixed in some newer version of git?


			-Tim Shepard
			 shep@alum.mit.edu
