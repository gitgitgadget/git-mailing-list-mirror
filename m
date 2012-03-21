From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v3 11/9] t7800: add test for difftool --tool-help
Date: Wed, 21 Mar 2012 15:35:59 -0400
Message-ID: <1332358560-13774-5-git-send-email-tim.henigan@gmail.com>
References: <1332358560-13774-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 21 20:37:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SARLT-0000p7-Is
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 20:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab2CUThN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 15:37:13 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:41921 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab2CUThL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 15:37:11 -0400
Received: by qcqw6 with SMTP id w6so846284qcq.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Qkfu4Kcd8f44yvF+vhFIwgN4wPijz1PslesI40ae07g=;
        b=LpVAoF/XO2pvzlmTCaMH2XdiigM0/1vt3JSC+OqQnhBv/fwj2HN4Ri75x5BkQ8Djx2
         XjxnIRt3D/sxVU9Ofv01fJjAa+AR7C2iZMj13LC7U280jN++JWv4Gu8drDRQWaLKMthY
         ZrAkt7AMX/1GdZbJJlEJuFgv/GqZ35Jk2s8LySWc7VdVr40OE86KWzGk6zGPgDGcL0cc
         Lo+XZT8l0g0LOb0OwOBwFdSYBl9COxF6i1fOLfyCTdRYvHIsysjq2reZ9W5eilxOXkvQ
         RPXihKJZTdXcf33Acd71yVXVPBvcCys6B8qirxcwcTi7sPzN8RU1s6gMB46855RXUXHl
         1BQw==
Received: by 10.224.187.137 with SMTP id cw9mr7592739qab.19.1332358629940;
        Wed, 21 Mar 2012 12:37:09 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id dv7sm4389254qab.15.2012.03.21.12.37.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 12:37:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.39.g6e141f
In-Reply-To: <1332358560-13774-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193605>

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 t/t7800-difftool.sh |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index dc181cf..663247c 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -300,4 +300,9 @@ test_expect_success PERL 'say no to the second file' '
 	echo "$diff" | stdin_doesnot_contain br2
 '
 
+test_expect_success PERL 'difftool --tool-help' '
+	tool_help=$(git difftool --tool-help) &&
+	echo "$tool_help" | stdin_contains tool
+'
+
 test_done
-- 
1.7.10.rc1.39.g6e141f
