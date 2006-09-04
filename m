From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/4] gitweb: Add GIT favicon, assuming image/png type
Date: Mon, 4 Sep 2006 20:32:13 +0200
Message-ID: <200609042032.13742.jnareb@gmail.com>
References: <200609041810.09838.jnareb@gmail.com> <200609041813.49103.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 04 20:32:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKJF2-0008AX-7O
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 20:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWIDScJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 14:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWIDScJ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 14:32:09 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:15386 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964965AbWIDScH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 14:32:07 -0400
Received: by nz-out-0102.google.com with SMTP id n1so877947nzf
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 11:32:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=j9Fo0ikbYVshStgWBceJLBzEyko8O9Ja+fr0Pj7oyJ78JT4E9pANzcit+R7AaALzLX/KgG2bl8/MnGhohjpNqAXr5pN4MuY/Tk+N/d7lX07npbS19JGH4ZAUFWfRNvFbif/GqcXU1JaenkNDMA1iKB9hUzQFKucRE4mJlyFZdLY=
Received: by 10.65.119.14 with SMTP id w14mr5911731qbm;
        Mon, 04 Sep 2006 11:32:06 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id q13sm3978849qbq.2006.09.04.11.32.05;
        Mon, 04 Sep 2006 11:32:05 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609041813.49103.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26428>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Corrected version, with the actual binary diff
(that was the version sent earlier, by the way).

 Makefile               |    2 ++
 gitweb/git-favicon.png |  Bin
 gitweb/gitweb.perl     |    5 +++++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 199fbe87384cd3f4686916277dd124cefc751e8a..f3b762de92e579300eba3f53ee26b2a80b4e76c7 100644
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
index 7961945630e44e94649f3ccd9f96a962c94af0d9..bebaa0fb1e93995da8ea19af8b70a453b9572488 100755
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
@@ -1192,6 +1194,9 @@ EOF
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
