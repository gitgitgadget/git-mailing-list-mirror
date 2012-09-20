From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] Documentation: Document signature showing options
Date: Thu, 20 Sep 2012 01:10:38 -0700
Message-ID: <1348128638-26003-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 10:10:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEbqX-0003B6-Qk
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 10:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658Ab2ITIKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 04:10:44 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59718 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab2ITIKk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 04:10:40 -0400
Received: by pbbrr13 with SMTP id rr13so4521820pbb.19
        for <git@vger.kernel.org>; Thu, 20 Sep 2012 01:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=SZxUiGY/8LHksmmMyZ3LNbAuBtThNZiI6+0JE2Ti5Bk=;
        b=FjTssqQtaSvNR4XocvR73+Qo/D+Ucy47EfN/sefaE681Xtgbv1d9nG+NqeIiijfp1g
         yAN4EEFDVgtWu42lT/CGvwAw5Yzjjl3chl+5DPQ2vuFn2hOxV5QlfmiSS/j0UDk8WRut
         GTDnm5/2XkexNQLMznZHI9LqjkxOoWi+NrchtQNN+sTy2SzDr1Ka2c961whHS+bi63He
         0tR4lMwRuqW7HN3sNE+Sm4B0lFcFOeRCYr2g1Y3PobEYVSupucNjfhspqYf8kIb0gzfC
         XXlvIyHXO+zsZFJSLMR24VPuyL6AgCyGCSqL5VFYzRIJMTr5ZW7rNNWjCi+VsqKgrqPX
         Wssg==
Received: by 10.68.195.226 with SMTP id ih2mr4883767pbc.9.1348128640202;
        Thu, 20 Sep 2012 01:10:40 -0700 (PDT)
Received: from earth (cpe-98-155-61-242.san.res.rr.com. [98.155.61.242])
        by mx.google.com with ESMTPS id ho7sm3176376pbc.3.2012.09.20.01.10.37
        (version=SSLv3 cipher=OTHER);
        Thu, 20 Sep 2012 01:10:39 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 20 Sep 2012 01:10:38 -0700
X-Mailer: git-send-email 1.7.12.1.382.gb0576a6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206041>

The pretty formats for GPG signatures were introduced but never
documented. Use the documentation from the commit that introduced them.
Do the same for the --show-signature option added to git log and
friends.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

I had to google for --show-signature one too many times.

 Documentation/pretty-formats.txt | 3 +++
 Documentation/pretty-options.txt | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index e3d8a83..d9edded 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -130,6 +130,9 @@ The placeholders are:
 - '%b': body
 - '%B': raw body (unwrapped subject and body)
 - '%N': commit notes
+- '%GG': raw verification message from GPG for a signed commit
+- '%G?': show either "G" for Good or "B" for Bad for a signed commit
+- '%GS': show the name of the signer for a signed commit
 - '%gD': reflog selector, e.g., `refs/stash@{1}`
 - '%gd': shortened reflog selector, e.g., `stash@{1}`
 - '%gn': reflog identity name
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 2a3dc86..5e49942 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -66,3 +66,7 @@ being displayed. Examples: "--notes=foo" will show only notes from
 --[no-]standard-notes::
 	These options are deprecated. Use the above --notes/--no-notes
 	options instead.
+
+--show-signature::
+	Check the validity of a signed commit object by passing the signature
+	to `gpg --verify` and show the output.
-- 
1.7.12.1.382.gb0576a6.dirty
