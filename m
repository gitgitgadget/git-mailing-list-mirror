From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Thu, 26 Mar 2015 14:04:07 +0100
Message-ID: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 26 14:04:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb7SJ-0008Bx-Jy
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 14:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbbCZNEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 09:04:10 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33384 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbbCZNEH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 09:04:07 -0400
Received: by ignm3 with SMTP id m3so13080339ign.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2015 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=QSXJdeo/qYtUSys3BAdGaHoOcbTZ20mlqZFeKhJD1lQ=;
        b=EnoKrEf6pnt5oisvbTusgu3b2RfPuJygkvBLcv3fN5I/eDSC5Jw/HF3fBfoEtLHKod
         gRmvf7i7kdqIzvhey3o1vSxh/qlk6ji/ezzPkDOdytD/0qlr9l1D+uHqKP3C7wZszviI
         S1QHnJJMDfaVf4a3HRj0RD6pncMkWj7osKOZxAtqmhzJQj+oqAwcCZOEVTs374Ptu6Kb
         RsJ+p/Ph0uqluYGAMaW5mtsJNF+eO3opsx1ySpPTVDy4m2RkGgYkdK1SApcouMssscmu
         gVoAlrpAujkH/f7CkWeTTRo4TSqM/i81scXIJOBhoYFVBHSgTVralFprSYgJwa9ymmQE
         Ev1g==
X-Received: by 10.50.126.6 with SMTP id mu6mr37209292igb.4.1427375047318; Thu,
 26 Mar 2015 06:04:07 -0700 (PDT)
Received: by 10.107.132.144 with HTTP; Thu, 26 Mar 2015 06:04:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266324>

Ignoring a merge sounds like ignoring the changes a merge commit
introduces altogether, as if the merge commit was skipped or dropped from
history. But that is not what happens if this options is not specified.
Instead, what happens is that the separate commits a merge commit
introduces are replayed in order, and only any possible merge conflict
resolutions are ignored. Get this straight in the docs.

Also, do not say that merge commits are *tried* to be recreated. They are
recreated, but possibly with conflicts, which in turn are likely to be
different from any original conflicts. Still recreating a merge commit does
not just silently fail in any case, which is how "try to recreate" might
sound.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index d728030..3a6d139 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -362,7 +362,7 @@ default is `--no-fork-point`, otherwise the
default is `--fork-point`.

 -p::
 --preserve-merges::
-    Instead of ignoring merges, try to recreate them.
+    Recreate merge commits instead of replaying commits a merge
commit introduces.
 +
 This uses the `--interactive` machinery internally, but combining it
 with the `--interactive` option explicitly is generally not a good
-- 
1.9.5.msysgit.1
