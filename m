From: Tzafrir Cohen <tzafrir.cohen@xorcom.com>
Subject: git-svn with the asterisk svn repository
Date: Tue, 23 Jun 2009 10:55:00 +0300
Organization: Xorcom*
Message-ID: <20090623075500.GR3311@xorcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 10:18:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ1Ce-0004TR-BJ
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 10:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751AbZFWIRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 04:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756256AbZFWIRR
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 04:17:17 -0400
Received: from local.xorcom.com ([62.90.10.53]:60113 "EHLO local.xorcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755641AbZFWIRO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 04:17:14 -0400
X-Greylist: delayed 1335 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jun 2009 04:17:13 EDT
Received: by local.xorcom.com (Postfix, from userid 1000)
	id 573DF1D158; Tue, 23 Jun 2009 10:55:00 +0300 (IDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Forced-Service: Sadly Using Gmail [tm]
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122081>

Hi

It took me quite a while to figure out how to use git-svn with the
repositories of the Asterisk project (now: http://svn.asterisk.org/svn/
). They have an extensive usage of svn:externals , which is changed from
branch to branch (mostly: "tagged" on a release tag) and thus using
submodules didn't seem useful.

Here are some notes of my workarounds.

Generally I tried to keep my the branches clean of unnecessary changes.
They need to build correctly without any need for extra changes. And for
the sake of clarity: even the gitignore file shouldn't be part of a
change. I want to be able to checkout a branch and just use it. Which
means that the gitignore file had to be on the gitignore file as well
and not checked in.

BTW: I also included a simple script to update the git tags from the SVN
"tags/*" branches (any such branch that matches a specific pattern and
for which a tag doesn't exist).

I also worked around the need of the svn:externals . Most of them were
for a common part of the build system called menuselect. I reimplemented
it in a single perl script and a very simple makefile (which are easy to
copy around). One or two other svn:exterernals don't seen to change
much, and I just used symlinks instead.

Simple documentation and scripts are available at
http://git.tzafrir.org.il/?p=asterisk-tools.git;a=tree

(Please CC replies if you actually want me to read them, as I almost
don't read this list)

P.S.: Anybody had luck with git-svn and HTTPS certificates 
authentication recently? I never tried to use git-svn to commit
anything.

-- 
               Tzafrir Cohen
icq#16849755              jabber:tzafrir.cohen@xorcom.com
+972-50-7952406           mailto:tzafrir.cohen@xorcom.com
http://www.xorcom.com  iax:guest@local.xorcom.com/tzafrir
