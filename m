From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/4] completion: simplify __gitcomp_1
Date: Fri, 13 Apr 2012 02:50:00 +0300
Message-ID: <1334274603-3277-2-git-send-email-felipe.contreras@gmail.com>
References: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 01:50:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SITmd-00051j-Ij
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 01:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758228Ab2DLXub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 19:50:31 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56331 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab2DLXua (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 19:50:30 -0400
Received: by mail-lb0-f174.google.com with SMTP id gm6so2046018lbb.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NoL9oscvV6IFf7xH6mJeYSywOHKMtlKeKt3qxIS8Z9o=;
        b=v5RRmlAuZGg/VaH/TZ1kpehI4UFqKzkkgCYvZK0/G7Bbjq/qCqfG2POcwZ8u0SzA+B
         nZND0CSM2ghufA9UE026VuPwq3RB68Uxk7eSN0hGa5UmlP5T8PO+Fnl7UX7rWHEsFlwP
         GkLULuqCvrdw8MoY71l9qlCV6cTAfaT35VmDhupe2uE3jUwDCC11TlxZn5lI0SseeJ4h
         5QzEOJPMaxxcSVwdBcmz6R5nuZZ6/M1MeFDQz/3f74TQ3b0aOawCypJ76cHht4CyoPD8
         +VyaYZ9fY9QmgIeySTXV7oDWBKPRXVW5y8/jHt/uT4qwRtF05OWno1VAIzIRsojZRiQJ
         KHeQ==
Received: by 10.112.47.69 with SMTP id b5mr70344lbn.17.1334274629427;
        Thu, 12 Apr 2012 16:50:29 -0700 (PDT)
Received: from localhost (84-231-136-182.elisa-mobile.fi. [84.231.136.182])
        by mx.google.com with ESMTPS id te8sm7677273lab.3.2012.04.12.16.50.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 16:50:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
In-Reply-To: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195390>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 31f714d..13be9a7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -307,13 +307,13 @@ __git_ps1 ()
 # __gitcomp_1 requires 2 arguments
 __gitcomp_1 ()
 {
-	local c IFS=' '$'\t'$'\n'
+	local c s IFS=' '$'\t'$'\n'
 	for c in $1; do
 		case "$c$2" in
-		--*=*) printf %s$'\n' "$c$2" ;;
-		*.)    printf %s$'\n' "$c$2" ;;
-		*)     printf %s$'\n' "$c$2 " ;;
+		--*=* | *.) s="" ;;
+		*)          s=" " ;;
 		esac
+		echo "$c$2$s"
 	done
 }
 
-- 
1.7.10.1.g1f19b8.dirty
