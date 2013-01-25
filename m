From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 5/7] mergetools/vim: Remove redundant diff command
Date: Fri, 25 Jan 2013 01:43:52 -0800
Message-ID: <1359107034-14606-6-git-send-email-davvid@gmail.com>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:44:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyfpx-00082T-QJ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab3AYJoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:44:17 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:56591 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826Ab3AYJoN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 04:44:13 -0500
Received: by mail-ia0-f174.google.com with SMTP id o25so283995iad.33
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 01:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=TSt3nlCqcbdONc5I4DsI6PsEbiqxPs6HlNPQWf6+m1M=;
        b=gNS4N4KXekLFbOT9zHVm0O/tW5lx6BmA+rvRoxdJAdeiTt3wVkywNljCDuf93/dejv
         S+TBFq9QNUGDwXknhskNn7bbSOy9L4fIw3BUbhDS9Xhx/gQQ4+tD3FogMu9ja3qTiRnL
         eX3kVovV8n1M/fCKV4oKh23loQH6za7nFAkQzXL/BsGne50V+6BxB/YNSOEAkVRg6+TU
         4d83uOsLDo8859dQ81AVDKmaAbUSnbF97jSOAkLAKXN6flEDuo5zew5SoG754yPmJ9QC
         6v/aIkczDdcYOJWMPiszfLJA2kG/g2G7IAVM1W34pmLSFKl2BQ9UfS2zRDdv0EHiUn1Z
         +kqQ==
X-Received: by 10.50.179.71 with SMTP id de7mr3433717igc.46.1359107052743;
        Fri, 25 Jan 2013 01:44:12 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id gs6sm314611igc.11.2013.01.25.01.44.10
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 01:44:11 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.367.g22b1720.dirty
In-Reply-To: <1359107034-14606-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214528>

vimdiff and vimdiff2 differ only by their merge command so remove the
logic in the diff command since it's not actually needed.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 mergetools/vim | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mergetools/vim b/mergetools/vim
index 619594a..39d0327 100644
--- a/mergetools/vim
+++ b/mergetools/vim
@@ -1,14 +1,6 @@
 diff_cmd () {
-	case "$1" in
-	gvimdiff|vimdiff)
-		"$merge_tool_path" -R -f -d \
-			-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
-		;;
-	gvimdiff2|vimdiff2)
-		"$merge_tool_path" -R -f -d \
-			-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
-		;;
-	esac
+	"$merge_tool_path" -R -f -d \
+		-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
 }
 
 merge_cmd () {
-- 
1.8.1.1.367.g22b1720.dirty
