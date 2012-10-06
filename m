From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch 4/5] Create html documents for all files in
 Documentation/howto
Date: Sat, 6 Oct 2012 17:57:05 +0200 (CEST)
Message-ID: <459552956.269766.1349539025462.JavaMail.ngmail@webmail08.arcor-online.net>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker66@arcor.de
To: th.acker66@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 17:57:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKWkh-00046L-VL
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 17:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756211Ab2JFP5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 11:57:10 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:47559 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754199Ab2JFP5I (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2012 11:57:08 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mx.arcor.de (Postfix) with ESMTP id 7377CE4067
	for <git@vger.kernel.org>; Sat,  6 Oct 2012 17:57:05 +0200 (CEST)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 73ABB7DA0F2;
	Sat,  6 Oct 2012 17:57:05 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id 6C48A1AB3A9;
	Sat,  6 Oct 2012 17:57:05 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-15.arcor-online.net 6C48A1AB3A9
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1349539025; bh=lVodoCoBqjb15YPVrilnMaR7rI+J4MT64ZcRi5NtqPA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=VdJdBLJttefxctcU1jUog/13moKbYhqJIg2Fyi0MgMUDsv6452tYbWi3+Rq2VXIn1
	 i3ThGS6JpFJ6RIMFyoAZq6ixsvonedBBhzvBwDdNm+zO1mA6AhxGIKmgwZtliUxqML
	 tAKDvnLC3YwYU7EbqrI4MX7ziW/ay//jLDUQKhAs=
Received: from [94.217.29.222] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 6 Oct 2012 17:57:05 +0200 (CEST)
In-Reply-To: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.29.222
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207155>

- add missing files
- fix some asciidoc layout problems

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/Makefile                             | 10 +++++
 Documentation/howto/maintain-git.txt               |  4 ++
 .../howto/rebase-from-internal-branch.txt          | 11 ++---
 Documentation/howto/rebuild-from-update-hook.txt   |  4 ++
 .../howto/recover-corrupted-blob-object.txt        | 10 +++++
 Documentation/howto/revert-a-faulty-merge.txt      |  4 ++
 Documentation/howto/separating-topic-branches.txt  |  4 ++
 Documentation/howto/setup-git-server-over-http.txt |  4 ++
 Documentation/howto/update-hook-example.txt        | 50 +++++++++++-----------
 Documentation/howto/use-git-daemon.txt             |  3 ++
 .../howto/using-signed-tag-in-pull-request.txt     |  4 +-
 11 files changed, 76 insertions(+), 32 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 80eb06d..abd27b5 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -24,6 +24,16 @@ SP_ARTICLES = user-manual
 SP_ARTICLES += howto/revert-branch-rebase
 SP_ARTICLES += howto/using-merge-subtree
 SP_ARTICLES += howto/using-signed-tag-in-pull-request
+SP_ARTICLES += howto/use-git-daemon
+SP_ARTICLES += howto/update-hook-example
+SP_ARTICLES += howto/setup-git-server-over-http
+SP_ARTICLES += howto/separating-topic-branches
+SP_ARTICLES += howto/revert-a-faulty-merge
+SP_ARTICLES += howto/recover-corrupted-blob-object
+SP_ARTICLES += howto/rebuild-from-update-hook
+SP_ARTICLES += howto/rebuild-from-update-hook
+SP_ARTICLES += howto/rebase-from-internal-branch
+SP_ARTICLES += howto/maintain-git
 RELNOTES = $(patsubst %.txt,%,$(wildcard RelNotes/*.txt))
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
 API_DOCS += technical/index-format
diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index 8823a37..58fd809 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -5,6 +5,10 @@ Abstract: Imagine that git development is racing along as usual, when our friend
  neighborhood maintainer is struck down by a wayward bus. Out of the
  hordes of suckers (loyal developers), you have been tricked (chosen) to
  step up as the new maintainer. This howto will show you "how to" do it.
+Content-type: text/asciidoc
+
+Maintain Git
+============
 
 The maintainer's git time is spent on three activities.
 
diff --git a/Documentation/howto/rebase-from-internal-branch.txt b/Documentation/howto/rebase-from-internal-branch.txt
index 74a1c0c..577b9a7 100644
--- a/Documentation/howto/rebase-from-internal-branch.txt
+++ b/Documentation/howto/rebase-from-internal-branch.txt
@@ -8,7 +8,12 @@ Abstract: In this article, JC talks about how he rebases the
  the "master" branch, and how "rebase" works.  Also discussed
  is how this applies to individual developers who sends patches
  upstream.
+Content-type: text/asciidoc
 
+Rebase from internal branch
+===========================
+
+--------------------------------------
 Petr Baudis <pasky@suse.cz> writes:
 
 > Dear diary, on Sun, Aug 14, 2005 at 09:57:13AM CEST, I got a letter
@@ -19,6 +24,7 @@ Petr Baudis <pasky@suse.cz> writes:
 >> > branch to the real branches.
 >>
 > Actually, wouldn't this be also precisely for what StGIT is intended to?
+--------------------------------------
 
 Exactly my feeling.  I was sort of waiting for Catalin to speak
 up.  With its basing philosophical ancestry on quilt, this is
@@ -156,8 +162,3 @@ you continue on starting from the new "master" head, which is
 the #1' commit.
 
 -jc
-
--
-To unsubscribe from this list: send the line "unsubscribe git" in
-the body of a message to majordomo@vger.kernel.org
-More majordomo info at  http://vger.kernel.org/majordomo-info.html
diff --git a/Documentation/howto/rebuild-from-update-hook.txt b/Documentation/howto/rebuild-from-update-hook.txt
index 48c6756..7aa13ac 100644
--- a/Documentation/howto/rebuild-from-update-hook.txt
+++ b/Documentation/howto/rebuild-from-update-hook.txt
@@ -5,6 +5,10 @@ Date: Fri, 26 Aug 2005 18:19:10 -0700
 Abstract: In this how-to article, JC talks about how he
  uses the post-update hook to automate git documentation page
  shown at http://www.kernel.org/pub/software/scm/git/docs/.
+Content-type: text/asciidoc
+
+Rebuild from update hook
+========================
 
 The pages under http://www.kernel.org/pub/software/scm/git/docs/
 are built from Documentation/ directory of the git.git project
diff --git a/Documentation/howto/recover-corrupted-blob-object.txt b/Documentation/howto/recover-corrupted-blob-object.txt
index 323b513..2af4ad7 100644
--- a/Documentation/howto/recover-corrupted-blob-object.txt
+++ b/Documentation/howto/recover-corrupted-blob-object.txt
@@ -3,11 +3,17 @@ From: Linus Torvalds <torvalds@linux-foundation.org>
 Subject: corrupt object on git-gc
 Abstract: Some tricks to reconstruct blob objects in order to fix
  a corrupted repository.
+Content-type: text/asciidoc
 
+Recover corrupted blob object
+=============================
+
+-----------------------------------------------------------
 On Fri, 9 Nov 2007, Yossi Leybovich wrote:
 >
 > Did not help still the repository look for this object?
 > Any one know how can I track this object and understand which file is it
+-----------------------------------------------------------
 
 So exactly *because* the SHA1 hash is cryptographically secure, the hash
 itself doesn't actually tell you anything, in order to fix a corrupt
@@ -31,19 +37,23 @@ original object, so right now the corrupt object is useless, but it's very
 interesting for the future, in the hope that you can re-create a
 non-corrupt version.
 
+-----------------------------------------------------------
 So:
 
 > ib]$ mv .git/objects/4b/9458b3786228369c63936db65827de3cc06200 ../
+-----------------------------------------------------------
 
 This is the right thing to do, although it's usually best to save it under
 it's full SHA1 name (you just dropped the "4b" from the result ;).
 
 Let's see what that tells us:
 
+-----------------------------------------------------------
 > ib]$ git-fsck --full
 > broken link from    tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
 >              to    blob 4b9458b3786228369c63936db65827de3cc06200
 > missing blob 4b9458b3786228369c63936db65827de3cc06200
+-----------------------------------------------------------
 
 Ok, I removed the "dangling commit" messages, because they are just
 messages about the fact that you probably have rebased etc, so they're not
diff --git a/Documentation/howto/revert-a-faulty-merge.txt b/Documentation/howto/revert-a-faulty-merge.txt
index 6fd7119..936c3a9 100644
--- a/Documentation/howto/revert-a-faulty-merge.txt
+++ b/Documentation/howto/revert-a-faulty-merge.txt
@@ -7,6 +7,10 @@ Abstract: Sometimes a branch that was already merged to the mainline
  after the offending branch is fixed.
 Message-ID: <7vocz8a6zk.fsf@gitster.siamese.dyndns.org>
 References: <alpine.LFD.2.00.0812181949450.14014@localhost.localdomain>
+Content-type: text/asciidoc
+
+Revert a faulty merge
+=====================
 
 Alan <alan@clueserver.org> said:
 
diff --git a/Documentation/howto/separating-topic-branches.txt b/Documentation/howto/separating-topic-branches.txt
index 6d3eb8e..17c1602 100644
--- a/Documentation/howto/separating-topic-branches.txt
+++ b/Documentation/howto/separating-topic-branches.txt
@@ -1,6 +1,10 @@
 From: Junio C Hamano <gitster@pobox.com>
 Subject: Separating topic branches
 Abstract: In this article, JC describes how to separate topic branches.
+Content-type: text/asciidoc
+
+Separating topic branches
+=========================
 
 This text was originally a footnote to a discussion about the
 behaviour of the git diff commands.
diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index 622ee5c..69dab4b 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -1,6 +1,10 @@
 From: Rutger Nijlunsing <rutger@nospam.com>
 Subject: Setting up a git repository which can be pushed into and pulled from over HTTP(S).
 Date: Thu, 10 Aug 2006 22:00:26 +0200
+Content-type: text/asciidoc
+
+Setup git server over http
+==========================
 
 Since Apache is one of those packages people like to compile
 themselves while others prefer the bureaucrat's dream Debian, it is
diff --git a/Documentation/howto/update-hook-example.txt b/Documentation/howto/update-hook-example.txt
index b7f8d41..063d967 100644
--- a/Documentation/howto/update-hook-example.txt
+++ b/Documentation/howto/update-hook-example.txt
@@ -5,6 +5,10 @@ Message-ID: <7vfypumlu3.fsf@assigned-by-dhcp.cox.net>
 Abstract: An example hooks/update script is presented to
  implement repository maintenance policies, such as who can push
  into which branch and who can make a tag.
+Content-type: text/asciidoc
+
+Update hook example
+===================
 
 When your developer runs git-push into the repository,
 git-receive-pack is run (either locally or over ssh) as that
@@ -32,8 +36,7 @@ like this as your hooks/update script.
 [jc: editorial note.  This is a much improved version by Carl
 since I posted the original outline]
 
--- >8 -- beginning of script -- >8 --
-
+----------------------------------------------------
 #!/bin/bash
 
 umask 002
@@ -111,12 +114,12 @@ then
 
       info "Found matching head pattern: '$head_pattern'"
       for user_pattern in $user_patterns; do
-	info "Checking user: '$username' against pattern: '$user_pattern'"
-	matchlen=$(expr "$username" : "$user_pattern")
-	if test "$matchlen" = "${#username}"
-	then
-	  grant "Allowing user: '$username' with pattern: '$user_pattern'"
-	fi
+	    info "Checking user: '$username' against pattern: '$user_pattern'"
+	    matchlen=$(expr "$username" : "$user_pattern")
+	    if test "$matchlen" = "${#username}"
+	    then
+	      grant "Allowing user: '$username' with pattern: '$user_pattern'"
+	    fi
       done
       deny "The user is not in the access list for this branch"
     done
@@ -149,13 +152,13 @@ then
 
       info "Found matching head pattern: '$head_pattern'"
       for group_pattern in $group_patterns; do
-	for groupname in $groups; do
-	  info "Checking group: '$groupname' against pattern: '$group_pattern'"
-	  matchlen=$(expr "$groupname" : "$group_pattern")
-	  if test "$matchlen" = "${#groupname}"
-	  then
-	    grant "Allowing group: '$groupname' with pattern: '$group_pattern'"
-	  fi
+	    for groupname in $groups; do
+	      info "Checking group: '$groupname' against pattern: '$group_pattern'"
+	      matchlen=$(expr "$groupname" : "$group_pattern")
+	      if test "$matchlen" = "${#groupname}"
+	      then
+	        grant "Allowing group: '$groupname' with pattern: '$group_pattern'"
+	      fi
         done
       done
       deny "None of the user's groups are in the access list for this branch"
@@ -169,24 +172,21 @@ then
 fi
 
 deny >/dev/null "There are no more rules to check.  Denying access"
-
--- >8 -- end of script -- >8 --
+----------------------------------------------------
 
 This uses two files, $GIT_DIR/info/allowed-users and
 allowed-groups, to describe which heads can be pushed into by
 whom.  The format of each file would look like this:
 
-        refs/heads/master	junio
-	+refs/heads/pu		junio
-        refs/heads/cogito$	pasky
-        refs/heads/bw/.*	linus
-        refs/heads/tmp/.*	.*
-        refs/tags/v[0-9].*	junio
+    refs/heads/master   junio
+    +refs/heads/pu      junio
+    refs/heads/cogito$  pasky
+    refs/heads/bw/.*    linus
+    refs/heads/tmp/.*   .*
+    refs/tags/v[0-9].*  junio
 
 With this, Linus can push or create "bw/penguin" or "bw/zebra"
 or "bw/panda" branches, Pasky can do only "cogito", and JC can
 do master and pu branches and make versioned tags.  And anybody
 can do tmp/blah branches. The '+' sign at the pu record means
 that JC can make non-fast-forward pushes on it.
-
-------------
diff --git a/Documentation/howto/use-git-daemon.txt b/Documentation/howto/use-git-daemon.txt
index 4e2f75c..23cdf35 100644
--- a/Documentation/howto/use-git-daemon.txt
+++ b/Documentation/howto/use-git-daemon.txt
@@ -1,4 +1,7 @@
+Content-type: text/asciidoc
+
 How to use git-daemon
+=====================
 
 Git can be run in inetd mode and in stand alone mode. But all you want is
 let a coworker pull from you, and therefore need to set up a git server
diff --git a/Documentation/howto/using-signed-tag-in-pull-request.txt b/Documentation/howto/using-signed-tag-in-pull-request.txt
index 98c0033..7670449 100644
--- a/Documentation/howto/using-signed-tag-in-pull-request.txt
+++ b/Documentation/howto/using-signed-tag-in-pull-request.txt
@@ -7,8 +7,8 @@ Abstract: Beginning v1.7.9, a contributor can push a signed tag to her
  later validate it.
 Content-type: text/asciidoc
 
-Using signed tag in pull requests
-=================================
+Using signed tag in pull request
+================================
 
 A typical distributed workflow using Git is for a contributor to fork a
 project, build on it, publish the result to her public repository, and ask
-- 
1.7.11.msysgit.1
