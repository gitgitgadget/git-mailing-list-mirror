From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v2 1/2] CodingGuidelines: Add a note about spaces after redirection
Date: Fri, 24 Feb 2012 18:12:57 -0500
Message-ID: <1330125178-9194-1-git-send-email-tim.henigan@gmail.com>
Cc: tim.henigan@gmail.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 27 20:44:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S26UG-00014v-N4
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 20:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651Ab2B0Tnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 14:43:41 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62591 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957Ab2B0Tnj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 14:43:39 -0500
Received: by vcqp1 with SMTP id p1so1837286vcq.19
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 11:43:39 -0800 (PST)
Received-SPF: pass (google.com: domain of tim.henigan@gmail.com designates 10.220.156.139 as permitted sender) client-ip=10.220.156.139;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tim.henigan@gmail.com designates 10.220.156.139 as permitted sender) smtp.mail=tim.henigan@gmail.com; dkim=pass header.i=tim.henigan@gmail.com
Received: from mr.google.com ([10.220.156.139])
        by 10.220.156.139 with SMTP id x11mr9803217vcw.18.1330371818922 (num_hops = 1);
        Mon, 27 Feb 2012 11:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=y+D7Pm/BHQNiw4yHFxGyDwz0vaa8xHjhxkob2URyFsU=;
        b=l7Nm+QoVwjgTVkPT0ZO7iC4IoW1HKDFmNEbYdTcnNNRRMOX3IjmKB3p77l727GdL2p
         K0uX4KUW1sE7gNA2LlceA+jAmZnfpcuoki/Uewc/Urali5Zrnn46X/Cf+JXT55EQL7pl
         P8k+DholKuLEf4Y9TfcpsVs/3pKfNgp6Ne/SY=
Received: by 10.220.156.139 with SMTP id x11mr7965421vcw.18.1330371818093;
        Mon, 27 Feb 2012 11:43:38 -0800 (PST)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id h5sm12058946vdk.0.2012.02.27.11.43.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Feb 2012 11:43:36 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191661>

During code review of some patches, it was noted that redirection operators
should have space before, but no space after them.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Updated to include double-quotes around redirection target and also
document why they are needed.


 Documentation/CodingGuidelines |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 4830086..5a190b9 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -35,6 +35,16 @@ For shell scripts specifically (not exhaustive):
 
  - Case arms are indented at the same depth as case and esac lines.
 
+ - Redirection operators should be written with space before, but
+   no space after them.  For example:
+      'echo test >"$file"'  is preferred over
+      'echo test > "$file"'
+
+   Note that even though it is not required by POSIX to double-
+   quote the redirection target in a variable (as shown above),
+   our code does so because some versions of bash issue a warning
+   without them.
+
  - We prefer $( ... ) for command substitution; unlike ``, it
    properly nests.  It should have been the way Bourne spelled
    it from day one, but unfortunately isn't.
-- 
1.7.9.1
