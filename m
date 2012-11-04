From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] New remote-bzr remote helper
Date: Sun,  4 Nov 2012 03:22:00 +0100
Message-ID: <1351995723-20396-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:22:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpr5-0000bs-8M
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311Ab2KDCWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:22:15 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45078 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab2KDCWO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:22:14 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1658012bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=aASCrfnaLxd45hUI0pTkrG8CoVambUkH9IPUhMr4dgY=;
        b=avNDyHSdiVgnKvKBwYEVKq1iv7pBGvDO/TedjitkSEtLYYpYZ1W0I5OiymKKNH9Kbv
         vYjxcwuj+V3sW4d+FmQlWPr+3SLnR5vr6pH3fEl2+W2iJGvPrULVUshvKj9f0P6X4K+z
         bsYKDAxwPv7rSnYOovjF3pEuIKu9P1ZGy8lc9/c0EXJVZWKGjvIqxVjxDqNuA4fIyuat
         bEmLn23PIt4LIy+mH4FHx+B/PVxji3RhnRhAp9nojkeVos0XHXNzL5n+ZOSOxJdoyGEO
         CkRRsyRUmbG2tITKdWNsSQzu8GUPG5LFd0AF69HcGzaXSX7xVYqU3QI7kgFcipFYirE3
         UQcg==
Received: by 10.205.122.1 with SMTP id ge1mr1380754bkc.110.1351995732291;
        Sat, 03 Nov 2012 19:22:12 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id e3sm7944038bks.7.2012.11.03.19.22.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:22:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209005>

Hi,

This is a proof-of-concept remote helper for bzr, that turns out to work rather well.

It uses bzr-fastimport[1], which is what most current bzr<->git tools uses, but
the quality is not that great. After applying an important fix[2], it works
nicely, but you will get tons of verbose messages.

Eventually we might want to implement the same functionality as bzr-fastimport,
but for now this already works nicely enough.

Cheers.

[1] http://wiki.bazaar.canonical.com/BzrFastImport
[2] https://launchpadlibrarian.net/121967844/bzr-fastimport-no-graph.patch

Felipe Contreras (3):
  Add new remote-bzr transport helper
  remote-bzr: add support for pushing
  remote-bzr: add simple tests

 contrib/remote-helpers/git-remote-bzr | 221 ++++++++++++++++++++++++++++++++++
 contrib/remote-helpers/test-bzr.sh    | 111 +++++++++++++++++
 2 files changed, 332 insertions(+)
 create mode 100755 contrib/remote-helpers/git-remote-bzr
 create mode 100755 contrib/remote-helpers/test-bzr.sh

-- 
1.8.0
