From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix incorrect wording in git-merge.txt.
Date: Mon, 03 Mar 2008 15:39:31 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0803031519360.2899@xanadu.home>
References: <1204564483-5260-1-git-send-email-Matthieu.Moy@imag.fr>
 <alpine.LFD.1.00.0803031320180.2899@xanadu.home>
 <vpqlk4zoacw.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 03 21:40:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWHSD-0005L4-T2
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 21:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbYCCUjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 15:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbYCCUjd
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 15:39:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:65474 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbYCCUjc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 15:39:32 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JX6009TR9DM2GG0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 03 Mar 2008 15:39:22 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <vpqlk4zoacw.fsf@bauges.imag.fr>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75984>

On Mon, 3 Mar 2008, Matthieu Moy wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > You don't really merge a commit _object_.
> > You merge with one or more other commits, tipycally identified by a 
> > branch name or a tag.
> 
> Strictly speaking, you can merge any commit, not necessarily a branch
> or a tag. That can be "git merge 66f0a4d" or whatever. Admitedly, the
> common case is to merge a tag or a branch (which is why I keep it in
> parentheses).

Yes, and I've been meaning the same all along.

> Now, I don't understand the distinction you seem to be making between
> "commit" and "commit object".

Objects are what the low level storage is made of.  Conceptually, The 
merge operation doesn't work at the object level, but rather at the 
history graph level.  You don't merge objects, you merge history.
I think it is unnecessary and probably best not to 
mention the word "object" in this case.

The alternative is to provide more detailed explanation, such as:

   A merge is made by joining one or more history line to the current 
   'HEAD' branch.  Those history lines are denoted by their terminating 
   commit.  To identify them, the SHA1 name of the corresponding commit 
   object is used, or more frequently the name of the branch or tag 
   currently pointing at such commit objects.

but while this is more correct strictly speaking as the relation between 
a merge and a commit object is made, I don't know if this is any more 
enlightening to those who ope to learn something from the reading the 
documentation.


Nicolas
