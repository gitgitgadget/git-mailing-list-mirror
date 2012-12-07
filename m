From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation/diff-config: work around AsciiDoc misfortune
Date: Fri, 07 Dec 2012 15:34:12 -0800
Message-ID: <7v1uf1fnd7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 00:34:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th7RA-0003g1-39
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 00:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503Ab2LGXeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 18:34:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753921Ab2LGXeP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 18:34:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71397A529;
	Fri,  7 Dec 2012 18:34:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=r
	0r+NYkCRqU251bk84VR2r7MWQU=; b=TV3B+sVLlRcGetZLAX5Q0HSebQT2P4nNo
	L7c6jmkdhgQvG+MJksPJccE0VZeE6JrOYR+TZOkXsnNCcTwVLNEcWobBwXN2JBzn
	Oqxxogiuu8rsAse0k0jFUfkEXi7ZzVAqSpWHY85lCladqMAnfTmZWStKM0PAUTEy
	CXxjklGZIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=p/p
	BAUzlis1UpFCJPxb/REzz0TgDd/kDiAdi3hZHoJi0139ZVdRxAqzldNhTQsy+tUW
	7DJk6nCGNERkWVZdMEM4xPR8/RkfMRY8lDhJaGf1lTwXsQawCFNynbtNa3W9cspW
	HbV4xSCrJcdakejuyov7e5Ouw2bGvqtpURSpqCVA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E06CA528;
	Fri,  7 Dec 2012 18:34:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7C48A525; Fri,  7 Dec 2012
 18:34:13 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BE32DE0-40C6-11E2-8062-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211204>

The line that happens to begin with indent followed by "3. " was
interpreted as if it were an enumerated list; just wrap the lines
differently to work it around for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The last section of Documentation/technical/api-command.txt has a
   related/similar issue in that AsciiDoc wants to renumber them
   starting from 1 not from 0, as all humans do, but the result is
   more desirable.  I'll leave a patch to renumber them in the
   source to others, as I am busy cutting the 1.8.1-rc1 today.

   But "3" in this one is not the beginning of an enumerated item;
   it is cardinal (i.e. counting), not ordinal, and needs to be
   corrected before the final release.

 Documentation/diff-config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 89dd634..4314ad0 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -57,8 +57,8 @@ diff.statGraphWidth::
 	to all commands generating --stat output except format-patch.
 
 diff.context::
-	Generate diffs with <n> lines of context instead of the default of
-	3. This value is overridden by the -U option.
+	Generate diffs with <n> lines of context instead of the default
+	of 3. This value is overridden by the -U option.
 
 diff.external::
 	If this config variable is set, diff generation is not
-- 
1.8.1.rc1.123.gb624e49
