From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Revert "make git-status use a pager"
Date: Mon, 21 Jul 2008 19:43:13 -0700
Message-ID: <7vprp6r64e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 04:44:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL7rN-0005lW-Vo
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 04:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbYGVCnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 22:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754524AbYGVCnS
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 22:43:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49738 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbYGVCnR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 22:43:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 23D4F36037;
	Mon, 21 Jul 2008 22:43:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 33CFB36031; Mon, 21 Jul 2008 22:43:14 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F01D6B68-5797-11DD-B48C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89428>

This reverts commit c8af1de9cfa0a5678ae766777e0f905e60b69fda.

The change was immensely unpopular, and poeple who would really want to
page can use pager.status configuration.
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 74ea0e6..1bfd271 100644
--- a/git.c
+++ b/git.c
@@ -341,7 +341,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "shortlog", cmd_shortlog, USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
-		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE | USE_PAGER },
+		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tag", cmd_tag, RUN_SETUP },
-- 
1.6.0.rc0
