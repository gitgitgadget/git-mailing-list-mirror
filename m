From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/12] attr.c: update a stale comment on "struct match_attr"
Date: Mon, 16 May 2016 14:05:36 -0700
Message-ID: <20160516210545.6591-4-gitster@pobox.com>
References: <20160516210545.6591-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 23:06:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2PiF-0001E6-DU
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbcEPVF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:05:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751095AbcEPVFz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:05:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 26A281C441;
	Mon, 16 May 2016 17:05:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=1173
	Slk8TlBSAp9VJ75Jgy16V6w=; b=noJ3INk2co4UupvZSqImwXJQ7Zrwn5f4YVbE
	RM2c7SAEfxcK9qRQOcpwep11ELhALHGC9D88W9dj+bLqiV8p093c3NkHQDTH248Z
	wYePqUsRnV84QF6+eiXdYoEtjl5Yf+sIgCccpGUYb/Q/+l4WSGiYi7tGkqWlOF2E
	HrassWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ihRPa3
	BojKS3EU859GAY/6HQqxzfgoDwyTwRNGpxf8WLpUbUPsSKFXtPEdzDB2IIjtf563
	ltOxvrzZyIcGU00fi00QkWo2P9xCN4i7sDCJjOhUgH8yUu2efz3c5g8xzpeiiKRE
	bOnpqde2Vn3nXb/XZ3I/tbk4/bCuIvjWlZcFE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E2381C440;
	Mon, 16 May 2016 17:05:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 93D211C43F;
	Mon, 16 May 2016 17:05:54 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-755-g8847aff
In-Reply-To: <20160516210545.6591-1-gitster@pobox.com>
X-Pobox-Relay-ID: FA6BAA6A-1BA9-11E6-92D9-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294791>

When 82dce998 (attr: more matching optimizations from .gitignore,
2012-10-15) changed a pointer to a string "*pattern" into an
embedded "struct pattern" in struct match_attr, it forgot to update
the comment that describes the structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 45aec1b..4ae7801 100644
--- a/attr.c
+++ b/attr.c
@@ -131,9 +131,8 @@ struct pattern {
  * If is_macro is true, then u.attr is a pointer to the git_attr being
  * defined.
  *
- * If is_macro is false, then u.pattern points at the filename pattern
- * to which the rule applies.  (The memory pointed to is part of the
- * memory block allocated for the match_attr instance.)
+ * If is_macro is false, then u.pat is the filename pattern to which the
+ * rule applies.
  *
  * In either case, num_attr is the number of attributes affected by
  * this rule, and state is an array listing them.  The attributes are
-- 
2.8.2-748-gfb85f76
