From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Mon, 17 Dec 2012 00:48:22 -0800
Message-ID: <7vk3shm5d5.fsf@alter.siamese.dyndns.org>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
 <1355726702-27974-2-git-send-email-chris@rorvick.com>
 <7vhanlnnz7.fsf@alter.siamese.dyndns.org> <50CED5D4.5040705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 09:48:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkWNP-0002s5-0w
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 09:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826Ab2LQIs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 03:48:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674Ab2LQIsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 03:48:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D86849F65;
	Mon, 17 Dec 2012 03:48:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SiXg7iqMzDLnFhaHPkENn3BCOoY=; b=BdniCA
	XA28OfY6LmQE2Gt7Iu33J8+eWAKpnJIG9DfL9E5KPvT0aIAgDR6TshP2aOXnUXSt
	A1/cQmmyMjc+OXSyLb9lxeDUtxSatZR8aet/ldGT6LwFWen0YS5LEDUZ2qzaaSRh
	alYSVYZKSIdK8kaf7Ol+kpOKK+qPdsTHi94cA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JYLYciY4+N866/ma7d+46tZBeiOEhmqZ
	jn/lyQqQN7wUbzZX15oLw6Fc9kOJcF2K0pVGnZsiOCZI1V8ADF9ifCMaUeJJFOut
	6Mxa92nSEfUbZLel0ILaOFPnt4UxXLvhDjGwDEsjyQ9LgOO9qAK2Etl83KG6Ga+M
	5Q+znfcemNE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5E249F64;
	Mon, 17 Dec 2012 03:48:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D0EA9F61; Mon, 17 Dec 2012
 03:48:24 -0500 (EST)
In-Reply-To: <50CED5D4.5040705@viscovery.net> (Johannes Sixt's message of
 "Mon, 17 Dec 2012 09:20:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 845E6AD8-4826-11E2-B1C0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211661>

Here is what I tentatively have (so that I do not forget) on 'pu',
marked with "(squash???)", as a suggested update on top of Chris's
patches.

 Documentation/git-checkout.txt | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git c/Documentation/git-checkout.txt w/Documentation/git-checkout.txt
index db89cf7..0e50eeb 100644
--- c/Documentation/git-checkout.txt
+++ w/Documentation/git-checkout.txt
@@ -21,10 +21,13 @@ or the specified tree.  If no paths are given, 'git checkout' will
 also update `HEAD` to set the specified branch as the current
 branch.
 
-'git checkout' [<branch>]::
+'git checkout' <branch>::
 
-	Update the index, working tree, and HEAD to reflect the
-	specified branch.
+	Prepare to work on building new history on <branch>, by
+	pointing the HEAD to the branch and updating the index and
+	the files in the working tree.  Local modifications to the
+	files in the working tree are kept, so that they can be
+	committed on the <branch>.
 +
 If <branch> is not found but there does exist a tracking branch in
 exactly one remote (call it <remote>) with a matching name, treat as
@@ -33,6 +36,11 @@ equivalent to
 ------------
 $ git checkout -b <branch> --track <remote>/<branch>
 ------------
++
+You could omit <branch>, in which case the command degenerates to
+"check out the current branch", which is a glorified no-op with a
+rather expensive side-effects to show only the tracking information,
+if exists, for the current branch.
 
 'git checkout' -b|-B <new_branch> [<start point>]::
 
@@ -54,12 +62,17 @@ $ git checkout <branch>
 that is to say, the branch is not reset/created unless "git checkout" is
 successful.
 
-'git checkout' [--detach] [<commit>]::
+'git checkout' --detach [<commit>]::
+'git checkout' <commit>::
 
-	Update the index and working tree to reflect the specified
-	commit and set HEAD to point directly to <commit> (see
-	"DETACHED HEAD" section.)  Passing `--detach` forces this
-	behavior even if <commit> is a branch.
+	Prepare to work on building new history on top of <commit>,
+	by detaching HEAD at the commit (see "DETACHED HEAD"
+	section), and updating the index and the files in the
+	working tree.  Local modifications to the files in the
+	working tree are kept, so that they can be committed on the
+	<branch>.
++
+Passing `--detach` forces this behavior even if <commit> is a branch.
 
 'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
 
