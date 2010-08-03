From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 0/3] *** SUBJECT HERE ***
Date: Tue,  3 Aug 2010 20:36:12 +1000
Message-ID: <1280831775-30759-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, ams@toroid.org, jon.seymour@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 03 12:37:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgEsW-0002Sh-3c
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 12:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936Ab0HCKhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 06:37:43 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42687 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767Ab0HCKhm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 06:37:42 -0400
Received: by pzk26 with SMTP id 26so1594118pzk.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 03:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=8bBQ4ZVqp3LJRaB3QLQRAE8dV7JDoPzyRga8Pi/X/zE=;
        b=U4Fifc3W7+L81xlmBQ5YFDohUYCCSQme+QKK+V78gtKpLHCn0dv7NVHv9vtkFTxcda
         7mGbD6ZXgiW1fEy5uOyBl0I3D39ufBrflNLv5SdeUEcdpAgXhYIWtXaxC8g1ceJufVlD
         GQHcrQxMb3MrCzreFWYXauzOx/l0ohKs8u6FE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wBycBNRGRZu2ePQuCe14mffwU2wYBJ8VwLN2Zrw1hh3OHkNDoiC+zMVm+UPvCo8mVL
         36GKQ5StGtOBaP8OzeRC2A4Kjt+zAD6xh9U1X8UEdcEK9BAzmmAs9SP0R7YxTTezZyQg
         BMmpXRytpBfFWEXI3iRGisy9bMDqg0bPtn1ZI=
Received: by 10.114.61.8 with SMTP id j8mr5002669waa.228.1280831862276;
        Tue, 03 Aug 2010 03:37:42 -0700 (PDT)
Received: from localhost.localdomain (r220-101-137-36.cpe.unwired.net.au [220.101.137.36])
        by mx.google.com with ESMTPS id c24sm13374316wam.19.2010.08.03.03.37.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 03:37:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.111.g8fc90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152500>

This series fixes git stash branch so that it is more tolerant of
stash-like commits created with git stash create.

It particular, it doesn't require there to be a stash stack if a
stash-like argument is specified and it doesn't attempt to drop
non-stash references after applying the stash.

This series replaces my previous patch that just included a test 
that demonstrated the existance of the issue.

  stash: It looks like a stash, but doesn't quack like a stash...
  stash: Allow git stash branch to process commits that look like
    stashes but are not stash references.
  stash: modify tests to reflect stash branch fixes.

 git-stash.sh     |   10 ++++++++--
 t/t3903-stash.sh |   28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

-- 
1.7.2.1.111.g8fc90
