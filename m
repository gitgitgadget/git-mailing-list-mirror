From: Junio C Hamano <junkio@cox.net>
Subject: GIT - breaking backward compatibility
Date: Mon, 19 Sep 2005 19:07:28 -0700
Message-ID: <7vpsr4cx0f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 20 04:08:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXY7-0003sv-0v
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 04:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbVITCH4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 22:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVITCH4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 22:07:56 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:35770 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964837AbVITCH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 22:07:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050920020729.GSXT23945.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 22:07:29 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8952>

I raised the following issues in my previous messages but did
not hear many opinions [*1*].  I do not want to take it as a
blank check from the community to do whatever I please.  So here
is a recap.

 * Tools renaming plan calls for removal of the backward
   compatible command names (e.g. git-fsck-cache and
   git-update-cache) sometime in the future.  This is scheduled
   for 0.99.8 around beginning of October.  If somebody wants
   extended amnesty period, this can be pushed back but unless I
   hear otherwise...

 * After reviewing the current set of commands, the following do
   not seem to be useful anymore; Linus said he feels they can
   go, and nobody else objected:

   git-diff-helper git-diff-stages git-export git-rev-tree

   I'd like to remove them before 1.0, and planning to do it
   within the 0.99.8 timeframe unless I hear otherwise.

 * After Brian Gerst posted a patch to show 'modified' files in
   ls-files [*2*], there was a brief discussion to change the
   tagged output markings to make them more readable, but
   neither Cogito nor StGIT seems to use tagged output.  I am
   currently thinking about removing '-t' altogether.

   Again, unless I hear otherwise, I'd like to remove it within
   the 0.99.8 timeframe.


BTW, independent from any of these I'll be doing a 0.99.7a
soonish for "fixes only" on top of 0.99.7.


[Footnote]

*1* Well, Pasky indicated he does not like some of the terms in
the glossary in his recent Cogito release announcement, but that
was unfortunately after the fact.

*2* I haven't taken this patch not because I do not think
showing 'modified' file is a bad idea but because showing cache
dirty files as 'modified' did not feel right to me.  I think
doing what 'git-update-index --refresh' does without actually
refreshing the cache status bits would be the right way to go.
