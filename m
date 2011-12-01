From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH/RFC 1/2] pull: pass the --no-ff-only flag through to merge, not fetch
Date: Wed, 30 Nov 2011 20:38:56 -0500
Message-ID: <1322703537-3914-1-git-send-email-naesten@gmail.com>
Cc: Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 02:40:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVvdM-0002AG-Vu
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 02:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab1LABkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 20:40:09 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:52706 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab1LABkI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 20:40:08 -0500
Received: by qao25 with SMTP id 25so986666qao.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 17:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=36hi4VDc/PBIckuW7yZEekkDAkKAH/u4L7PCOxm/UN0=;
        b=TXMWMXdXqvF2xnEuM+laCnQ27VUurdPAGSpHfE/1mwfV1wrgAW0v7hcgdqidyK1c7O
         ja2GodEwHnenM1YtBMTuAq8vJGcyGN9rv7sH+C3KVghWVJoj2VqdXTLwpuvu4KlPvtrH
         rhZCBPionfoSnQFep9yBNSGehVxvSEDz0lOzs=
Received: by 10.229.68.23 with SMTP id t23mr36651qci.104.1322703607598;
        Wed, 30 Nov 2011 17:40:07 -0800 (PST)
Received: from hydrogen (207-172-114-83.c3-0.upd-ubr1.trpr-upd.pa.cable.rcn.com. [207.172.114.83])
        by mx.google.com with ESMTPS id h9sm3935973qac.13.2011.11.30.17.40.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Nov 2011 17:40:06 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.76)
	(envelope-from <naesten@gmail.com>)
	id 1RVvd4-000163-23; Wed, 30 Nov 2011 20:40:02 -0500
X-Mailer: git-send-email 1.7.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186156>

Without this, pull becomes unusable for merging branches when the config
option `merge.ff` is set to `only`.

Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 git-pull.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 9868a0b..a09fcbc 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -76,6 +76,8 @@ do
 		no_ff=--no-ff ;;
 	--ff-only)
 		ff_only=--ff-only ;;
+	--no-ff-only)
+		ff_only=--no-ff-only ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
-- 
1.7.7.3
