From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [gitk PATCH] gitk: Disable log.decorate config
Date: Fri, 19 Mar 2010 23:44:23 +0100
Message-ID: <1269038663-11025-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 23:43:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nskuv-0002H5-OJ
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 23:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab0CSWnk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 18:43:40 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:47294 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab0CSWnk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 18:43:40 -0400
Received: by bwz1 with SMTP id 1so460184bwz.21
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 15:43:38 -0700 (PDT)
Received: by 10.204.82.36 with SMTP id z36mr2601302bkk.88.1269038616571;
        Fri, 19 Mar 2010 15:43:36 -0700 (PDT)
Received: from localhost.localdomain (91.194.19.95.dynamic.jazztel.es [95.19.194.91])
        by mx.google.com with ESMTPS id a11sm6470766bkc.9.2010.03.19.15.43.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 15:43:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.384.g015e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142656>

Since eb73445 (Add `log.decorate' configuration variable., 2010-02-17)
the log output changes if log.decorate is set. Gitk is unable to
understand the new output (it returns the error: "Can't parse git log
output: {commit $sha1 $sha2...}), so disable it with --no-decorate.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 1f36a3e..aca44b7 100755
--- a/gitk
+++ b/gitk
@@ -362,7 +362,7 @@ proc start_rev_list {view} {
=20
     if {[catch {
 	set fd [open [concat | git log --no-color -z --pretty=3Draw --parents=
 \
-			 --boundary $args "--" $files] r]
+			 --boundary --no-decorate $args "--" $files] r]
     } err]} {
 	error_popup "[mc "Error executing git log:"] $err"
 	return 0
--=20
1.7.0.2.384.g015e
