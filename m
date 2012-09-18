From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 1/4] rebase usage: subcommands can not be combined with -i
Date: Mon, 17 Sep 2012 21:28:07 -0400
Message-ID: <1347931690-20625-2-git-send-email-andrew.kw.w@gmail.com>
References: <CANiSa6j2zA5P6yDaR7VU416Bzes6xbWuHbU83=BGN67Wo9j_Cw@mail.gmail.com>
 <1347931690-20625-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 04:29:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDnZS-0002lx-MT
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 04:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325Ab2IRC3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 22:29:35 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59766 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab2IRC3e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 22:29:34 -0400
Received: by yenm15 with SMTP id m15so879156yen.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 19:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mk7JCXIkGYXvcXvot8B/chLSMPoMJhJeefp10H0ZNno=;
        b=eDRIJWij8+x2SQ9ivI87jEGXxWPA4K8sSKpV5ipAKl6MPfRU8vpOF4LmI910X563rM
         rXitFdy871KTIKuqJMzn+hGpdil6gC1841BmucvBoEJZcyCXV+mnauoFwLxHiyq71112
         jb0l4mVrsIdcbedJXQHFXsh85Iq+4ScZPqR2GVzGcWYxEM7sLtzHi0BMl3ORYpaLQ8ZP
         uDuzSKbZrJTNx4psideQW+lqC3J4OOOaAAjDoIH8iCGQxP3JLWZent+0haaf98jTreNj
         iqF8fkD715+qb2XmXemIM+mr8vUvcLr3RVr3OKiOKrJycKJhddS0HHhptM7CwYObULes
         CGXg==
Received: by 10.101.67.2 with SMTP id u2mr4278178ank.59.1347935373475;
        Mon, 17 Sep 2012 19:29:33 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id s12sm11226868anh.2.2012.09.17.19.29.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 19:29:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.318.g79683ba.dirty
In-Reply-To: <1347931690-20625-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205780>

From: Martin von Zweigbergk <martinvonz@gmail.com>

Since 95135b0 (rebase: stricter check of standalone sub command,
2011-02-06), git-rebase has not allowed to use -i together with e.g.
--continue. Yet, when rebase started using OPTIONS_SPEC in 45e2acf
(rebase: define options in OPTIONS_SPEC, 2011-02-28), the usage message
included

	git-rebase [-i] --continue | --abort | --skip

Remove the "[-i]" from this line.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 15da926..e6b43a2 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -8,7 +8,7 @@ OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
-git-rebase [-i] --continue | --abort | --skip
+git-rebase --continue | --abort | --skip
 --
  Available options are
 v,verbose!         display a diffstat of what changed upstream
-- 
1.7.12.318.g79683ba.dirty
