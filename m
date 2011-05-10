From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] lock_any_ref_for_update(): clarify switch case statement
Date: Tue, 10 May 2011 13:48:01 +0200
Message-ID: <4DC925F1.4060307@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 13:48:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJlQC-0003X6-7U
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 13:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434Ab1EJLsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 07:48:07 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:50490 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753869Ab1EJLsG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 07:48:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 4EAE0DE740
	for <git@vger.kernel.org>; Tue, 10 May 2011 13:48:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R7CUz1YSLSqJ for <git@vger.kernel.org>;
	Tue, 10 May 2011 13:48:04 +0200 (CEST)
Received: from [10.10.10.226] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 2D7E4DE73D
	for <git@vger.kernel.org>; Tue, 10 May 2011 13:48:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110503 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173329>


Write CHECK_REF_FORMAT_OK instead of '0' to be more verbose.

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index e3c0511..67d6bbd 100644
--- a/refs.c
+++ b/refs.c
@@ -1092,7 +1092,7 @@ struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *o
 	switch (check_ref_format(ref)) {
 	default:
 		return NULL;
-	case 0:
+	case CHECK_REF_FORMAT_OK:
 	case CHECK_REF_FORMAT_ONELEVEL:
 		return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);
 	}
-- 
1.7.5.1
