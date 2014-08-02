From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH 2/7] Documentation: git-init: list items facelift
Date: Sat,  2 Aug 2014 11:06:52 -0700
Message-ID: <1407002817-29221-3-git-send-email-linusarver@gmail.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Cc: Steven Drake <sdrake@xnet.co.nz>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Linus Arver <linusarver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 20:07:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDdim-0007gz-1r
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 20:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbaHBSHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 14:07:52 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:52116 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbaHBSHv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 14:07:51 -0400
Received: by mail-yh0-f48.google.com with SMTP id i57so3348240yha.7
        for <git@vger.kernel.org>; Sat, 02 Aug 2014 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2lUDvDd6pP2Q94ajwmuyUHyyvu1hTk0fh91XNjoDURs=;
        b=tREijRW1RWgqJpupY/LZB/dNHDUjxVG2Bts0L8ALMBQKAax1HItFhTnNiJYd7YwlJC
         dfeFaah8OplKbPnRN0AvbaH1R2IMmTLIP+dWZuhiL1X4c2wpMZb3h5UIkwrVtNanGDj8
         f8DT2hhj3wJcJhWYG5loC1JGjGZsyDzi687gtGYuN6R6ZTLEKXa+uFAm1LAQmbAiIgg4
         lkdJfDVg/imo2d4zUpB04oTs4JN/eWmllOsPw8ChTUk1sFxrUFF3ExdTPBOkb+0mkskJ
         sOhDux6RZx6RZvhPTGwE3QFKvn7MfS45SIyL1odnA/znjtm62kDa80ZLL4UFN2zy3o/t
         cOXQ==
X-Received: by 10.236.120.130 with SMTP id p2mr4134148yhh.166.1407002870852;
        Sat, 02 Aug 2014 11:07:50 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id i24sm20618668yha.12.2014.08.02.11.07.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Aug 2014 11:07:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.3
In-Reply-To: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254707>

No textual change.

Signed-off-by: Linus Arver <linusarver@gmail.com>
---
 Documentation/git-init.txt | 49 ++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 5ed5859..45501d0 100644
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
 
 By default, the configuration flag 'receive.denyNonFastForwards' is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
-- 
2.0.3
