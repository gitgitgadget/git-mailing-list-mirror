From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] SubmittingPatches: remove overlong checklist
Date: Tue,  1 Jan 2013 15:24:55 -0800
Message-ID: <1357082695-29713-4-git-send-email-gitster@pobox.com>
References: <1357082695-29713-1-git-send-email-gitster@pobox.com>
Cc: Jason Holden <jason.k.holden.swdev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 02 00:25:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqBD8-0001aT-OX
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 00:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab3AAXZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 18:25:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63703 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221Ab3AAXZE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 18:25:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 357F4A4FE;
	Tue,  1 Jan 2013 18:25:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0T3a
	e/b6SmKeOZjzi4f4Zrjv0X0=; b=S0Ov386z0B375MopdowjoWRP1IQ/w6Kz0IEU
	dtbl3qeNTpLKZ19Yov5jkTBvXUkz0BKlEfJEBVBsg2s3TPtAOD9/gHiP5WcFyPA5
	vVtE9QLau5q9c/c2+ISNs7gp9fbqi1GTgHGDdwFjjI/gCm3Gm65vCGMjefMVhgG8
	0xNxdiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	lEL68YEur0L634GyWIF/rM1pIB3lW4rtUmf5fXJTrxAKR6Iu/RJ4xA3X0pB5t+0L
	AP17GcUMiIP71xSCTByr5Lwle9BkJ+YN0LTG1Nco1igW/UQf+2R2Ecj19JvhcSYW
	x1zKMx4plOm6JplAWys23AqZI7Fts9OT7aa7i4ygJ2s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26495A4FD;
	Tue,  1 Jan 2013 18:25:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B220A4FC; Tue,  1 Jan 2013
 18:25:03 -0500 (EST)
X-Mailer: git-send-email 1.8.1.209.gc32ab23
In-Reply-To: <1357082695-29713-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7801B79A-546A-11E2-A625-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212473>

The section is no longer a concise checklist.  It also talks about
things that are not covered in the "Long version" text, which means
people need to read both, covering more or less the same thing in
different phrasing.

Fold the details into the main text and remove the section.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 126 +++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 73 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e810263..a7daad3 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -1,65 +1,3 @@
-Checklist (and a short version for the impatient):
-
-	Commits:
-
-	- make commits of logical units
-	- check for unnecessary whitespace with "git diff --check"
-	  before committing
-	- do not check in commented out code or unneeded files
-	- the first line of the commit message should be a short
-	  description (50 characters is the soft limit, see DISCUSSION
-	  in git-commit(1)), and should skip the full stop
-	- it is also conventional in most cases to prefix the
-	  first line with "area: " where the area is a filename
-	  or identifier for the general area of the code being
-	  modified, e.g.
-	  . archive: ustar header checksum is computed unsigned
-	  . git-cherry-pick.txt: clarify the use of revision range notation
-	  (if in doubt which identifier to use, run "git log --no-merges"
-	  on the files you are modifying to see the current conventions)
-	- the body should provide a meaningful commit message, which:
-	  . explains the problem the change tries to solve, iow, what
-	    is wrong with the current code without the change.
-	  . justifies the way the change solves the problem, iow, why
-	    the result with the change is better.
-	  . alternate solutions considered but discarded, if any.
-	- describe changes in imperative mood, e.g. "make xyzzy do frotz"
-	  instead of "[This patch] makes xyzzy do frotz" or "[I] changed
-	  xyzzy to do frotz", as if you are giving orders to the codebase
-	  to change its behaviour.
-	- try to make sure your explanation can be understood without
-	  external resources. Instead of giving a URL to a mailing list
-	  archive, summarize the relevant points of the discussion.
-	- add a "Signed-off-by: Your Name <you@example.com>" line to the
-	  commit message (or just use the option "-s" when committing)
-	  to confirm that you agree to the Developer's Certificate of Origin
-	- make sure that you have tests for the bug you are fixing
-	- make sure that the test suite passes after your commit
-
-	Patch:
-
-	- use "git format-patch -M" to create the patch
-	- do not PGP sign your patch
-	- do not attach your patch, but read in the mail
-	  body, unless you cannot teach your mailer to
-	  leave the formatting of the patch alone.
-	- be careful doing cut & paste into your mailer, not to
-	  corrupt whitespaces.
-	- provide additional information (which is unsuitable for
-	  the commit message) between the "---" and the diffstat
-	- if you change, add, or remove a command line option or
-	  make some other user interface change, the associated
-	  documentation should be updated as well.
-	- if your name is not writable in ASCII, make sure that
-	  you send off a message in the correct encoding.
-	- send the patch to the list (git@vger.kernel.org) and the
-	  maintainer (gitster@pobox.com) if (and only if) the patch
-	  is ready for inclusion. If you use git-send-email(1),
-	  please test it first by sending email to yourself.
-	- see below for instructions specific to your mailer
-
-Long version:
-
 Here are some guidelines for people who want to contribute their code
 to this software.
 
