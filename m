From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 16/19] check_branch_commit(): make first parameter const
Date: Mon, 22 Jun 2015 16:03:07 +0200
Message-ID: <284c129521a0287fc0f4260c4b4e8751d675419a.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:03:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72KM-0005gX-Mr
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933675AbbFVODw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:03:52 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:50774 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933601AbbFVODg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:36 -0400
X-AuditID: 12074411-f797e6d000007df3-33-558815b7b17d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 7D.1F.32243.7B518855; Mon, 22 Jun 2015 10:03:35 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3CcE030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:34 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqLtdtCPUYO5FeYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZxzZuYe54BZrxfbDD9gaGA+xdDFyckgImEhc2XedEcIWk7hwbz1bFyMXh5DAZUaJjQ8+
	MUM4J5kkjpyezwpSxSagK7Gop5kJxBYRUJOY2AYyiYuDWaCDUeLC8m3sXYwcHMIC3hJrV3qA
	1LAIqEr8/rgWrJ5XIEri2YOvbBDb5CTOH//JDGJzClhIzN/3nx3EFhIwl5g48xHLBEbeBYwM
	qxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfVyM0v0UlNKNzFCQkpwB+OMk3KHGAU4GJV4eB1s
	20OFWBPLiitzDzFKcjApifIeeA0U4kvKT6nMSCzOiC8qzUktPsQowcGsJMLbchYox5uSWFmV
	WpQPk5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4PUT6QgVEixKTU+tSMvMKUFIM3Fw
	ggznkhIpTs1LSS1KLC3JiAfFRnwxMDpAUjxAe3NA2nmLCxJzgaIQracYdTkW/Li9lkmIJS8/
	L1VKnNcfpEgApCijNA9uBSyBvGIUB/pYmNcLpIoHmHzgJr0CWsIEtORLbhvIkpJEhJRUA+Om
	7hCR7kWW3C2Fos+kmd/6uG6eJnFi/ucXggfeTZwyQ+GG2y71O45Rq9muJm6MeWR2uMvyfKf1
	D65tTGuevb20Zxpb8xmLp9Fa0ol/vT/878m3uO7ry/nTRy5FuigqnfNFV/f2iG2G 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272350>

Make it clear that this function does not overwrite its first
argument.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b42e5b6..47e3eb9 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -160,7 +160,7 @@ static int branch_merged(int kind, const char *name,
 }
 
 static int check_branch_commit(const char *branchname, const char *refname,
-			       unsigned char *sha1, struct commit *head_rev,
+			       const unsigned char *sha1, struct commit *head_rev,
 			       int kinds, int force)
 {
 	struct commit *rev = lookup_commit_reference(sha1);
-- 
2.1.4
