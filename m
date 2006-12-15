X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add title attribute to ref marker with full ref name
Date: Fri, 15 Dec 2006 23:49:12 +0100
Message-ID: <1166222952562-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Fri, 15 Dec 2006 22:46:51 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=S5VovyewWfYIgPWGsO787njHqIqkyGNkbfANg3vjZ02o3gFrFyoLuFbwqCYDbr06eNlAsc4333S54qP0Qat5GmEe7nfj27hkWpV6bc02J8tFZ4TTUXAEq6zXWS44zIO3M7LOoYWbZbyIlr3V20FXc4uOqr48NMWXRS6pyef36Sw=
X-Mailer: git-send-email 1.4.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34570>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvLpI-0004Ya-Gf for gcvg-git@gmane.org; Fri, 15 Dec
 2006 23:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030305AbWLOWqp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 17:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbWLOWqp
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 17:46:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:12859 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1030305AbWLOWqp (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 17:46:45 -0500
Received: by ug-out-1314.google.com with SMTP id 44so940853uga for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 14:46:43 -0800 (PST)
Received: by 10.66.232.9 with SMTP id e9mr655571ugh.1166222803437; Fri, 15
 Dec 2006 14:46:43 -0800 (PST)
Received: from roke.D-201 ( [81.190.25.107]) by mx.google.com with ESMTP id
 m4sm4126754ugc.2006.12.15.14.46.42; Fri, 15 Dec 2006 14:46:43 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kBFMnEMQ007284; Fri, 15 Dec 2006 23:49:14 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kBFMnCUZ007283; Fri, 15 Dec 2006 23:49:12 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Add title attribute, which will be shown as popup on mouseover in
graphical web browsers, with full name of ref, including part (type)
removed from the name of ref itself. This is useful to see that this
strange ref is StGIT ref, or it is remote branch, or it is lightweigh
tag (with branch-like name).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5ea3fda..5eaab05 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -856,7 +856,8 @@ sub format_ref_marker {
 				$name = $ref;
 			}
 
-			$markers .= " <span class=\"$type\">" . esc_html($name) . "</span>";
+			$markers .= " <span class=\"$type\" title=\"$ref\">" .
+			            esc_html($name) . "</span>";
 		}
 	}
 
-- 
1.4.4.1
