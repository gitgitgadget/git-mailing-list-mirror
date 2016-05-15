From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] attr: update a stale comment on "struct match_attr"
Date: Sun, 15 May 2016 15:59:08 -0700
Message-ID: <xmqq60uf3p37.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 00:59:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b250F-0007UV-MQ
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 00:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbcEOW7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 18:59:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751815AbcEOW7L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 18:59:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F8951B95F;
	Sun, 15 May 2016 18:59:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=4
	0pufcDxfZrNvKnzZDmpiVe8JEM=; b=Yoc6IEsLXFzYVLGikX3lJSWpohalrr1jx
	liX5Vqc+DXU82UxlDPOP1rDHm1ghRtM2wEbP/a7VPg7HInJ+r/9VDKGbYEdxmpsB
	deD0dv7vRjG3yHDyLpmPx3st5BSCtrDJeKEiPyHUxNDnIaaZfwvAVhO8ALHJUgu/
	BsbI7sb1mc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=POt
	7v0CmASKr2OQgxgd0vO0aV9TY1vQKYmM1heEnmQ+fw/ZFQq8DJHw8JoDsgY/K8MO
	HXCqyvpyJd/SDgT5fj1CYCzn4yAHkxtQAjWW/rhRqd4Jk1DqfLlVNOhdw/IKXmaP
	8H/H3f7GXyjqtrXtf1xB25VBHTZAcARO9PUYysV4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 183911B95E;
	Sun, 15 May 2016 18:59:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90BEE1B95D;
	Sun, 15 May 2016 18:59:10 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A2BB8060-1AF0-11E6-8DE8-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294695>

When 82dce998 (attr: more matching optimizations from .gitignore,
2012-10-15) changed a pointer to a string "*pattern" into an
embedded "struct pattern" in struct match_attr, it forgot to update
the comment that describes the structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index eec5d7d..94b27f4 100644
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
