From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH] git-remote.txt: fix wrong remote refspec
Date: Thu, 23 Jun 2011 13:45:19 +0900
Message-ID: <1308804319-6354-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 06:45:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZbnH-0008QL-T3
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 06:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319Ab1FWEp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 00:45:26 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57276 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab1FWEpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 00:45:25 -0400
Received: by yxi11 with SMTP id 11so591954yxi.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 21:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=JNfuoM48dwLdWLZ7Uv1WxxSDpkBFtIgrFMvstGmd3W8=;
        b=pePnheKgDwHmDgh5BJ7l0ML7BadwpZyF2Q02JNtXbfMBuVK+iPZ+Tf5CnfztsA9GI0
         W1Y+yZMNmGQZiXmwvFkbY0xb2utVIthKX8AxL8X7RYLjHpcC4e0S/YPKAYyFHZKjcohY
         Wv6F8vtx5kGdRkUJoAFV7fhLfrjinRgvCRFus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=piyUu2AIdp2hP7YLy3fUvch520dYhyhZU0XWA8v+9FGxsoMwrSZA2bQw83w4O0qsFp
         U3K00qsu39cRZ4DCnyhAD3sqTF1beHyPsgDPnhPjRWnJG4T3Uz1GGE9FJgPBCEVPlb1D
         iJ4M1+ckgApbP/xLNC7nMxKRzFIXcE2QkZvsk=
Received: by 10.91.99.4 with SMTP id b4mr1775176agm.0.1308804325267;
        Wed, 22 Jun 2011 21:45:25 -0700 (PDT)
Received: from localhost.localdomain ([118.176.77.244])
        by mx.google.com with ESMTPS id c19sm1195589anm.41.2011.06.22.21.45.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 21:45:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176261>

$GIT_DIR/remotes/<name>/HEAD should be
$GIT_DIR/refs/remotes/<name>/HEAD.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 Documentation/git-remote.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 528f34a..f5b6e8b 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -64,7 +64,7 @@ refspec for the remote to track all branches under
 is created.  You can give more than one `-t <branch>` to track
 multiple branches without grabbing all branches.
 +
-With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
+With `-m <master>` option, `$GIT_DIR/refs/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch. See also the set-head command.
 +
 When a fetch mirror is created with `\--mirror=fetch`, the refs will not
@@ -92,23 +92,23 @@ configuration settings for the remote are removed.
 
 'set-head'::
 
-Sets or deletes the default branch (`$GIT_DIR/remotes/<name>/HEAD`) for
+Sets or deletes the default branch (`$GIT_DIR/refs/remotes/<name>/HEAD`) for
 the named remote. Having a default branch for a remote is not required,
 but allows the name of the remote to be specified in lieu of a specific
 branch. For example, if the default branch for `origin` is set to
 `master`, then `origin` may be specified wherever you would normally
 specify `origin/master`.
 +
-With `-d`, `$GIT_DIR/remotes/<name>/HEAD` is deleted.
+With `-d`, `$GIT_DIR/refs/remotes/<name>/HEAD` is deleted.
 +
 With `-a`, the remote is queried to determine its `HEAD`, then
-`$GIT_DIR/remotes/<name>/HEAD` is set to the same branch. e.g., if the remote
+`$GIT_DIR/refs/remotes/<name>/HEAD` is set to the same branch. e.g., if the remote
 `HEAD` is pointed at `next`, "`git remote set-head origin -a`" will set
 `$GIT_DIR/refs/remotes/origin/HEAD` to `refs/remotes/origin/next`. This will
 only work if `refs/remotes/origin/next` already exists; if not it must be
 fetched first.
 +
-Use `<branch>` to set `$GIT_DIR/remotes/<name>/HEAD` explicitly. e.g., "git
+Use `<branch>` to set `$GIT_DIR/refs/remotes/<name>/HEAD` explicitly. e.g., "git
 remote set-head origin master" will set `$GIT_DIR/refs/remotes/origin/HEAD` to
 `refs/remotes/origin/master`. This will only work if
 `refs/remotes/origin/master` already exists; if not it must be fetched first.
-- 
1.7.5.2
