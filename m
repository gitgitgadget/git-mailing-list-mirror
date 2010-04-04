From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/2] pack-protocol.txt: fix pkt-line lengths
Date: Sun,  4 Apr 2010 21:12:17 +0800
Message-ID: <1270386737-1424-2-git-send-email-rctay89@gmail.com>
References: <1270386737-1424-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 04 15:12:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyPcw-0004Nm-NM
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 15:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122Ab0DDNMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 09:12:33 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:61292 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab0DDNMa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 09:12:30 -0400
Received: by mail-qy0-f179.google.com with SMTP id 9so224129qyk.1
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 06:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jouFjTEKfSIGcfTQqDIdQj740ar+zkMfbQkZPoxB9OM=;
        b=r9E4/AvHsfefT16J+7nCMam4wljY6P6/YcBFWOnkNQ6clZ8SmkvW0XvhNLVfNwKcgC
         RfzVN2FvMX9q9IdbeT8O2fALavxBuPG/ORQtC6W1FGQXClNpoXJ3YNu4oTJU2p6zq5fW
         9d806gchtlcR4+idw1rrS1Qu7PmSlGRSj0YbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vo7Hn0W0jXB1AG4Hq/M+p4NMRolLBw4uJ6fEf7/hH0i3Rmpy1HCmFSAqbKO5U9D4Pu
         AGztmXrAHc+q3gzCjEuwtLeqoG/LAl2MYtVOQqNHCsi6Tk2bRvETbpwX7MpeVkr08mV5
         LOQdgfZ5rLu6+My8gb/GfKFntBOGOApIDkYjk=
Received: by 10.229.192.10 with SMTP id do10mr7506628qcb.48.1270386749519;
        Sun, 04 Apr 2010 06:12:29 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id w30sm3582239qce.16.2010.04.04.06.12.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Apr 2010 06:12:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1270386737-1424-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143924>

Previously, the lengths were 4-bytes short. Fix it such that the lengths
reflect the total length of the pkt-line, as per spec.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/technical/pack-protocol.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index f9468a1..369f91d 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -331,7 +331,7 @@ An incremental update (fetch) response might look like this:
 
    C: 0009done\n
 
-   S: 003aACK 74730d410fcb6603ace96f1dc55ea6196122532d\n
+   S: 0031ACK 74730d410fcb6603ace96f1dc55ea6196122532d\n
    S: [PACKFILE]
 ----
 
@@ -488,7 +488,7 @@ An example client/server communication might look like this:
    C: 0000
    C: [PACKDATA]
 
-   S: 000aunpack ok\n
-   S: 0014ok refs/heads/debug\n
-   S: 0026ng refs/heads/master non-fast-forward\n
+   S: 000eunpack ok\n
+   S: 0018ok refs/heads/debug\n
+   S: 002ang refs/heads/master non-fast-forward\n
 ----
-- 
1.7.0.20.gcb44ed
