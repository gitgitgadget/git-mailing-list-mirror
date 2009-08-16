From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 0/3] git-gui: more robust handling of fancy repos
Date: Mon, 17 Aug 2009 01:58:45 +0200
Message-ID: <1250467128-29839-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 01:59:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcpcx-0006us-3H
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 01:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbZHPX65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 19:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752379AbZHPX65
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 19:58:57 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:39915 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbZHPX64 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 19:58:56 -0400
Received: by fxm11 with SMTP id 11so2023084fxm.39
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 16:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=nfmNhKk0s6foo0/ivXJJ1qGRJAnQ4a+Cv+kpJQE0xG8=;
        b=lTahsTO6la7Vsn9VP1zuMRAXnsdNsMuqNsedethgZHRYT83Cd/9qkjVREzxXzQMzct
         xC+z7eQZSqEQ7/8k+YG5MwqsYTSsVC8dfa9PcvRVrhKQqCL9UWBCny8/uOc/9qXOnbhu
         oBvSbYigI57s+BGHrPMOP26WCQ/beu2eOdr9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=i65HsgyTxVtxPzZWCBxvvN+QD8LZI/IoAkBaXTcdAce53+Kx+xDnqx/CE1uvKHDDN2
         pVL4BBensbDeiyDNy+B3ycuKZihcKpAO+xOjFve/dFYTEySZ9Q35XWCfo2yeqP4F64jd
         NqNtA+WpCzKf5Vi1pZpDbr73Z71GYNnoZKPo4=
Received: by 10.103.212.9 with SMTP id o9mr1080559muq.135.1250467137167;
        Sun, 16 Aug 2009 16:58:57 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-24-143.clienti.tiscali.it [94.37.24.143])
        by mx.google.com with ESMTPS id j2sm16271171mue.50.2009.08.16.16.58.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Aug 2009 16:58:56 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.177.g695987
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126096>

As promised a long time ago (March 30), version 3 of the small patchset
to improve handling of repositories in git gui. The most significant
change is the addition of the third patch.

The first patch allows git gui to work with respotiories for which
the worktree is not the parent of the gitdir.

The second patch refactors bare repository detection, improves the error
message if the bare support feature is disabled, and disabled
inapplicable menu entries.

The third patch allows git-gui to work properly when launched from the
.git directory itself, solving the issue Markus Heidelberg was having in
http://thread.gmane.org/gmane.comp.version-control.git/115044

Giuseppe Bilotta (3):
  git-gui: handle non-standard worktree locations
  git-gui: handle bare repos correctly
  git-gui: work from the .git dir

 git-gui/git-gui.sh |   88 +++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 73 insertions(+), 15 deletions(-)
