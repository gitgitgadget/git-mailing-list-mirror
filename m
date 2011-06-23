From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH v2] git-remote.txt: fix wrong remote refspec
Date: Thu, 23 Jun 2011 17:12:04 +0900
Message-ID: <1308816724-8406-1-git-send-email-namhyung@gmail.com>
References: <1308809849.1338.11.camel@leonhard>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 10:12:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZf1Y-0005H6-MT
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 10:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817Ab1FWIMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 04:12:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63587 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867Ab1FWIMO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 04:12:14 -0400
Received: by iwn6 with SMTP id 6so1371987iwn.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=weL14KXYd8cg9wXHOg7gJhxpAL+0xPZVJtTHtNQ9WO8=;
        b=Cx8f+j1XfysKdFPyR3ZKLO8c9mNTWiPjLNFhwn0heL3bOtkrp2bthWdG1SbAfCSbRR
         iUVIEaAO5WubG3nGC6vxsi77ncY1ATa4SZHO8DUGcRPxhAcMDjuX9ZNbFiBA1J0zfOVo
         7BreC3TUBQkINuWvaFnqgl5e8BroB6oI62kaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=raSqZo1g9yPVvurew4+K5b+9RglvHnD762FY2PGzvHRPweuk7BejezI+cs8uxu/R+h
         LYlntdjIA29sD1JrjUqH9A7It7u2JmLVlUZwKZBlJ+49N3CcCSoP7fiySWy2FnmIjvnZ
         1ortMOjk+xL940acYOM0eW4HumowK8eqddU9I=
Received: by 10.42.155.10 with SMTP id s10mr1925222icw.54.1308816733969;
        Thu, 23 Jun 2011 01:12:13 -0700 (PDT)
Received: from localhost.localdomain ([118.176.77.244])
        by mx.google.com with ESMTPS id y1sm1397554ica.16.2011.06.23.01.12.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 01:12:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.2
In-Reply-To: <1308809849.1338.11.camel@leonhard>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176266>

$GIT_DIR/remotes/<name>/<branch> should be
$GIT_DIR/refs/remotes/<name>/<branch>.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 Documentation/git-remote.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 528f34a..1e3945f 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -60,11 +60,11 @@ the remote repository.
 +
 With `-t <branch>` option, instead of the default glob
 refspec for the remote to track all branches under
-`$GIT_DIR/remotes/<name>/`, a refspec to track only `<branch>`
+`$GIT_DIR/refs/remotes/<name>/`, a refspec to track only `<branch>`
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
