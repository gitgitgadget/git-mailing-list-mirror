From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH 0/2 v4] worktree: for_each_worktree and list
Date: Thu, 13 Aug 2015 14:32:17 -0400
Message-ID: <1439490739-9361-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Thu Aug 13 20:32:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxJ7-0002Xc-Fw
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 20:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbbHMSct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 14:32:49 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34490 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbbHMScs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 14:32:48 -0400
Received: by iodb91 with SMTP id b91so61088654iod.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rnTROj4JyDFA1SpHUnv5kfOC8235XPThEhjNyCgY84A=;
        b=Hwwq7cONSSbjOfRLOt25rXoVQaG9fBGykjFFpyyeRGtDUTaJlzuO7YNRU4H+Aw9RvM
         xlX69MFPl2OBgqyEkrj25muNi0RFWHz8FJvAYyM43hmtVbkKVz00XLD1SM9xvWL9V2br
         38AOzqMeP3MgS3O+DuGO+/9+YhMOrlz+j4wVdmb4FYwOr8ZJbzCG9ybAmlyqOSNnRY1Z
         rPbK1ihNWQX1dhgLkKi2A65D3E/m6G0WBx5xVGmagP/y2WpDr8Mz35RrRWdcLAi/G6T+
         nWTlVMfC4sh9fG2DXe8bIzhBewFum6Hj5hBWwn8o8TB+T2b5uwzDIGn4gfVMl7DXYhtj
         Cl4w==
X-Received: by 10.107.148.8 with SMTP id w8mr47509636iod.116.1439490767973;
        Thu, 13 Aug 2015 11:32:47 -0700 (PDT)
Received: from localhost.localdomain (114.sub-70-199-83.myvzw.com. [70.199.83.114])
        by smtp.gmail.com with ESMTPSA id g12sm2038690ioe.28.2015.08.13.11.32.44
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Aug 2015 11:32:46 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275871>

This patch series adds a for_each_worktree function and then uses it to implement 
the `git worktree list` command.

Differences from [v3](http://www.mail-archive.com/git@vger.kernel.org/msg75599.html)
  - create the for_each_worktree function
  - uses the function in the list
  - a bare repo is NOT included in the iterated worktrees


Michael Rappazzo (2):
  worktree: add 'for_each_worktree' function
  worktree: add 'list' command

 Documentation/git-worktree.txt |  11 +++-
 builtin/worktree.c             | 139 +++++++++++++++++++++++++++++++++++++++++
 t/t2027-worktree-list.sh       |  51 +++++++++++++++
 3 files changed, 200 insertions(+), 1 deletion(-)
 create mode 100755 t/t2027-worktree-list.sh

-- 
2.5.0
