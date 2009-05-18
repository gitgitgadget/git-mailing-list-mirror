From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 4/8] builtin-mailinfo.c: use "ISO8859-1" instead of "latin1" as fallback encoding
Date: Mon, 18 May 2009 18:44:41 -0500
Message-ID: <KfeKNR3Jm6YKvPIcYGBMpGlk83sgTnCuuc7WdvYgBn_Ja9b0yZjdlJxTSSCaDWC05irzAQVk1uM@cipher.nrlssc.navy.mil>
References: <KfeKNR3Jm6YKvPIcYGBMpCbbOxxIaBRphS4qzgN2W9mXIvp7Hl8SgBQzbAhZRV4A4Q6X14JTLR4@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpKjNOsMcmMNMJ1vr-EBr-eE371H-Rg69NOM1rMB2Oa5nCGVe2SMGKdc@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpLkRr97IFN82BZR2bJNHFQYwhjGgwGRoIAkKO5m1EZb7M9epcX8P-fk@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpEj60b9ww0Dv2XSyNy2qLE-KEaaF8D8q9OHVC3tPAPSzNe1CJUXJDfA@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 01:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6CW5-0003Pz-1k
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 01:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbZERXpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 19:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753235AbZERXpD
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 19:45:03 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50116 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbZERXo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 19:44:58 -0400
Received: by mail.nrlssc.navy.mil id n4INitKQ024906; Mon, 18 May 2009 18:44:58 -0500
In-Reply-To: <KfeKNR3Jm6YKvPIcYGBMpEj60b9ww0Dv2XSyNy2qLE-KEaaF8D8q9OHVC3tPAPSzNe1CJUXJDfA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 May 2009 23:44:55.0418 (UTC) FILETIME=[A57C7DA0:01C9D812]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119475>

Some platforms do not understand the character encoding "latin1" which is
another name for "ISO8859-1".  So use "ISO8859-1" instead which all tested
platforms understand.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-mailinfo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index c68187e..92637ac 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -480,7 +480,7 @@ static const char *guess_charset(const struct strbuf *line, const char *target_c
 		if (is_utf8(line->buf))
 			return NULL;
 	}
-	return "latin1";
+	return "ISO8859-1";
 }
 
 static void convert_to_utf8(struct strbuf *line, const char *charset)
-- 
1.6.3.1.24.g152f4
