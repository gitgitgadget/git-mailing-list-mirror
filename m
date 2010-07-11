From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v1 0/4] add parent rewrite feature to line level log
Date: Sun, 11 Jul 2010 14:27:33 +0800
Message-ID: <1278829657-26607-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 08:29:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXq33-0003sS-Vg
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 08:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141Ab0GKG3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 02:29:45 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46564 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab0GKG3o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 02:29:44 -0400
Received: by pvc7 with SMTP id 7so1397241pvc.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 23:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=jaKOoUQ+E/RO9JyaVriY02AOFqfkEUN6LRO9yOtxbaw=;
        b=AacDuYyazdZA5vCQLOYTFARKAZBOihU2sxhiFvwuO8b3jgpXPRD8XGSQBFdiKzn6py
         mLQ4JNXdP+nFCls/fWzyhbcvjJfaiNaZ8iGoOluD2O21aiKEOekKAoCg1WAjIeeS0gz7
         n04hPu9Dv3cd89chhtNP7XC9thtDQr09ZboYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PrLeNPKCHWpNpFaraCb41nxphA60BliThon+GCOifVpid/qE4MrkzuwUvb0vNPcLCX
         8e2JuaLEvlFBapTwr9kZVyj9035rYOl9KVuDypau79Dn8YW4SsOzth4Hxqzsokx5Oc/5
         EH4pASMD6yijXhHWG1mrFXXDxKGxueNGG4CGM=
Received: by 10.142.178.2 with SMTP id a2mr5584441wff.142.1278829783863;
        Sat, 10 Jul 2010 23:29:43 -0700 (PDT)
Received: from localhost.localdomain ([222.35.175.242])
        by mx.google.com with ESMTPS id b19sm1874759rvf.3.2010.07.10.23.29.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 23:29:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2.18.g2bc49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150757>

With this series of patches, one can provide options such as '--graph', '--parents', '--simplify-merges' and etc to 'git log -L' command and get the right result.
Note that, this series is based on the previous series 'the version 3 of 13 commits just posted to the list'. :-)

Bo Yang (4):
  make rewrite_parents a external function
  add parent rewrite feature to line level log
  line.c output the '--graph' padding before each line
  add test cases for '--graph' of line level log

 Documentation/git-log.txt          |    2 +
 line.c                             |  177 ++++++++++++++++++++++++-----
 line.h                             |    2 +
 revision.c                         |   14 +--
 revision.h                         |   10 ++
 t/t4301-log-line-single-history.sh |  225 ++++++++++++++++++++++++++++++++++++
 t/t4302-log-line-merge-history.sh  |   51 ++++++++-
 7 files changed, 445 insertions(+), 36 deletions(-)
