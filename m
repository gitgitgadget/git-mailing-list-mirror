From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 2/3] git-mergetool/difftool: make (g)vimdiff
 workable under Windows
Date: Sun, 5 Apr 2009 14:42:57 +0200
Message-ID: <200904051442.58155.markus.heidelberg@web.de>
References: <200904051440.33154.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>, David Aguilar <davvid@gmail.com>, Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Apr 05 14:44:32 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.25])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqRiB-0004bc-V2
	for gcvm-msysgit@m.gmane.org; Sun, 05 Apr 2009 14:44:32 +0200
Received: by yx-out-2122.google.com with SMTP id 22so612179yxm.63
        for <gcvm-msysgit@m.gmane.org>; Sun, 05 Apr 2009 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:jabber-id:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:x-sender
         :x-provags-id:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=t6h1hpcQ2e36+ww0ptSteuChriLtc8wWKbVWARJSLXg=;
        b=ccwmEQWkfRWxvgN4OCWF12xKs24/CPBRYdkNhupN7EYKs68Lmcgv2CGcrXiEC9N0bB
         0Zs3M3A9eTztpNSTXjnUbAFzLgZYjO+jDV9vE6PKfM1Zvv4IZ6hrLu6ld70onBxMe/Lt
         p2kNXJnFHNl2LRkeoJx9IF1JSQTi7UG2Nnr4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :jabber-id:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:x-provags-id:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=mZqiW7rAjD/1WGd0JTnCA9Ya6O8zlUYLqjlaGwjrTJekCIQDpUvgQkheRFPBP+w82O
         Ivixf+XDcchL4SbmjxROPio3/unlk+WG9Ri12k9A6Q0bbye1kOMpxV5VizhGF3bvJTC4
         hLGQorNB+E9ICpAVnYU8ArPCDnjeWv10Hr2LE=
Received: by 10.100.229.12 with SMTP id b12mr271927anh.0.1238935375557;
        Sun, 05 Apr 2009 05:42:55 -0700 (PDT)
Received: by 10.176.167.11 with SMTP id p11gr4650yqe.0;
	Sun, 05 Apr 2009 05:42:55 -0700 (PDT)
X-Sender: markus.heidelberg@web.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.91.9 with SMTP id o9mr1589620agb.18.1238935374850; Sun, 05 Apr 2009 05:42:54 -0700 (PDT)
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234]) by gmr-mx.google.com with ESMTP id 15si509874gxk.0.2009.04.05.05.42.54; Sun, 05 Apr 2009 05:42:54 -0700 (PDT)
Received-SPF: pass (google.com: domain of markus.heidelberg@web.de designates 217.72.192.234 as permitted sender) client-ip=217.72.192.234;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of markus.heidelberg@web.de designates 217.72.192.234 as permitted sender) smtp.mail=markus.heidelberg@web.de
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172]) by fmmailgate03.web.de (Postfix) with ESMTP id 37B2FF9FF1DC; Sun,  5 Apr 2009 14:42:54 +0200 (CEST)
Received: from [89.59.118.104] (helo=.) by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256) (WEB.DE 4.110 #277) id 1LqRga-0007tD-00; Sun, 05 Apr 2009 14:42:52 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200904051440.33154.markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX183DPRuYGMNOOCYYRT+U4iDC8+ECaFxEIizuhFc qpJYthmHRM6imY9HsZZ+KQ93U57TBaTVviLyDpts9BlovlT4Gd 33AG8OCmfdsLCpnqQylA==
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115660>


Under Windows vimdiff and gvimdiff are not available as symbolic links,
but as batch files vimdiff.bat and gvimdiff.bat. These files weren't
found by 'type vimdiff' which led to the following error:

    The merge tool vimdiff is not available as 'vimdiff'

Even if they were found, it wouldn't work to invoke these batch files
from git-mergetool.

To solve this, use vim and gvim (vim.exe and gvim.exe) and pass the -d
command line switch over to them.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 contrib/difftool/git-difftool-helper |   10 ++++++++--
 git-mergetool.sh                     |   10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
index 9c0a134..e481913 100755
--- a/contrib/difftool/git-difftool-helper
+++ b/contrib/difftool/git-difftool-helper
@@ -86,11 +86,11 @@ launch_merge_tool () {
 		;;
 
 	vimdiff)
-		"$merge_tool_path" -c "wincmd l" "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -d -c "wincmd l" "$LOCAL" "$REMOTE"
 		;;
 
 	gvimdiff)
-		"$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -d -c "wincmd l" -f "$LOCAL" "$REMOTE"
 		;;
 
 	xxdiff)
@@ -160,6 +160,12 @@ init_merge_tool_path() {
 	merge_tool_path=$(git config mergetool."$1".path)
 	if test -z "$merge_tool_path"; then
 		case "$1" in
+		vimdiff)
+			merge_tool_path=vim
+			;;
+		gvimdiff)
+			merge_tool_path=gvim
+			;;
 		emerge)
 			merge_tool_path=emacs
 			;;
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 87fa88a..6e611e9 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -214,12 +214,12 @@ merge_file () {
 	    ;;
 	vimdiff)
 	    touch "$BACKUP"
-	    "$merge_tool_path" -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
+	    "$merge_tool_path" -d -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
 	    check_unchanged
 	    ;;
 	gvimdiff)
 	    touch "$BACKUP"
-	    "$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
+	    "$merge_tool_path" -d -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
 	    check_unchanged
 	    ;;
 	xxdiff)
@@ -359,6 +359,12 @@ init_merge_tool_path() {
 	merge_tool_path=`git config mergetool.$1.path`
 	if test -z "$merge_tool_path" ; then
 		case "$1" in
+			vimdiff)
+				merge_tool_path=vim
+				;;
+			gvimdiff)
+				merge_tool_path=gvim
+				;;
 			emerge)
 				merge_tool_path=emacs
 				;;
-- 
1.6.2.2.460.g49e5c
