From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 0/3] Easier access to index-v4
Date: Sun, 23 Feb 2014 21:49:56 +0100
Message-ID: <1393188599-5391-1-git-send-email-t.gummerer@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, sunshine@sunshineco.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 23 21:50:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHfzx-0007Oh-Gx
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 21:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbaBWUuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 15:50:00 -0500
Received: from mail-la0-f44.google.com ([209.85.215.44]:48776 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbaBWUt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 15:49:59 -0500
Received: by mail-la0-f44.google.com with SMTP id hr13so1652518lab.3
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 12:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=y4hbxB8iHgjw0ngbdNR31qrvrRFQRMVaukjgRDYpYBc=;
        b=zO5zRvTIH+pBrVNmIq9XeAOIHbIMNvlVRV5BkyhlOegy3m8my6nFvi+efoDreAt9IK
         em9W61smo3xRaMV0jaKTLfCn2EKnVhAQfjX1Luckb+J/NO+5NTXqL74Mml2vBKEiS6bx
         6/z+0X+DEm7KxVttgd9ZHOUrMVaMgIxVs/QFQns2xmu2Qu5vx8yMx1RxEKe9h87p/5uU
         mTChyoobCeS9V0ZMHiMdZDtTJDeVnNCmhkVHowiYkMb+8XIfKzjFye1j2zaUA0MD07dC
         LOo+hUHghOHwoR8dMs53N7zCuyAMMU/I84mqQEn8GWmXOtVvts9jooCD9VRhS7/yDLbs
         gfTg==
X-Received: by 10.112.45.108 with SMTP id l12mr9594819lbm.21.1393188598018;
        Sun, 23 Feb 2014 12:49:58 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id yq2sm22195670lab.3.2014.02.23.12.49.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2014 12:49:57 -0800 (PST)
X-Mailer: git-send-email 1.9.0.1.ge0caaa8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242547>

Hi,

previous round was at $gmane/242198.

Thanks to Junio, Eric and Duy for comments on the previous round.

Since then I've squashed the fixes suggested by Junio, added a test
showing what should happen if an index file is present and
GIT_INDEX_VERSION is set and fixed the typo found by Eric.

Thomas Gummerer (3):
  introduce GIT_INDEX_VERSION environment variable
  test-lib: allow setting the index format version
  read-cache: add index.version config variable

 Documentation/config.txt              |  4 ++
 Documentation/git.txt                 |  5 +++
 Makefile                              |  7 ++++
 read-cache.c                          | 38 +++++++++++++++++-
 t/t1600-index.sh                      | 76 +++++++++++++++++++++++++++++++++++
 t/t2104-update-index-skip-worktree.sh |  2 +
 t/test-lib-functions.sh               |  5 +++
 t/test-lib.sh                         |  3 ++
 8 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100755 t/t1600-index.sh

-- 
1.9.0.1.ge0caaa8.dirty
