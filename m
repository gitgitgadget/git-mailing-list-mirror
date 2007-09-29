From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] gitk: add check for required tcl version >= 8.4
Date: Sat, 29 Sep 2007 02:32:54 -0700
Message-ID: <7vlkaplsu1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Sat Sep 29 11:33:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbYhG-0002CS-Db
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 11:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbXI2JdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 05:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbXI2JdE
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 05:33:04 -0400
Received: from rune.pobox.com ([208.210.124.79]:34096 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996AbXI2JdD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 05:33:03 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id C02DA13E0A0;
	Sat, 29 Sep 2007 05:33:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1AA7813DEBB;
	Sat, 29 Sep 2007 05:33:19 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59451>

From: Steffen Prohaska <prohaska@zib.de>
Date: Fri, 28 Sep 2007 22:57:22 +0200

gitk requires tcl version >= 8.4 to work flawlessly. So let's
check the tcl version and quit if it's too low.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---

 * I do not have a ready access to older tcl/tk myself, so I
   cannot judge if this is sensible or not.  Just forwarding in
   case you missed it.

 gitk |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 300fdce..6ea6489 100755
--- a/gitk
+++ b/gitk
@@ -7,6 +7,11 @@ exec wish "$0" -- "$@"
 # and distributed under the terms of the GNU General Public Licence,
 # either version 2, or (at your option) any later version.
 
+if {[info tclversion] < 8.4} {
+   puts stderr "Sorry, gitk requires tcl version >= 8.4."
+   exit 1 
+}
+
 proc gitdir {} {
     global env
     if {[info exists env(GIT_DIR)]} {
-- 
1.5.3.2.111.g5166
