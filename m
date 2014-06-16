From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] doc git: multivar configuration parameters append to existing values
Date: Mon, 16 Jun 2014 13:49:12 +0100
Message-ID: <1402922952-172-1-git-send-email-philipoakley@iee.org>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Robert Clausecker <fuz@fuz.su>,
	Alex Riesen <raa.lkml@gmail.com>,
	Tanay Abhra <tanayabh@gmail.com>
To: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 14:49:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwWLW-0001BV-Ju
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 14:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbaFPMtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 08:49:06 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:24071 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751962AbaFPMtF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2014 08:49:05 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkwMABbnnlMCYJ7h/2dsb2JhbABagw0BUREDrhmOBIdCDIEFF3WEYCMYgQIkARKIRgnPPo4SZDWEFQScBpIVg0E8LwEBgQA
X-IPAS-Result: AkwMABbnnlMCYJ7h/2dsb2JhbABagw0BUREDrhmOBIdCDIEFF3WEYCMYgQIkARKIRgnPPo4SZDWEFQScBpIVg0E8LwEBgQA
X-IronPort-AV: E=Sophos;i="5.01,486,1400022000"; 
   d="scan'208";a="462723345"
Received: from host-2-96-158-225.as13285.net (HELO localhost) ([2.96.158.225])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 16 Jun 2014 13:49:02 +0100
X-Mailer: git-send-email 1.9.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251714>

When the '-c' option is used to pass alternate URLs or similar
multivar parameters to git commands the effect is not what the user
expected [1,2].

Clarify that multivar configuration parameters do not supercede
previous values. Suggest an alternative style parameter.

[1] http://article.gmane.org/gmane.comp.version-control.git/250427
[2] http://article.gmane.org/gmane.comp.version-control.git/251529

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/git.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3bd68b0..bedbd76 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -440,7 +440,10 @@ example the following invocations are equivalent:
 
 -c <name>=<value>::
 	Pass a configuration parameter to the command. The value
-	given will override values from configuration files.
+	given will override single valued variables from configuration
+	files, and append to multivar variables. Previous multivar values
+	remain in effect. Use "insteadOf" style config variables when an
+	over-ride is needed.
 	The <name> is expected in the same format as listed by
 	'git config' (subkeys separated by dots).
 
-- 
1.9.4.msysgit.0
