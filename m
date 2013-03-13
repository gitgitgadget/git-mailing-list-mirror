From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 4/4] contrib/subtree: Replace invisible carriage return with a visible \r
Date: Wed, 13 Mar 2013 22:32:43 +0000
Message-ID: <1363213963-4065-5-git-send-email-pcampbell@kemitix.net>
References: <1363213963-4065-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Matt Hoffman <matt.hoffman@quantumretail.com>,
	Paul Campbell <pcampbell@kemitix.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 13 23:34:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFuFO-0005XP-Sg
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 23:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934342Ab3CMWdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 18:33:42 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:58367 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934325Ab3CMWdk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 18:33:40 -0400
Received: by mail-we0-f173.google.com with SMTP id x51so1494098wey.4
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 15:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=Xv1TzIEXwOj+iYXaTR2JYo+kmZewwiQgsbPtrE/wKcM=;
        b=jNURdQZYSWsISHsl9CaEMLkIPyIoanSA9+DqB8PiaZbPSgfwtcAkwQ/53bvPxrsuuv
         P8DSmNgEJhWEGRS5Tj+V47kvjvQ0vHvS6vM0UGr8jczIBo4ny9/9xQhmuzvSyXf3OLqX
         BY2C68RPzqquUmUtDgGocsMouGqnLm5djWhLISJK9IO/8/7jfMAqlqmIVeAgoQkJjP0j
         2y23kCOktSVHkM5NhZpVsqfb2dcqlc8kM+d70S5ndHe4N8DX66QhoCpc7GtEbs9enms1
         wePnJlcjgN72VR/46qgDR8OuIJrdtrRvB7b8WNMIrakLQytjVtlXVc7eFFXAl4iGRCGW
         0gRw==
X-Received: by 10.194.123.103 with SMTP id lz7mr172689wjb.10.1363214018936;
        Wed, 13 Mar 2013 15:33:38 -0700 (PDT)
Received: from coyote.home (host-2-102-86-203.as13285.net. [2.102.86.203])
        by mx.google.com with ESMTPS id c15sm330641wiw.3.2013.03.13.15.33.37
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 13 Mar 2013 15:33:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1363213963-4065-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQmCQUz/oNnmgLafMPcJT3FDAJkuqVkBsKdAo6e2F9DjELp256V7FFXSVLxvoV3dYimvLOtd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218101>

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
index 2d9b071..5314bd0 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -595,7 +595,7 @@ cmd_split()
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
1.8.2
