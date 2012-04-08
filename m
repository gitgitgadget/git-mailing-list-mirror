From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/12] completion: simplify __gitcomp_1
Date: Sun,  8 Apr 2012 06:07:50 +0300
Message-ID: <1333854479-23260-4-git-send-email-felipe.contreras@gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 05:08:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGiUo-00077H-P3
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 05:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370Ab2DHDIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 23:08:51 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54731 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab2DHDIX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 23:08:23 -0400
Received: by mail-lb0-f174.google.com with SMTP id gg6so1342002lbb.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 20:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ETkodWVpPCiRGHRsLtUezr8AybY4o0dPfX2D2J1MoRg=;
        b=jUvMa0vB+m/0Fatg+ZmQ+nX9NrCFvk0SREhKPWwDzj9ZP36zMAZ+6zfY7jZqzCW7A5
         veo3/iofeoyqmDxkuDq5GsDyYRAVyE0ljUiub8eIKlV4Q9IVnGMD4BggHrbjaZ+V8oy1
         d824Hjnjtt1bYWcS9UvfJmOS8rPumkWTH4hqSohmFFM+eB3ylrvsfB6+82wwaTl2DmMy
         E8JtwC01y4KREB+3TokEJ0t2PtlaSHBIRYhV3sa9MxUCqm6QZQSaSswk8UGTYJTdpgCF
         u+OKOpL+S3eYybQdIpe9F444poCV1vq3vbNi2DR3CbxLDla4E4sNzdH3XytBlzO3dhUy
         PNag==
Received: by 10.152.104.80 with SMTP id gc16mr4690532lab.46.1333854502501;
        Sat, 07 Apr 2012 20:08:22 -0700 (PDT)
Received: from localhost (84-231-195-184.elisa-mobile.fi. [84.231.195.184])
        by mx.google.com with ESMTPS id ev8sm15513325lbb.5.2012.04.07.20.08.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 20:08:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.3.g5a738d
In-Reply-To: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194957>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 39f5435..5c66674 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -306,13 +306,13 @@ __git_ps1 ()
 
 __gitcomp_1 ()
 {
-	local c IFS=' '$'\t'$'\n'
+	local c s IFS=' '$'\t'$'\n'
 	for c in $1; do
 		case "$c" in
-		--*=*) printf %s$'\n' "$c" ;;
-		*.)    printf %s$'\n' "$c" ;;
-		*)     printf %s$'\n' "$c " ;;
+		--*=* | *.) s="" ;;
+		*)          s=" " ;;
 		esac
+		echo "$c$s"
 	done
 }
 
-- 
1.7.10.3.g5a738d
