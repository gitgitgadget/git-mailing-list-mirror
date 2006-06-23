From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH 1/5] git-merge: Don't use -p when outputting summary
Date: Sat, 24 Jun 2006 00:45:40 +0300
Message-ID: <20060624004540.3a6705e1.tihirvon@gmail.com>
References: <20060624003315.804a1796.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 00:17:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FttxS-0004Mf-CT
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 00:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbWFWWQz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 18:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbWFWWQz
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 18:16:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:45557 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752119AbWFWWQy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 18:16:54 -0400
Received: by nf-out-0910.google.com with SMTP id m19so277746nfc
        for <git@vger.kernel.org>; Fri, 23 Jun 2006 15:16:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=M7H5m4zGq+65wC3nvgtmc2EmKgl0hpeXfnSbVUAiFvwBhNRcsiwYFJEV0p62CVsYa++gZmY7h+ycpXuinEUXF+BxYL8AvuSwU+9dEJBnkzLlqGtJBePulowzG4xDMb7zBPY9+4YkMTyyGPjPxeuZh6g2THcKW6wUuHPtO6evh2E=
Received: by 10.48.255.5 with SMTP id c5mr1393797nfi;
        Fri, 23 Jun 2006 15:16:53 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id g1sm3393424nfe.2006.06.23.15.16.52;
        Fri, 23 Jun 2006 15:16:53 -0700 (PDT)
To: junkio@cox.net
In-Reply-To: <20060624003315.804a1796.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22442>

-p is not needed and we only want diffstat and summary.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 git-merge.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index af1f25b..da5657e 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -55,7 +55,7 @@ finish () {
 
 	case "$no_summary" in
 	'')
-		git-diff-tree -p --stat --summary -M "$head" "$1"
+		git-diff-tree --stat --summary -M "$head" "$1"
 		;;
 	esac
 }
-- 
1.4.1.rc1.gf603-dirty
