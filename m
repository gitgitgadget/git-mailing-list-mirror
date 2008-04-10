From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] core-tutorial.txt: Fix showing the current behaviour.
Date: Thu, 10 Apr 2008 02:08:23 +0200
Message-ID: <47FD5A77.6000901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 02:09:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjkLp-000611-PP
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 02:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbYDJAI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 20:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753235AbYDJAI3
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 20:08:29 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:62304 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbYDJAI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 20:08:28 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3603408fkr.5
        for <git@vger.kernel.org>; Wed, 09 Apr 2008 17:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=2/9b3sRvtAykm5uyDdfxkCjngC4XwRcUqI+cEk3CBDM=;
        b=t7hm8qOKRHekO+amZIY8vuscWppN82SSZwsA4nDbF4WpdZL2VgJzVy+K4SJ7KFvUi1mItFqydRCNLBfm8Kct0K9BLIVOZUlv++BDXZK6K/KNc+/q2gbN1R5voLi9QUf0JIpTLvqmaH6Jk5VoDjX6fB/JqHXYZ07gPA80dmUwrVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=LHoO3YWtloO4axX3QMPpYB+JeSYL4rFVv302HQYtcbwQCG49F7hzcerQ6bKf0BLN2J49yJ7cG1hB56xooHKo9iByyMt/VElNyb0y3+rII8W0JAr4Gh4tiWAsfpf6dGGUo3oLLSxMeZWyqoHbZUF6Z1JTX7MBQmGTvAtjiUuU4mE=
Received: by 10.82.167.9 with SMTP id p9mr1224952bue.7.1207786104914;
        Wed, 09 Apr 2008 17:08:24 -0700 (PDT)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id k10sm1123267nfh.17.2008.04.09.17.08.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Apr 2008 17:08:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79160>

The --root option from "git diff-tree" won't do nothing
when is given to commands like git-whatchanged or git-log,
because those always print the initial commit by default.

This fixes the tutorial explaining the function of the
log.showroot configuration variable.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
 Documentation/core-tutorial.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index aa40dfd..5a55312 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -535,18 +535,18 @@ with the associated patches use the more complex (and much more
 powerful)

 ----------------
-$ git-whatchanged -p --root
+$ git-whatchanged -p
 ----------------

 and you will see exactly what has changed in the repository over its
 short history.

 [NOTE]
-The `\--root` flag is a flag to `git-diff-tree` to tell it to
-show the initial aka 'root' commit too. Normally you'd probably not
-want to see the initial import diff, but since the tutorial project
-was started from scratch and is so small, we use it to make the result
-a bit more interesting.
+When using the above two commands, the initial commit will be shown.
+If this is a problem because it is huge, you can hide it by setting
+the log.showroot configuration variable to false. Having this, you
+can still show it for each command just adding the `\--root` option,
+which is a flag for `git-diff-tree` accepted by both commands.

 With that, you should now be having some inkling of what git does, and
 can explore on your own.
-- 
1.5.3.4
