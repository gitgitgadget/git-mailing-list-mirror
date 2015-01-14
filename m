From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/10] urlmatch.c: make match_urls() static
Date: Wed, 14 Jan 2015 15:40:50 -0800
Message-ID: <1421278855-8126-6-git-send-email-gitster@pobox.com>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 00:41:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBXYx-0002jw-MU
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 00:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbbANXlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 18:41:18 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751421AbbANXlR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 18:41:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F7232DBA6;
	Wed, 14 Jan 2015 18:41:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Y69D
	iVe8khcFUm9cujf/e3Z9wVA=; b=FooOsILOteQ+DMSls8i1+QGdktEltN7DPGQO
	k5Aqj0Ost9VTBn8Ac8Wey2MTFXKqIwYGyxD/GpWzvkmnMfNgZMo/1dsrLnsxRbKD
	H51dC/ZPq86e181ec/SZnkmjMWvtj6CE5pUZYbN+9XbfzRL0s5y6u0uTsSrqH4aE
	nXj+FB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=EudSXJ
	7uXiBnQeG+gjhzM/2+wSjlY7885K5Y8ErHcHUxMxQUBkpLb7G7JRwajJlVYOAon+
	OEdEe83i8BrO4pnbvd5eKH3wqE6gM3pDKoI5vOxxLctsZcNLM2hW/D0KY5WUM48d
	G6FObL9qibzUjlZ0PvL5+Gqwz9NfMj2Bvto/Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 656E52DBA4;
	Wed, 14 Jan 2015 18:41:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E45BE2DB8A;
	Wed, 14 Jan 2015 18:41:04 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc0-134-g109a908
In-Reply-To: <1421278855-8126-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CE38B0D4-9C46-11E4-BC67-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262444>

No external callers exist.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 urlmatch.c | 6 +++---
 urlmatch.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/urlmatch.c b/urlmatch.c
index 618d216..132d342 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -412,9 +412,9 @@ static size_t url_match_prefix(const char *url,
 	return 0;
 }
 
-int match_urls(const struct url_info *url,
-	       const struct url_info *url_prefix,
-	       int *exactusermatch)
+static int match_urls(const struct url_info *url,
+		      const struct url_info *url_prefix,
+		      int *exactusermatch)
 {
 	/*
 	 * url_prefix matches url if the scheme, host and port of url_prefix
diff --git a/urlmatch.h b/urlmatch.h
index b461dfd..528862a 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -31,7 +31,6 @@ struct url_info {
 };
 
 extern char *url_normalize(const char *, struct url_info *);
-extern int match_urls(const struct url_info *url, const struct url_info *url_prefix, int *exactusermatch);
 
 struct urlmatch_item {
 	size_t matched_len;
-- 
2.3.0-rc0-134-g109a908
