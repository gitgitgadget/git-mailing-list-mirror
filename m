From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] log --graph: do not accept log --graphbogus
Date: Sun, 25 May 2008 20:19:25 -0700
Message-ID: <7v4p8lg3b6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Mon May 26 05:20:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0TG4-0004oF-Cl
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 05:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbYEZDTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 23:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbYEZDTc
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 23:19:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbYEZDTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 23:19:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 55ECA5F2A;
	Sun, 25 May 2008 23:19:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C0FD45F26; Sun, 25 May 2008 23:19:27 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8DE9CC76-2AD2-11DD-B48C-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82893>

An obvious fix to the argument parser.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index fb9924e..ac057e1 100644
--- a/revision.c
+++ b/revision.c
@@ -1202,7 +1202,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				get_commit_format(arg+8, revs);
 				continue;
 			}
-			if (!prefixcmp(arg, "--graph")) {
+			if (!strcmp(arg, "--graph")) {
 				revs->topo_order = 1;
 				revs->rewrite_parents = 1;
 				revs->graph = graph_init(revs);
-- 
1.5.5.1.467.g9bd81
