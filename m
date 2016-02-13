From: larsxschneider@gmail.com
Subject: [PATCH v3 1/3] git-config.txt: describe '--includes' default behavior
Date: Sat, 13 Feb 2016 15:24:14 +0100
Message-ID: <1455373456-64691-2-git-send-email-larsxschneider@gmail.com>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, sschuberth@gmail.com, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, hvoigt@hvoigt.net, sbeller@google.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 15:25:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUb8D-0007ml-G7
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 15:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbcBMOYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 09:24:31 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32795 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbcBMOYV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 09:24:21 -0500
Received: by mail-wm0-f65.google.com with SMTP id c200so7726878wme.0
        for <git@vger.kernel.org>; Sat, 13 Feb 2016 06:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3ke6Cy6akHW9Qyg5/aDf20RXb9y5xgjnUQQgd8sLWMk=;
        b=GChQe/1JUOBcT73YuauA6/iLnXMil9vNlQZLp6zBZWoGXNmD9b3K9sGgmiSnLbPmFe
         A9Pjc8Y6PBpuukoGmL+0qd028VPWeT6zd5QbGJg7g8YT6bA7+V3v0mJrgBlaheXGtKtO
         ekipZL4aZduOX9X61bNijpERdn1VJMY4mWqusy7/y8/1o11HO0GHslY/U2U2pfXTDiI6
         1TR9x9bgjamFFczZW8noR8t5B/ydLzTWwfKjh7ytsvNocrDYvJNPIBOPUly8gBmu9ikV
         DKHvRkRFcpKF7h3bVgAswuNVyzMKJS+s5PcxSIEAm2cmdI6C/RlRiOqPTDAXxjQRWk8P
         rG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3ke6Cy6akHW9Qyg5/aDf20RXb9y5xgjnUQQgd8sLWMk=;
        b=DRZ2aicAcFKb/8UzBLlqXkAuV4iIggRLCmXxQmSSgaXZEpfdeEMtxuwU5h0A9wq19e
         9Jof8M22ie421NY0oyo9iIpyBDxaCOMqAIL0v/iJks/yXcl1MU5Pj76UaYKn0hp/qiha
         njGLaA1rlEDF/LJHKqKR/iJSYFKNxuxdaPqTg1HOhLz6qgvZnUnARGuZ3wotEhJfmr9a
         TCOb9DFSOAQ2dKxafc0f13QWtDQ0uAgkEHkK6DKE+veEVbaEQmtEz7kB1UN9fGvdJN4o
         pP/agshrzvcSYrz/FeBEOridEe2IG6nroG8WYLLmdcvm9q0QZ+IUXXwygcVDsLFLGCsc
         DLDw==
X-Gm-Message-State: AG10YOT6SLxGhGg0d9Hu667/dpQ1L+5KwToLBiZ2ybIRy2pSAmhiVy9bHKEkG5LLxYhjDw==
X-Received: by 10.194.76.72 with SMTP id i8mr6908092wjw.117.1455373460802;
        Sat, 13 Feb 2016 06:24:20 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB53AE.dip0.t-ipconnect.de. [93.219.83.174])
        by smtp.gmail.com with ESMTPSA id os7sm16754763wjc.18.2016.02.13.06.24.19
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 13 Feb 2016 06:24:20 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286111>

From: Lars Schneider <larsxschneider@gmail.com>

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-config.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 2608ca7..59b1c95 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -219,7 +219,9 @@ See also <<FILES>>.
 
 --[no-]includes::
 	Respect `include.*` directives in config files when looking up
-	values. Defaults to on.
+	values. Defaults to off when reading a specific config file
+	(e.g. via `--file` or via `--local` etc.), and to on when
+	generically reading all config.
 
 [[FILES]]
 FILES
-- 
2.5.1
