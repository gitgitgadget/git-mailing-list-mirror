From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/2] Documentation: git-add does not update files marked
 "assume unchanged"
Date: Sat, 1 May 2010 11:27:20 +0200
Message-ID: <20100501092720.GB15941@localhost>
References: <20100501092512.GA15941@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 11:27:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O88z0-0003Tq-RC
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 11:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774Ab0EAJ12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 05:27:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:31055 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab0EAJ11 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 05:27:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so221833fgg.1
        for <git@vger.kernel.org>; Sat, 01 May 2010 02:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=E03QJzBjsohw97bFLVlhcLsAlU62qf7AluzKaOfyFGA=;
        b=rXgRYKhAm8MjReBy9S6iazkIsz39do5bM+0eoTqVAbntNXDwVyWbBHXAegEglqBeAQ
         Hy6Tny7Qomzp/NsZ8mn5XlpisJk4D6udLzFJDsBT7zM3ZrfUylh9Ei1LHuqbPGXi8Q2b
         aVbkY5DbJSi5NEX6dY/yJ5woiaUo1BciPFg5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=sI9x5ip5b0MfVJof9z0i6iEwiwtDmCFrdJlO4bPj0QVK/FNaddtqRilgZxURHbJ5MP
         WfOhuwtToDggohKzsfUYoP4hq9jNf+NCBdNM+stdyhgmaklSTvsqmxwBqgGaO+xDmYCJ
         D+9ywNKygnaslZkUrpHIBm5okcMP/sY1dRyzo=
Received: by 10.87.76.7 with SMTP id d7mr5879336fgl.65.1272706044721;
        Sat, 01 May 2010 02:27:24 -0700 (PDT)
Received: from darc.lan (p549A6756.dip.t-dialin.net [84.154.103.86])
        by mx.google.com with ESMTPS id 3sm1117406fge.15.2010.05.01.02.27.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 May 2010 02:27:23 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1O88ym-0008AJ-PM; Sat, 01 May 2010 11:27:20 +0200
Content-Disposition: inline
In-Reply-To: <20100501092512.GA15941@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146081>


Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Behavior of git-add also changed since commit 1dcafcc0, but I actually
prefer it this way.

 Documentation/git-update-index.txt |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 68dc187..2d45774 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -93,8 +93,6 @@ OPTIONS
 This option can be also used as a coarse file-level mechanism
 to ignore uncommitted changes in tracked files (akin to what
 `.gitignore` does for untracked files).
-You should remember that an explicit 'git add' operation will
-still cause the file to be refreshed from the working tree.
 Git will fail (gracefully) in case it needs to modify this file
 in the index e.g. when merging in a commit;
 thus, in case the assumed-untracked file is changed upstream,
@@ -102,7 +100,8 @@ you will need to handle the situation manually.
 
 --really-refresh::
 	Like '--refresh', but checks stat information unconditionally,
-	without regard to the "assume unchanged" setting.
+	without regard to the "assume unchanged" setting. The "assume
+	unchanged" bit is unset for all paths.
 
 --skip-worktree::
 --no-skip-worktree::
-- 
1.7.0.5.3.ga76e