@@ -119,13 +57,52 @@ change, the approach taken by the change, and if relevant how this
 differs substantially from the prior version, are all good things
 to have.
 
+Make sure that you have tests for the bug you are fixing.
+
+When adding a new feature, make sure that you have new tests to show
+the feature triggers the new behaviour when it should, and to show the
+feature does not trigger when it shouldn't.  Also make sure that the
+test suite passes after your commit.  Do not forget to update the
+documentation to describe the updated behaviour.
+
 Oh, another thing.  I am picky about whitespaces.  Make sure your
 changes do not trigger errors with the sample pre-commit hook shipped
 in templates/hooks--pre-commit.  To help ensure this does not happen,
 run git diff --check on your changes before you commit.
 
+(2) Describe your changes well.
+
+The first line of the commit message should be a short description (50
+characters is the soft limit, see DISCUSSION in git-commit(1)), and
+should skip the full stop.  It is also conventional in most cases to
+prefix the first line with "area: " where the area is a filename or
+identifier for the general area of the code being modified, e.g.
+
+  . archive: ustar header checksum is computed unsigned
+  . git-cherry-pick.txt: clarify the use of revision range notation
+
+If in doubt which identifier to use, run "git log --no-merges" on the
+files you are modifying to see the current conventions.
+
+The body should provide a meaningful commit message, which:
 
-(2) Generate your patch using git tools out of your commits.
+  . explains the problem the change tries to solve, iow, what is wrong
+    with the current code without the change.
+
+  . justifies the way the change solves the problem, iow, why the
+    result with the change is better.
+
+  . alternate solutions considered but discarded, if any.
+
+Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
+instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
+to do frotz", as if you are giving orders to the codebase to change
+its behaviour.  Try to make sure your explanation can be understood
+without external resources. Instead of giving a URL to a mailing list
+archive, summarize the relevant points of the discussion.
+
+
+(3) Generate your patch using git tools out of your commits.
 
 git based diff tools generate unidiff which is the preferred format.
 
@@ -133,22 +110,27 @@ You do not have to be afraid to use -M option to "git diff" or
 "git format-patch", if your patch involves file renames.  The
 receiving end can handle them just fine.
 
-Please make sure your patch does not include any extra files
-which do not belong in a patch submission.  Make sure to review
+Please make sure your patch does not add commented out debugging code,
+or include any extra files which do not relate to what your patch
+is trying to achieve. Make sure to review
 your patch after generating it, to ensure accuracy.  Before
 sending out, please make sure it cleanly applies to the "master"
 branch head.  If you are preparing a work based on "next" branch,
 that is fine, but please mark it as such.
 
 
-(3) Sending your patches.
+(4) Sending your patches.
 
 People on the git mailing list need to be able to read and
 comment on the changes you are submitting.  It is important for
 a developer to be able to "quote" your changes, using standard
 e-mail tools, so that they may comment on specific portions of
 your code.  For this reason, all patches should be submitted
-"inline".  WARNING: Be wary of your MUAs word-wrap
+"inline".  If your log message (including your name on the
+Signed-off-by line) is not writable in ASCII, make sure that
+you send off a message in the correct encoding.
+
+WARNING: Be wary of your MUAs word-wrap
 corrupting your patch.  Do not cut-n-paste your patch; you can
 lose tabs that way if you are not careful.
 
@@ -200,16 +182,14 @@ patch, format it as "multipart/signed", not a text/plain message
 that starts with '-----BEGIN PGP SIGNED MESSAGE-----'.  That is
 not a text/plain, it's something else.
 
-Unless your patch is a very trivial and an obviously correct one,
-first send it with "To:" set to the mailing list, with "cc:" listing
+Send your patch with "To:" set to the mailing list, with "cc:" listing
 people who are involved in the area you are touching (the output from
 "git blame $path" and "git shortlog --no-merges $path" would help to
 identify them), to solicit comments and reviews.  After the list
 reached a consensus that it is a good idea to apply the patch, re-send
-it with "To:" set to the maintainer and optionally "cc:" the list for
-inclusion.  Do not forget to add trailers such as "Acked-by:",
-"Reviewed-by:" and "Tested-by:" after your "Signed-off-by:" line as
-necessary.
+it with "To:" set to the maintainer and "cc:" the list for inclusion.
+Do not forget to add trailers such as "Acked-by:", "Reviewed-by:" and
+"Tested-by:" after your "Signed-off-by:" line as necessary.
 
 
 (4) Sign your work
-- 
1.8.1.209.gc32ab23
