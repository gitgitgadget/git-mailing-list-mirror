From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH na/strtoimax] Compatibility: declare strtoimax() under NO_STRTOUMAX
Date: Sat, 05 Nov 2011 16:37:34 +0100
Message-ID: <4EB5583E.2030306@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nick Alcock <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Sat Nov 05 16:37:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMiJT-0006oL-VL
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 16:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab1KEPhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 11:37:38 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:60999 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751797Ab1KEPhh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 11:37:37 -0400
X-Greylist: delayed 24816 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Nov 2011 11:37:37 EDT
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1804B13004A;
	Sat,  5 Nov 2011 16:37:33 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184852>

Commit f696543d (Add strtoimax() compatibility function) introduced an
implementation of the function, but forgot to add a declaration.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 git-compat-util.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index feb6f8e..4efef46 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -354,6 +354,8 @@ extern size_t gitstrlcpy(char *, const char *, size_t);
 #ifdef NO_STRTOUMAX
 #define strtoumax gitstrtoumax
 extern uintmax_t gitstrtoumax(const char *, char **, int);
+#define strtoimax gitstrtoimax
+extern intmax_t gitstrtoimax(const char *, char **, int);
 #endif
 
 #ifdef NO_STRTOK_R
-- 
1.7.7.1.1608.gd424d
