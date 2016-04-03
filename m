From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/34] Documentation/diff-config: fix description of diff.renames
Date: Sun,  3 Apr 2016 10:23:27 -0700
Message-ID: <1459704240-28792-1-git-send-email-gitster@pobox.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 19:24:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amll1-0006kJ-4C
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 19:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbcDCRYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 13:24:06 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56358 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751534AbcDCRYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 13:24:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2BB3150F74;
	Sun,  3 Apr 2016 13:24:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=PtXpHOzps8P56gbJGbQEdX9bpGA
	=; b=H7/O1cX2jAgHkkc4l/j+103wATZYj6LnX5eS30wwtT6I17CgfOg3PwFzKba
	xptMUEaGoqScuvhv2R2hY9XkQemctbQWMnSBvZDDocQmvNctGWGxLEc75gZflsOA
	MUhaxF1roc177zA7on0du8c5OjnC05yxBK+hw+kR11OKc6fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=RjClknM7AQZRQ/LTvwU1n
	zBZ0oBmjHjGwyaKkeuKpjSrnSVHDkTtIJpY/MOiDuG39FyTdYFwwEy3NpJm99xRC
	7ho7F6gQEcpb0Oi+DKyV+Y48CrokjooFhibryJ8boqm/yChxmQ3fxCuJZCSCro6x
	bpXQBdDJQMDbO5yZGsFfY0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 23F4250F73;
	Sun,  3 Apr 2016 13:24:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6CEDE50F6E;
	Sun,  3 Apr 2016 13:24:02 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-246-g1783343
X-Pobox-Relay-ID: DBFEEBA6-F9C0-11E5-A5A5-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290640>

From: Matthieu Moy <Matthieu.Moy@imag.fr>

The description was misleading, since "set to any boolean value" include
"set to false", and diff.renames=false does not enable basic detection,
but actually disables it. Also, document that diff.renames only affects
Porcelain.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-config.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 6eaa452..cf4a915 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -108,9 +108,13 @@ diff.renameLimit::
 	detection; equivalent to the 'git diff' option '-l'.
 
 diff.renames::
-	Tells Git to detect renames.  If set to any boolean value, it
-	will enable basic rename detection.  If set to "copies" or
-	"copy", it will detect copies, as well.
+	Whether and how Git detects renames.  If set to "false",
+	rename detection is disabled. If set to "true", basic rename
+	detection is enabled.  If set to "copies" or "copy", Git will
+	detect copies, as well.  Defaults to false.  Note that this
+	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
+	linkgit:git-log[1], and not lower level commands such as
+	linkgit:git-diff-files[1].
 
 diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
-- 
2.8.0-246-g1783343
