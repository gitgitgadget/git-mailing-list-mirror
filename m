From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/5] verify_lock(): do not capitalize error messages
Date: Sat, 23 May 2015 01:34:56 +0200
Message-ID: <1432337697-29161-5-git-send-email-mhagger@alum.mit.edu>
References: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 01:35:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvwTS-0003SR-C1
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 01:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757700AbbEVXf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 19:35:26 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44945 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757328AbbEVXfX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 19:35:23 -0400
X-AuditID: 1207440f-f79236d000000c5e-32-555fbd2c282a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id D7.31.03166.C2DBF555; Fri, 22 May 2015 19:35:08 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3AFA.dip0.t-ipconnect.de [93.219.58.250])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4MNZ2Pv007402
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 22 May 2015 19:35:07 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqKuzNz7U4PUlI4uuK91MFg29V5gt
	bq+Yz2yxeXM7iwOLx9/3H5g8Fmwq9bh4Sdnj8ya5AJYobpukxJKy4Mz0PH27BO6MxZ2vmAva
	2SvmXD/D1MB4kLWLkZNDQsBE4vnhRYwQtpjEhXvr2boYuTiEBC4zShw9uY4JwjnBJLHy1ydm
	kCo2AV2JRT3NTCC2iICaxMS2QywgNrNArsSGfaeA4hwcwgIuEocuiYGEWQRUJQ51z2UDCfMC
	hZu7jSB2yUmcP/4TbCKngKvE7aV9YBOFgEp6t39jmcDIu4CRYRWjXGJOaa5ubmJmTnFqsm5x
	cmJeXmqRrolebmaJXmpK6SZGSOjw72DsWi9ziFGAg1GJh9fgYFyoEGtiWXFl7iFGSQ4mJVHe
	VSviQ4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8J7dDJTjTUmsrEotyodJSXOwKInzqi9R9xMS
	SE8sSc1OTS1ILYLJynBwKEnwcu4BahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgH
	xUV8MTAyQFI8QHuNQNp5iwsSc4GiEK2nGHU57kz5v4hJiCUvPy9VSpz3/W6gIgGQoozSPLgV
	sETxilEc6GNhXlOQUTzAJAM36RXQEiagJasmxIIsKUlESEk1MIrVSnJI/dI/2bE/f+n6adUa
	Ey99qFn8v4lrN8vvFgcetoLi09MVTsiKRX7j5fsncIyHlXfynN8qe6yn+B/7fDL/h/ufa6Fy
	B44pb9wnXG0tvO2J97LrnBtjhFfdEZSYc0MiJuvNkq7ctCf6fIdL4nJ91Z1ll7wu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269773>

Our convention is for error messages to start with a lower-case
letter.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 625e69f..48aff79 100644
--- a/refs.c
+++ b/refs.c
@@ -2211,12 +2211,12 @@ static int verify_lock(struct ref_lock *lock,
 			  mustexist ? RESOLVE_REF_READING : 0,
 			  lock->old_sha1, NULL)) {
 		int save_errno = errno;
-		strbuf_addf(err, "Can't verify ref %s", lock->ref_name);
+		strbuf_addf(err, "can't verify ref %s", lock->ref_name);
 		errno = save_errno;
 		return -1;
 	}
 	if (hashcmp(lock->old_sha1, old_sha1)) {
-		strbuf_addf(err, "Ref %s is at %s but expected %s",
+		strbuf_addf(err, "ref %s is at %s but expected %s",
 			    lock->ref_name,
 			    sha1_to_hex(lock->old_sha1),
 			    sha1_to_hex(old_sha1));
-- 
2.1.4
