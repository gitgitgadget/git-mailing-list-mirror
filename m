From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH] Modify description file to say what this file is
Date: Tue, 17 Feb 2009 08:58:40 +0000
Message-ID: <43d8ce650902170058l7163b060x4ab89cf327395357@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 10:00:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZLoH-00049J-Vo
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 10:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbZBQI6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 03:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbZBQI6m
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 03:58:42 -0500
Received: from mail-gx0-f222.google.com ([209.85.217.222]:47289 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbZBQI6l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 03:58:41 -0500
Received: by gxk22 with SMTP id 22so3893306gxk.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 00:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=dfR6AhGU4b976i+JN8VBj3igomDgXnJqUqmAh9+DX4s=;
        b=gIYn9erA80RyyI7r53wdi9pxql6YJ4oaiESlmU6sKvArgokqoZ0ARZTDug9GhI8saW
         vaPNKuiJ4vY0XfpPuDVlJuwCoai/pFHKVWX0P+FT1kytqbTMSgXavjYC7GHNenhXawRT
         7dgMNxFv6KZkDyt+n2ifDbz1deUK/12eUHfbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=UykuNDlArAARVU3xrpWqlwmmD8EUV30QFE6vUhioNvlB1NHXjf8IBauqPfbIUucNih
         7AlaGeVAvTU2XfG4Pu17VXvs1prrHrMm68LC9adXAJH0IJePoG8xfGw6nEq6EITzfAKD
         b1cr6/ZYltmYeiVbc9lxGJ3N8iYlNeOC1Pj1s=
Received: by 10.151.8.8 with SMTP id l8mr2035962ybi.36.1234861120374; Tue, 17 
	Feb 2009 00:58:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110339>

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
