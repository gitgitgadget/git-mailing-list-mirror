From: Pavel Roskin <proski@gnu.org>
Subject: SVN_URL undocumented
Date: Mon, 10 Apr 2006 17:22:42 -0400
Message-ID: <1144704162.18727.30.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 10 23:23:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FT3qc-0002ck-2L
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 23:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWDJVWz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 17:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWDJVWz
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 17:22:55 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:14255 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751202AbWDJVWy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 17:22:54 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FT3qU-0004kM-O4
	for git@vger.kernel.org; Mon, 10 Apr 2006 17:22:51 -0400
Received: from proski by dv.roinet.com with local (Exim 4.61)
	(envelope-from <proski@dv.roinet.com>)
	id 1FT3qN-0005Nh-5D; Mon, 10 Apr 2006 17:22:43 -0400
To: Eric Wong <normalperson@yhbt.net>
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18593>

Hello, Eric!

I'm trying to use git-svn, but the documentation seems to be quite
unclear.  I'm using current git-svn from the git repository.

I'm running "git-svn init" in a Subversion working directory:

$ git-svn init
SVN repository location required
 at /home/proski/bin/git-svn line 223
        main::init() called at /home/proski/bin/git-svn line 104

The help shown by git-svn without arguments doesn't say anything about
arguments for "init", unlike other subcommands.  I'm assuming that
"git-svn init" is not taking any arguments.

The manual page doesn't say anything about arguments, but it mentions
that "the SVN_URL must be specified at this point".  This statement is
unclear to me.

There are several references to SVN_URL in the manual, but there is no
description what it is.  Is it supposed to be an environment variable,
or an undocumented argument, or is it taken from "svn info" output?

The environment variable has no effect:

$ SVN_URL=http://svn.madwifi.org/trunk git-svn init
SVN repository location required
 at /home/proski/bin/git-svn line 223
        main::init() called at /home/proski/bin/git-svn line 104

Looking at the sources, it looks like that SVN_URL is an undocumented
argument for "git-cvs init".  "git-svn fetch" appears to be taking that
value from the git repository, but it also takes care to protect the
original value (I have no idea where it can come from).

One of the "basic examples" further in the manual confirms that SVN_URL
is set on the command line:

git-svn init http://svn.foo.org/project/trunk

I believe that the documentation should be updated to describe where
SVN_URL comes from, and what arguments are accepted by "git-svn init".
Basic examples shouldn't recommend using undocumented arguments.

It seems to me that the current documentation describes the internals of
git-svn instead of its user interface.  Rather than tell the user that
"FOO must be specified at that point", the documentation should say what
(an how) should (or can) be specified when the command is invoked on the
command line.

Also, it would be great to refer to the "additional fetch arguments" in
the "fetch" description.  That section is easy to miss by somebody who
is specifically looking for "fetch arguments".

-- 
Regards,
Pavel Roskin
