From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] fast-export: simplification
Date: Sun,  1 Sep 2013 02:05:46 -0500
Message-ID: <1378019148-1565-1-git-send-email-felipe.contreras@gmail.com>
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 09:10:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG1ny-0007Gt-Ja
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 09:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073Ab3IAHKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 03:10:32 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:43688 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab3IAHKb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 03:10:31 -0400
Received: by mail-oa0-f54.google.com with SMTP id n10so3174403oag.27
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 00:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TfzjlPIDI2oX/ZOe68TbK6j5xDsZdMJu/QJ1Du7y/nU=;
        b=sQ2E+jP1M3DBMk6aU1weAdtI+jR7Vn6Jh1CbEWkImXuonc8a3tAwqE3TwntUsUqIRv
         l6n191lsV1eA1NTBuethykWVYgr0zKs5XF3Apn72IWki/gw+hHVXu3S7r572mqb4xXHb
         rB1F2iGy9ieYIylTf2MMneemGioIFS3PfBe6yPVm44we0zF+xVoBHNVJatEv2Vyx/rTZ
         kM1FOeC6j0+gh3PjHPf4P690Lx17H7WKp2jOEW9pSvA4re87HYhrChs4OE4u2l1VACMz
         14/Ew2dgXnhxRJ0sanQXoxNTuOH28QDn70+zmQLEvR1zxHSsTDzKMv0+FOtyUVpOYzOf
         1Jvw==
X-Received: by 10.60.103.146 with SMTP id fw18mr12867649oeb.32.1378019429901;
        Sun, 01 Sep 2013 00:10:29 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm7540639oep.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 00:10:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-337-g7358a66-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233567>

Hi,

No functional changes, but get_tags_and_duplicates() is quite complex as it is,
and can be simplified by spliting code into a separate function.

Felipe Contreras (2):
  fast-export: make extra_refs global
  fast-export: refactor get_tags_and_duplicates()

 builtin/fast-export.c | 87 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 40 deletions(-)

-- 
1.8.4-337-g7358a66-dirty
