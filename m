From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH] work around Python warnings from AsciiDoc
Date: Sun, 07 Dec 2008 18:38:46 -0800
Message-ID: <7vprk3bdc9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 03:40:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9W2b-0000Cp-OZ
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 03:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbYLHCiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 21:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754088AbYLHCiw
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 21:38:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46069 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066AbYLHCiv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 21:38:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C646518578;
	Sun,  7 Dec 2008 21:38:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4A77E18409; Sun, 
 7 Dec 2008 21:38:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 58CCA16E-C4D1-11DD-BB95-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102516>

It appears that a reference to an anchor defined as [[anchor-name]] from
another place using <<anchor-name>> syntax, when the anchor name contains
a string "-with-" in its name, triggers these warnings from Python
interpreter.

  asciidoc -b docbook -d book user-manual.txt
  <string>:1: Warning: 'with' will become a reserved keyword in Python 2.6
  <string>:1: Warning: 'with' will become a reserved keyword in Python 2.6
  <string>:1: Warning: 'with' will become a reserved keyword in Python 2.6
  <string>:1: Warning: 'with' will become a reserved keyword in Python 2.6

There currently is no reference to "Finding comments with given content",
but for consistency and for futureproofing, the anchor is also updated as
the other ones that are actually used and trigger these warnings.

Signed-off-by: Junio C Hamano <junio@pobox.com>

---
 Documentation/user-manual.txt |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git c/Documentation/user-manual.txt w/Documentation/user-manual.txt
index 9f527d3..c0c2f8d 100644
--- c/Documentation/user-manual.txt
+++ w/Documentation/user-manual.txt
@@ -13,7 +13,7 @@ to build and test a particular version of a software project, search for
 regressions, and so on.
 
 People needing to do actual development will also want to read
-<<Developing-with-git>> and <<sharing-development>>.
+<<Developing-With-git>> and <<sharing-development>>.
 
 Further chapters cover more specialized topics.
 
@@ -399,7 +399,7 @@ the order it uses to decide which to choose when there are multiple
 references with the same shorthand name, see the "SPECIFYING
 REVISIONS" section of linkgit:git-rev-parse[1].
 
-[[Updating-a-repository-with-git-fetch]]
+[[Updating-a-repository-With-git-fetch]]
 Updating a repository with git-fetch
 ------------------------------------
 
@@ -955,7 +955,7 @@ echo "git diff --stat --summary -M v$last v$new > ../diffstat-$new"
 and then he just cut-and-pastes the output commands after verifying that
 they look OK.
 
-[[Finding-comments-with-given-content]]
+[[Finding-comments-With-given-Content]]
 Finding commits referencing a file with given content
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -972,7 +972,7 @@ Figuring out why this works is left as an exercise to the (advanced)
 student.  The linkgit:git-log[1], linkgit:git-diff-tree[1], and
 linkgit:git-hash-object[1] man pages may prove helpful.
 
-[[Developing-with-git]]
+[[Developing-With-git]]
 Developing with git
 ===================
 
@@ -1675,7 +1675,7 @@ dangling objects can arise in other situations.
 Sharing development with others
 ===============================
 
-[[getting-updates-with-git-pull]]
+[[getting-updates-With-git-pull]]
 Getting updates with git-pull
 -----------------------------
 
@@ -1683,7 +1683,7 @@ After you clone a repository and make a few changes of your own, you
 may wish to check the original repository for updates and merge them
 into your own work.
 
-We have already seen <<Updating-a-repository-with-git-fetch,how to
+We have already seen <<Updating-a-repository-With-git-fetch,how to
 keep remote tracking branches up to date>> with linkgit:git-fetch[1],
 and how to merge two branches.  So you can merge in changes from the
 original repository's master branch with:
@@ -1794,7 +1794,7 @@ Public git repositories
 
 Another way to submit changes to a project is to tell the maintainer
 of that project to pull the changes from your repository using
-linkgit:git-pull[1].  In the section "<<getting-updates-with-git-pull,
+linkgit:git-pull[1].  In the section "<<getting-updates-With-git-pull,
 Getting updates with git-pull>>" we described this as a way to get
 updates from the "main" repository, but it works just as well in the
 other direction.
@@ -2004,7 +2004,7 @@ $ git push ssh://yourserver.com/~you/proj.git +master
 Normally whenever a branch head in a public repository is modified, it
 is modified to point to a descendant of the commit that it pointed to
 before.  By forcing a push in this situation, you break that convention.
-(See <<problems-with-rewriting-history>>.)
+(See <<problems-With-rewriting-history>>.)
 
 Nevertheless, this is a common practice for people that need a simple
 way to publish a work-in-progress patch series, and it is an acceptable
@@ -2573,7 +2573,7 @@ There are numerous other tools, such as StGIT, which exist for the
 purpose of maintaining a patch series.  These are outside of the scope of
 this manual.
 
-[[problems-with-rewriting-history]]
+[[problems-With-rewriting-history]]
 Problems with rewriting history
 -------------------------------
 
