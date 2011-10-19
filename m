From: mhagger@alum.mit.edu
Subject: [RFC 13/13] filter_refs(): the refname is full, so use REFNAME_FULL option
Date: Wed, 19 Oct 2011 22:55:16 +0200
Message-ID: <1319057716-28094-14-git-send-email-mhagger@alum.mit.edu>
References: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:00:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdFI-0005kD-9B
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063Ab1JSVAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:00:09 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:32789 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054Ab1JSVAH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:00:07 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGd4f-000423-5g; Wed, 19 Oct 2011 22:49:17 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183960>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c6bc8eb..d72aa44 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -546,7 +546,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
 		if (!memcmp(ref->name, "refs/", 5) &&
-		    check_refname_format(ref->name + 5, 0))
+		    check_refname_format(ref->name, REFNAME_FULL))
 			; /* trash */
 		else if (args.fetch_all &&
 			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
-- 
1.7.7
