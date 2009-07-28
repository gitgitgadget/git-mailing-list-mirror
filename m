From: Saikiran Madugula <hummerbliss@gmail.com>
Subject: [PATCH] Documentation: Fix build failure of docs.
Date: Tue, 28 Jul 2009 16:38:49 +0100
Message-ID: <4A6F1B89.9080202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Saikiran Madugula <hummerbliss@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 17:39:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVolZ-0004jE-39
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 17:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbZG1Pix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 11:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753515AbZG1Piw
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 11:38:52 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:54739 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbZG1Piw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 11:38:52 -0400
Received: by ey-out-2122.google.com with SMTP id 9so33755eyd.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=2DODJd9U9+HWlwlT5sgwRvVZUzc7jPT7Wt1rIjSShBo=;
        b=iDz/yUiq9YAu4bXPrAl6J0lbOyej0A4RINSFszdQX1OQdbOlscI9F75h9AqlJy7bNy
         RxLdI9UkQtTTyBxK8JWnoPAPCUmJa42jnj97+RZ6KXYxQxEQayEfpK3drBgczUTBma9X
         jcH0acJc11qwan5NF7qP8zO9OFZq6wUt+niGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=vM1NFolGZ/A8d+wuBiutzLfxeW4N4GZU2aGawuT/NvXXXLWW8MPyyZC5z1D+wZOEpe
         gAcrXht2gMZedAOTOHgvHtyS5ALN3bzqeMDnA7Zpo03R/H/UFPgpMpCgdhlQXqoXArQZ
         vmUc4t1XxsH9pGQ4dz5KqWpI40HJw1uOGpNNg=
Received: by 10.211.179.6 with SMTP id g6mr10163442ebp.32.1248795531601;
        Tue, 28 Jul 2009 08:38:51 -0700 (PDT)
Received: from ?10.0.11.140? ([85.118.31.194])
        by mx.google.com with ESMTPS id 7sm92121eyb.2.2009.07.28.08.38.50
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 08:38:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124258>

This patch fixes the build failure due to what seems to be extraneous
characters, "+++" in the git-filter-branch.txt file.

$make man

...

ASCIIDOC git-filter-branch.xml
    XMLTO git-filter-branch.1
xmlto: input does not validate (status 1)
/home/bobthe/git.kernel.org/git/Documentation/git-filter-branch.xml:435:
parser error : PCDATA invalid Char value 7
Clone it with <literal>git clone +++0+++</literal>.  The clone
                                    ^
/home/bobthe/git.kernel.org/git/Documentation/git-filter-branch.xml:435:
parser error : PCDATA invalid Char value 7
Clone it with <literal>git clone +++0+++</literal>.  The clone
                                      ^
make[1]: *** [git-filter-branch.1] Error 1
make[1]: Leaving directory
`/home/bobthe/git.kernel.org/git/Documentation'
make: *** [man] Error 2

...

Signed-off-by: Saikiran Madugula <hummerbliss@gmail.com>
---
 Documentation/git-filter-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index ab527b5..8a261c7 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -364,7 +364,7 @@ objects until you tell it to.  First make sure that:
 Then there are two ways to get a smaller repository.  A safer way is
 to clone, that keeps your original intact.
 
-* Clone it with `git clone +++file:///path/to/repo+++`.  The clone
+* Clone it with `git clone file:///path/to/repo`.  The clone
   will not have the removed objects.  See linkgit:git-clone[1].  (Note
   that cloning with a plain path just hardlinks everything!)
 
-- 
1.5.6.3
