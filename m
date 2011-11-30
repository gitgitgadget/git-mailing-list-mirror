From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Makefile: Add missing "sparse object" to gettext target-specific
 rule
Date: Wed, 30 Nov 2011 20:43:52 +0000
Message-ID: <4ED69588.9020207@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: avarab@gmail.com
X-From: git-owner@vger.kernel.org Thu Dec 01 19:17:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWBCn-0008Bb-0i
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 19:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095Ab1LASRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 13:17:50 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:47836 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756035Ab1LASRs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2011 13:17:48 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1RWBCc-0002lf-XL; Thu, 01 Dec 2011 18:17:46 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186179>


In particular, we add gettext.sp to the target-specific rule which
adds the GIT_LOCALE_PATH setting to EXTRA_CPPFLAGS, otherwise sparse
complains thus:

        SP gettext.c
    gettext.c:125:25: error: undefined identifier 'GIT_LOCALE_PATH'

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Avar,

If you are going to re-roll your latest i18n patch (commit 6c856c48,
"i18n: add infrastructure for translating Git with gettext", 18-11-2011),
could you please squash this patch into it.

Thanks!

ATB,
Ramsay Jones

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ac8c76d..f926b5f 100644
--- a/Makefile
+++ b/Makefile
@@ -2129,7 +2129,7 @@ config.sp config.s config.o: EXTRA_CPPFLAGS = \
 attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
 	-DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
 
-gettext.s gettext.o: EXTRA_CPPFLAGS = \
+gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
 	-DGIT_LOCALE_PATH='"$(localedir_SQ)"'
 
 http.sp http.s http.o: EXTRA_CPPFLAGS = \
-- 
1.7.7
