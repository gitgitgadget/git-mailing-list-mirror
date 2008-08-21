From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] revision.h: make show_early_output an extern which is defined
 in revision.c
Date: Wed, 20 Aug 2008 19:34:30 -0500
Message-ID: <tafnhasVGgid37Mhftl4QXLlge-grjM8UOkw0dHIRb0@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 03:30:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVz0c-0007uF-4f
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 03:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbYHUB3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 21:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbYHUB3i
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 21:29:38 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46286 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbYHUB3i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 21:29:38 -0400
Received: by mail.nrlssc.navy.mil id m7L1TOiZ003127; Wed, 20 Aug 2008 20:29:24 -0500
X-OriginalArrivalTime: 21 Aug 2008 00:34:30.0828 (UTC) FILETIME=[AD05C6C0:01C90325]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93083>


The variable show_early_output is defined in revision.c and should be
declared extern in revision.h so that the linker does not complain
about multiply defined variables.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 revision.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/revision.h b/revision.h
index f64e8ce..1b04566 100644
--- a/revision.h
+++ b/revision.h
@@ -119,7 +119,7 @@ struct rev_info {
 void read_revisions_from_stdin(struct rev_info *revs);
 
 typedef void (*show_early_output_fn_t)(struct rev_info *, struct commit_list *);
-volatile show_early_output_fn_t show_early_output;
+extern volatile show_early_output_fn_t show_early_output;
 
 extern void init_revisions(struct rev_info *revs, const char *prefix);
 extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
-- 
1.6.0.13.ge1c8
