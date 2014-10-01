From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 2/3] daemon: fix error message after bind()
Date: Wed, 01 Oct 2014 12:18:15 +0200
Message-ID: <542BD4E7.7030401@web.de>
References: <542BD471.3000308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:19:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZH07-0006xH-T3
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbaJAKTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:19:12 -0400
Received: from mout.web.de ([212.227.15.14]:55844 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbaJAKTL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 06:19:11 -0400
Received: from [192.168.178.27] ([79.250.168.13]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Lu5BO-1YHeBx1dDi-011UPN; Wed, 01 Oct 2014 12:19:07
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <542BD471.3000308@web.de>
X-Provags-ID: V03:K0:K18w/fMB0GNOSJyNmGo5lF0x8xKlw3P4ZizfGmX+f556D5irAuw
 YyUmxWw4AsBn2sLChx0vJxlWZiNh4JhZ3qpTGkU879i+NnlIzYX6Pvte72gcr4iIoVCEeVk
 x104CpyCySRka5LqMzCVhz7jahoEuVU2zvG3IGYFlEnk0qFCPZThcdOMSvi0NX0F8P31KCJ
 1js4wbZzoyC+2MTW+XN2g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257697>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index a6f467e..090f6a4 100644
--- a/daemon.c
+++ b/daemon.c
@@ -924,7 +924,7 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 	}
 
 	if ( bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0 ) {
-		logerror("Could not listen to %s: %s",
+		logerror("Could not bind to %s: %s",
 			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
 			 strerror(errno));
 		close(sockfd);
-- 
2.1.2
