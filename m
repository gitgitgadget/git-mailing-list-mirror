From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 08/23] contrib/subtree: Replace invisible carriage return with a visible \r
Date: Sun, 10 Mar 2013 23:41:16 +0000
Message-ID: <1362958891-26941-9-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Matt Hoffman <matt.hoffman@quantumretail.com>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Avery Pennarun" <apenwarr@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:44:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpv4-0004DI-Fh
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424Ab3CJXoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:44:21 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:63544 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab3CJXoU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:44:20 -0400
Received: by mail-wg0-f43.google.com with SMTP id e12so4400729wge.10
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=b8pH19JfHeQgoS3klCotVRaguPyr3dCE6gAvJYAIALk=;
        b=EUzOBdIEs/st15v945ofOR1dV4WRL46+nmD4zygoCHQlSCblctxxN/N3j+mfAiStRk
         phA4ecuMMp0yzUeqVhECKKiN6KpQzHWyXfmRRXWcf2BaUeZqrmkJVQRRjPbGB5vUhovd
         0VXfKOgNtRoazzGvBsGRpf7a3P6DFaR/D1KgsFcGy3YYI3jaerwQ/iDO7upuhOnVBLK+
         ao/RgrC7lU85nWXeqPuv3Vn7s4pBqTiwJbhJFf8bJDcs3jKCSStQMy56fJBRQch6lVpU
         zzUwVleDNu85KdqNIE/boA6rYpxy4dSR0xNEv8fsSVcObj+KYVa86bPk7vYE1ex/nrdF
         9iWw==
X-Received: by 10.180.105.99 with SMTP id gl3mr9197879wib.22.1362959059153;
        Sun, 10 Mar 2013 16:44:19 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.44.13
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:44:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQkERBLWCCbGdrAzoBV3Z2Qfc+fEH9WlhqMUbB2Foc7xGenWG9L1regTQbd2SHRpKhK3JhnG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217828>

From: Matt Hoffman <matt.hoffman@quantumretail.com>

The ctrl-M (^M) character used for the carriage return (CR) is not visible
in all (most) text editors and is often silently converted to a new
line (NL) or CR/NL combo.

'say' is a wrapper for echo with accepts the option -e to interperet
escaped characters. \r becomes a CR, yet is not munged by text
editors.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>

Conflicts:
	git-subtree.sh
---
 contrib/subtree/git-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 98c508b..8056851 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -605,7 +605,7 @@ cmd_split()
 	eval "$grl" |
 	while read rev parents; do
 		revcount=$(($revcount + 1))
-		say -n "$revcount/$revmax ($createcount)
"
+		say -ne "$revcount/$revmax ($createcount)\r"
 		debug "Processing commit: $rev"
 		exists=$(cache_get $rev)
 		if [ -n "$exists" ]; then
-- 
1.8.2.rc1
