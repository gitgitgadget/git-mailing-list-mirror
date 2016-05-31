From: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
Subject: [PATCH] Documentation: bold literals in man
Date: Tue, 31 May 2016 18:20:33 +0200
Message-ID: <20160531162033.7137-1-erwan.mathoniere@grenoble-inp.org>
References: <xmqqbn3sydvk.fsf@gitster.mtv.corp.google.com>
Cc: jordan.de-gea@grenoble-inp.org, gitster@pobox.com, peff@peff.net,
	jrnieder@gmail.com, stefan@sevenbyte.org, rybak.a.v@gmail.com,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Samuel GROOT <samuel.groot@grenoble-inp.org>,
	Tom RUSSELLO <tom.russello@grenoble-inp.org>,
	Matthieu MOY <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 18:21:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7mPe-00052d-ER
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 18:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbcEaQU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 12:20:58 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:51256 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbcEaQU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 12:20:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 5D1472415;
	Tue, 31 May 2016 18:20:54 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 429f42OMPbpu; Tue, 31 May 2016 18:20:54 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4BBF1222F;
	Tue, 31 May 2016 18:20:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 457D92077;
	Tue, 31 May 2016 18:20:54 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dOYbjjAPpH0A; Tue, 31 May 2016 18:20:54 +0200 (CEST)
Received: from machin-portable.grenet.fr (eduroam-033003.grenet.fr [130.190.33.3])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 2D5E82064;
	Tue, 31 May 2016 18:20:54 +0200 (CEST)
X-Mailer: git-send-email 2.8.0.GIT
In-Reply-To: <xmqqbn3sydvk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295994>

Backticks are emphasized through monospaced styling in the HTML
version of Git documentation. But were left unstyled in the man version.

To make the man version reading more comfortable, `MAN_BOLD_LITERAL`
was added by:
5121a6d (Documentation: option to render literal text as bold for
manpages, 2009-03-27)
It allowed the user to build the documentation manpages with literals
in bold style.

For precaution it was not set by default.
Since 79c461d (docs: default to more modern toolset, 2010-11-19),
it is assumed ASCIIDOC 8 and at least docbook-xsl 1.73 are used,
so no compatibility issue may occur.

Remove `MAN_BOLD_LITERAL`. Set by default literals as bold.
Implement `NO_MAN_BOLD_LITERAL`, a new Makefile option, disabling
this feature when defined.

Signed-off-by: Erwan MATHONIERE <erwan.mathoniere@grenoble-inp.org>
Signed-off-by: Samuel GROOT <samuel.groot@grenoble-inp.org>
Signed-off-by: Tom RUSSELLO <tom.russello@grenoble-inp.org>
Signed-off-by: Matthieu MOY <matthieu.moy@grenoble-inp.fr>
---
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f6e288b..35c1385 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -146,7 +146,7 @@ else
 	ASCIIDOC_EXTRA += -a git-asciidoc-no-roff
 	endif
 endif
-ifdef MAN_BOLD_LITERAL
+ifndef NO_MAN_BOLD_LITERAL
 XMLTO_EXTRA += -m manpage-bold-literal.xsl
 endif
 ifdef DOCBOOK_SUPPRESS_SP
-- 
2.8.2.662.gc18eb58
