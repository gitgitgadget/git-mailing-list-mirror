From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] t4008: correct stale comments
Date: Sun, 15 Feb 2015 15:43:39 -0800
Message-ID: <1424043824-25242-2-git-send-email-gitster@pobox.com>
References: <1424043824-25242-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 00:44:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YN8r3-0006FA-6Z
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 00:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905AbbBOXnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2015 18:43:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753074AbbBOXns (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2015 18:43:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E4BB39CE5;
	Sun, 15 Feb 2015 18:43:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bO9v
	IRCHUTGM4iIVOkXOveleF3s=; b=QtYLnEnjfL54+wa6okrDpmfDSMy810qpq1Th
	zv7O7Qh2TCwmhZEFLnhl2LtC5wCRRlvvpXD1TtnYb+WdggWao8S/sJuCxfjCiAty
	NaSzI5oKCHW4mccvLMUYsstFBuFeUWkfKxPLnQlyq11Cipi7hZNlP89d2F0tMch8
	LbcqEAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=kJ2hTV
	tNxb1ov1uq2BmoPutt5Qu49TYzdqEesz1ja/Xc816TPD8hk4uhBRP40ETeEMjvEC
	7Z31m5RCW7ZVpUST0m7+p8NkzoH59kEnLsiI2xaszG2oZKnzoOZv+ePKa8U1Q/Uq
	8bZkS8OtdhOK6Cevt+MyhcxZjaC3xs+THcTa8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 061A539CE4;
	Sun, 15 Feb 2015 18:43:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85FCF39CE3;
	Sun, 15 Feb 2015 18:43:47 -0500 (EST)
X-Mailer: git-send-email 2.3.0-266-g5b48884
In-Reply-To: <1424043824-25242-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7C5D9BFA-B56C-11E4-B738-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263857>

A complete rewrite of a single file was originally designed to be
expressed as a deletion immediately followed by a creation of the
same file, and the comments in the test updated here were written to
reflect that design decision made in f345b0a0 (Add -B flag to diff-*
brothers., 2005-05-30).  However, we later realized that a complete
rewrite is merely how a textual diff should be represented at
366175ef (Rework -B output., 2005-06-19), and updated the actual
tests.  But we forgot to update the introductory text while doing
so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4008-diff-break-rewrite.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
index 8920464..a4e771b 100755
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -10,14 +10,14 @@ We have two very different files, file0 and file1, registered in a tree.
 We update file1 so drastically that it is more similar to file0, and
 then remove file0.  With -B, changes to file1 should be broken into
 separate delete and create, resulting in removal of file0, removal of
-original file1 and creation of completely rewritten file1.
+original file1 and creation of completely rewritten file1.  The latter
+two are then merged back into a single "complete rewrite".
 
 Further, with -B and -M together, these three modifications should
 turn into rename-edit of file0 into file1.
 
 Starting from the same two files in the tree, we swap file0 and file1.
-With -B, this should be detected as two complete rewrites, resulting in
-four changes in total.
+With -B, this should be detected as two complete rewrites.
 
 Further, with -B and -M together, these should turn into two renames.
 '
-- 
2.3.0-266-g5b48884
