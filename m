From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH] request-pull: Include newline in output
Date: Tue, 08 Feb 2011 18:35:13 -0800 (PST)
Message-ID: <4d51fd61.8937e30a.096e.0a65@mx.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 03:35:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmztr-00072S-P6
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 03:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756187Ab1BICfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 21:35:16 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56333 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160Ab1BICfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 21:35:15 -0500
Received: by wyb28 with SMTP id 28so6440396wyb.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 18:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:subject:from:to:cc;
        bh=ol1dVOnPOEdG3pFdXMGcp3Wc3LgwTwdTiIaXDJm6Wq4=;
        b=urJBWzIKd5iIQcZ2z/DNSpxX5nqXmEH1E9NGx8w1ZDlhINQRPX+XCsnWsPtWhScSIS
         zC0FclhI4n3vV0MBV0KrHBR8pIS1918dL6QgmZ5E5kGbBS/+MCSzNi2Cqe30BQlwJ2tR
         PKL2rJTipwHCcsT+bRX60aWfUAIUmPznleR2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:subject:from:to:cc;
        b=TpXTKSI/JtRHTDUjFooSgLX++H9M2GnGCIe/jQpYkLh72dAFMn4csQuPNxvxtPQiWk
         h230ZIbfkqtGUHvXPtKof6MU8Eq+Y60raHfHNtie1AXPdBrZMDnHTE/fFEHynLL6s9sm
         Lsgr35qvQBKJmgjAM6tHHlFBSZuXuMC83hU5g=
Received: by 10.227.157.79 with SMTP id a15mr3261496wbx.157.1297218914260;
        Tue, 08 Feb 2011 18:35:14 -0800 (PST)
Received: from gmail.com ([109.169.29.56])
        by mx.google.com with ESMTPS id u9sm235140wbg.18.2011.02.08.18.35.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Feb 2011 18:35:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166388>

Date: Tue, 9 Feb 2011 02:17:47 +0000
Output looked like this:

    The following changes since commit 7811d9600f02e70c9f835719c71156c967a684f7:

      pull: Document the "--[no-]recurse-submodules" options (2011-02-07 15:19:09 -0800)

    are available in the git repository at:
      git://git.kernel.org/pub/scm/git/git.git something

Now it looks like this:

    The following changes since commit 7811d9600f02e70c9f835719c71156c967a684f7:

      pull: Document the "--[no-]recurse-submodules" options (2011-02-07 15:19:09 -0800)

    are available in the git repository at:

      git://git.kernel.org/pub/scm/git/git.git something

Isn't that nice?

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-request-pull.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 6fdea39..d8e7ba3 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -70,7 +70,7 @@ git show -s --format='The following changes since commit %H:
 
   %s (%ci)
 
-are available in the git repository at:' $baserev &&
+are available in the git repository at:%n' $baserev &&
 echo "  $url $branch" &&
 echo &&
 
-- 
1.7.4.15.g7811d.dirty
