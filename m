From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation/git-checkout.txt: Explain --orphan without
 introducing an undefined "orphan branch"
Date: Thu, 29 Sep 2011 11:59:07 -0700
Message-ID: <7v39fftbt0.fsf@alter.siamese.dyndns.org>
References: <1316960136073-6829212.post@n2.nabble.com>
 <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
 <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr>
 <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr>
 <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com>
 <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com>
 <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 21:00:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Lpz-0006CT-RD
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 21:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757398Ab1I2S7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 14:59:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62471 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754012Ab1I2S7w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 14:59:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B8C858BD;
	Thu, 29 Sep 2011 14:59:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h1RhioCf4/lWGRzc8XWpXGe66b8=; b=ZqnSbv
	CqWyjtNqH7gzzvtvbjscpRM4trLYpRnp2Yil90TSbhg0OxoogInGOXO9Pi66iymo
	zZ+PSjJktnKMgWFrqO+RPXpQ7yGveNzxrIplzdl45HFxsMrfj3RxCO6t73Dc0nfL
	1KeQ875xRB4jDY2evmrm0O0j6Id0YnQxx0T8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T0WJYOdrN0QkfOLrAoZ90wbh6r3OU4dV
	ZHjgYvKCA3ThAby87A8SruE/PEnyXNMN/zw0PHL+fjXJUHwUAnvdxqilAUxEddGv
	9xbkIMxsaYEA+gzkEwUsXIwICPTiP1asD239wMk8awN7qJa/XRRJ+x/sgFF4uf7H
	ktm+EGZzTto=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 529BB58BC;
	Thu, 29 Sep 2011 14:59:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2AC858BA; Thu, 29 Sep 2011
 14:59:50 -0400 (EDT)
In-Reply-To: <7vmxdnte0j.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 29 Sep 2011 11:11:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 357D7E2A-EACD-11E0-B6F8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182423>

The name of the `--orphan` option to `checkout` is meant to express that
the next commit made on the branch does not have any parent (specifically,
it will not be a child of the current nor start_point commit), but the
glossary calls such a commit 'a root commit'. The explanation however used
an undefined term 'orphan branch', adding mental burden to the first time
readers.

Reword the description to clarify what it does without introducing a new
term, stressing that it is similar to what happens to the "master' branch
in a brand new repository created by `git init`. Also explain that it is
OK to tweak the index and the working tree before creating a commit.

Also mildly discourage the users from using this to originate a new root
commit that tracks material that is unrelated to the main branches in a
single repository with a working tree, and hint a better way of starting
an unrelated history, as it seems to be a common abuse of this option.

We may want to give a synonym `--new-root` to this option and eventually
deprecate the `--orphan` option, as "parent vs orphan" might not
immediately "click" to non native speakers of English (like myself), but
that is a separate topic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I am inclined to suggest doing something like this instead.

 Documentation/git-checkout.txt |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index c0a96e6..63d164e 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -125,16 +125,16 @@ explicitly give a name with '-b' in such a case.
 	below for details.
 
 --orphan::
-	Create a new 'orphan' branch, named <new_branch>, started from
-	<start_point> and switch to it.  The first commit made on this
-	new branch will have no parents and it will be the root of a new
-	history totally disconnected from all the other branches and
-	commits.
+	Adjust the working tree and the index as if you checked out the
+	<start_point>. The next commit begins a history that is not connected
+	to any other branches, as if you ran `git init` in a new repository,
+	except that the commit will be made on the <new_branch> branch, not on
+	the "master" branch.
 +
-The index and the working tree are adjusted as if you had previously run
-"git checkout <start_point>".  This allows you to start a new history
-that records a set of paths similar to <start_point> by easily running
-"git commit -a" to make the root commit.
+Running "git commit" immediately after doing this will record a root commit
+with a tree that is the same as the tree of the <start_point>. You may
+manipulate the index before creating the commit to record a tree that is
+different from that of the <start_point>.
 +
 This can be useful when you want to publish the tree from a commit
 without exposing its full history. You might want to do this to publish
@@ -143,11 +143,13 @@ whose full history contains proprietary or otherwise encumbered bits of
 code.
 +
 If you want to start a disconnected history that records a set of paths
-that is totally different from the one of <start_point>, then you should
-clear the index and the working tree right after creating the orphan
-branch by running "git rm -rf ." from the top level of the working tree.
+that is totally different from the one of <start_point>, you could
+clear the index and the working tree right after "git checkout --orphan"
+by running "git rm -rf ." from the top level of the working tree.
 Afterwards you will be ready to prepare your new files, repopulating the
 working tree, by copying them from elsewhere, extracting a tarball, etc.
+However, such a use case to keep track of a history that is unrelated to
+the main project is better done by starting a new, separate repository.
 
 -m::
 --merge::
