From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] git-tag(1): Refer to git-check-ref-format(1) for <name>
Date: Sat, 22 Aug 2009 09:45:18 +0900
Message-ID: <20090822094518.6117@nanako3.lavabit.com>
References: <87ab2gsqst.fsf@jondo.cante.net> <7veirs6qxn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Jari Aalto <jari.aalto@cante.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 02:48:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeemC-0005yL-0v
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 02:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932848AbZHVAsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 20:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbZHVAsA
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 20:48:00 -0400
Received: from karen.lavabit.com ([72.249.41.33]:45425 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932720AbZHVAsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 20:48:00 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id C6E7A11B88A;
	Fri, 21 Aug 2009 19:48:01 -0500 (CDT)
Received: from 2049.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id ML8GBLQ1T9PA; Fri, 21 Aug 2009 19:48:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=PwIQQW5d0ilzpUJvryZjSFyLaTGDsoe5/y/Mo38l54to+TBlSw8W/xGFk/1+8tO8fwwOO5S7gn9SRQNy0xj8eMiM+Ju3uc3eVz5QpgnbXEXVXUUTYvUaRWPb3/VKrwU3Mvb2U0TSZudb3oPlGCAqpzroorrIVosVSO2Nwxvp5vc=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7veirs6qxn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126775>

Quoting Junio C Hamano <gitster@pobox.com>

  but at the same time, I wish if we can somehow teach people that the
  branches and the tags are just two special cases of refs that follow
  exactly the same set of rules, we would not have to apply another
  similar patch to git-branch documentation and instead we can teach what
  the naming rules are for refs in general.  Then the readers can learn
  the rule once, and extend the knowledge to other types of refs
  (e.g. notes) in the future.

I read the help page for the git-branch command and noticed that we don't
need a similar patch. I think the git-branch help is nicer than git-tag
help because it doesn't reproduce the rule in an incomplete way that can
lead to confusion, divergence, and additional maintenance hassle.

-- 8< -- 8< -- 8< -- cut here >8 -- >8 -- >8 --

Subject: Documentation: consistently refer to check-ref-format

Change the <name> placeholder to <tagname> in the SYNOPSIS section of
git-tag documentation, and describe it in the OPTIONS section in a way
similar to how documentation for git-branch does.

Add SEE ALSO section to list the other documentation pages these two pages
refer to.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

 Documentation/git-branch.txt |    6 ++++++
 Documentation/git-tag.txt    |   20 ++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index ae201de..9998887 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -209,6 +209,12 @@ but different purposes:
 - `--no-merged` is used to find branches which are candidates for merging
   into HEAD, since those branches are not fully contained by HEAD.
 
+SEE ALSO
+--------
+linkgit:git-check-ref-format[1],
+linkgit:git-fetch[1],
+linkgit:git-remote[1].
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org> and Junio C Hamano <gitster@pobox.com>
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 1118ce2..5113eae 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -10,17 +10,15 @@ SYNOPSIS
 --------
 [verse]
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
-	<name> [<commit> | <object>]
-'git tag' -d <name>...
+	<tagname> [<commit> | <object>]
+'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>]
-'git tag' -v <name>...
+'git tag' -v <tagname>...
 
 DESCRIPTION
 -----------
 
-Adds a 'tag' reference in `.git/refs/tags/`.  The tag <name> must pass
-linkgit:git-check-ref-format[1] which basicly means that control characters,
-space, ~, ^, :, ?, *, [ and \ are prohibited.
+Adds a tag reference in `.git/refs/tags/`.
 
 Unless `-f` is given, the tag must not yet exist in
 `.git/refs/tags/` directory.
@@ -88,6 +86,12 @@ OPTIONS
 	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
 	is given.
 
+<tagname>::
+	The name of the tag to create, delete, or describe.
+	The new tag name must pass all checks defined by
+	linkgit:git-check-ref-format[1].  Some of these checks
+	may restrict the characters allowed in a tag name.
+
 CONFIGURATION
 -------------
 By default, 'git-tag' in sign-with-default mode (-s) will use your
@@ -252,6 +256,10 @@ $ GIT_COMMITTER_DATE="2006-10-02 10:31" git tag -s v1.0.1
 ------------
 
 
+SEE ALSO
+--------
+linkgit:git-check-ref-format[1].
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>,

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
