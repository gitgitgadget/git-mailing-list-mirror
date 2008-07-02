From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 08/12] fast-import: MinGW does not have getppid(). 
 So do not print it.
Date: Wed,  2 Jul 2008 10:32:08 +0200
Message-ID: <1214987532-23640-8-git-send-email-prohaska@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <1214987532-23640-7-git-send-email-prohaska@zib.de>
Reply-To: prohaska@zib.de
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <johannes.schindelin@gmx.de>, Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 10:33:25 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.168])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxmE-0001Fq-DL
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 10:33:22 +0200
Received: by py-out-1314.google.com with SMTP id u10so7771577pyb.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=adQlXSWMOVUUekNOehOZ+xIvIgfLkT6Vy+6JpS6jzTU=;
        b=oI/6w7EJuVH0QO9dvNz6zFZ1g7tbmVfPZwC2L8pqrmcvCg9S3TwPRkXROhMZX8c0Md
         e1ywcWuT//9R0t2agr3Tw4k3sv/8RfmhAcD5OEqsytfndnaWFYbVyGYFTnyYKHXoJcTU
         Ya8KJPrWcK+xaPRC/7nSrPt5q0n0b13zDbl8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere;
        b=hSxdHzMvU92LcxzD0z5Ta/sCbrq6fGADwyA+f5K/O/dV36ib+IcNrHrlWkj57CwazF
         Ivj2BcxMd73/zezaLygmVh0o37XqNwxSt+QA6UMtIU5H/LnIskQK1gPM2tOzG8uhPzUh
         hXq5Ea1GsOnUdGOaxbFphhNiMniMpHBc9R4bY=
Received: by 10.141.175.5 with SMTP id c5mr481408rvp.22.1214987542422;
        Wed, 02 Jul 2008 01:32:22 -0700 (PDT)
Received: by 10.107.3.34 with SMTP id f34gr2551pri.0;
	Wed, 02 Jul 2008 01:32:22 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.117.20 with SMTP id p20mr8847815agc.4.1214987541571; Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 39si7857866yxd.0.2008.07.02.01.32.20; Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m628WEZw019118; Wed, 2 Jul 2008 10:32:19 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7]) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m628WC0P017527; Wed, 2 Jul 2008 10:32:13 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1214987532-23640-7-git-send-email-prohaska@zib.de>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87105>


From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 fast-import.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index e72b286..271b93c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -391,7 +391,9 @@ static void write_crash_report(const char *err)
 
 	fprintf(rpt, "fast-import crash report:\n");
 	fprintf(rpt, "    fast-import process: %d\n", getpid());
+#ifndef __MINGW32__
 	fprintf(rpt, "    parent process     : %d\n", getppid());
+#endif
 	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_LOCAL));
 	fputc('\n', rpt);
 
-- 
1.5.6.1.255.g32571
