From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] for-each-ref: document `creatordate` and `creator` fields
Date: Tue, 5 Jan 2016 03:51:57 +0000
Message-ID: <20160105035157.GA1212@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 04:52:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGIfC-0003y2-F7
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 04:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbcAEDv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 22:51:58 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:43225 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753913AbcAEDv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 22:51:58 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0B2A20208;
	Tue,  5 Jan 2016 03:51:57 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283344>

These were introduced back in 2006 at 3175aa1ec28c but
never documented.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 And I just found these very useful, today!

 I also noticed creator{name,email} aren't supported, yet.
 Perhaps they're worth implementing for consistency.

 Documentation/git-for-each-ref.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c6f073c..06208c4 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -142,6 +142,11 @@ In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
 
+For commit and tag objects, the special `creatordate` and `creator`
+fields will correspond to the appropriate date or name-email-date tuple
+from the `committer` or `tagger` fields depending on the object type.
+These are intended for working on a mix of annotated and lightweight tags.
+
 Fields that have name-email-date tuple as its value (`author`,
 `committer`, and `tagger`) can be suffixed with `name`, `email`,
 and `date` to extract the named component.
@@ -153,8 +158,8 @@ line is 'contents:body', where body is all of the lines after the first
 blank line.  The optional GPG signature is `contents:signature`.  The
 first `N` lines of the message is obtained using `contents:lines=N`.
 
-For sorting purposes, fields with numeric values sort in numeric
-order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
+For sorting purposes, fields with numeric values sort in numeric order
+(`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
 All other fields are used to sort in their byte-value order.
 
 There is also an option to sort by versions, this can be done by using
-- 
EW
