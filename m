From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] t/.gitattributes: only ignore whitespace errors in test files
Date: Fri, 13 Jun 2008 00:35:59 +0200
Message-ID: <1213310159-28049-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 00:36:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6vPS-0000mz-S5
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 00:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbYFLWfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 18:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbYFLWfr
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 18:35:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:29901 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbYFLWfq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 18:35:46 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2627908fgg.17
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 15:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:from;
        bh=7Dar9vRK9eMNKBEzkw8KRpO7NRV+pKNdCmOofDuGSTE=;
        b=aImBD72rrAwf1Ie5v2+I++nNbiBE1ZneYjJZ0+hdoQUlOnGvyRfpRvJJcf/6x/DiY5
         rbdebLGQfCc9QGShj4P0fz/UHUF4gIQfErFqOKoOZtO9jsReZX6YAr8qk+0CqYh/uYZ5
         Ape1UMQdT0mLo1FgAbnvUqy6aBP6z2h65lwuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=dWlzk8aJfN2gwkMaysrDrOHX/VASActqsLwoKytkzMm8mOaQnIXltJuKpsy2tXy+Y0
         IOlshBAfXWangxtVdnNJwdQZaTBC1J+dt81NSkVFdhyVjqlqFDQXBRnL5O0hn+GDnF82
         rp/AcpJOcJEehj60neN9rqWOWmjsgZ/8OObhs=
Received: by 10.86.82.16 with SMTP id f16mr3077887fgb.9.1213310143162;
        Thu, 12 Jun 2008 15:35:43 -0700 (PDT)
Received: from fly ( [91.33.248.95])
        by mx.google.com with ESMTPS id 4sm3804432fgg.9.2008.06.12.15.35.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Jun 2008 15:35:41 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K6vOi-0007Iq-2x; Fri, 13 Jun 2008 00:36:00 +0200
X-Mailer: git-send-email 1.5.6.rc2.23.gfef6b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84807>

Only ignore whitespace errors in t/tNNNN-*.sh and the t/tNNNN
subdirectories.  Other files (like test libraries) should still be
checked.

Also fix a whitespace error in t/test-lib.sh.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
 t/.gitattributes |    3 ++-
 t/test-lib.sh    |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/.gitattributes b/t/.gitattributes
index 562b12e..ab6edbf 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -1 +1,2 @@
-* -whitespace
+t[0-9][0-9][0-9][0-9]-*.sh -whitespace
+t[0-9][0-9][0-9][0-9]/* -whitespace
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2a08cdc..73079d8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -168,7 +168,7 @@ trap 'die' exit
 # environment variables to work around this.
 #
 # In particular, quoting isn't enough, as the path may contain the same quote
-# that we're using. 
+# that we're using.
 test_set_editor () {
 	FAKE_EDITOR="$1"
 	export FAKE_EDITOR
-- 
1.5.6.rc2.23.gfef6b.dirty
