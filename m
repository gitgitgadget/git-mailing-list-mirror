From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin-apply: fix conversion error in strbuf series
Date: Wed, 03 Oct 2007 17:53:57 -0700
Message-ID: <7v7im3d7iy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 02:59:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdF3I-0003u2-HH
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 02:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbXJDAyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 20:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbXJDAyD
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 20:54:03 -0400
Received: from rune.pobox.com ([208.210.124.79]:58334 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbXJDAyB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 20:54:01 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 53C731414F3;
	Wed,  3 Oct 2007 20:54:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DB00F1414F1;
	Wed,  3 Oct 2007 20:54:20 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59912>


Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 047a60d..05c6bc3 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2651,7 +2651,7 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 
 		patch = xcalloc(1, sizeof(*patch));
 		patch->inaccurate_eof = inaccurate_eof;
-		nr = parse_chunk(buf.buf + offset, buf.len, patch);
+		nr = parse_chunk(buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0)
 			break;
 		if (apply_in_reverse)
-- 
1.5.3.4.1150.gbb28
