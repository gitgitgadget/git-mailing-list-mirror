From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2] git-show-branch.txt: document --date-order option
Date: Sun, 31 May 2009 23:34:46 -0700
Message-ID: <1243838086-32430-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 08:35:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB17U-0003K9-KI
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 08:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbZFAGet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 02:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbZFAGet
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 02:34:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:6117 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbZFAGes (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 02:34:48 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2224661rvb.1
        for <git@vger.kernel.org>; Sun, 31 May 2009 23:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=Bp7/LVLUgEhKaVh7d6aZNfUJxSyMN0VWR1bHp4mHuWw=;
        b=GkEqM+InqaZiNoWtWjJ1zvRurjbgeNN7NBK8l+PQuL0z/XVI0iH8xG38zE6KJeHPj+
         aM7fbWNLbxXQ3uv6+y2z5VR3HN5L26Oi2Xq+uTVy+QEi2PraTbCiv5igRQ0oRQtTZcRk
         k63KuUzeLyvlANgHngSUGJlsXoet2v3Yq7XuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pdxNgQC6gTOcnMOjnNBbq7AB/q+BWRTY4Pp4tGw8AB++SuGcerAmMRXPYD06NiNXDR
         ccoC/YNDEx7FB/d+XSsHdhElFzjw/8HuFdnY7XIoFP6yEXQQ2+XzJLOXupLBA8qiXPSh
         Dm0eO4zM3oQb82TinJVKU5WFEiPDyU0YLiySU=
Received: by 10.140.172.20 with SMTP id u20mr5982222rve.244.1243838090546;
        Sun, 31 May 2009 23:34:50 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id c20sm13955079rvf.40.2009.05.31.23.34.48
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 23:34:49 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 31 May 2009 23:34:46 -0700
X-Mailer: git-send-email 1.6.3.1.244.gf9275
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120445>

Copy the description of date-order from rev-list-options.txt, and then
reword it to be commit specific. While we're at it, put <rev> <glob>...
on a new line to not exceed 80 characters.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Seems like this wasn't picked up. I also found a small typo, so it's good
that it wasn't picked up.

 Documentation/git-show-branch.txt |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index edd8f64..89ec536 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -8,10 +8,11 @@ git-show-branch - Show branches and their commits
 SYNOPSIS
 --------
 [verse]
-'git show-branch' [--all] [--remotes] [--topo-order] [--current]
+'git show-branch' [--all] [--remotes] [--topo-order | --date-order]
+		[--current] [--color | --no-color]
 		[--more=<n> | --list | --independent | --merge-base]
-		[--color | --no-color]
-		[--no-name | --sha1-name] [--topics] [<rev> | <glob>]...
+		[--no-name | --sha1-name] [--topics]
+		[<rev> | <glob>]...
 'git show-branch' (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]
 
 DESCRIPTION
@@ -58,6 +59,11 @@ OPTIONS
         appear in topological order (i.e., descendant commits
         are shown before their parents).
 
+--date-order::
+	This option is similar to '--topo-order' in the sense that no
+	parent comes before all of its children, but otherwise commits
+	are ordered according to their commit date.
+
 --sparse::
 	By default, the output omits merges that are reachable
 	from only one tip being shown.  This option makes them
-- 
1.6.3.1.244.gf9275
