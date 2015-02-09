From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/8] write_ref_sha1(): remove check for lock == NULL
Date: Mon,  9 Feb 2015 10:12:37 +0100
Message-ID: <1423473164-6011-2-git-send-email-mhagger@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 10:20:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKkVl-00028d-Jv
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 10:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbbBIJT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 04:19:57 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:52463 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932383AbbBIJT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 04:19:56 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Feb 2015 04:19:56 EST
X-AuditID: 1207440f-f792a6d000001284-d0-54d87a15d500
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 09.D7.04740.51A78D45; Mon,  9 Feb 2015 04:12:53 -0500 (EST)
Received: from michael.fritz.box (p4FC971C1.dip0.t-ipconnect.de [79.201.113.193])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t199CnQX026231
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Feb 2015 04:12:52 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqCtadSPEoOW7okXXlW4mi4beK8wW
	b28uYbS4vWI+s0X3lLeMFr19n1gtNm9uZ3Fg9/j7/gOTx85Zd9k9Fmwq9bh4Sdnj8ya5ANYo
	bpukxJKy4Mz0PH27BO6Mh/daWQvesFTcO3qUqYHxMXMXIweHhICJxKuFpl2MnECmmMSFe+vZ
	uhi5OIQELjNKnNmzA8o5wSSxbPNmNpAqNgFdiUU9zUwgtoiAmsTEtkMsIDazwGomia13wWqE
	BVwkLv88DxZnEVCVeNb3kxXE5hVwluj8vYUVYpucxPnjP5lBbE6g+nfn5oD1CgHVzJ68j3kC
	I+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCFBxr+DsWu9zCFGAQ5G
	JR7eio/XQ4RYE8uKK3MPMUpyMCmJ8i5IvBEixJeUn1KZkVicEV9UmpNafIhRgoNZSYT3ewZQ
	jjclsbIqtSgfJiXNwaIkzqu+RN1PSCA9sSQ1OzW1ILUIJivDwaEkwTunAqhRsCg1PbUiLTOn
	BCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQZ8cXA2ABJ8QDt3QHSzltckJgLFIVoPcWoy7Ggff9M
	JiGWvPy8VClx3n6QIgGQoozSPLgVsJTyilEc6GNhXs5KoCoeYDqCm/QKaAkT0JKCArAlJYkI
	KakGRkuZT8m7Engk9737dclhT9i7HT7xn47e+33js6/Cu6jjBndMC9nqMkOC1BPYNvPXRmW4
	3XHlmvmP7/2vUj1br9yQ3FcnP79KdjxZqbZsyp2tKY8rDecHFp+/FB767f1HMfFH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263551>

None of the callers pass NULL to this function, and there doesn't seem
to be any usefulness to allowing them to do so.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/refs.c b/refs.c
index c5fa709..d1130e2 100644
--- a/refs.c
+++ b/refs.c
@@ -3080,10 +3080,6 @@ static int write_ref_sha1(struct ref_lock *lock,
 	static char term = '\n';
 	struct object *o;
 
-	if (!lock) {
-		errno = EINVAL;
-		return -1;
-	}
 	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
 		unlock_ref(lock);
 		return 0;
-- 
2.1.4
