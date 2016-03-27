From: Rogier Goossens <goossens.rogier@gmail.com>
Subject: [PATCH v2a 3/3] gitk: Include commit title in branch dialog
Date: Sun, 27 Mar 2016 09:21:01 +0200
Message-ID: <9310641.nkQBije1VN@wiske>
References: <51900395.pKIx87RN0F@wiske> <10662590.KWXHt2RUKZ@wiske>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Mar 27 09:21:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ak50f-0002ta-FB
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 09:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbcC0HVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 03:21:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36857 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbcC0HVM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 03:21:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id l68so13618936wml.3
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 00:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNvZktBEiUpZtYVRqY8CJfybltGt3AgrKuBSblOzb9s=;
        b=RwD4naAXkod7Gs2DuAnJIruWxn2/FmsM6ry3F/sDP6rU5Rc+vabtXc5HgTy+uaWZsp
         HIK2R1O7X8MPqsPt0I5Zh2oHaPM/BvRD6tw6cGYfbv1n/kasagFSw/uMIQerTs12y0cS
         ORP+wsZHTCI/+uF8XaWzend8/UkpGtMzc5IR74Z692ycqhBClyNQFE7qNZh/WHMh5ORg
         jjHE1zMRzZVrO9HpPmJN/vfLn30Fo9zwabwHKKiUeLpWzP57Ej1liLkb4jJnOPEzqAeL
         klHboosoj6lMAJP7iP+0vczEwVjPT9VLtg72zuG+DYSJw4Nd7dZHG3IG8zv8KJfpiql2
         sNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RNvZktBEiUpZtYVRqY8CJfybltGt3AgrKuBSblOzb9s=;
        b=jXjw82W2vZEhkiW1RotCYRUEAa/7HoHuigm0itIMniaKcblhk8kyRjbThwLIghDvXu
         YaDYvgatIZ+7uWjIkUWC0uo4aM/yrjV1+f7CKVNNEAai6KEIPRuptt/2iMaIt6YiJgw/
         nuP+GN3nd9MHg8+QKTw/uKSlSztf0ElUgXyFrXB4b4w1HvMqrcPqqc8L/+5t2SztsrL2
         YEmXMiyz086E6PYujhHhEPUOo4UFlTAahz0rNeTiLO67Wt8qVJzsfa56/SzTyUFmAlWf
         eg1bXtK3eAsPTClrGxnrg6KWH8oxAO5JFCEi80Ninaf545fOVgu3pvsYhNHcHHLjdWPc
         t2rA==
X-Gm-Message-State: AD7BkJIJzbTiwG6XVnPfzRbJ6QwEAa2SiZRVfYbKjkBUp52LONRncmbRe4jY0C4SfkF3ZA==
X-Received: by 10.28.133.14 with SMTP id h14mr5084095wmd.100.1459063270997;
        Sun, 27 Mar 2016 00:21:10 -0700 (PDT)
Received: from wiske.localnet ([86.81.114.242])
        by smtp.gmail.com with ESMTPSA id u202sm4559687wmd.24.2016.03.27.00.21.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Mar 2016 00:21:10 -0700 (PDT)
User-Agent: KMail/4.14.1 (Linux/3.16.0-4-amd64; KDE/4.14.2; x86_64; ; )
In-Reply-To: <10662590.KWXHt2RUKZ@wiske>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289997>

Hi,

I made another branch dialog related change, included in this message.
It applies on top of my other two patches.

Rogier.

------- 8< ------------------- 8< --------------

Only the SHA1 was included. It's convenient to have the title
mentioned as well.

Signed-off-by: Rogier Goossens <goossens.rogier@gmail.com>
---
 gitk | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index dc75c97..413711e 100755
--- a/gitk
+++ b/gitk
@@ -9484,7 +9484,7 @@ proc mvbranch {} {
 }
 
 proc branchdia {top valvar uivar} {
-    global NS
+    global NS commitinfo
     upvar $valvar val $uivar ui
 
     catch {destroy $top}
@@ -9497,6 +9497,11 @@ proc branchdia {top valvar uivar} {
     $top.sha1 insert 0 $val(id)
     $top.sha1 conf -state readonly
     grid $top.id $top.sha1 -sticky w
+    ${NS}::entry $top.head -width 60
+    $top.head insert 0 [lindex $commitinfo($val(id)) 0]
+    $top.head conf -state readonly
+    grid x $top.head -sticky ew
+    grid columnconfigure $top 1 -weight 1
     ${NS}::label $top.nlab -text [mc "Name:"]
     ${NS}::entry $top.name -width 40
     $top.name insert 0 $val(name)
-- 
2.1.4
