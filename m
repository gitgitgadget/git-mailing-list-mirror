From: imyousuf@gmail.com
Subject: [PATCH 1/5] Add Long Usage instead of simple usage
Date: Sat,  3 May 2008 19:53:29 +0600
Message-ID: <1209822813-12237-1-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 15:54:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsICV-0005MW-9f
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 15:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbYECNyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 09:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbYECNyF
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 09:54:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:60977 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbYECNyD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 09:54:03 -0400
Received: by ug-out-1314.google.com with SMTP id h3so301813ugf.16
        for <git@vger.kernel.org>; Sat, 03 May 2008 06:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=OiuNELfDrq/C6DIcqrzErmupT3kDhW2qo5g4udQt4GM=;
        b=i3iYo9ydJ2QIrBsG8Jr+XD2codHdBJ35R10h0wxAM11jX17WtZud4LhqI9rN1uYW1o126ch+ZML5SyVDR0WF00zxMenYXQR9A0d83kHY7heZrb5GBByVpAqF46YItT+7N3GcfvrvK7WxLlN+Gmj6WLfQ+8RGqlI+C0NI0dFPhqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=G7b97t15jRIkF5PnegKX4gCWx45JHrEErz99g3YXbISEFKZEz0JLb6E7dcNz4YM9fqShlc/JmuTjyMnhM8NbpqkX2wQGT0bqgL5kZ+5TWZG4vojCRiYsVJE1VRNVHYJfyB61YtKK0x+7oaPg/xF3lzzbprm6A+vcwfeFg52h1oU=
Received: by 10.67.20.3 with SMTP id x3mr918028ugi.62.1209822840770;
        Sat, 03 May 2008 06:54:00 -0700 (PDT)
Received: from localhost ( [122.248.32.83])
        by mx.google.com with ESMTPS id 30sm2487031ugf.31.2008.05.03.06.53.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 May 2008 06:53:59 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81080>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

With the already available commands the synopsis is quite hard to
read; thus converted it to Long usage instead. In process also
updated the file comment.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 git-submodule.sh |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ce0f00c..a5ee2e5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1,12 +1,17 @@
 #!/bin/sh
 #
-# git-submodules.sh: add, init, update or list git submodules
+# git-submodules.sh: add, init, update, summary or status git submodules
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE="[--quiet] [--cached] \
-[add <repo> [-b branch]|status|init|update|summary [-n|--summary-limit <n>] [<commit>]] \
-[--] [<path>...]"
+USAGE="<command> <options>
+Use $0 -h for more details"
+# Did not use '\' at the end of the lines to ensure that each synopsis
+# are in a separate line
+LONG_USAGE="$0 add [-q|--quiet] [-b|--branch branch] <repository> [<path>]
+$0 [status] [-q|--quiet] [-c|--cached] [--] [<path>...]
+$0 init|update [-q|--quiet] [--] [<path>...]
+$0 summary [--cached] [-n|--summary-limit <n>] [<commit>]"
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
-- 
1.5.4.2
