From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/18] quote.c: mark file-local function static
Date: Mon, 11 Jan 2010 23:52:53 -0800
Message-ID: <1263282781-25596-11-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:53:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbZT-0004h8-C2
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab0ALHxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445Ab0ALHx3
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab0ALHx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 283AB8E89B
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ytwC
	O9r5I0S6+OdeNeJyf/E8Dlk=; b=mKmewDBQ2T8AaWHdrOuurNJO0S3dYsO8SB+F
	2uo+FvF4wp1xm9QrLN4juYGDDd7nW3l2kwkpkXVSraQ742kYYsdpycqXUKnphTUe
	Moh1PddNj2t3QQ3uHjVIyDO95pZOHWqAdlgs4JXI+2ZhMNxnc9O/3qML+R5uFDcB
	a+sD1co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=PBiotn
	IiL/5ahhrXjz0M8uuczw4jtWyltnyqrd0opdk0arfpYDpR3G+ItKigMOX1PmEdbZ
	RJmEakpuFhDPvw/jzqKi64hnhPzBsl53IxifsSnDrup1qu6+gQTvdi4fjOMYQCpJ
	umGF4VyqjUw2TP6W9xM8yg59dPDlmjryIGy6U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 241D18E89A
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD50C8E899 for
 <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:27 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 91C98B4E-FF4F-11DE-99AA-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136686>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 quote.c |    2 +-
 quote.h |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/quote.c b/quote.c
index 848d174..acb6bf9 100644
--- a/quote.c
+++ b/quote.c
@@ -72,7 +72,7 @@ void sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxlen)
 	}
 }
 
-char *sq_dequote_step(char *arg, char **next)
+static char *sq_dequote_step(char *arg, char **next)
 {
 	char *dst = arg;
 	char *src = arg;
diff --git a/quote.h b/quote.h
index 66730f2..f83eb23 100644
--- a/quote.h
+++ b/quote.h
@@ -45,7 +45,6 @@ extern char *sq_dequote(char *);
  * next argument that should be passed as first parameter. When there
  * is no more argument to be dequoted, "next" is updated to point to NULL.
  */
-extern char *sq_dequote_step(char *arg, char **next);
 extern int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc);
 
 extern int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
-- 
1.6.6.280.ge295b7.dirty
