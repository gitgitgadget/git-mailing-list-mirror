From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH] Modify description file to say what this file is
Date: Tue, 17 Feb 2009 08:49:48 +0000
Message-ID: <43d8ce650902170049u558ff0dasf95ba32087c9f13a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 09:51:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZLfh-0001mD-NL
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 09:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbZBQItv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 03:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbZBQItu
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 03:49:50 -0500
Received: from mail-gx0-f222.google.com ([209.85.217.222]:50804 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbZBQItu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 03:49:50 -0500
Received: by gxk22 with SMTP id 22so3890440gxk.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 00:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=rTzizSETUAwkg0gbPhM5w+91TVy0DlraE3FIDfRpqy8=;
        b=cmULdVQ6qczcAEpHZzsnkSxptF1b7yBd5DU2Wo4xUsKWsf2/V2lkAUqXhmKFsOcaoW
         y1EJmmB2b99nBrxcjhvukD9OoW0tail23RS6ZMSFX1z7QegC8ZQ+qTNZ5CRP/0rpwhII
         uadqkSB4zA4PO5Qp/7f1lZ75G1i2+C/QEfjos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=aXxMV5VO8RbMbHoqkG3jaIX9v5N8Bt7vNnhKXiNwr9KypRWMETInjWzaI/HOxwh6VT
         ayJIAF8bGc2impznxEkErgH2nZ68OY6C/mZTho2BbpD8Wfjyo4rx0oJokux3+nrQPwXO
         m3VmzVcg+ABs2VzseouOnU0tppuxW8vs1XE/Q=
Received: by 10.150.143.5 with SMTP id q5mr4100368ybd.17.1234860588581; Tue, 
	17 Feb 2009 00:49:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110336>

Hi all,
  I'm new to git development, and want to make a series of commits to
make git a bit easier to use.  This is my first patch, to see how it
goes :-)

>From 60bf1fd524410479fbc30eb67d32689c1297892e Mon Sep 17 00:00:00 2001
From: John Tapsell <johnflux@gmail.com>
Date: Tue, 17 Feb 2009 08:26:28 +0000
Subject: [PATCH] Modify description file to say what this file is

A lot of people see this message for the first time on the gitweb
interface, where there is no clue as to what 'this file' means.

Signed-off-by: John Tapsell <johnflux@gmail.com>
---
 templates/hooks--update.sample |    5 +++--
 templates/this--description    |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index 93c6055..f753d28 100755
--- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -43,10 +43,11 @@ allowdeletetag=$(git config --bool hooks.allowdeletetag)

 # check for no description
 projectdesc=$(sed -e '1q' "$GIT_DIR/description")
-if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit
this file to name it for gitweb." ]; then
+case $projectdesc in "Unnamed repository;"*|'')
 	echo "*** Project description file hasn't been set" >&2
 	exit 1
-fi
+	;;
+esac

 # --- Check types
 # if $newrev is 0000...0000, it's a commit to delete a ref.
diff --git a/templates/this--description b/templates/this--description
index c6f25e8..914a64e 100644
--- a/templates/this--description
+++ b/templates/this--description
@@ -1 +1 @@
-Unnamed repository; edit this file to name it for gitweb.
+Unnamed repository; edit the .git/description file to name it for gitweb.
-- 
1.6.2.rc1
