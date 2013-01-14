From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/14] imap-send.c: remove unused field imap_store::trashnc
Date: Mon, 14 Jan 2013 06:32:42 +0100
Message-ID: <1358141566-26081-11-git-send-email-mhagger@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:34:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tucge-0007V5-QB
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613Ab3ANFd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:33:56 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:51913 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752369Ab3ANFdz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:33:55 -0500
X-AuditID: 1207440c-b7f196d0000008bc-34-50f398c3fc1e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id FF.92.02236.3C893F05; Mon, 14 Jan 2013 00:33:55 -0500 (EST)
Received: from michael.fritz.box (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5Wt2r026427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:33:54 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqHt4xucAgxst0hZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujNs3prMX
	vGSpuLjsPlMD43PmLkZODgkBE4k7/adYIWwxiQv31rN1MXJxCAlcZpRYcHsZI4Rzlkli5cqF
	YFVsAroSi3qamUBsEQE1iYlth1hAbGaBFImO592MILawgLdE27btYDUsAqoSlyY8ZAOxeQVc
	JTo2X4XarCDxeuclsJmcQPHvH0+BxYUEXCQenmpmm8DIu4CRYRWjXGJOaa5ubmJmTnFqsm5x
	cmJeXmqRrqFebmaJXmpK6SZGSADx7GD8tk7mEKMAB6MSD++mks8BQqyJZcWVuYcYJTmYlER5
	w/uBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4Q+uAcrwpiZVVqUX5MClpDhYlcV7VJep+QgLp
	iSWp2ampBalFMFkZDg4lCV5nYKQICRalpqdWpGXmlCCkmTg4QQQXyAYeoA2fp4NsKC5IzC3O
	TIcoOsWoKCXOKwUyQQAkkVGaBzcAFuuvGMWB/hHm/QfSzgNME3Ddr4AGMwENPnvhPcjgkkSE
	lFQDY9vK1aoy7hef2n7WrvLtyl+uFX/HUP7n7SlTPxgpdDy6wL1KYI3ggXLdu77TdxyfHut9
	L/rJuYmqoRzT/Dpl847U3jxrU36BP/p3xHOuj+mP+Nfqx2YwbF6cc8al6GzyKpud696ax9SW
	96Sl/txz1yQ3SH+TiQunN1tIwdmAJPb3676lzJk7Q4mlOCPRUIu5qDgRAJR3GTPQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213439>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 9616e80..70abe9b 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -127,7 +127,6 @@ struct imap_store {
 	int uidvalidity;
 	struct imap *imap;
 	const char *prefix;
-	unsigned /*currentnc:1,*/ trashnc:1;
 };
 
 struct imap_cmd_cb {
@@ -1079,7 +1078,6 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 	} /* !preauth */
 
 	ctx->prefix = "";
-	ctx->trashnc = 1;
 	return (struct store *)ctx;
 
 bail:
-- 
1.8.0.3
