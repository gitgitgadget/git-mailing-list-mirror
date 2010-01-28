From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] tests: update tests that used to fail
Date: Thu, 28 Jan 2010 00:42:31 -0800
Message-ID: <7vtyu6mxhk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 09:42:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaPxb-0007fg-9D
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 09:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693Ab0A1Imh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 03:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755618Ab0A1Imh
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 03:42:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab0A1Imh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 03:42:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 969F493644;
	Thu, 28 Jan 2010 03:42:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=odkM
	9yxrX8gqCLnaAbumTxKbkWI=; b=uuSQGdd1Q4hL9C8iIJywv2/niRB3Jx1HO5Lb
	gAtE91NgM7oiDrRZ0q280GrJilPT514aTjYRVxnCbC79Kvk3qB1rkk95SclFAdrP
	9jaDTuvDijQgdDt+Poil7Hzb65o/kd5563zILd6fPC4tyynPdBazkEgrIc7biK5q
	UAoMY4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=NvN
	hw4NKiuClqIxg2ZjWmF0X8f5vw4ac6Af8+ic8L2iiMaLvBi4pFADSIuSOMZQ7cFM
	Sc+1W/O6q2dh5t2tdY000OCIYvUKIkVp5QwxwRzI+vxjWrGq4E5XmxI3u8C/XNX0
	qlNPW/18kE5QlacOs22+jFZemvYK6411h8G8Use4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 833E593643;
	Thu, 28 Jan 2010 03:42:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE75C93642; Thu, 28 Jan
 2010 03:42:32 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1496188A-0BE9-11DF-B42B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138226>

"diff --cc" output t4038 tests was fixed by b810cbb (diff --cc: a lost
line at the beginning of the file is shown incorrectly, 2009-07-22), which
was actually the commit that introduced this test..

An error in "git merge -s resolve" t6035 tests was fixed by 730f728
(unpack-trees.c: look ahead in the index, 2009-09-20).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4038-diff-combined.sh        |    2 +-
 t/t6035-merge-dir-to-symlink.sh |    2 +-
 t/t7507-commit-verbose.sh       |    5 -----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 2cf7e01..7584efa 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -76,7 +76,7 @@ test_expect_success 'check combined output (1)' '
 	verify_helper sidewithone
 '
 
-test_expect_failure 'check combined output (2)' '
+test_expect_success 'check combined output (2)' '
 	git show sidesansone -- >sidesansone &&
 	verify_helper sidesansone
 '
diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
index d1b2287..3202e1d 100755
--- a/t/t6035-merge-dir-to-symlink.sh
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -48,7 +48,7 @@ test_expect_success 'setup for merge test' '
 	git tag baseline
 '
 
-test_expect_failure 'do not lose a/b-2/c/d in merge (resolve)' '
+test_expect_success 'do not lose a/b-2/c/d in merge (resolve)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s resolve master &&
