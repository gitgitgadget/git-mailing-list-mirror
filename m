From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Fix AbstractTreeIterator path comparion betwen
	'a' and 'a/b'
Date: Tue, 3 Feb 2009 08:15:39 -0800
Message-ID: <20090203161539.GV26880@spearce.org>
References: <1233605617-14513-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Tor Arne =?iso-8859-1?Q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 17:17:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUNxS-0008N2-Qm
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 17:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbZBCQPk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2009 11:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbZBCQPk
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 11:15:40 -0500
Received: from george.spearce.org ([209.20.77.23]:56644 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbZBCQPk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 11:15:40 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6DA7538210; Tue,  3 Feb 2009 16:15:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1233605617-14513-1-git-send-email-torarnv@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108206>

Tor Arne Vestb=F8 <torarnv@gmail.com> wrote:
> The occurance of a '/' as the next character in the longer path
> does not neccecarily mean the two paths are equal, for example
> when the longer path has more components following the '/'.
>=20
> Signed-off-by: Tor Arne Vestb=F8 <torarnv@gmail.com>
> ---
>  .../jgit/treewalk/AbstractTreeIteratorTest.java    |   93 ++++++++++=
++++++++++
>  .../jgit/treewalk/AbstractTreeIterator.java        |    4 +-
>  2 files changed, 95 insertions(+), 2 deletions(-)
>  create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewa=
lk/AbstractTreeIteratorTest.java

*sigh*

I can't get Eclipse to run this test.  Every time I try it comes
up with a CNFE:

  Class not found org.spearce.jgit.treewalk.AbstractTreeIteratorTest
  java.lang.ClassNotFoundException: org.spearce.jgit.treewalk.AbstractT=
reeIteratorTest
    at java.net.URLClassLoader$1.run(URLClassLoader.java:200)

Aside from this test not running, Eclipse says the tests pass.  But
Maven tells another story:

  (cd jgit-maven/jgit && mvn clean package)
  ...
  Failed tests:
    testNoDF_NoGap(org.spearce.jgit.treewalk.NameConflictTreeWalkTest)
    testDF_GapByOne(org.spearce.jgit.treewalk.NameConflictTreeWalkTest)
    testDF_SkipsSeenSubtree(org.spearce.jgit.treewalk.NameConflictTreeW=
alkTest)

  Tests run: 773, Failures: 3, Errors: 0, Skipped: 0

Yet under Eclipse this test says its fine.  But Maven actually
managed to run your new test case, where Eclipse didn't.

*confused*
=20
--=20
Shawn.
