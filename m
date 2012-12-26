From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] merge-tree: lose unused "resolve_directories"
Date: Wed, 26 Dec 2012 15:03:38 -0800
Message-ID: <1356563020-13919-4-git-send-email-gitster@pobox.com>
References: <1356563020-13919-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 27 00:04:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To01F-0007FV-5u
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 00:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab2LZXDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 18:03:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33951 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab2LZXDt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 18:03:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C675BA326
	for <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=HTk0
	cm4ne2jvej4Rs0ur4hLnCTw=; b=R+IsyMVgGCMRyxVNclwA00HMqTQZMOTgQeMo
	NEqQ2OuQpWrtD5fQsYyECyexg77L3noWmF8vXAYVdjw3FSz/OlIekrFqX17uz43n
	Xu26fTdB50w74LpBTY+Nlirst0eh4IuhVBEd2HURNtxtlk1GDzflOapiy5RXllXO
	oDRLEjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=H76uMI
	3NSP6gIaLWZp3zoYR7o01VmPs5EuYFRd60d6GMku4//ae9fFwPuxPGaDsGMDr3oU
	4Qw4o/42HFbznREqp6cmNKRK6j+dnN5+4jm4tPyFXAbeFwy1gjKH1ptuoQITYbmW
	i6v0PxNtheMRNZVFfcGFbol24ZdQL/mA/+whk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4768A325
	for <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 412EAA324 for
 <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:48 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc3.356.g686f81c
In-Reply-To: <1356563020-13919-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 81A96400-4FB0-11E2-A19D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212166>

This option is always set; simplify.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge-tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index b61d811..95de162 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -6,7 +6,6 @@
 #include "merge-blobs.h"
 
 static const char merge_tree_usage[] = "git merge-tree <base-tree> <branch1> <branch2>";
-static int resolve_directories = 1;
 
 struct merge_list {
 	struct merge_list *next;
@@ -198,8 +197,6 @@ static int unresolved_directory(const struct traverse_info *info, struct name_en
 	struct tree_desc t[3];
 	void *buf0, *buf1, *buf2;
 
-	if (!resolve_directories)
-		return 0;
 	p = n;
 	if (!p->mode) {
 		p++;
-- 
1.8.1.rc3.356.g686f81c
