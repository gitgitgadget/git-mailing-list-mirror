From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] git-cherry should show "+" instead of "-" and vice versa
Date: Mon, 23 Oct 2006 20:03:08 +0100
Message-ID: <200610232003.08861.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 23 21:08:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc590-0003Tb-Iz
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 21:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWJWTGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 15:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWJWTGI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 15:06:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:50570 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965069AbWJWTFl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 15:05:41 -0400
Received: by ug-out-1314.google.com with SMTP id q2so1476677uge
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 12:05:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:date:subject:to:x-tuid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=BpEf8AlAtedZNEpxOEpADJV2LJ6uIhUFrxyDTNoV96h1eay/29pe2AYHcqax/fYNXKWAsr8Q+JSmG3tbIxQYDG9GPRu5vnBbpkzpXIWrMBK946Q+Xalhi764py7m9UdO0I74f+t9HL5EsVjkUTSwyjBh4UZqhaSDoaKPTegAD8c=
Received: by 10.67.101.10 with SMTP id d10mr7848373ugm;
        Mon, 23 Oct 2006 12:05:40 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id a1sm470575ugf.2006.10.23.12.05.39;
        Mon, 23 Oct 2006 12:05:39 -0700 (PDT)
To: git@vger.kernel.org
X-TUID: 7e77c1ffeae94ef5
X-Length: 991
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29863>

In git-cherry.sh:

  if test -f "$patch/$2"
  then
    sign=-
  else
    sign=+
  fi

Documentation says 'If the change seems to be in the upstream, it is shown on
the standard output with prefix "+"', however the above does the reverse.  
When
the file $patch/$2 exists it is because the patch /is/ in upstream so the sign
should be "+".
Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 git-cherry.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-cherry.sh b/git-cherry.sh
index 8832573..1cc48e8 100755
--- a/git-cherry.sh
+++ b/git-cherry.sh
@@ -71,9 +71,9 @@ do
 	then
 		if test -f "$patch/$2"
 		then
-			sign=-
-		else
 			sign=+
+		else
+			sign=-
 		fi
 		case "$verbose" in
 		t)
-- 
1.4.2.3
