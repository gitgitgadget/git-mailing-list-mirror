From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/3] Fix resolvable rename + D/F conflict testcases
Date: Mon,  6 Sep 2010 14:47:47 -0600
Message-ID: <1283806070-22027-1-git-send-email-newren@gmail.com>
References: <AANLkTimz8qSwefp137-D+vEbsf6soG51u0im9EC911_O@mail.gmail.com>
Cc: gitster@pobox.com, oinksocket@letterboxes.org,
	ken.schalk@intel.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 22:46:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsiaL-00008F-Gc
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 22:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab0IFUqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 16:46:30 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:47857 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088Ab0IFUq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 16:46:28 -0400
Received: by pxi10 with SMTP id 10so1101130pxi.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JtnTS1g7gWjoucwboAu/x4dCOknS6w5XyEWFTdsJKBg=;
        b=F+EpTdEdHmL+cajS8cYMbVZ9Ki3psWA3FWED3B+LUzV1qhriADOovBRo5D1w1eh0pF
         BHJanRyEs/dE33COUuUIpu9i5F4uml7o/RTYD0w5Ry7UWJICXvdf4A5nWJJuhlOLwW7W
         /9AlAxbB7vX60we2da9nn/+VP+Rid6KZWmwZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MTfSa/zZL7hGoArXROD4oDBeKpLdMWlT8eTsalNvyCa1brPNsvDokC/Wv3bHS3H6K0
         3YIZaRuxLWUsDsrzsddL0pzuyJRJGX9CuKuYt/k2Jc/+grnjVlGUzkw3MXqIRLuU2LKj
         Q2PDiNF+LEpfzeB1fJCDqtqivIgFRX9rHFAdQ=
Received: by 10.114.15.11 with SMTP id 11mr2063089wao.121.1283805988148;
        Mon, 06 Sep 2010 13:46:28 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d39sm11973876wam.4.2010.09.06.13.46.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 13:46:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc0.170.g5cfb0.dirty
In-Reply-To: <AANLkTimz8qSwefp137-D+vEbsf6soG51u0im9EC911_O@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155615>

This fixes an issue reported by Nick, as well as a closely related
issue in the handling of rename + directory/file conflicts,
particularly where a file on one side of the rename is a directory
name on the other side of the merge.

Elijah Newren (3):
  t3509: Add rename + D/F conflict testcases that recursive strategy
    fails
  merge-recursive: Small code cleanup
  merge-recursive: D/F conflicts where was_a_dir/file -> was_a_dir

 merge-recursive.c               |   50 ++++++++++++++++-------------
 t/t3509-cherry-pick-merge-df.sh |   66 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 22 deletions(-)

-- 
1.7.3.rc0.170.g5cfb0.dirty
