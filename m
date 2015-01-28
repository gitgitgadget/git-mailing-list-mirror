From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: correct "exclude" change
Date: Wed, 28 Jan 2015 06:08:04 +0000
Message-ID: <1422425284-5282-2-git-send-email-luke@diamand.org>
References: <1422425284-5282-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 07:08:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGLnb-0000DC-DO
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 07:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758264AbbA1GIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 01:08:16 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:58145 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbbA1GIO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 01:08:14 -0500
Received: by mail-pa0-f48.google.com with SMTP id ey11so23426449pad.7
        for <git@vger.kernel.org>; Tue, 27 Jan 2015 22:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NzScRBAWSQnqEk7osPH6z6gVZW1OhFjWuLhHUJjtgb8=;
        b=JVivQEKOVebIM3SHQT0q6/u/x3VsOPlptE18IhEXMJ+IKJlLWhvm1R3Z6ivWlWU8HB
         6Ccc5qwF1JCYa2QwZu6nHs0cKJCVVL7B9xkl+5dpQoDHztE5DRA8GTJOh8EAR9X3fYsK
         yUsJBBNAOU1/j+9MN7cy4fPVZ7qVE3JOIdr+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NzScRBAWSQnqEk7osPH6z6gVZW1OhFjWuLhHUJjtgb8=;
        b=aWOBvdr/E0qoGbsCRUe8YB4J/oXH/+IitI/vPSRsciToA5zKYZs989kcoUJP0X8Yn9
         lhMMsBiiEO13iCt3TVB+O/gTz1Wq0SKChu019BhsoKgIYR1Xu3KnolU1grs1Dac5r1zh
         kwdlcLjRGtehTBQ88velzVqFKD2H3XuYAbUWei95aEd8RRvek/8g/YQcG/CMHerJz2ZH
         rY8NVIIPWIvm0klP0YnO/DaLHofT2XYJtR/qJmQwqTRAtOz/Z6i7BDiIUuHAOyL/bmql
         8wPn8lvZ0o7zgn3auquxzHzh5V5GX8s1AXQ93N3HAw1moI9ModHlAHgX0cRNh7XkM/zU
         2UBw==
X-Gm-Message-State: ALoCoQnFktGVpCbO9LdN3v+MafV3wrzW+jrMi5X6WYOnbKKbdmIxMP75ZFl+cIKoD9uesoyajWdE
X-Received: by 10.68.197.161 with SMTP id iv1mr2767428pbc.147.1422425294002;
        Tue, 27 Jan 2015 22:08:14 -0800 (PST)
Received: from lgd-kipper.corp.roku ([216.38.147.4])
        by mx.google.com with ESMTPSA id fg6sm3441182pdb.24.2015.01.27.22.08.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jan 2015 22:08:13 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc2.188.g4b64765.dirty
In-Reply-To: <1422425284-5282-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263100>

The previous change for excluding paths in the "sync"
subcommand was incorrect, missing a comma, preventing
git-p4 from working.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 6ff0b76..549022e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1915,7 +1915,7 @@ class P4Sync(Command, P4UserMap):
                 optparse.make_option("--keep-path", dest="keepRepoPath", action='store_true',
                                      help="Keep entire BRANCH/DIR/SUBDIR prefix during import"),
                 optparse.make_option("--use-client-spec", dest="useClientSpec", action='store_true',
-                                     help="Only sync files that are included in the Perforce Client Spec")
+                                     help="Only sync files that are included in the Perforce Client Spec"),
                 optparse.make_option("-/", dest="cloneExclude",
                                      action="append", type="string",
                                      help="exclude depot path"),
-- 
2.3.0.rc2.188.g4b64765.dirty
