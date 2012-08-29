From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] name-rev: lose unnecessary typedef
Date: Wed, 29 Aug 2012 14:17:22 -0700
Message-ID: <1346275044-10171-2-git-send-email-gitster@pobox.com>
References: <7vharmxkzl.fsf@alter.siamese.dyndns.org>
 <1346275044-10171-1-git-send-email-gitster@pobox.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 23:18:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6ped-0008Mc-TK
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 23:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551Ab2H2VR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 17:17:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754468Ab2H2VR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 17:17:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FEA48CA7;
	Wed, 29 Aug 2012 17:17:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Nozn
	BmR6mXoRw3iQHT2azuWXozU=; b=gDnCGSooGtKZw8r2SEs3mGsN07nJtYy2DlI7
	4HfwTsDnnEZZOinkkuoXJ8sFnKB/lyAp1PNLxpq6qAxSWwmI+hWcoO1d0HOyITTd
	Nj17iVna37kQmwQDapwxVlnCr+wu+vYFyDcJvFtqCoa8tVRDif7CdaWezKWCSA1N
	qV1unec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Im5pPTQlnDN4t/VRWwZLTSeKI6jWvMLPq1ucbUCSPUwmlIMkIwOkX3hq7DQb9YAJ
	BxvmUTfsqYpp5cM9lu1lhoZlwSnaWMug0EgeOjOEYcGFlkya13LjPwmEfZXO2/T0
	csehi96y3v8MyWFIsSTRP+u5hRQhB7zXppEqA1GqJBw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F26218CA6;
	Wed, 29 Aug 2012 17:17:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C45E8CA4; Wed, 29 Aug 2012
 17:17:27 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.285.ga3d5fc0
In-Reply-To: <1346275044-10171-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EF32F24C-F21E-11E1-887E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204503>

Just spell it "struct rev_name"; it makes it more clear what is
going on.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/name-rev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 1b37458..8af2cfa 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -7,11 +7,11 @@
 
 #define CUTOFF_DATE_SLOP 86400 /* one day */
 
-typedef struct rev_name {
+struct rev_name {
 	const char *tip_name;
 	int generation;
 	int distance;
-} rev_name;
+};
 
 static long cutoff = LONG_MAX;
 
@@ -43,7 +43,7 @@ static void name_rev(struct commit *commit,
 	}
 
 	if (name == NULL) {
-		name = xmalloc(sizeof(rev_name));
+		name = xmalloc(sizeof(struct rev_name));
 		commit->util = name;
 		goto copy_data;
 	} else if (name->distance > distance) {
-- 
1.7.12.285.ga3d5fc0
