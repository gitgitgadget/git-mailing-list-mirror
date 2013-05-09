From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/3] mergetools/kdiff3: do not use --auto when diffing
Date: Thu,  9 May 2013 02:13:28 -0700
Message-ID: <1368090810-40596-1-git-send-email-davvid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Charles Bailey <charles@hashpling.org>,
	Theodore Ts'o <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 11:13:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaMv2-0003oY-Ln
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 11:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748Ab3EIJNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 05:13:39 -0400
Received: from mail-da0-f54.google.com ([209.85.210.54]:52592 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598Ab3EIJNi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 05:13:38 -0400
Received: by mail-da0-f54.google.com with SMTP id u36so1486355dak.41
        for <git@vger.kernel.org>; Thu, 09 May 2013 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=gefufJrbFVTr1oQn3qxH6Y7HTlJBrZJ0/BQyL4EtUcA=;
        b=Sb79jJ0C4MrU6Qv5CPNOF4Z1xPELtbEhh2S+KjPlvng+RnQURSjA4lqtnJVfSvWuil
         oUde05/ZRaoIKyipqH/2G73umUXmxnJyjsBc54JjU7YxQL9vNvRWJZsUdpqSUYabILgG
         9WT3OvN7BYMdgMd3xb7UZowhpoEHaIUeS6z6/I0LoBoqOQe01bcrOvCaHu6Ema7cRfSa
         7c2IVkOIEQj85EURmJnpCLNiR9DKLdZSbfzpUYZYtSQtIgDKEYmhnajoz77zTQKclxHY
         EZFssESXmQnNSWNwumTEUI9orfkzi5Yok3/Hie84NFoW6pFnXMYox5zsi5Imd38CzAYn
         QY7g==
X-Received: by 10.66.251.133 with SMTP id zk5mr12118715pac.26.1368090818377;
        Thu, 09 May 2013 02:13:38 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id wi6sm2323180pbc.22.2013.05.09.02.13.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 02:13:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.38.gd586103
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223720>

The `kdiff3 --auto` help message is, "No GUI if all conflicts are auto-
solvable."  This flag was carried over from the original mergetool
commands.  diff_cmd() is for two-way comparisons only so remove the
superfluous flag.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This one is not RFC; just a trivial fix.

 mergetools/kdiff3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mergetools/kdiff3 b/mergetools/kdiff3
index 28fead4..a30034f 100644
--- a/mergetools/kdiff3
+++ b/mergetools/kdiff3
@@ -1,5 +1,5 @@
 diff_cmd () {
-	"$merge_tool_path" --auto \
+	"$merge_tool_path" \
 		--L1 "$MERGED (A)" --L2 "$MERGED (B)" \
 		"$LOCAL" "$REMOTE" >/dev/null 2>&1
 }
-- 
1.8.3.rc1.38.g0f1704c
