From: Stefan Beller <sbeller@google.com>
Subject: Subject: [PATCH for submodule ideas wiki] `git commit` to warn about broken submodule states configuration
Date: Wed, 16 Mar 2016 14:07:03 -0700
Message-ID: <1458162423-13768-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Wed Mar 16 22:09:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agIhC-0002Fo-6h
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766AbcCPVJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:09:30 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:32895 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166AbcCPVJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:09:29 -0400
Received: by mail-pf0-f179.google.com with SMTP id 124so89788243pfg.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 14:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gaBAomDBiUopeEhW8O3y+04RUd5dpNDPH4q07Y1qWx0=;
        b=ig1rh2XI89cXW9lbgU1JxUb9ehGdUmEMzd1CSzptWzoLkDGMB0AawlajmJNR/wQkLS
         srjIcnuvMfPJxTR3/EQ0g6DnorfXaeFiY9DmRZMfMYq68gZLmMoaBivEpjSs/01yFC9+
         m6i6MoYYNhKB84hdCTNYmpZxajuqLcQPQPDGGY20k2yQjWXNxsMWY4F5Xylrlv5Ntrhh
         tH+JbqpE5DSw5kKkcRLbQd+QtceKGC2YRMFoGBSx6OBx3u4M4XedwFlMmK+0zgDuw7jh
         s17N00FuLcyvMyA8PcKTr6lFIsBISOy4Bk762gLS3gDYjOH7oUI+KTLLXmxm14XHXxhw
         wHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gaBAomDBiUopeEhW8O3y+04RUd5dpNDPH4q07Y1qWx0=;
        b=T/Ak9/R8MeQcfDIFuxZlbRKQeZdu/Ff25Q3l9FLsHJr9i4wVsNkkQ1cA5m11sjG55Q
         +Rej/I6sHXOMQbFEmWfayhsLBedMaTy+Y47CAvgNQixjQUNYrw1nJ+CcDaRmnBoNgmH5
         s79Da9YcdEeYgHLIXHBHNUki7eCQ9CNfC97qppp+XjAqWUybz3TpDDU6s7orJADRaLiw
         gZ9XUyYjMmr41sVwHxWXeo1LDMOHCwSiXfw936IcBSydfSPFHM3EwJWF2HZv/BC3FmLk
         rZx9juMaDSyMDgJ/ZzNqekKlkOTf6Hzuh0MrczKRpDQo2/cUOo6clZdLPvzDgoCU1F1i
         11RA==
X-Gm-Message-State: AD7BkJJTE+PeMkDPdnTL+qAjR5HgslmcLByjLg3yorUk/kUkghw4I1JGXxiGx+gABTTgQqE8
X-Received: by 10.98.66.155 with SMTP id h27mr9252955pfd.91.1458162568268;
        Wed, 16 Mar 2016 14:09:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:35c8:8c27:4243:7f7b])
        by smtp.gmail.com with ESMTPSA id tn5sm7813682pac.32.2016.03.16.14.09.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 14:09:27 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.42.g8e9204f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289036>

---

  Hi Jens,
 
  I cannot find the edit button in the wiki[1] any more.
  Please apply this patch documenting another idea.
  
  Thanks,
  Stefan
  
  [1] https://github.com/jlehmann/git-submod-enhancements/wiki

 Home.textile | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Home.textile b/Home.textile
index 152ad04..3b00496 100644
--- a/Home.textile
+++ b/Home.textile
@@ -47,6 +47,17 @@ h2. Submodule related bugs to fix
 * E.g. @git log <submodule>/@ and @git diff <rev> <submodule>/@ do not produce any output while dropping the '/' at the end makes them work as expected.
 * @git add@ does not honour the submodule.&lt;name&gt;.ignore settings
 * @git submodule add@ messes up paths from nested submodules, see ("thread on mailing list":http://thread.gmane.org/gmane.comp.version-control.git/288130)
+* @git commit@ can be cautious about submodule related commits. That is if a commit contains a change to the .gitmodules file, make sure that the corresponding gitlink is present (either already in the tree or newly added). IIUC Jonathan correctly a submodule which is configured in .gitmodules, but not present as a gitlink is considered broken, which we may want to avoid in the first place. When implementing this, we need to take care of historical mistakes being handled correctly as well as a flag to commit, which overwrites the potential warning. The gitmodules file unlike other in-tree configuration files (.gitignore, .gitattributes, .mailmap) have a 1:1 mapping so the existence of the gitlink is strongly expected. (Counter example with .gitignore: Ignoring *.exe doesn't expect any .ex
 e file to be there). I imagine this to roughly work as:
+
+bc.     $ git add .gitmodules
+    $ git commit -m "add submodule to .gitmodules, but not as gitlink"
+      Warning: Not committing as this would break submodule consistency. Use
+      --force-submodules to commit the broken submodule state.
+    $ echo $?
+      1 # fail
+    $ git commit --force-submodules -m "add submodule to .gitmodules, but not as gitlink"
+    $ echo $?
+      0 # Success
 
 *[[Ideas]]*
 
-- 
2.7.0.rc0.42.g8e9204f.dirty
