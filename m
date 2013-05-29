From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 6/8] rebase: cherry-pick: fix status messages
Date: Tue, 28 May 2013 23:16:38 -0500
Message-ID: <1369801000-3705-7-git-send-email-felipe.contreras@gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 06:18:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXqb-0002So-3B
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 06:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934890Ab3E2ESk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 00:18:40 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:45855 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933908Ab3E2ESj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 00:18:39 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so11004727oag.37
        for <git@vger.kernel.org>; Tue, 28 May 2013 21:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qZeIP8xonlU2ijOw69uTRh2rAR1S0JoM8j+UaPTvyrs=;
        b=JYqBClphk24AnQGucPRQP6w/axr5W34Y1qj620CUD1NSSilKU5jrrE4QuLVr2g0Vt3
         mUnGSGUpNi3Hho4BarZdnc6FmThwmiHR5wcjOgjXYzagqtjXiD0zh8bACiv4OnqUpbpH
         QumnsjXd/EvgLicKp+3Y1x8a8FQ0KqCv9wbw96lyACWAgbjQ9gMG4XIE706eTWYfPrfs
         cPe584haOotrtI2jyXxVXFwOBkteL7NWbS8l6sZAIvFX7Zc1rmqF9M6MaOGOfx5xt0BS
         sERuvbNoq8E5/GP3PBLO2IJLNd3TkwwyM6xrPLZtBluUm3gjBUW9+tyA2z9pQ0Vz1kBu
         BBrQ==
X-Received: by 10.60.102.178 with SMTP id fp18mr553796oeb.35.1369801118986;
        Tue, 28 May 2013 21:18:38 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ns4sm38407735obc.2.2013.05.28.21.18.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 21:18:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225729>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index ab892e6..ef3224d 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -3,6 +3,9 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
+GIT_CHERRY_PICK_HELP="$resolvemsg"
+export GIT_CHERRY_PICK_HELP
+
 case "$action" in
 continue)
 	git cherry-pick --continue &&
-- 
1.8.3.rc3.312.g47657de
