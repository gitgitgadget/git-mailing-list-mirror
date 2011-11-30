From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] compat/getpass.c: Fix a sparse "symbol not declared" warning
Date: Wed, 30 Nov 2011 20:54:27 +0000
Message-ID: <4ED69803.6070508@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 01 19:17:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWBCn-0008Bb-Hf
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 19:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099Ab1LASRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 13:17:53 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:53540 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756057Ab1LASRw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2011 13:17:52 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1RWBCg-0006lr-eM; Thu, 01 Dec 2011 18:17:51 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186180>


In particular, sparse complains as follows:

        SP compat/getpass.c
    compat/getpass.c:5:6: warning: symbol 'getpass_echo' was not \
        declared. Should it be static?

In order to suppress the warning, we include the getpass.h header
file which contains an appropriate extern declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jeff,

When you next re-roll your most recent credentials/getpass series, could
you please squash this patch in. (This patch was against pu @ 1cc922af,
but I guess you need to apply a similar patch to commit 8eca119c "stub out
getpass_echo function", 27-11-2011 instead)

Thanks!

ATB,
Ramsay Jones

 compat/getpass.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/compat/getpass.c b/compat/getpass.c
index b5bd1dd..a145d27 100644
--- a/compat/getpass.c
+++ b/compat/getpass.c
@@ -1,4 +1,5 @@
 #include "../git-compat-util.h"
+#include "getpass.h"
 
 #ifdef HAVE_DEV_TTY
 
-- 
1.7.7
