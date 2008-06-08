From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] t1006-cat-file.sh: typo
Date: Mon,  9 Jun 2008 01:03:13 +0200
Message-ID: <1212966193-27969-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 01:04:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Tvq-0004Dq-Mg
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 01:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbYFHXDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 19:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755424AbYFHXDW
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 19:03:22 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:27703 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386AbYFHXDV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 19:03:21 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1338039mue.1
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 16:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:from;
        bh=pUln3NY2oJoUIdxdBs3gYwrt6G1Z07dTgbu8bvmVuaM=;
        b=Ys56bUNPAe6lOlY1I5yemQUejIaCXZsteDXIBsy8fvaR2rECSB5Wk3W1exxkUM/8Vw
         Meir6MrTMa0kPqa3ZiLqqSPN+o1MjInFLB9AnnDD0Btq1vMQTRRC1rObDpIHNt4wID6k
         tG0ZGAkLxS26+BB7c6jPhmZUn4Epn38z2ETvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=VFgWJu8N89wS4cxMkjma07cte5FPzi7AE9FGzw7unnXd/lpviGqI8yoyzskhMu7g9/
         ZmYgMWCT9H6EdzFkdJUazobW7+LIB8MpTpHRSemJn2CBT8hvwBqqoiQTNvla6C+e02RK
         9mpDGVx5gjhG6LxNoxcarvNddrFkDuUefI3hk=
Received: by 10.102.228.10 with SMTP id a10mr1866135muh.109.1212966197661;
        Sun, 08 Jun 2008 16:03:17 -0700 (PDT)
Received: from fly ( [91.33.232.240])
        by mx.google.com with ESMTPS id y2sm39196323mug.1.2008.06.08.16.03.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Jun 2008 16:03:17 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K5Tus-0007Hb-86; Mon, 09 Jun 2008 01:03:14 +0200
X-Mailer: git-send-email 1.5.6.rc1.19.gec491.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84339>

Previously timestamps were removed unconditionally (though this didn't
seem to break this test).  Now they are only removed if $no_ts is
non-empty.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
The no_ts feature doesn't seem to be particularly important (it still
works if you switch it always on), but for now I'll just fix it so
that it does what the author apparently intended.

 t/t1006-cat-file.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index cb1fbe5..973aef7 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -74,7 +74,7 @@ $content"
     test -z "$content" ||
     test_expect_success "--batch output of $type is correct" '
 	expect="$(maybe_remove_timestamp "$batch_output" $no_ts)"
-	actual="$(maybe_remove_timestamp "$(echo $sha1 | git cat-file --batch)" no_ts)"
+	actual="$(maybe_remove_timestamp "$(echo $sha1 | git cat-file --batch)" $no_ts)"
         if test "z$expect" = "z$actual"
 	then
 		: happy
-- 
1.5.6.rc1.19.gec491.dirty
