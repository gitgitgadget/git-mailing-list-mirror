From: Seth Robertson <in-gitvger@baka.org>
Subject: Announce gitslave - manage a superproject with slave repositories
Date: Mon, 20 Sep 2010 21:39:01 -0400
Message-ID: <201009210139.o8L1d1iY026728@no.baka.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 21 03:39:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxrp8-00048V-29
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 03:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865Ab0IUBjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 21:39:04 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:38503 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391Ab0IUBjD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 21:39:03 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id o8L1d1eT008504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 20 Sep 2010 21:39:01 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id o8L1d1iY026728
	for <git@vger.kernel.org>; Mon, 20 Sep 2010 21:39:01 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156685>


I'd like to announce the first public version of gitslave.

gitslave creates a group of related repositories all of which are
concurrently developed on and on which all git operations should
operate, so when you branch, each repository in the project is
branched in turn.  Similarly when you commit, push, pull, merge,
tag, checkout, status, log, etc; each git command will run on the
superproject and all slave repositories in turn.  This sort of
activity may be very familiar to CVS users and to a lesser extent
subversion users where it was fairly normal to assemble a
superproject in just this way.

git-submodules is the legacy solution for a similar sort of
activity, but went a different way.  With submodules you have a
semi-fixed subrepository which you are typically not doing active
development on and which git commands performed on the
superproject will not recurse down into the submodules. Another
option is to stick everything in one giant repository, but that
does not work well if some subsets are shared with other
superprojects.

The gits wrapper around git combines (and occasionally
post-processes for some special commands) the git output to make
everything clearer, which is very useful when you have a few
dozen slaves where looking at a concatenation of identical output
for each git command would lose the wheat in the chaff.

However, gitslave is not perfect. You can have partial success
and failure (which is advertised), programs like `gitk` will not
show the global systems' history only a specific repository's,
and things can get a little squirrelly if different branches/tags
have different slave modules associated with them and you
checkout back and forth.  However, we have not had any
significant problems in over two years of intensive work on a
project using this script.

If your development style or project lends itself to many
individual repositories, and those repositories are under your
direct control and all repositories should at identical
branch names at the same time, gitslave might just be for you.

http://gitslave.sourceforge.net/

Current release as of 2010-09-20: 1.0.0
http://sourceforge.net/projects/gitslave/files/gitslave-1.0.0.tar.gz/download

                                        -Seth Robertson
