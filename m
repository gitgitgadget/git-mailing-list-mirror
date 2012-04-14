From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/5] completion: simplify __gitcomp_1
Date: Sun, 15 Apr 2012 00:43:00 +0300
Message-ID: <1334439784-6460-2-git-send-email-felipe.contreras@gmail.com>
References: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 14 23:44:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJAl7-00021w-AO
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 23:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247Ab2DNVnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 17:43:46 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56125 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756157Ab2DNVnp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2012 17:43:45 -0400
Received: by lahj13 with SMTP id j13so3144468lah.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 14:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NoL9oscvV6IFf7xH6mJeYSywOHKMtlKeKt3qxIS8Z9o=;
        b=zcS2u9+lNAqKe8bDdxtSBjKC0rOGQ2FpD/5wj4KvMESj75xZMqTgbFx3rqymgyg7XH
         jcwp+Dfv6pqavLaexGQeqcUb9DrLMSb6+t39Ky54mbciJHDZTOIA3MNPd+K2WJ41jaXa
         iqSWnne8EPciCxh0gLAvLzoiKw0pzZ+b0uDj7F4Qb5y+soYbuNefVl4WzN+S+BNG0wEk
         HGvFWaYoMt1wYOMdj+amsDfmHn3ynvNgMA3n590pvxBd3GF7rLiheAMKbtrMCLWia4yo
         vB+rTPvCvNDbRlMvzyVXyvcohSaWk6Zlowt560DWTB/2V4IzNm0Pe+eiSQ8uf+j36hhj
         mxoQ==
Received: by 10.112.24.161 with SMTP id v1mr2974227lbf.12.1334439824128;
        Sat, 14 Apr 2012 14:43:44 -0700 (PDT)
Received: from localhost (84-231-107-120.elisa-mobile.fi. [84.231.107.120])
        by mx.google.com with ESMTPS id oy17sm13939697lab.7.2012.04.14.14.43.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 14:43:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
In-Reply-To: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195519>

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
