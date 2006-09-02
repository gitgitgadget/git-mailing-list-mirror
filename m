From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add GIT favicon, assuming image/png type
Date: Sat, 2 Sep 2006 18:57:35 +0200
Message-ID: <200609021857.35590.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 02 18:57:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJYoP-0005zc-8N
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 18:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWIBQ52 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 12:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWIBQ52
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 12:57:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:41567 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751207AbWIBQ51 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 12:57:27 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1259415uge
        for <git@vger.kernel.org>; Sat, 02 Sep 2006 09:57:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Vv+vtCwkGOfsLidPAtNbB1KY2ySDLre3KF8f0axdWbjUIWxOVpbXQRmzVh5KbYEW3VuBz/bwiqZEnHcB5BAcUduZhsWyed+fADeTFMguHIr470WrCEU3+ij2tFqMZqlUMs/wtf9HRyUwwXFqi46Xf4CfMBaMv2CimhwohVzAVIc=
Received: by 10.66.244.11 with SMTP id r11mr1827265ugh;
        Sat, 02 Sep 2006 09:57:26 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id k30sm5103809ugc.2006.09.02.09.57.24;
        Sat, 02 Sep 2006 09:57:25 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26344>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
My first [PATCH] with binary patch.

 Makefile               |    2 ++
 gitweb/git-favicon.png |  Bin
 gitweb/gitweb.perl     |    5 +++++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 164dbcf734c964b7de1742f2d63db710a323e284..6a2cce5fecd0a966075222bd59c44cd206c88886 100644
--- a/Makefile
+++ b/Makefile
@@ -137,6 +137,7 @@ GITWEB_LIST =
 GITWEB_HOMETEXT = indextext.html
 GITWEB_CSS = gitweb.css
 GITWEB_LOGO = git-logo.png
+GITWEB_FAVICON = git-favicon.png
 
 export prefix bindir gitexecdir template_dir GIT_PYTHON_DIR
 
@@ -674,6 +675,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_HOMETEXT++|$(GITWEB_HOMETEXT)|g' \
 	    -e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
 	    -e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
+	    -e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
 	    $< >$@+
 	chmod +x $@+
 	mv $@+ $@
diff --git a/gitweb/git-favicon.png b/gitweb/git-favicon.png
new file mode 100644
index 0000000000000000000000000000000000000000..de637c0608090162a6ce6b51d5f9bfe512cf8bcf
GIT binary patch
literal 164
zc-rd>@N?(olHy`uVBq!ia0vp^0wB!93?!50ihlx9JOMr-t_OgO28RD&a4c8tKak5=
z;1OBOz`!jG!i)^F=12eq?L1u^Ln;_q4{j86a1dcV@b%g0mmUiOK9(+Io+#BK-XURJ
z*52lzAh4o%_q+oa1XgVS7Wa3@eurhH>!fs<8s*Qab3eLq`JX({BnD4cKbLh*2~7aN
C3N}^%

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 06bdb0ed74ae1d810645359dcd7713acb41e1b37..74ea6b369394dd47acfca3d023b2a8fdaaa355db 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -48,6 +48,8 @@ # URI of default stylesheet
 our $stylesheet = "++GITWEB_CSS++";
 # URI of GIT logo
 our $logo = "++GITWEB_LOGO++";
+# URI of GIT favicon, assumed to be image/png type
+our $favicon = "++GITWEB_FAVICON++";
 
 # source of projects list
 our $projects_list = "++GITWEB_LIST++";
@@ -1225,6 +1227,9 @@ EOF
 		       'href="%s" type="application/rss+xml"/>'."\n",
 		       esc_param($project), href(action=>"rss"));
 	}
+	if (defined $favicon) {
+		print qq(<link rel="shortcut icon" href="$favicon" type="image/png"/>\n);
+	}
 
 	print "</head>\n" .
 	      "<body>\n" .
-- 
1.4.1.1


-- 
VGER BF report: U 0.5
