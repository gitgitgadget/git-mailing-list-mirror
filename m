From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 15/18] strbuf.c: remove unused function
Date: Mon, 11 Jan 2010 23:52:58 -0800
Message-ID: <1263282781-25596-16-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:53:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbZV-0004h8-ON
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497Ab0ALHxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495Ab0ALHxo
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab0ALHxi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 51C708E8AD
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Gw8E
	a+BDitcOhzQ4RDxlRytZ7lU=; b=JOQmB2KtL3s17VEzjtbyvDC76jSeEFAJ91Nr
	IwY93dhY8bWf0wYOckwz49B57dGI+Bp8bCNVt0pDwtfj9oEk73ylw01E5VJfjZ2W
	IlOOnXi1eCSKvDZntSsIdJKQ7Uf2UbwFVfnGqPm9y2MmJZRKrO9eYUHtuUk+L+1A
	5mhevaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=uPYcJG
	eOLcdQjtwI7QYy/E0OMuQEJ5cRCCmAUpeNQmTByjL0hCeG2Db2xkvNT308EHTLD1
	qftQs2snnEcfgausg+SqheV87AcLRvTFWjaTSyEGX6aV0lMOCMhbEKeGn/iC1Vh5
	/XeGzXooxOS5MBUl7OjMh8MpJDH6FHPIrBGl8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EDE68E8AC
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D983F8E8A9 for
 <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:37 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 97DBB8E0-FF4F-11DE-8A02-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136692>

strbuf_tolower() is not used anywhere.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 strbuf.c |    7 -------
 strbuf.h |    1 -
 2 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index a6153dc..3fa81b3 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -91,13 +91,6 @@ void strbuf_ltrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
-void strbuf_tolower(struct strbuf *sb)
-{
-	int i;
-	for (i = 0; i < sb->len; i++)
-		sb->buf[i] = tolower(sb->buf[i]);
-}
-
 struct strbuf **strbuf_split(const struct strbuf *sb, int delim)
 {
 	int alloc = 2, pos = 0;
diff --git a/strbuf.h b/strbuf.h
index fa07ecf..b37f06a 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -81,7 +81,6 @@ extern void strbuf_trim(struct strbuf *);
 extern void strbuf_rtrim(struct strbuf *);
 extern void strbuf_ltrim(struct strbuf *);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
-extern void strbuf_tolower(struct strbuf *);
 
 extern struct strbuf **strbuf_split(const struct strbuf *, int delim);
 extern void strbuf_list_free(struct strbuf **);
-- 
1.6.6.280.ge295b7.dirty
