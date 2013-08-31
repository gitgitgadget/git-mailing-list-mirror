From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] Reject non-ff pulls by default
Date: Sat, 31 Aug 2013 17:38:07 -0500
Message-ID: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 00:43:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFtsi-00077S-3e
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 00:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952Ab3HaWmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 18:42:53 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:41384 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3HaWmw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 18:42:52 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so3206490obb.37
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2w7hsCCa5apyeppEOfgsN+Mdj98F/YtBhF7pVICEYJk=;
        b=tNnXUETkdtwxT3tXlt7XOcUloxPpT2CFqGxouH1Ihma2AC0dzZ8TPruMOxMAmouf7N
         4VERb1YylknDBiOM8ygjOky2/RVHxeCbGO9fhSceuGS2uFHYXIbhR2uo7Y94hB6qmUa/
         rC4nS8o06X4bC72lUcDcDFA5jKc9kSPhqafdzzatBIkWade5OMY09LK5SAGNc9d6ms0f
         8XWwWBR91gTdJX4f/pPddQjJZccE2E4+xmpM8pHEdahT/VKbTRxhj+qt35L5i7GJfTqL
         byThJ9o4FzpStnKP5hAQd/G6zETUDdf4XpLUOt1qmZcw8XGAJJUDZ44ngSrCSjtFKH1n
         Ybvg==
X-Received: by 10.182.129.201 with SMTP id ny9mr11919998obb.0.1377988971134;
        Sat, 31 Aug 2013 15:42:51 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm5633234oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 31 Aug 2013 15:42:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-337-g7358a66-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233554>

Junio already sent a similar patch, but I think this is simpler.

Felipe Contreras (3):
  merge: simplify ff-only option
  t: replace pulls with merges
  pull: reject non-ff pulls by default

 Documentation/git-pull.txt             |  1 +
 builtin/merge.c                        | 20 ++++++++++----------
 git-pull.sh                            |  9 ++++++++-
 t/annotate-tests.sh                    |  2 +-
 t/t4200-rerere.sh                      |  2 +-
 t/t5500-fetch-pack.sh                  |  2 +-
 t/t5520-pull.sh                        | 33 +++++++++++++++++++++++++++++++++
 t/t5524-pull-msg.sh                    |  2 +-
 t/t5700-clone-reference.sh             |  4 ++--
 t/t6022-merge-rename.sh                | 20 ++++++++++----------
 t/t6026-merge-attr.sh                  |  2 +-
 t/t6029-merge-subtree.sh               |  4 ++--
 t/t6037-merge-ours-theirs.sh           | 10 +++++-----
 t/t7603-merge-reduce-heads.sh          |  2 +-
 t/t9114-git-svn-dcommit-merge.sh       |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh |  2 +-
 16 files changed, 79 insertions(+), 38 deletions(-)

-- 
1.8.4-337-g7358a66-dirty
