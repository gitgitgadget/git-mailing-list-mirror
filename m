From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 2/2] CodingGuidelines: Add note forbidding use of 'which' in shell scripts
Date: Fri, 24 Feb 2012 16:12:01 -0500
Message-ID: <1330117921-8257-2-git-send-email-tim.henigan@gmail.com>
References: <1330117921-8257-1-git-send-email-tim.henigan@gmail.com>
Cc: tim.henigan@gmail.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 27 18:43:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S24bt-00012P-B9
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 18:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513Ab2B0Rnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 12:43:37 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48072 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024Ab2B0Rng (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 12:43:36 -0500
Received: by vbbff1 with SMTP id ff1so1063357vbb.19
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 09:43:35 -0800 (PST)
Received-SPF: pass (google.com: domain of tim.henigan@gmail.com designates 10.220.155.132 as permitted sender) client-ip=10.220.155.132;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tim.henigan@gmail.com designates 10.220.155.132 as permitted sender) smtp.mail=tim.henigan@gmail.com; dkim=pass header.i=tim.henigan@gmail.com
Received: from mr.google.com ([10.220.155.132])
        by 10.220.155.132 with SMTP id s4mr9087717vcw.65.1330364615880 (num_hops = 1);
        Mon, 27 Feb 2012 09:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NQzusRzNK/thyJv7AF1LB5vI3cD3BMLFvtyTxD8F9rk=;
        b=C3OU+XNXXUCd3KJaFN1LkjHxnRSrbwgfIcSVSVot6pUYv1PefjMvZdfa0fhqFtMqUT
         gwWzaThqFGViDAM6ycqT6mQTbrtgW8XqlRISSBaFsTrSl2sKDnerHYcqE5J0LoEFOFku
         Dw6ti4TLqcdYntOkdhzeVtpCFMF/xZLreUL0I=
Received: by 10.220.155.132 with SMTP id s4mr7341329vcw.65.1330364615817;
        Mon, 27 Feb 2012 09:43:35 -0800 (PST)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id a19sm11541210vdh.12.2012.02.27.09.43.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Feb 2012 09:43:34 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1330117921-8257-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191635>

During the code review of a recent patch, it was noted that shell scripts
must not use 'which'.  The output of the command is not machine parseable
and its exit code is not reliable across platforms.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 Documentation/CodingGuidelines |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index a4ffe7c..3505a4b 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -44,6 +44,10 @@ For shell scripts specifically (not exhaustive):
    properly nests.  It should have been the way Bourne spelled
    it from day one, but unfortunately isn't.
 
+ - The use of 'which' is not allowed.  The output of 'which' is not
+   machine parseable and its exit code is not reliable across
+   platforms.
+
  - We use POSIX compliant parameter substitutions and avoid bashisms;
    namely:
 
-- 
1.7.9.1
