From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH] Clarify documentation on commit message strip
Date: Sat, 25 Apr 2015 07:42:45 +0200
Message-ID: <1429940565-14947-1-git-send-email-iveqy@iveqy.com>
References: <xmqqmw1w259r.fsf@gitster.dls.corp.google.com>
Cc: gitster@pobox.com, iveqy@iveqy.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 07:52:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylt0V-0003vD-Fy
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 07:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbbDYFnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 01:43:18 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:36557 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbbDYFnR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 01:43:17 -0400
Received: by lagv1 with SMTP id v1so48544982lag.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 22:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=16irK+r4jQj4caS6mnM5Cn2ppOiETbXAIakFQHGVdTo=;
        b=l/zro3oKs755LD4PEUPSWfynvVK/LI4bNg7SVjlNFpqfG1Yq2LfvZ280tVqICYnMgZ
         vbdPrqmveKj7B0whIirhiHj6kFYHBQdIGCCJPcl2C5LJUGvAwhCjF1LCM/J17ODE63tE
         yYud0JY4c1bwu8DTYm7PeWussf0GJmw7XPU/UVjuY7uFu8A6DpR+AGM0pxkkVVPRg9Ey
         PA3aGo6QFtiV7DWr0SnRrujeBKqswahjIL5fClZQhS+ldy1gVKXGE9umNnmctU9rpWPw
         d0lmkzPnxYSsmYDQ3yCkk3LkLiS4B/YsB5yqT+Fuwt9ofuSF5LqTB6DyaampQ+2Vht9F
         dw9A==
X-Received: by 10.152.7.209 with SMTP id l17mr1587950laa.100.1429940596392;
        Fri, 24 Apr 2015 22:43:16 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-249-10-52.bredband.comhem.se. [83.249.10.52])
        by mx.google.com with ESMTPSA id n10sm3129954laa.40.2015.04.24.22.43.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2015 22:43:15 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Ylsrz-0003ts-1R; Sat, 25 Apr 2015 07:43:15 +0200
X-Mailer: git-send-email 2.4.0.rc3.4.g20acbad
In-Reply-To: <xmqqmw1w259r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267774>

When using `-v` to add a unified diff to the commit message, this is
stripped and not a part of the commit message. This is not mentioned.

Add a note about this with the `-v` description and slightly modify
the description for the default `--cleanup` mode.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---

>I'd prefer the description not to be _too_ explicit e.g. by
>mentioning "unified diff", etc.
>
>Personally I think it is sufficient to do s/#comment/comment/ to the
>existing text, without doing anything else.  What is "commentary" to
>be removed is fairly clear in the contents given to the user in the
>editor.

I agree that it is very clear once you do edit the commit message. My main
point with this patch was to clarify -v, since it's not obvious from the
documentation that it will be removed.

I've no objections about your suggestions about the `strip` part. I hope I've
understood you correctly and that this patch is correct.

 Documentation/git-commit.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 617e29b..1db4c7f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -180,8 +180,8 @@ OPTIONS
 +
 --
 strip::
-	Strip leading and trailing empty lines, trailing whitespace, and
-	#commentary and collapse consecutive empty lines.
+	Strip leading and trailing empty lines, trailing whitespace,
+	commentary and collapse consecutive empty lines.
 whitespace::
 	Same as `strip` except #commentary is not removed.
 verbatim::
@@ -283,7 +283,8 @@ configuration variable documented in linkgit:git-config[1].
 	Show unified diff between the HEAD commit and what
 	would be committed at the bottom of the commit message
 	template.  Note that this diff output doesn't have its
-	lines prefixed with '#'.
+	lines prefixed with '#'. This diff will not be a part
+	of the commit message.
 +
 If specified twice, show in addition the unified diff between
 what would be committed and the worktree files, i.e. the unstaged
-- 
2.1.4
