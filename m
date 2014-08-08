From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH v2 2/7] Documentation: git-init: list items facelift
Date: Fri,  8 Aug 2014 10:29:15 -0700
Message-ID: <1407518960-6203-3-git-send-email-linusarver@gmail.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
 <1407518960-6203-1-git-send-email-linusarver@gmail.com>
Cc: Steven Drake <sdrake@xnet.co.nz>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Linus Arver <linusarver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 19:30:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnzy-0002iO-8w
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 19:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbaHHRad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 13:30:33 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:41084 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaHHRab (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 13:30:31 -0400
Received: by mail-yh0-f53.google.com with SMTP id c41so4324259yho.12
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 10:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hEtnMvC7jenfX09cmQYLcYxASpB7mrVbNTGrDEsP/VU=;
        b=WOAmmS1QphCHNA0aPBSDfQaW/JUWU5Gte3F8xzhsqmR5bofaG8o2sV71oOjuL3u/pI
         j/U3xrry4Lzo5095uvJK/wV1dKo2CQXgvY7/h9J6yIozntKt8WOt0Ywctk8HDHRbYK20
         mHatGza7vAcN8tnLHb8HsKF15VA77qq3Erj3i91ve5x+OmUKd4POMvCmSxjPCUeiLRqb
         /dI2hkDL6ket9/EqMEvjDPbOUgk6Z9oPj+RjR68NKvDIMiq6OLbiC/86pETw758i8uIQ
         o8R0EuvYw039I/UGaAhaUXI60CYKPYKUEO+Cp+4+HHncNTERVtDt6eg6+JIxJ8/sme8g
         PIIg==
X-Received: by 10.236.142.227 with SMTP id i63mr16316200yhj.88.1407519031023;
        Fri, 08 Aug 2014 10:30:31 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id u47sm6776458yhm.35.2014.08.08.10.30.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 10:30:30 -0700 (PDT)
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1407518960-6203-1-git-send-email-linusarver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255052>

No textual change.

Signed-off-by: Linus Arver <linusarver@gmail.com>
---
 Documentation/git-init.txt | 49 ++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index f1f920e..c02ccd0 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -72,30 +72,37 @@ repository.  When specified, the config variable "core.sharedRepository" is
 set so that files and directories under `$GIT_DIR` are created with the
 requested permissions.  When not specified, Git will use permissions reported
 by umask(2).
-
++
 The option can have the following values, defaulting to 'group' if no value
 is given:
++
+--
+'umask' (or 'false')::
+
+Use permissions reported by umask(2). The default, when `--shared` is not
+specified.
+
+'group' (or 'true')::
 
- - 'umask' (or 'false'): Use permissions reported by umask(2). The default,
-   when `--shared` is not specified.
-
- - 'group' (or 'true'): Make the repository group-writable, (and g+sx, since
-   the git group may be not the primary group of all users).
-   This is used to loosen the permissions of an otherwise safe umask(2) value.
-   Note that the umask still applies to the other permission bits (e.g. if
-   umask is '0022', using 'group' will not remove read privileges from other
-   (non-group) users). See '0xxx' for how to exactly specify the repository
-   permissions.
-
- - 'all' (or 'world' or 'everybody'): Same as 'group', but make the repository
-   readable by all users.
-
- - '0xxx': '0xxx' is an octal number and each file will have mode '0xxx'.
-   '0xxx' will override users' umask(2) value (and not only loosen permissions
-   as 'group' and 'all' does). '0640' will create a repository which is
-   group-readable, but not group-writable or accessible to others. '0660' will
-   create a repo that is readable and writable to the current user and group,
-   but inaccessible to others.
+Make the repository group-writable, (and g+sx, since the git group may be not
+the primary group of all users). This is used to loosen the permissions of an
+otherwise safe umask(2) value. Note that the umask still applies to the other
+permission bits (e.g. if umask is '0022', using 'group' will not remove read
+privileges from other (non-group) users). See '0xxx' for how to exactly specify
+the repository permissions.
+
+'all' (or 'world' or 'everybody')::
+
+Same as 'group', but make the repository readable by all users.
+
+'0xxx'::
+
+'0xxx' is an octal number and each file will have mode '0xxx'. '0xxx' will
+override users' umask(2) value (and not only loosen permissions as 'group' and
+'all' does). '0640' will create a repository which is group-readable, but not
+group-writable or accessible to others. '0660' will create a repo that is
+readable and writable to the current user and group, but inaccessible to others.
+--
 
 By default, the configuration flag `receive.denyNonFastForwards` is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
-- 
2.0.4
