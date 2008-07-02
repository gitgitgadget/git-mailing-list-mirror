From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 02/12] Do not complain about "no common commits" in
 an empty repo
Date: Wed,  2 Jul 2008 10:32:02 +0200
Message-ID: <1214987532-23640-2-git-send-email-prohaska@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de>
Reply-To: prohaska@zib.de
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <johannes.schindelin@gmx.de>, Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 10:33:32 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxmD-0001FN-Ey
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 10:33:21 +0200
Received: by yx-out-2122.google.com with SMTP id 22so925117yxm.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 01:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=0HVPDMu6Bg3uCgNIOA77H8BbtSDuL26dXWm8zkiVgPQ=;
        b=47o6QTi12SOO4VOkrux/mpcuQxe/jr1UjHux5p7Y2K6N2Qdk9/KZncYhf/skWUnkET
         f5w12HMVQRObGgd0LG/k0iEgyUmy1gObKbsO2ssmlRq5FoSJTTq6e7zeVCjZyxf5/FFK
         74PNt0cphrC4ILAf7BMb3uvgSwTSsDywokZ+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere;
        b=qF0i7U0iw8XlaOx6PmMgi8+TiURPprvyiEDMYGoFOmJqV091GeP1y2G3Hop8V5/7Vz
         V1QWPXC7MMhJOe17w+2YqI6MVTXbhoh64qHu8oOdl5KgJlrTXlWWdqgziRXo594DSgX1
         PHsNeVo1kMHxty1A995r6EqCgCgvlYB/F7IYs=
Received: by 10.142.177.7 with SMTP id z7mr271589wfe.12.1214987541944;
        Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received: by 10.107.13.30 with SMTP id q30gr2549pri.0;
	Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.120.14 with SMTP id s14mr8854109agc.3.1214987541570; Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 39si7857844yxd.0.2008.07.02.01.32.18; Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m628WC02019111; Wed, 2 Jul 2008 10:32:17 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7]) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m628WC0J017527; Wed, 2 Jul 2008 10:32:12 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1214987532-23640-1-git-send-email-prohaska@zib.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87111>


From: Johannes Schindelin <johannes.schindelin@gmx.de>

If the repo is empty, we know that already, thank you very much.
So shut fetch-pack up about that case.

Fixes issue 3, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin-fetch-pack.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index f4dbcf0..2175c6d 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -309,7 +309,8 @@ done:
 		}
 		flushes--;
 	}
-	return retval;
+	/* it is no error to fetch into a completely empty repo */
+	return count ? retval : 0;
 }
 
 static struct commit_list *complete;
-- 
1.5.6.1.255.g32571
