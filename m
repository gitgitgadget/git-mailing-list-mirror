From: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
Subject: cvs revision number -> git commit name?
Date: Tue, 26 Jan 2010 22:53:12 +0100
Message-ID: <hbf.20100126bda0@bombur.uio.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 22:53:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZtLc-0006O5-H2
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 22:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676Ab0AZVxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 16:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754201Ab0AZVxO
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 16:53:14 -0500
Received: from mail-out1.uio.no ([129.240.10.57]:40703 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658Ab0AZVxN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 16:53:13 -0500
Received: from mail-mx1.uio.no ([129.240.10.29])
	by mail-out1.uio.no with esmtp (Exim 4.69)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1NZtLU-0000jq-UC
	for git@vger.kernel.org; Tue, 26 Jan 2010 22:53:12 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx1.uio.no with esmtp  (Exim 4.69)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1NZtLU-0001wd-Kk
	for git@vger.kernel.org; Tue, 26 Jan 2010 22:53:12 +0100
Received: from hbf by bombur.uio.no with local (Exim 4.44)
	id 1NZtLU-0000KG-Ja
	for git@vger.kernel.org; Tue, 26 Jan 2010 22:53:12 +0100
X-UiO-Ratelimit-Test: rcpts/h 11 msgs/h 6 sum rcpts/h 11 sum msgs/h 6 total rcpts 714 max rcpts/h 11 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: B0AE464C5063A8C48928C93B1711BE8F3BBF06A3
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 6 total 1810 max/h 8 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138079>

When moving from CVS to Git, what's a good way to help Git users
find an old commit given the original CVS revision number?  Are
there tools available to help?

There are plenty of still-useful references to CVS revisions
floating around - in bug reports, mailing list archives, commit
messages referring to other commits.  Some loose thoughts:

One could commit a table with a (file,revision)->commit mapping,
I suppose something can generate it when importing from cvs?

Many but far from all old file contain the CVS ID, named $OpenLDAP$.
Can Git grep all versions of a file for '\$OpenLDAP:.* 1.23 '?

Could maybe add a line like this to many of the log messages:
    "<cvs: version 1.23>"
for single-file commits, or
    "<cvs: here/foo.c 1.23, there/bar.c 1.45>"
for multi-file comments with few enough files that such an
annotation fits on one line.  That'll make log messages like "fix
rev 1.23" easier to read without need for a tool to find what the
message is talking about, but does clutter up the log a lot.

Some stats:
    1600 files = 23M text, 770k lines, in 100 directories.
   Maybe 20000 Git commits, 50M ldap.git/.git/ directory.

-- 
Hallvard
