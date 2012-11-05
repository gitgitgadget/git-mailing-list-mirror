From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/5] remote-bzr: update working tree
Date: Mon,  5 Nov 2012 16:56:20 +0100
Message-ID: <1352130980-3998-6-git-send-email-felipe.contreras@gmail.com>
References: <1352130980-3998-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 16:57:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVP37-0007Ns-Gt
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 16:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab2KEP5C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 10:57:02 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38101 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab2KEP5A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 10:57:00 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2063229bkc.19
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 07:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iyHkT0OEd5MsT5O8ZAtVCibzBidUubj79dIwBOwatSU=;
        b=NKxNuFQ/IQkGtxZT1yQAZwVAz97s6iB7IuBOEV6bX6/zYebJglymxO/eevYcWOrgQg
         SQo7g8lLaoDu+yynLfojU8uxeoBimCsfKkaGrO8xKfXHrFM6Q0xAVCV3B0mYU45H1eP2
         bBJDiSNxP30H4ghYFjQyGFPkRO7WVtEhIYWc7IGRnbTKwv27Eg3xjIjBouYbatBa0jhd
         1bVw5rFdVLYP09EmLRDHKoql9fjFodca4evrO0iMP507j5qOXHDfPJACGCR9Sjae2YwO
         Z68QONZui1UfJAgV375j/LdaQFGy9Nn8awlJWAA2D4L8eqCht3l2GGCRhGzUuNxogeE8
         BH5w==
Received: by 10.204.131.89 with SMTP id w25mr2408099bks.35.1352131019335;
        Mon, 05 Nov 2012 07:56:59 -0800 (PST)
Received: from localhost (ip-109-43-0-76.web.vodafone.de. [109.43.0.76])
        by mx.google.com with ESMTPS id r15sm10142482bkw.9.2012.11.05.07.56.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 07:56:58 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352130980-3998-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209070>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index c981fda..1a06a0a 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -572,6 +572,8 @@ def do_export(parser):
             repo.generate_revision_history(revid, marks.get_tip('master'))
             revno, revid = repo.last_revision_info()
             peer.import_last_revision_info_and_tags(repo, revno, revid)
+            wt = peer.bzrdir.open_workingtree()
+            wt.update()
         print "ok %s" % ref
     print
 
-- 
1.8.0
