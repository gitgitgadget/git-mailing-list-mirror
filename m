From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] wt-status: remove unused workdir_untracked field
Date: Sat, 10 Apr 2010 00:40:52 -0700
Message-ID: <1270885256-31589-2-git-send-email-gitster@pobox.com>
References: <1270885256-31589-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 09:41:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0VJh-0000KR-JP
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 09:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab0DJHlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 03:41:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab0DJHlG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 03:41:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 01399A954C
	for <git@vger.kernel.org>; Sat, 10 Apr 2010 03:41:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6iMm
	suKanAO80stgetFqjR/gqHA=; b=xBNSoMZZH92EL51bS0+CSUNX5HQsRDUzzaI0
	P+S3XLWiBUWf9RqHluti7FrQQPHPYAGVZO3XPmryQ+uk4UaikBf97LidVRDKbe/L
	PSf0UVYA3gR9cAdEKwb4o2qZtlBkyn4XnaBS/6ftxnf60dp6MzoccX7QlpON7zgn
	Ey3AJ8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=HryL0p
	Z3o0ORC2nWJi/Jsg6Dwb/Yw7bJbippzVo0Ns2LTetl6N6av0eDOR+7sKnEdpzA6Z
	bIYxl1jmXRXMOoIHsjWoxSXDGm4uUxDWYbJdgWM3aMR29TCKFj+bKaM97ZlEYFgo
	H9O3IAxmsQE4AGitr+6Ebl8K2Sx4ztXsmyvIA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F0DCFA954B
	for <git@vger.kernel.org>; Sat, 10 Apr 2010 03:41:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67694A954A for
 <git@vger.kernel.org>; Sat, 10 Apr 2010 03:41:01 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc0.264.g94f6e
In-Reply-To: <1270885256-31589-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 69F7640A-4474-11DF-88E3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144523>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c |    1 -
 wt-status.h |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 8ca59a2..db20b86 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -378,7 +378,6 @@ static void wt_status_collect_untracked(struct wt_status *s)
 			continue;
 		if (!match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
 			continue;
-		s->workdir_untracked = 1;
 		string_list_insert(ent->name, &s->untracked);
 	}
 }
diff --git a/wt-status.h b/wt-status.h
index 9120673..2c49f46 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -47,7 +47,6 @@ struct wt_status {
 	/* These are computed during processing of the individual sections */
 	int commitable;
 	int workdir_dirty;
-	int workdir_untracked;
 	const char *index_file;
 	FILE *fp;
 	const char *prefix;
-- 
1.7.1.rc0.264.g94f6e
