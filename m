From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/7] builtin/log.c: drop unused "numbered" parameter from
 make_cover_letter()
Date: Sat, 22 Dec 2012 00:33:26 -0800
Message-ID: <1356165212-5611-2-git-send-email-gitster@pobox.com>
References: <1356165212-5611-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 09:34:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmKWo-0007hl-Uc
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 09:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168Ab2LVIdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 03:33:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060Ab2LVIdg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 03:33:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E1C3827D
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=7kXo
	ZBdpMVbdho6JKlRWmSA+0Fc=; b=RYI1Z4a5NlNjHVv8sUE+yNFI4qcYgZAIoCpD
	v91iEtWpBi8vOjwlgjW6QovQu0D0fktsX/3br+NIGA0NeabmggL0gUHwEtT/ORLu
	L2TJV3g+YQvgFfy+JTibcdjbMd6rS8dTS1FnG0JpZ8epXdhMQVLLgPaA5vqO39rA
	uTqFAFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Z2Rsol
	dbvYdJjDBW7LNJIynYDwy4DW5Fff7PqLQ/EhRQ8R/dOG0Vd7I03+umU0ZSFKUAdU
	D5+JHmn4YyMeBo1i5DaJ0FLa9atMehHGaU4IaZdJFHwt79RNaNxzCxifq42JTLBQ
	a589pS/X69T3CRxfQbB0eLLnrRAJDKuWp/m2w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D18E827C
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9969C827A for
 <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:35 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.227.g7335c9f
In-Reply-To: <1356165212-5611-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 46D9FD7C-4C12-11E2-95A9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212037>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 09cf43e..28d9063 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -768,7 +768,7 @@ static void add_branch_description(struct strbuf *buf, const char *branch_name)
 }
 
 static void make_cover_letter(struct rev_info *rev, int use_stdout,
-			      int numbered, int numbered_files,
+			      int numbered_files,
 			      struct commit *origin,
 			      int nr, struct commit **list, struct commit *head,
 			      const char *branch_name,
@@ -1343,7 +1343,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_letter) {
 		if (thread)
 			gen_message_id(&rev, "cover");
-		make_cover_letter(&rev, use_stdout, numbered, numbered_files,
+		make_cover_letter(&rev, use_stdout, numbered_files,
 				  origin, nr, list, head, branch_name, quiet);
 		total++;
 		start_number--;
-- 
1.8.0.6.gd28b5d4.dirty
