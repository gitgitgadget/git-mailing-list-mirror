From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] t/gitweb-lib.sh: Use GIT_BUILD_DIR
Date: Sun, 12 Sep 2010 11:41:04 +0200
Message-ID: <1284284466-14506-2-git-send-email-jnareb@gmail.com>
References: <1284284466-14506-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 12 11:41:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ouj42-00073O-7K
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 11:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435Ab0ILJla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 05:41:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41112 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab0ILJl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 05:41:29 -0400
Received: by bwz11 with SMTP id 11so3684705bwz.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 02:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Z0dRYISoBgEcNd/zWObsXc3r11uJ7U6LJllOeDZzpFs=;
        b=ki5dbABSLy9n48YZ5o1/m3xl/ah+0SrhKxwnzbWlDcKIPlu4LvVkGWZZbo8ej9WNao
         nlpop0GmRs6VFF06cvHU+Ks9HRuRVdCrtLgJWl8BV0w9QcFI0LCr+G1jGM2IbkMvNzB/
         /INlKgxUHl11O/ZiAp3zHWi+VHCk5bybTal3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ya0F3NFa/zDmZxJbamrLiaHuXirYdQqVozpK99JFRZPG5q3j59516dN7FMPKQpLJYI
         w+v+iUJ7T4RtmTJnxcfzS/kJPiFKlTDa/1t0AxsQp/Cn15wpyzSaISecgr2bBYmN9VZP
         3GIjp0LxjiQ8lt+ilfzEN8SGVKhB29yyUtjbo=
Received: by 10.204.50.206 with SMTP id a14mr2184449bkg.65.1284284487766;
        Sun, 12 Sep 2010 02:41:27 -0700 (PDT)
Received: from localhost.localdomain (abvl188.neoplus.adsl.tpnet.pl [83.8.209.188])
        by mx.google.com with ESMTPS id 24sm3570708bkr.19.2010.09.12.02.41.26
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Sep 2010 02:41:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1284284466-14506-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156024>

Use "$GIT_BUILD_DIR" instead of "$TEST_DIRECTORY/.." (both defined in
t/test-lib.sh) in t/gitweb-lib.sh.  It better describes the intent.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I think it makes gitweb_init() and gitweb_install() more clear.

 t/gitweb-lib.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
 mode change 100644 => 100755 t/gitweb-lib.sh

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
old mode 100644
new mode 100755
index 81ef2a0..8fad236
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -19,9 +19,9 @@ our \$site_name = '[localhost]';
 our \$site_header = '';
 our \$site_footer = '';
 our \$home_text = 'indextext.html';
-our @stylesheets = ('file:///$TEST_DIRECTORY/../gitweb/static/gitweb.css');
-our \$logo = 'file:///$TEST_DIRECTORY/../gitweb/static/git-logo.png';
-our \$favicon = 'file:///$TEST_DIRECTORY/../gitweb/static/git-favicon.png';
+our @stylesheets = ('file:///$GIT_BUILD_DIR/gitweb/static/gitweb.css');
+our \$logo = 'file:///$GIT_BUILD_DIR/gitweb/static/git-logo.png';
+our \$favicon = 'file:///$GIT_BUILD_DIR/gitweb/static/git-favicon.png';
 our \$projects_list = '';
 our \$export_ok = '';
 our \$strict_export = '';
@@ -38,7 +38,7 @@ gitweb_run () {
 	GATEWAY_INTERFACE='CGI/1.1'
 	HTTP_ACCEPT='*/*'
 	REQUEST_METHOD='GET'
-	SCRIPT_NAME="$TEST_DIRECTORY/../gitweb/gitweb.perl"
+	SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.perl"
 	QUERY_STRING=""$1""
 	PATH_INFO=""$2""
 	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD \
-- 
1.7.2.1
