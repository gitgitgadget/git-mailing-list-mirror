From: Bruno Ribas <ribas@c3sl.ufpr.br>
Subject: [PATCH 2/2] Removed NULL check on builtin-pack-objects.c from create_delta_index() as it just checks for Out of Memory
Date: Wed,  4 Apr 2007 15:50:09 -0300
Message-ID: <11757126101733-git-send-email-ribas@c3sl.ufpr.br>
References: <11757126093105-git-send-email-ribas@c3sl.ufpr.br>
Cc: Junio C Hamano <junkio@cox.net>, Bruno Ribas <ribas@c3sl.ufpr.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 20:51:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZAZt-00006j-6Z
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 20:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993017AbXDDSuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 14:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbXDDSuR
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 14:50:17 -0400
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:58333 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbXDDSuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 14:50:14 -0400
Received: from localhost (labatt.c3sl.ufpr.br [200.17.202.89])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id A1FA5301B431;
	Wed,  4 Apr 2007 15:50:11 -0300 (BRT)
X-Mailer: git-send-email 1.5.0.6
In-Reply-To: <11757126093105-git-send-email-ribas@c3sl.ufpr.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43767>


Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
---
 builtin-pack-objects.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b5f9648..04a4abc 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1254,8 +1254,6 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	}
 	if (!src->index) {
 		src->index = create_delta_index(src->data, src_size);
-		if (!src->index)
-			die("out of memory");
 	}
 
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
-- 
1.5.0.3
