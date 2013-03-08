From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.8.2-rc3
Date: Fri, 08 Mar 2013 09:39:24 -0800
Message-ID: <7v7glhhjub.fsf@alter.siamese.dyndns.org>
References: <7v7glils5k.fsf@alter.siamese.dyndns.org>
 <vpqtxommbxo.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 08 18:39:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE1Gs-0000ni-29
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 18:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933088Ab3CHRj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 12:39:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755874Ab3CHRj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 12:39:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD444BC76;
	Fri,  8 Mar 2013 12:39:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cnDgGOOhtU/67UUmwm9Pq4Q8SGo=; b=CZF3VK
	3rxfNmtmdrpQE9yyuBi8Ga6sOOls4lh4W+7ceAg98VEcgwrQS0h2IWEjleHjlWKO
	M4NrF0b44GchF3/eB//lY75gAt3foYeM7K7xEIRhDu8kelkAIfQ/3fbnZtL/8det
	t2yqtyzQAt6mmVRKTMGVUwPjPZQSoFOQ9j5L4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rM2DNyYDffiYj0hJW0+8KMly814iWQIS
	x+kLp4bqLuMz92SkZnpOKkSOF99RtiyDQ6NtnctzvkMorBZjpgL01WOhROhuTC50
	Qltm23k/4h4r7wNJD42n2J+8VAQ+F4oiExx8dKSoki84NWGcZfiv9RsdL/aF8R1B
	MHkGM359RMo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B16C5BC75;
	Fri,  8 Mar 2013 12:39:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F28B1BC71; Fri,  8 Mar 2013
 12:39:25 -0500 (EST)
In-Reply-To: <vpqtxommbxo.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Fri, 08 Mar 2013 11:18:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EFC500C-8817-11E2-81AD-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217672>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> A few suggestions on the release notes (you may safely ignore)

They both look very sensible, at least to me.  Perhaps like this?

Thanks.

 Documentation/RelNotes/1.8.2.txt | 60 +++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/Documentation/RelNotes/1.8.2.txt b/Documentation/RelNotes/1.8.2.txt
index 78c6577..fc606ae 100644
--- a/Documentation/RelNotes/1.8.2.txt
+++ b/Documentation/RelNotes/1.8.2.txt
@@ -1,19 +1,8 @@
 Git v1.8.2 Release Notes
 ========================
 
-Backward compatibility notes
-----------------------------
-
-In the next major release Git 2.0 (not *this* one), we will change the
-behavior of the "git push" command.
-
-When "git push [$there]" does not say what to push, we have used the
-traditional "matching" semantics so far (all your branches were sent
-to the remote as long as there already are branches of the same name
-over there).  We will use the "simple" semantics that pushes the
-current branch to the branch with the same name, only when the current
-branch is set to integrate with that remote branch.  There is a user
-preference configuration variable "push.default" to change this.
+Backward compatibility notes (this release)
+-------------------------------------------
 
 "git push $there tag v1.2.3" used to allow replacing a tag v1.2.3
 that already exists in the repository $there, if the rewritten tag
@@ -22,22 +11,41 @@ that the old tag v1.2.3 points at.  This was found to be error prone
 and starting with this release, any attempt to update an existing
 ref under refs/tags/ hierarchy will fail, without "--force".
 
-When "git add -u" and "git add -A", that does not specify what paths
-to add on the command line, is run from inside a subdirectory, the
+When "git add -u" and "git add -A" that does not specify what paths
+to add on the command line is run from inside a subdirectory, the
 scope of the operation has always been limited to the subdirectory.
 Many users found this counter-intuitive, given that "git commit -a"
 and other commands operate on the entire tree regardless of where you
-are. In this release, these commands give warning in such a case and
-encourage the user to say "git add -u/-A ." instead when restricting
-the scope to the current directory.
-
-At Git 2.0 (not *this* one), we plan to change these commands without
-pathspec to operate on the entire tree.  Forming a habit to type "."
-when you mean to limit the command to the current working directory
-will protect you against the planned future change, and that is the
-whole point of the new message (there will be no configuration
-variable to squelch this warning---it goes against the "habit forming"
-objective).
+are.  In this release, these commands give a warning message that
+suggests the users to use "git add -u/-A ." when they want to limit
+the scope to the current directory; doing so will squelch the message,
+while training their fingers.
+
+
+Backward compatibility notes (for Git 2.0)
+------------------------------------------
+
+When "git push [$there]" does not say what to push, we have used the
+traditional "matching" semantics so far (all your branches were sent
+to the remote as long as there already are branches of the same name
+over there).  In Git 2.0, the default will change to the "simple"
+semantics that pushes the current branch to the branch with the same
+name, only when the current branch is set to integrate with that
+remote branch.  There is a user preference configuration variable
+"push.default" to change this.  If you are an old-timer who is used
+to the "matching" semantics, you can set it to "matching" to keep the
+traditional behaviour.  If you want to live in the future early,
+you can set it to "simple" today without waiting for Git 2.0.
+
+When "git add -u" and "git add -A", that does not specify what paths
+to add on the command line is run from inside a subdirectory, these
+commands will operate on the entire tree in Git 2.0 for consistency
+with "git commit -a" and other commands. Because there will be no
+mechanism to make "git add -u" behave as if "git add -u .", it is
+important for those who are used to "git add -u" (without pathspec)
+updating the index only for paths in the current subdirectory to start
+training their fingers to explicitly say "git add -u ." when they mean
+it before Git 2.0 comes.
 
 
 Updates since v1.8.1
