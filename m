From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/23] query_refspecs(): move some constants out of the loop
Date: Wed, 30 Oct 2013 06:33:01 +0100
Message-ID: <1383111192-23780-13-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:42:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOXl-0007Xo-S6
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282Ab3J3FmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:42:03 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48314 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753197Ab3J3FmA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:42:00 -0400
X-AuditID: 1207440e-b7fbc6d000004ad9-f9-52709a5b3c67
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 1E.0E.19161.B5A90725; Wed, 30 Oct 2013 01:34:19 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIN014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:17 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqBs9qyDI4P4mS4vpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE7483vyywFnRwVG88GNTDuZuti5OSQEDCRWNe9nx3CFpO4cG89UJyLQ0jgMqPEt18XmSGc
	K0wSd5p+gnWwCehKLOppZgKxRQTUJCa2HWIBKWIWmMgscXz6IhaQhLCAv8Sdf38ZQWwWAVWJ
	udvmgjXzCrhKLP9yghFinYLEjeaprCA2J1D8066bYGcICbhINLV/Zp/AyLuAkWEVo1xiTmmu
	bm5iZk5xarJucXJiXl5qka6xXm5miV5qSukmRkjY8u1gbF8vc4hRgINRiYfX4EF+kBBrYllx
	Ze4hRkkOJiVR3rQpBUFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHinHwcq501JrKxKLcqHSUlz
	sCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8CrPBBoqWJSanlqRlplTgpBm4uAEEVwgG3iA
	NvCAFPIWFyTmFmemQxSdYlSUEudNAkkIgCQySvPgBsASzCtGcaB/hCHaeYDJCa77FdBgJqDB
	e1jyQAaXJCKkpBoYF5vxTNso3JtunBfQELVYoO7oj+w5Tfw9p51mhXpcVGJTs7rg1PbxS9XK
	U5G7c7kW5y/4wC7958DxL8nJG6YwXnefxacQ2qd4mu2Efq9bdEGdwws+eea7As57 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236980>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 remote.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index e42daa8..a5e6c7f 100644
--- a/remote.c
+++ b/remote.c
@@ -825,6 +825,8 @@ static int query_refspecs(struct refspec *refs, int ref_count, struct refspec *q
 {
 	int i;
 	int find_src = !query->src;
+	const char *needle = find_src ? query->dst : query->src;
+	char **result = find_src ? &query->src : &query->dst;
 
 	if (find_src && !query->dst)
 		return error("query_refspecs: need either src or dst");
@@ -833,8 +835,6 @@ static int query_refspecs(struct refspec *refs, int ref_count, struct refspec *q
 		struct refspec *refspec = &refs[i];
 		const char *key = find_src ? refspec->dst : refspec->src;
 		const char *value = find_src ? refspec->src : refspec->dst;
-		const char *needle = find_src ? query->dst : query->src;
-		char **result = find_src ? &query->src : &query->dst;
 
 		if (!refspec->dst)
 			continue;
-- 
1.8.4.1
