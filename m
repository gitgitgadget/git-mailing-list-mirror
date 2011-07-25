From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 0/2]  rebase -i: Some nice-to-have behaviors for "reword"
Date: Sun, 24 Jul 2011 23:38:31 -0400
Message-ID: <1311565113-5022-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 09:04:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn3aw-0006Ee-28
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 09:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab1G3HEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 03:04:05 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57751 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab1G3HED (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 03:04:03 -0400
Received: by iyb12 with SMTP id 12so4819660iyb.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 00:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=7vIxVkCaoBQVnpxVMzW9kv6yPTxwoRZC8NchdRkPD/g=;
        b=gr1BR5lT3aK9BENALPb1EY3wnlLsrQjMXGva6Gq8pD9AvEZ0sO4LjKtxSXRve7Oygz
         ttB0/T5LXvzRUrI7/mpz3DYDOPiKOdHg+qbWpVZ8nKNwUHJW8N94aDm3kUuKnJqjfqea
         MLJLZJgBrrFX0E/jqDAQ94wgr2Z/bgpPuGjMY=
Received: by 10.42.115.131 with SMTP id k3mr1625007icq.511.1312009442475;
        Sat, 30 Jul 2011 00:04:02 -0700 (PDT)
Received: from localhost.localdomain (24-246-58-202.cable.teksavvy.com [24.246.58.202])
        by mx.google.com with ESMTPS id h6sm3831145icw.19.2011.07.30.00.04.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 30 Jul 2011 00:04:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178177>

I've been using the "reword" command fairly often, and these are two small
modifications that I've always wished I could do during a "reword".  They're
more of a convenience than anything.  Hopefully they're not derailing the
original intent of "reword" too much...

1/2:
Often times when I need to reword commit, it's because the commit message was
unclear.  So when the "commit --amend" happens, I often found myself having to
do a "show HEAD" to inspect the diff to figure out what the commit was actually
doing.  This patch saves me this extra step.  Since this behavior isn't what
users might expect when they run "rebase -v", maybe I'm better off putting this
into a new flag, like "rebase --commit-verbose".  Any thoughts?

2/2:
Sometimes when I'm rewording a bunch of commits, I'd realize that I actually
want to edit the commit that I'm current rewording, like a quick fix or
something.  Or I might even want to abort the entire rebase operation
altogether.  This patch provides a way to gracefully to abort the "reword".  

Andrew Wong (2):
  rebase -i: run "commit --amend" with verbose if rebase was called
    with -v
  rebase -i: interrupt rebase when "commit --amend" failed

 git-rebase--interactive.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

-- 
1.7.2.2
