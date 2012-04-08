From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/12] completion: trivial simplification
Date: Sun,  8 Apr 2012 06:07:51 +0300
Message-ID: <1333854479-23260-5-git-send-email-felipe.contreras@gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 05:09:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGiVP-0007R6-SP
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 05:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424Ab2DHDIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 23:08:52 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53218 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754120Ab2DHDIZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Apr 2012 23:08:25 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so2813271lah.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 20:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Mochg6daDLjLWUfaoJB9RsbXrf5NXjcdO3DM3kalq4U=;
        b=ebLs4JsxNodTlYVI7KKGfH7E6Nwq2947GIhatMRlO7I5dEzFdnQ/ERsOkhlE3OCvxZ
         RKk3kbil6lJD1WEwbQH0wPY6Y0u7tu7k1XyVZ978U4oOI6tdL9J2OZ+wdD4muIwhVhgL
         eNeRuZ4OneuHov3Hryi4zJRE7p+RqSrNy5xnn/LD23dsJ6QAz3ViABxzGH1mh51/89al
         TL867blhra6iRk4lz5k7GrsUoBDqGtsiUTHtG/TItyG7lyixEuzlOou/BxRIJM4LlEZD
         01EMIghrT+Z84ZGyALDixSKcQLLoeXZDEUNOM0yGwdiEPoy7pDZsfsIYpmpx7z4oQ2/8
         qUWg==
Received: by 10.152.146.67 with SMTP id ta3mr4723555lab.25.1333854504596;
        Sat, 07 Apr 2012 20:08:24 -0700 (PDT)
Received: from localhost (84-231-195-184.elisa-mobile.fi. [84.231.195.184])
        by mx.google.com with ESMTPS id pj20sm11379913lab.13.2012.04.07.20.08.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 20:08:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.3.g5a738d
In-Reply-To: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194967>

cword-1 is the previous word ($prev).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5c66674..3bc8d85 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1656,7 +1656,7 @@ _git_notes ()
 		__gitcomp '--ref'
 		;;
 	,*)
-		case "${words[cword-1]}" in
+		case "$prev" in
 		--ref)
 			__gitcomp_nl "$(__git_refs)"
 			;;
@@ -1682,7 +1682,7 @@ _git_notes ()
 	prune,*)
 		;;
 	*)
-		case "${words[cword-1]}" in
+		case "$prev" in
 		-m|-F)
 			;;
 		*)
-- 
1.7.10.3.g5a738d
