From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] t7511: avoid use of reserved filename on Windows.
Date: Mon, 31 Oct 2011 11:44:28 +0000
Message-ID: <1320061468-22500-1-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Cc: "\"msysGit" <msysgit@googlegroups.com>",
	"\"Junio C Hamano" <gitster@pobox.com>",
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: "\"Git" <git@vger.kernel.org>"
X-From: msysgit+bncCM7pyrzTCBCBlrr1BBoE1OzvgQ@googlegroups.com Mon Oct 31 12:48:51 2011
Return-path: <msysgit+bncCM7pyrzTCBCBlrr1BBoE1OzvgQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCM7pyrzTCBCBlrr1BBoE1OzvgQ@googlegroups.com>)
	id 1RKqMB-000086-BH
	for gcvm-msysgit@m.gmane.org; Mon, 31 Oct 2011 12:48:47 +0100
Received: by wyh13 with SMTP id 13sf11939312wyh.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 31 Oct 2011 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:x-cloudmark-analysis:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=hpeslWTjnbiNeY4D/505Z5KHfMYtde1zxGMqEKtSgWM=;
        b=P2KrsKHu0HsbgzzmfC9NmPxBHNEQxHiTg9Cuci4s2tpxeu0sVqVgF2y2XP+1DGCPJ6
         dAeCDJ1++J2Hoo8WwRKWROATHSBSWvWh3NbmloPuIcM2/NJ60wSTP/Dwnxor7xXiRwMx
         S5HJmiWDKcDvuGTKf/7PCwsws7dHQWdCSKQKs=
Received: by 10.216.137.201 with SMTP id y51mr464825wei.71.1320061697747;
        Mon, 31 Oct 2011 04:48:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.227.200.140 with SMTP id ew12ls14435477wbb.3.gmail; Mon, 31
 Oct 2011 04:48:16 -0700 (PDT)
Received: by 10.216.134.30 with SMTP id r30mr178365wei.4.1320061696186;
        Mon, 31 Oct 2011 04:48:16 -0700 (PDT)
Received: by 10.217.0.79 with SMTP id k57mswes;
        Mon, 31 Oct 2011 04:44:37 -0700 (PDT)
Received: by 10.227.203.7 with SMTP id fg7mr1221850wbb.4.1320061476637;
        Mon, 31 Oct 2011 04:44:36 -0700 (PDT)
Received: by 10.227.203.7 with SMTP id fg7mr1221849wbb.4.1320061476614;
        Mon, 31 Oct 2011 04:44:36 -0700 (PDT)
Received: from mtaout03-winn.ispmail.ntl.com (mtaout03-winn.ispmail.ntl.com. [81.103.221.49])
        by gmr-mx.google.com with ESMTP id fd1si9594786wbb.0.2011.10.31.04.44.36;
        Mon, 31 Oct 2011 04:44:36 -0700 (PDT)
Received-SPF: neutral (google.com: 81.103.221.49 is neither permitted nor denied by best guess record for domain of patthoyts@users.sourceforge.net) client-ip=81.103.221.49;
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111031114431.RXST15194.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Mon, 31 Oct 2011 11:44:31 +0000
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RKqI3-0007Ll-46; Mon, 31 Oct 2011 11:44:31 +0000
Received: from frog.patthoyts.tk (unknown [192.168.0.15])
	by fox.patthoyts.tk (Postfix) with ESMTP id 6D4EB207AF;
	Mon, 31 Oct 2011 11:44:30 +0000 (GMT)
X-Mailer: git-send-email 1.7.8.rc0.200.gbcc18
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=2yG2c2T6X4kA:10 a=FP58Ms26AAAA:8 a=gEJE_6Ao7LWlcozskn8A:9 a=IX78iWqc6ZER1Rl5uggA:7 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
X-Original-Sender: patthoyts@users.sourceforge.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 81.103.221.49 is neither permitted nor denied by best guess record for domain
 of patthoyts@users.sourceforge.net) smtp.mail=patthoyts@users.sourceforge.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184502>

PRN is a special filename on Windows to send data to the printer. As
this is generated during test 2 - use an alternate prefix.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 t/t7511-status-index.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7511-status-index.sh b/t/t7511-status-index.sh
index bca359d..b5fdc04 100755
--- a/t/t7511-status-index.sh
+++ b/t/t7511-status-index.sh
@@ -24,7 +24,7 @@ check() {
 
 check  1
 check  2 p
-check  3 pr
+check  3 px
 check  4 pre
 check  5 pref
 check  6 prefi
-- 
1.7.8.rc0.200.gbcc18
