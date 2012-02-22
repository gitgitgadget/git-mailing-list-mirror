From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation/merge-options.txt: group "ff" related options
 together
Date: Wed, 22 Feb 2012 14:27:07 -0800
Message-ID: <7vmx8a8pxg.fsf_-_@alter.siamese.dyndns.org>
References: <DB0837FD-0963-4BF9-BD7B-B243F580CC1C@imgtec.com>
 <7vr4xm8qin.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean Gies <Sean.Gies@imgtec.com>
To: "git\@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 22 23:27:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Kea-0002QC-OE
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 23:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894Ab2BVW1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 17:27:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41759 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282Ab2BVW1K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 17:27:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C30564E8;
	Wed, 22 Feb 2012 17:27:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wOwrDs6Pr4lD4C6Pj2p2KQXWd6g=; b=Odt46i
	sasULmYtP8cioqt9c5Gjqnj1wA05rw/+Xldd53HFMYx6HSc9F3/z3pNv/q8aPqp3
	sKmkg6lZOGuQSNDEIt45RRNg7d/aTuX4hdX3mC1YtLJokoQUoKHSrWYt42zaj/EY
	U9dLmLqnwR+XVCwYg7Wb+W2oRPiEku8CBwq+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d9NR4tPXj1yz9BFuOgBl5RHMXGPjC1pa
	aoBOQQlwvKqHH1EAtq6gQNR1DL/F57/RCwHLxXJKcM6mIbg/GELO3fm3KlKBJOQ4
	gVlzYaaxzacPumV7NIGMqKCvMQONCoTSq3d9BGkaVz09ii14M5VK3dr1L0ia29Gy
	+SmEmCTPaFI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42C1164E7;
	Wed, 22 Feb 2012 17:27:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B909A64E5; Wed, 22 Feb 2012
 17:27:08 -0500 (EST)
In-Reply-To: <7vr4xm8qin.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 22 Feb 2012 14:14:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B6C83CA-5DA4-11E1-87B5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191300>

The --ff-only option was not described next to --ff and --no-ff options in
"git merge" documentation, even though these three are logically together,
describing one option that takes one of three values.

Also the description for '--ff' and '--no-ff' discussed what '--ff' means,
and mentioned '--no-ff' as if it were a side-note to '--ff'.

Make them into three top-level entries and list them together. This way,
it would be more clear that the user can choose one from these three.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Perhaps a patch like this would be an improvement to make it easier to
   find the options.

 Documentation/merge-options.txt |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index f2f1d0f..0bcbe0a 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -24,13 +24,18 @@ updated behaviour, the environment variable `GIT_MERGE_AUTOEDIT` can be
 set to `no` at the beginning of them.
 
 --ff::
+	When the merge resolves as a fast-forward, only update the branch
+	pointer, without creating a merge commit.  This is the default
+	behavior.
+
 --no-ff::
-	Do not generate a merge commit if the merge resolved as
-	a fast-forward, only update the branch pointer. This is
-	the default behavior of git-merge.
-+
-With --no-ff Generate a merge commit even if the merge
-resolved as a fast-forward.
+	Create a merge commit even when the merge resolves as a
+	fast-forward.
+
+--ff-only::
+	Refuse to merge and exit with a non-zero status unless the
+	current `HEAD` is already up-to-date or the merge can be
+	resolved as a fast-forward.
 
 --log[=<n>]::
 --no-log::
@@ -65,11 +70,6 @@ merge.
 With --no-squash perform the merge and commit the result. This
 option can be used to override --squash.
 
---ff-only::
-	Refuse to merge and exit with a non-zero status unless the
-	current `HEAD` is already up-to-date or the merge can be
-	resolved as a fast-forward.
-
 -s <strategy>::
 --strategy=<strategy>::
 	Use the given merge strategy; can be supplied more than
