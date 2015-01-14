From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/10] remote.c: make clear_cas_option() static
Date: Wed, 14 Jan 2015 15:40:51 -0800
Message-ID: <1421278855-8126-7-git-send-email-gitster@pobox.com>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 00:41:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBXZ3-0002mZ-RZ
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 00:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbbANXlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 18:41:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51100 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751726AbbANXlY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 18:41:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 30FA52DBB0;
	Wed, 14 Jan 2015 18:41:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=kJPe
	9x0Mt5YID4YNFoPdVzoyHRQ=; b=CCVxF+H8DZmkP3pu9wle+2yDm2I4NAkJh8Ap
	cA2q/63XgA6IzAZKKVmHvSvJWah9in/aSwmUgSxuRy7xD4ZwAlulglsiZySORb8y
	+5b3Y9qmykbSehXhqWwugaiWt1hZOTRkA57m6ZpnbfqZtwqTOYsZ985OLWzVA2P7
	45FmBmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Uce1CH
	RjLeeoPqxcuYKzqphdB/uhZz4cucIOJwr6t2X4lLbKvhbjLrZDKcAfeh2AqXp0qV
	ca1ygZkg7H6R9W42rF/2x9Zl2CyB0ZrK0Ios9cUG8N3wqsJC0RnAqLQvwVQhB63d
	aA9TA5BjaJZTcIRYs7yGow3c11/cqbkfigVmI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2579E2DBAF;
	Wed, 14 Jan 2015 18:41:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E38E2DB94;
	Wed, 14 Jan 2015 18:41:08 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc0-134-g109a908
In-Reply-To: <1421278855-8126-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D01FBCA8-9C46-11E4-9F2B-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262445>

No external callers exist.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c | 2 +-
 remote.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 5b9c693..0b3939c 100644
--- a/remote.c
+++ b/remote.c
@@ -2156,7 +2156,7 @@ struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fet
 /*
  * Compare-and-swap
  */
-void clear_cas_option(struct push_cas_option *cas)
+static void clear_cas_option(struct push_cas_option *cas)
 {
 	int i;
 
diff --git a/remote.h b/remote.h
index 8b62efd..31ccdcd 100644
--- a/remote.h
+++ b/remote.h
@@ -260,7 +260,6 @@ struct push_cas_option {
 
 extern int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
 extern int parse_push_cas_option(struct push_cas_option *, const char *arg, int unset);
-extern void clear_cas_option(struct push_cas_option *);
 
 extern int is_empty_cas(const struct push_cas_option *);
 void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
-- 
2.3.0-rc0-134-g109a908
