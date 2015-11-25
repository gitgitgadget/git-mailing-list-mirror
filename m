From: atousa.p@gmail.com
Subject: [PATCH v1] git rev-list doesn't complain when repo is empty
Date: Tue, 24 Nov 2015 23:00:53 -0800
Message-ID: <1448434853-7527-1-git-send-email-apahlevan@ieee.org>
References: <CA+izobv6OuAAjnKH5A=vcmJh3yDhWi41WAD-OmVSN2d7P_5SGA@mail.gmail.com>
Cc: Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 08:01:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1U4n-0003yf-Dp
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 08:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbbKYHBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 02:01:06 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34599 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbbKYHBF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 02:01:05 -0500
Received: by padhx2 with SMTP id hx2so48310678pad.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 23:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1c9iQ1gqw7oAtd/PD19iniBRPRVr31jlHPMFrVrT9bY=;
        b=d/T6XYpXi3vj+0F66ar2jvY4JlRil3svoHJVBZWx2kCR/z6MmwXgis+nUhQsJ/p4AU
         7Wwpc7UL3NXM5e+yCw6bS+x+qZ/j40ZhQqfta8t8C7Kju/ttHWwyGUS6Ja9mkoQ+oS1+
         7G0oTVbrN4iboSWvmm8LPqLZY3T3jhSkkbwLCesPn7HXjDSOraXOwCJKTrhmgrBz1vYD
         +MJoO/sgQIGlSSUqigbmdfgxnBO9TqhfPHRX5eHdIxIUDnhYu0pP6cm2OHZtyq5fabHe
         9nGUQe0I5vbEx4EDuWqdR24csJQGBLZr3WY/an37+PT5huFkXzF7DYDMwP/xO9XbqePX
         SBKA==
X-Received: by 10.98.0.73 with SMTP id 70mr29132724pfa.4.1448434864591;
        Tue, 24 Nov 2015 23:01:04 -0800 (PST)
Received: from Atousas-Air.jduprat.net ([50.240.193.13])
        by smtp.gmail.com with ESMTPSA id q20sm18443812pfi.5.2015.11.24.23.01.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 23:01:03 -0800 (PST)
X-Google-Original-From: apahlevan@ieee.org
X-Mailer: git-send-email 2.4.9 (Apple Git-60)
In-Reply-To: <CA+izobv6OuAAjnKH5A=vcmJh3yDhWi41WAD-OmVSN2d7P_5SGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281683>

From: Atousa Pahlevan Duprat <apahlevan@ieee.org>

Signed-off-by: Atousa Pahlevan Duprat <apahlevan@ieee.org>
---
 builtin/rev-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index d80d1ed..f71b87f 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -348,7 +348,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	     (!(revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
 	      !revs.pending.nr)) ||
 	    revs.diff)
-		usage(rev_list_usage);
+               return 0; // empty repo
 
 	if (revs.show_notes)
 		die(_("rev-list does not support display of notes"));
-- 
2.4.9 (Apple Git-60)
