From: David Cowden <dcow90@gmail.com>
Subject: [PATCH] Clarify pre-push hook documentation
Date: Sun, 23 Mar 2014 12:01:07 -0700
Message-ID: <1395601267-78377-1-git-send-email-dcow90@gmail.com>
Cc: David Cowden <dcow90@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 20:01:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRneD-00015p-OY
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 20:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbaCWTBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 15:01:25 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:39554 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaCWTBY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 15:01:24 -0400
Received: by mail-pa0-f52.google.com with SMTP id rd3so4512839pab.39
        for <git@vger.kernel.org>; Sun, 23 Mar 2014 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HlPtjkcSO4bBCbxVtKMq1vS8KkXj8sjNpX4LGohNpOo=;
        b=AD3dkcOTpK+wwMOv5tWRSyE4n6WKICqj/0nx+OUpnllq6HPOcwOMF9hFEzOoJNpwzI
         Gm2stUZOvpQu0OyONS+ZxQQjpAPjFpwEhMBZtlfSRMmPiUsfuHxW+OacyX+WI7zkmUcl
         Giz9rKQ50aRqv6daMrH4T1TJfOJ+K0QgXdBQYYhJGKAHnYaqZZn4WgA28TYPXjvQgMKA
         lUkFpTEnj0smV8oC4FU8+VXvyxNgzckJNbjPOwIcJ1Idv/bzFUWZiE45MkifanvdXswW
         2Ot1GyG5eGgU5ffdJzHadPoepvd2MZYX3tHEv5YD2R9ILyp15V/CCH2oQkf3n1F+XGdk
         Jptg==
X-Received: by 10.68.226.197 with SMTP id ru5mr66521437pbc.77.1395601283473;
        Sun, 23 Mar 2014 12:01:23 -0700 (PDT)
Received: from localhost.localdomain (99-119-66-90.lightspeed.sntcca.sbcglobal.net. [99.119.66.90])
        by mx.google.com with ESMTPSA id gj9sm26514489pbc.7.2014.03.23.12.01.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 23 Mar 2014 12:01:21 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244798>

The documentation as-is does not mention that the pre-push hook is
executed even when there is nothing to push.  This can lead a new
reader to beilieve there will always be lines fed to the script's
standerd input and cause minor confusion as to what is happening
when there are no lines provided to the pre-push script.

Signed-off-by: David Cowden <dcow90@gmail.com>
---

Notes:
    c.f. http://stackoverflow.com/questions/22585091/git-hooks-pre-push-script\
    -does-not-receive-input-via-stdin

 Documentation/githooks.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d954bf6..a28f6f7 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -203,6 +203,10 @@ SHA-1>` will be 40 `0`.  If the local commit was specified by something other
 than a name which could be expanded (such as `HEAD~`, or a SHA-1) it will be
 supplied as it was originally given.
 
+The hook is executed regardless of whether there are changes to push or not.
+In the event that there are no changes, no data will be provided on the
+script's standard input.
+
 If this hook exits with a non-zero status, 'git push' will abort without
 pushing anything.  Information about why the push is rejected may be sent
 to the user by writing to standard error.
-- 
1.9.1
