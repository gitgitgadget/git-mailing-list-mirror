From: Steven Klass <sklass@7stalks.com>
Subject: [PATCH] Corrects an Abort Trap: 6 error with completions.
Date: Mon, 8 Jul 2013 06:58:33 -0700
Message-ID: <5FF738AB-DA01-4460-9ADF-D960E2FD6309@7stalks.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: spearce@spearce.org
To: "git@vger.kernel.org" <git@vger.kernel.org>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 08 15:58:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwBxg-0002a6-Vu
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 15:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab3GHN6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 09:58:36 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:51524 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab3GHN6f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jul 2013 09:58:35 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so4311199pbc.18
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 06:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version:x-mailer:x-gm-message-state;
        bh=ZSc/xY9HdAnNAWRB70TT0HBPXGR255D87FRCwWb3/qE=;
        b=Qb1aKsFMSYcSkTUjwrk/byHo8UpXIrrRECh8bKrO3xAAzfTVF/XPPG3C9IXRW4M5TB
         7RdP2GHeZzqS70KbeoxFkgrhSqqqbg+gVQ1mJLOkg1hTyBDeruPgQYORRPaY/HWlo8Z1
         rWu2jSB2be6Gs529BFJRTqYdPsPIhZFy/zOeue+bilhKfZr3wbHHzP6Ka3r2pD99u78D
         ue1EQPzKXTEG+DmI4yMCIvuI6+xzQg0D4+/b5LKbg4uO+A7joYck+UP/mjOP98OymW6P
         AR0+x6LuClwqVBjkaO4v5nBd82UUqp6D9N/GAXbW/cohSFZB8Yhjsbt6wCP8p/EFCfdv
         hCzQ==
X-Received: by 10.68.189.101 with SMTP id gh5mr21752102pbc.86.1373291915413;
        Mon, 08 Jul 2013 06:58:35 -0700 (PDT)
Received: from [192.168.1.19] (ip68-0-158-66.tc.ph.cox.net. [68.0.158.66])
        by mx.google.com with ESMTPSA id ne6sm18209953pbc.28.2013.07.08.06.58.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 06:58:34 -0700 (PDT)
X-Mailer: Apple Mail (2.1508)
X-Gm-Message-State: ALoCoQmzJIEDNpxjZ1xCUtC1dkKYEZrNt/aIdCLw7IhHjemyj9++quEq37//5cg1rTKiLOAo4C1q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229857>

Hi Folks,

	Corrects an Abort Trap: 6 error with completions.
	Fixed an issue where the two commands on a single line  would cause a strange unrelated 'Abort trap: 6' error on  non-git commands on Mac OSX 10.8.

Signed-off-by: Steven Klass <sklass@7stalks.com>

---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 contrib/completion/git-completion.bash

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
old mode 100644
new mode 100755
index 6c3bafe..d63b1ba
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2165,7 +2165,8 @@ _git_config ()
           user.name
           user.signingkey
           web.browser
-          branch. remote.
+          branch.
+          remote.
      "
 }

---

Steven Klass

(480) 225-1112
sklass@7stalks.com
http://www.7stalks.com
