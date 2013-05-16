From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 0/3] New kind of upstream branch: downstream branch
Date: Wed, 15 May 2013 22:43:45 -0500
Message-ID: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 05:45:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucp8A-0007Kk-DI
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 05:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260Ab3EPDpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 23:45:20 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:38535 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab3EPDpS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 23:45:18 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so3197036oag.18
        for <git@vger.kernel.org>; Wed, 15 May 2013 20:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=o1IQhEvyCRyztLOSBeGK3NY+U2gG3NMY98xuqNsnzok=;
        b=ifmNGrJ4OqzzVOmhT+aEkkf9LOaqzDnKNoBg7ht5gVQBX58ubrmXHjAsRgfz7l2DzS
         MG16FKUwav9uF/OuhFLCDx/DkbUkXlf5R9MSx3kClInV608DuN3mG8W5wg3lhGyedLlI
         czP0El0M+aHdokXrH10otfJn30maRCApSHt7xdyg7d7m4XUaz97xmENe1nngOclhOziX
         Rw9yDeBDBFa3HqXwIjRg/QMKE+CzgAR2vnYt3jbYixVf22P+8mtligTtepZGQuXbu5k5
         XFByKFQwl8/dUevlKUA6jZxbGUTL2bvKH4P3xybNwgAbFvVe3eo5bsPFv7MnM2DPRhXL
         dngQ==
X-Received: by 10.182.171.8 with SMTP id aq8mr18996550obc.27.1368675917659;
        Wed, 15 May 2013 20:45:17 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm6249497obb.5.2013.05.15.20.45.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 May 2013 20:45:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224471>

Hi,

After thinking a bit more about, I think the current 'upstream' branch serves
most of the purposes; actually tracks an upstream branch; makes sense to rebase
onto that, makes sense to fetch from that remote, merge, and pull.

The only job it doesn't make sense to use the 'upstream' branch for is to push,
so here's a new notion of 'downstream' branch.

These patches are only exploratory, 'git branch -v' doesn't show these
branches, there's no @{downstream}, no documentation, and there isn't even a
way to set it.

If there's no downstream branch configured, nothing changes.

Felipe Contreras (3):
  remote: don't override default if cur head remote is '.'
  pull: trivial cleanups
  push: add separate 'downstream' branch

 builtin/push.c | 65 ++++++++++++++++++++++++++++++++++++----------------------
 git-pull.sh    | 15 +++++++++-----
 remote.c       | 10 ++++++---
 remote.h       |  3 +++
 4 files changed, 61 insertions(+), 32 deletions(-)

-- 
1.8.3.rc1.579.g184e698
