From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/17] find_first_merges(): initialize merges variable using initializer
Date: Sun, 19 May 2013 22:27:09 +0200
Message-ID: <1368995232-11042-15-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeADp-0004mK-5I
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab3ESU2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:33 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:57958 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754167Ab3ESU2R (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:28:17 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-b4-519935e1f174
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.86.02295.1E539915; Sun, 19 May 2013 16:28:17 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5X026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:28:16 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqPvQdGagwebVChZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTtj6/TNjAUX2SreTfjP1MC4g7WLkZNDQsBE4uSqGWwQtpjEhXvrgWwuDiGBy4wSz1rO
	MIEkhATOM0kc2l8DYrMJ6Eos6mkGi4sIyEp8P7yREcRmFpjAKLG0v7CLkYNDWCBC4so8VZAw
	i4CqxISTU9hBbF4BV4n9kyZD7VKQuDxrDTOIzQkU39K+ixVilYvEv/7brBMYeRcwMqxilEvM
	Kc3VzU3MzClOTdYtTk7My0st0jXUy80s0UtNKd3ECAkonh2M39bJHGIU4GBU4uHVeDc9UIg1
	say4MvcQoyQHk5Io7zuTmYFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHj3CAHleFMSK6tSi/Jh
	UtIcLErivKpL1P2EBNITS1KzU1MLUotgsjIcHEoSvObAyBESLEpNT61Iy8wpQUgzcXCCCC6Q
	DTxAG6RBCnmLCxJzizPTIYpOMSpKifMygyQEQBIZpXlwA2Cx/4pRHOgfYV5bkCoeYNqA634F
	NJgJaDDrtakgg0sSEVJSDYyuE1jb32pfPxL19VRNqKf3fc4U3ni1q6L6mhwv5i6MurOy6LC7
	rpmaAuezfGvp7r2K61LM58d+STbt4Nm+orciIJx7z/qX1v0L86ZIPWj4xhAxV94hP0BS7+m5
	w9dM3wRP3nP9wJUDe71DX8ucKr+z6knIpqjut4t186/K6vitFfB4f2ifs4QSS3FG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224918>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 submodule.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index e728025..b837c04 100644
--- a/submodule.c
+++ b/submodule.c
@@ -846,7 +846,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 		struct commit *a, struct commit *b)
 {
 	int i, j;
-	struct object_array merges;
+	struct object_array merges = OBJECT_ARRAY_INIT;
 	struct commit *commit;
 	int contains_another;
 
@@ -856,7 +856,6 @@ static int find_first_merges(struct object_array *result, const char *path,
 	struct rev_info revs;
 	struct setup_revision_opt rev_opts;
 
-	memset(&merges, 0, sizeof(merges));
 	memset(result, 0, sizeof(struct object_array));
 	memset(&rev_opts, 0, sizeof(rev_opts));
 
-- 
1.8.2.3
