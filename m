From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/18] date.c: mark file-local function static
Date: Mon, 11 Jan 2010 23:52:47 -0800
Message-ID: <1263282781-25596-5-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:53:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbZR-0004h8-KP
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409Ab0ALHxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589Ab0ALHxX
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40987 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab0ALHxS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CF408E885
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=2cxZ
	UVEDNqO0wQci2otN2jx1pvc=; b=XHxtqTNaga5fSwtziaSinLMimyM3rLATauVG
	vI1t5U6HOwL928R/ThYVAx8bexDFqVgYCZE1C4BnAKptBH64vj8vebVT4cVtasG4
	Z/E3rNd93kPR0nUui6rORGl4H+JXN0i353PMUK9OSEak862Y2Y4P24H3ENSNzEPM
	hpjjv7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=VbIjfF
	9X1KFBljeVqrN9lvlChi7OqmehgYFOwWohtzA+RWeyvqrQL7/Sl61rV5OE8FfD5A
	6SXYzlEZ3bol5IrspCm8vrplpZMfTWjiMp2anWeOzKCan3PKjGflR7RkMDYeyET2
	VOerh8YrDcbtaZ526fVZ5djAo6wcn9TGfaOlw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 897A38E884
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DD468E883 for
 <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:16 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8B7AA872-FF4F-11DE-93EE-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136684>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Has a trivial conflict in git-compat-util.h when applyed to 'pu'

 date.c            |    2 +-
 git-compat-util.h |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/date.c b/date.c
index 5d05ef6..45f3684 100644
--- a/date.c
+++ b/date.c
@@ -9,7 +9,7 @@
 /*
  * This is like mktime, but without normalization of tm_wday and tm_yday.
  */
-time_t tm_to_time_t(const struct tm *tm)
+static time_t tm_to_time_t(const struct tm *tm)
 {
 	static const int mdays[] = {
 	    0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
diff --git a/git-compat-util.h b/git-compat-util.h
index 5c59687..85dea12 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -198,7 +198,6 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 
 extern int prefixcmp(const char *str, const char *prefix);
-extern time_t tm_to_time_t(const struct tm *tm);
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
 {
-- 
1.6.6.280.ge295b7.dirty
