From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [RFC] Add "edit" action for interactive rebase?
Date: Mon, 10 Sep 2012 12:14:42 -0400
Message-ID: <1347293683-27996-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 10 18:15:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB6dt-0004y2-L2
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758089Ab2IJQPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:15:08 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55134 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab2IJQPF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:15:05 -0400
Received: by ieje11 with SMTP id e11so3477495iej.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Vrscw74EiDQitsRjrfFNzGkCXhwzA29BgATrrqAC1VQ=;
        b=x0pXgJeob1/hyOmgvDAzjltdFTibFUJ8wwDYz97FOT6PrigkNCTLxczLmAmBY4PXxR
         CLMukcEDfp0x8mVENwgtcHvVE+hc48fY13f8s7a0RSCkpvACNMU7r/G7MuOwOKIXpL5D
         /SRHp5tH6AYSpuuZwDxE1lSO3+NsFkPb51zQ0TFG1qEnmthAgrazwGBcIjwGe5negYa9
         WAIyGZ2csef+0dv2S0a32H6iZafj9qLpKGtl9jc0iH06bBO0E/Hvpsoq34D1xRdenFZt
         80XFSNSv00AGrh5lWhdP7ZsTP+xMQW6TRBRkK/zSfi4d0e1y3NupHIVQTkJNZTQZ/CTh
         MzPQ==
Received: by 10.50.160.202 with SMTP id xm10mr11341155igb.10.1347293704540;
        Mon, 10 Sep 2012 09:15:04 -0700 (PDT)
Received: from nigel.sohovfx.com ([66.207.196.114])
        by mx.google.com with ESMTPS id ho1sm12253218igc.3.2012.09.10.09.15.02
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Sep 2012 09:15:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.289.g0ce9864.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205133>

Occasionally, while I'm in the middle of an interactive rebase, I'd change my
mind about the todo list and want to modify it.  This means manually digging
out the todo file from the rebase directory, and invoking the editor.  So I
thought it might be convenient to have an "edit" action that simply invokes the
editor on the todo file but do nothing else.

This should be safe to do in the middle of a rebase, since we don't preprocess
the todo file and generate any state from it.  I've also been manually editing
the todo file a while now, and I never ran into any issues.

I wonder if any others have ever ran into this situation, and would this be
a useful feature to have in interactive rebase? Comments?

This patch doesn't have any documentations yet. I'll add some documentations in
another patch if we decide to include this.

Andrew Wong (1):
  rebase -i: Teach "--edit" action

 git-rebase--interactive.sh |  6 ++++++
 git-rebase.sh              | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

-- 
1.7.12.289.g0ce9864.dirty
