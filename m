From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 1/4] contrib/diffall: change comment to reflect actual reason for 'cdup'
Date: Tue, 13 Mar 2012 13:45:30 -0400
Message-ID: <1331660734-10538-1-git-send-email-tim.henigan@gmail.com>
Cc: tim.henigan@gmail.com
To: git@vger.kernel.org, gitster@poxbox.com
X-From: git-owner@vger.kernel.org Tue Mar 13 18:46:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7VnL-0007vx-AQ
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 18:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759077Ab2CMRpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 13:45:54 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44051 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758945Ab2CMRpy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 13:45:54 -0400
Received: by eekc41 with SMTP id c41so464836eek.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=LgMxWsMrbuXYJiPFlArkk5IsPQUO3siTUQw8QQjIS3E=;
        b=iB4pyW1OpxHxZwvfDdivvOen0VMudizax4AOA+bboKblqZ/fSuIj7Lt/azuYxiD1YE
         +U0fFkMwPShtt6O2E1oaHwzeDkdK6Atr7Kd0sZ9CIWV1dAZ+m3od5Yz5KD8r1bHxLBg3
         J2WiOpOAzhmG80w7sHpGTboeUkrBWH24DT4S/K0zxiKCyztXx/stfYH2RC7Y3QXEGn5+
         Os4EwkzsShe8DtePzrcfsxlEeXFqLV6EG+ngkw8TO50Xc84nXn/jqE7jp1weTHXu9qsu
         tU1H2PboLO4XQRrcPipRLnCTHucu1VrFqSbLWCSwjj+ywjulsfZbxCv/B5IBa1q/KKWW
         MfVQ==
Received: by 10.229.78.86 with SMTP id j22mr4141779qck.95.1331660752159;
        Tue, 13 Mar 2012 10:45:52 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id h11sm4417727qae.3.2012.03.13.10.45.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 10:45:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193041>

The comment from an earlier commit did not reflect the actual reason this
operation is needed.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 contrib/diffall/git-diffall |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/diffall/git-diffall b/contrib/diffall/git-diffall
index 9bbd27f..d706a6d 100755
--- a/contrib/diffall/git-diffall
+++ b/contrib/diffall/git-diffall
@@ -36,7 +36,9 @@ fi
 
 start_dir=$(pwd)
 
-# needed to access tar utility
+# All the file paths returned by the diff command are relative to the root
+# of the working copy. So if the script is called from a subdirectory, it
+# must switch to the root of working copy before trying to use those paths.
 cdup=$(git rev-parse --show-cdup) &&
 cd "$cdup" || {
 	echo >&2 "Cannot chdir to $cdup, the toplevel of the working tree"
-- 
1.7.10.rc0
