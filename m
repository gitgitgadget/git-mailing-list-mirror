From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 0/3] Testing installed gitweb
Date: Sun, 26 Sep 2010 15:02:23 +0200
Message-ID: <1285506146-8009-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 26 15:11:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozr0T-0001iE-5j
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 15:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757419Ab0IZNK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 09:10:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33662 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755475Ab0IZNK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 09:10:58 -0400
Received: by bwz11 with SMTP id 11so2792344bwz.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 06:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=apQrxibF3t8pEV7zOQ5P3jGYMXBi/Mq01cRAEtzebl0=;
        b=Zh2MZL5FVxN2ulHrmMFh/CcQSFfh/qz1qcGLX9rIvZnQqoy0b/nQHKTuNBIWqWu4EL
         aLtoBqDaCRFzv9Q2lHhQAFNCjRe6IhSMitG3f6qkrpXcqXZ6lmAcFDxE48AKIXVpOVWL
         FuIF1uLJcD49NGYhaECV22CITmxoeRbRKriAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=lIwQE1XDmqszn3X9Hqi6MrPPLg0qLjnXsJl41U/1Ekn43ZMwtr7MYYyr1oGtZfxpEv
         Vfob6FDEv6/GSzcAgIlzI50arJIraw1fwj8vwqBUiu7EGwyI8EiAgm5+Ix4W9sxmgpeJ
         On1z2luKOrk4tvZY9PJMy0ywG7K1aeaoYMjpM=
Received: by 10.204.112.7 with SMTP id u7mr4236919bkp.70.1285506657461;
        Sun, 26 Sep 2010 06:10:57 -0700 (PDT)
Received: from localhost.localdomain (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id x13sm3388546bki.0.2010.09.26.06.10.53
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 06:10:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157222>

This series add a mechanism to easy test installed gitweb, via

  $ make -C gitweb test-installed

This way we can check if the install procedure work correctly, when
gitweb gets split into smaller modules.

This series applies on top of 'jn/gitweb-test-lib' branch, merged as
4621733 into next, i.e. on top of commit 89d1b5b (t/gitweb-lib.sh: Use
tabs for indent consistently, 2010-09-12).


The major change from previous version is that 'test-installed' target
no longer depends on 'install', which means that it doesn't force
installing gitweb each time it is run.


Jakub Narebski (3):
  gitweb/Makefile: Include gitweb/config.mak
  t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
  gitweb/Makefile: Add 'test' and 'test-installed' targets

 gitweb/Makefile |   12 +++++++++++-
 t/Makefile      |    4 ++++
 t/gitweb-lib.sh |   21 +++++++++++++++++++--
 3 files changed, 34 insertions(+), 3 deletions(-)

-- 
1.7.3
