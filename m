From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/6] name-rev: lose unnecessary typedef
Date: Wed, 29 Aug 2012 20:50:24 -0700
Message-ID: <1346298629-13730-2-git-send-email-gitster@pobox.com>
References: <1346298629-13730-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 05:51:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6vmu-0007XS-RU
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 05:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563Ab2H3Duj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 23:50:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48021 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab2H3Dud (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 23:50:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D08288A6
	for <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Otwx
	4iFjnZiBsILer/JvyIq/+O0=; b=YuI+EZ5Qm0z8jq/+rbHXVWRjjFKPNNXz2OcB
	a/uIsVC07d9AhwSeKXhbr0kSPNMMGB+Tf5p2k6DWRJzSH9VMaoXEEAfY+e+6S6sK
	uJCbTCeZh/RVdTCKpsVe2t7wWllz9J1YOcYVEARSIYOJIp2XQCXJUatB0+XOiBDK
	sQ7DhEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Vy+W8E
	lbXjslP4Tvr4f84WLrxohV9rb4FUQNKA1F/CLDKDhXOz/11gSigpcfF/gUd9jop8
	Kl3ku9efaeV2gMlLWa9uStbrAMyR68a+i6qybi3AK3CtXVjmQ4Sc7mUnt8dwvo2Z
	Sp6GQ1Lqj4GAaWBFC4brgT/Wx/vI+B+79eIEQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CB6E88A5
	for <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2B4A88A4 for
 <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:32 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.286.g9df01f7
In-Reply-To: <1346298629-13730-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D93E1F70-F255-11E1-AF86-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204510>

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
1.7.12.286.g9df01f7
