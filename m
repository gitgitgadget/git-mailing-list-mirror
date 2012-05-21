From: mhagger@alum.mit.edu
Subject: [PATCH v2 1/4] cmd_fetch_pack(): declare dest to be const
Date: Mon, 21 May 2012 09:59:56 +0200
Message-ID: <1337587199-21099-2-git-send-email-mhagger@alum.mit.edu>
References: <1337587199-21099-1-git-send-email-mhagger@alum.mit.edu>
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 10:07:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWNeZ-0002Ux-U7
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 10:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129Ab2EUIHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 04:07:38 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:60604 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755897Ab2EUIHf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2012 04:07:35 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 May 2012 04:07:34 EDT
X-AuditID: 12074411-b7f596d000000932-e4-4fb9f6205b60
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id BA.78.02354.026F9BF4; Mon, 21 May 2012 04:00:32 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4L80LNw006950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 May 2012 04:00:32 -0400
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1337587199-21099-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsUixO6iqKvwbae/wfsb+hZdV7qZLBp6rzBb
	3F4xn9mie8pbRgcWj7/vPzB57Jx1l93j4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4M74e6WYv
	WM9V0TdFuYGxnaOLkZNDQsBE4vv3D0wQtpjEhXvr2boYuTiEBC4zSkz40ArlnGGS+HTkMSNI
	FZuAlMTLxh52EFtEQE1iYtshli5GDg5mgWKJy4tNQMLCAk4S2xdNAhvKIqAq8fFzP1g5r4CL
	xIqJ7YwQy+Qlnt7vYwOxOQVcJQ5d380CYgsB1Wx4uJhtAiPvAkaGVYxyiTmlubq5iZk5xanJ
	usXJiXl5qUW6pnq5mSV6qSmlmxghwSO4g3HGSblDjAIcjEo8vE4zdvoLsSaWFVfmHmKU5GBS
	EuU1/QQU4kvKT6nMSCzOiC8qzUktPsQowcGsJMJ79yFQjjclsbIqtSgfJiXNwaIkzsu3RN1P
	SCA9sSQ1OzW1ILUIJivDwaEkwRvzFahRsCg1PbUiLTOnBCHNxMEJIrhANvAAbUgAKeQtLkjM
	Lc5Mhyg6xagoJc4bBJIQAElklObBDYDF+StGcaB/hHnTQap4gCkCrvsV0GAmoMFBL8AGlyQi
	pKQaGFVW+ec/PrLb6/v09aeL6zjaTsmmSW7140pOOaUyTWr214cKeaun3bz4NVBwcuY+rlJp
	N+mQk3cfZe2ceu6vkmG65babK1geF3WtSymr/P5wO7f2TL97KeoP/I1Klv8s3m/6cYL3ed6/
	gdN4pS8z1t7edTY9cMlbJa/yeSwVme1vOjZcrpM+JKnEUpyRaKjFXFScCACwOTjP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198091>

From: Michael Haggerty <mhagger@alum.mit.edu>

There is no need for it to be non-const, and this avoids the need
for casting away the constness of an argv element.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 10db15b..7e9d62f 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -901,7 +901,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, ret, nr_heads;
 	struct ref *ref = NULL;
-	char *dest = NULL, **heads;
+	const char *dest = NULL;
+	char **heads;
 	int fd[2];
 	char *pack_lockfile = NULL;
 	char **pack_lockfile_ptr = NULL;
@@ -971,7 +972,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			}
 			usage(fetch_pack_usage);
 		}
-		dest = (char *)arg;
+		dest = arg;
 		heads = (char **)(argv + i + 1);
 		nr_heads = argc - i - 1;
 		break;
@@ -1018,7 +1019,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		fd[0] = 0;
 		fd[1] = 1;
 	} else {
-		conn = git_connect(fd, (char *)dest, args.uploadpack,
+		conn = git_connect(fd, dest, args.uploadpack,
 				   args.verbose ? CONNECT_VERBOSE : 0);
 	}
 
-- 
1.7.10
