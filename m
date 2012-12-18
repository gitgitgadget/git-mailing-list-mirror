From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Mon, 17 Dec 2012 17:53:20 -0800
Message-ID: <7vvcc0i0rz.fsf@alter.siamese.dyndns.org>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
 <1355726702-27974-2-git-send-email-chris@rorvick.com>
 <7vhanlnnz7.fsf@alter.siamese.dyndns.org>
 <17103971665F4C4495C6C96086A58B8F@PhilipOakley>
 <7v1ueol6ut.fsf@alter.siamese.dyndns.org>
 <CAH5451nVe1VcD3VzCO7EtKSkzv9CyJs=uqQ9MkMTJEXMTwEvmw@mail.gmail.com>
 <7vobhsjq6a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Chris Rorvick <chris@rorvick.com>,
	Git List <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 02:53:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkmNK-0008F8-2b
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 02:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab2LRBxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 20:53:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36332 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221Ab2LRBxX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 20:53:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6C32A0EB;
	Mon, 17 Dec 2012 20:53:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dA//zEm/0FzAkPTXVZaY4XqxpKE=; b=WuQJDr
	u+TQtC1O/tz5Pbs12OjYwYLo75/buPZTj8x02DAncq8fw81tPxGSG4RCN9wCAeAa
	foxb3FNBmSuU5UzSN6Y4pBMGpdX+XKfPnjgJUfItEWe70ykIK9nFainfio37jme0
	cwpVDF3I5KUzU5vhyb8y7kKV6ev1Afje+eOTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w11mbBx96FuBYGuVf+X8ZdJb1sDTLEIO
	J0Q+5gNPAjDoLqvEJ0SCbDFyUp3FCy/upsoloABxM46JvPwMyUEv5SymKazMz4/n
	CRtIIStKKkzNpCbO+vXVOsrmZt+Uk4eHYKgr0FV0nhn86qGrBpNKAtR7h4eMSGE2
	a1nJWNgf55o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3C8FA0EA;
	Mon, 17 Dec 2012 20:53:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1258BA0E3; Mon, 17 Dec 2012
 20:53:21 -0500 (EST)
In-Reply-To: <7vobhsjq6a.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 17 Dec 2012 13:59:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B401E028-48B5-11E2-A16F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211729>

Junio C Hamano <gitster@pobox.com> writes:

> I agree with you that sightseeing use case where you do not intend
> to make any commit is also important.  That is exactly why I said
> "further work is done on that branch" not "to that branch" in the
> message you are responding to.

Here is a work-in-progress relative to Chris's 83c9989
(Documentation/git-checkout.txt: document 70c9ac2 behavior,
2012-12-17).

Even though "switch to that specific branch" may be easy to grasp as
a concept, I do not think "switch to detached HEAD" makes much
sense, so I ended up with "switch" for the <branch> case, and
"detach" for the "--detach" one, at least for now.

diff --git c/Documentation/git-checkout.txt w/Documentation/git-checkout.txt
index db89cf7..dcf1a32 100644
--- c/Documentation/git-checkout.txt
+++ w/Documentation/git-checkout.txt
@@ -21,10 +21,12 @@ or the specified tree.  If no paths are given, 'git checkout' will
 also update `HEAD` to set the specified branch as the current
 branch.
 
-'git checkout' [<branch>]::
-
-	Update the index, working tree, and HEAD to reflect the
-	specified branch.
+'git checkout' <branch>::
+	To prepare for working on <branch>, switch to it by updating
+	the index and the files in the working tree, and by pointing
+	HEAD at the branch. Local modifications to the files in the
+	working tree are kept, so that they can be committed to the
+	<branch>.
 +
 If <branch> is not found but there does exist a tracking branch in
 exactly one remote (call it <remote>) with a matching name, treat as
@@ -33,6 +35,11 @@ equivalent to
 ------------
 $ git checkout -b <branch> --track <remote>/<branch>
 ------------
++
+You could omit <branch>, in which case the command degenerates to
+"check out the current branch", which is a glorified no-op with a
+rather expensive side-effects to show only the tracking information,
+if exists, for the current branch.
 
 'git checkout' -b|-B <new_branch> [<start point>]::
 
@@ -54,12 +61,17 @@ $ git checkout <branch>
 that is to say, the branch is not reset/created unless "git checkout" is
 successful.
 
-'git checkout' [--detach] [<commit>]::
+'git checkout' --detach [<commit>]::
+'git checkout' <commit>::
 
-	Update the index and working tree to reflect the specified
-	commit and set HEAD to point directly to <commit> (see
-	"DETACHED HEAD" section.)  Passing `--detach` forces this
-	behavior even if <commit> is a branch.
+	Prepare to work on top of <commit>, by detaching HEAD at it
+	(see "DETACHED HEAD" section), and updating the index and the
+	files in the working tree.  Local modifications to the files
+	in the working tree are kept, so that the resulting working
+	tree will be the state recorded in the commit plus the local
+	modifications.
++
+Passing `--detach` forces this behavior even if <commit> is a branch.
 
 'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
 
