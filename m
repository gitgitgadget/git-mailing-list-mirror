From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (with specific RFHs)
Date: Tue, 21 Feb 2006 03:23:34 -0800
Message-ID: <7vfymdx8eh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Feb 21 12:24:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBVcw-0005zD-M5
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 12:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161188AbWBULXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 06:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161204AbWBULXi
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 06:23:38 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43733 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161188AbWBULXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 06:23:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060221112011.FMCT17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 21 Feb 2006 06:20:11 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16528>

* The 'master' branch has these since the last announcement.

 - more portability bits from Johannes.

   I'm holding off Makefile changes because it seems to trigger
   "make -j" breakage.  Testing, diagnosing and fixing the
   version in the 'next' branch by more knowledgeable people is
   very much appreciated.
 
 - merge-tree by Linus.

 - git-mktree: reverse of git-ls-tree.

   I am hoping that this may help a new merge engine based on
   merge-tree by Linus, but maybe not.  It depends on how you
   use merge-tree output.

 - loosening "empty ident" errors. 

   Enough people seem to have been bitten by this since 1.2.0
   was released.

 - Fix fmt-merge-msg counting.

 - cherry-pick/revert: rewording error-help message.

 - git-svn updates from Erig Wong (contrib/).


* The 'next' branch, in addition, has these.

 - "Assume unchanged git".

   I have been using this in production for some time, without
   usin CE_VALID, and am reasonably sure this does not break
   anything for normal use.  I am hoping to push this one to
   'master' sometime this week.  If people can find missing or
   incomplete docs in this part, help is appreciated.

 - Solaris 9+ portability bits from Paul Jakma.

   Testing by people with Solaris 8 boxes to make sure this does
   not regress and/or people with Solaris 9 or 10 boxes to see
   if this help is appreciated.  Quite likely to be "master"
   material without further changes.

 - Reusing data from existing packs, and "Thin pack" bandwidth
   reduction for "git push" and "git fetch".

   I am holding these off not because they are risky (I've been
   using them in the production over the long weekend), but I'm
   keeping them to entice people to try out the 'next' branch
   ;-).  Quite likely to be "master" material without further
   changes.

 - Perl 5.6 backward compatibility.

   Instead of open($fh, '-|', @list), use a bit older equivalent
   form.  Thanks for Johannes and Eric Wong.  Quite likely to be
   "master" material without further changes.

 - git-annotate by Ryan and git-blame by Fredrik.

   The one by Fredrik, being all in C, doing all git things
   internally and forking only diff, seems much faster, but it
   seems to have inherited bugs from my original blame script
   implementation from long time ago.  Ryan's one seems to be
   computing sensible results.


* The 'pu' branch, in addition, has these.

 - "Bash completion" in Ben Clifford (contrib/)

   Without requests from the list, I am not particularly
   interested in carrying this in my tree, but I wanted to try
   out "an even cooler merge" myself, just like Linus did with
   gitk merge.

 - "Bound commit" lowlevel machinery for subprojects support.
 
   Honestly, I am not very interested in this myself.  If
   somebody is interested in gitlink based subproject support,
   the parts this touches would interfere with it -- in which
   case I'd drop this.
