From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/18] utf8.c: mark file-local function static
Date: Mon, 11 Jan 2010 23:52:55 -0800
Message-ID: <1263282781-25596-13-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:53:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbZT-0004h8-VN
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab0ALHxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470Ab0ALHxe
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315Ab0ALHxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8ED278E8A2
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=2//H
	hQffCcSuSTpdSBQwvlIFJPk=; b=IPAXcmEvRr6pBzhlP4TluP/ylZaOISaGu2ay
	LcRPCLxZY56tYbqiCxW9UdT/0TpZcrsc9Wo+x+0wzbaWkjsZHshtFrGipPZwUcuw
	KbC3St2Cu0cZyjcs8u6XZ2UoLNLBVGY626SSQXuHOnQ/2hsCHbmCdAB7aWVipGzd
	zMCdvNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=idnllb
	ph6cGLwEA4cJ39krxuTK2gJxgvjOzPFLf0t017Pm8fTtoo4ehz80+2ojcX1uZGK6
	3foI1uECykGlnORYT8NBe2EjFY2njGtiQ3qf9CxG59Zd0y9E3w2JpAjWM+BRAbvl
	5BazlkT5aqlSrGI/RQK3Kp9mD3u2VskIxhmYE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B3198E8A1
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2265E8E8A0 for
 <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:30 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 93D4A61C-FF4F-11DE-93EE-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136689>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 utf8.c |    2 +-
 utf8.h |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/utf8.c b/utf8.c
index 7ddff23..ab326ac 100644
--- a/utf8.c
+++ b/utf8.c
@@ -163,7 +163,7 @@ static int git_wcwidth(ucs_char_t ch)
  * If the string was not a valid UTF-8, *start pointer is set to NULL
  * and the return value is undefined.
  */
-ucs_char_t pick_one_utf8_char(const char **start, size_t *remainder_p)
+static ucs_char_t pick_one_utf8_char(const char **start, size_t *remainder_p)
 {
 	unsigned char *s = (unsigned char *)*start;
 	ucs_char_t ch;
diff --git a/utf8.h b/utf8.h
index ae30ae4..c9738d8 100644
--- a/utf8.h
+++ b/utf8.h
@@ -3,7 +3,6 @@
 
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
 
-ucs_char_t pick_one_utf8_char(const char **start, size_t *remainder_p);
 int utf8_width(const char **start, size_t *remainder_p);
 int utf8_strwidth(const char *string);
 int is_utf8(const char *text);
-- 
1.6.6.280.ge295b7.dirty
