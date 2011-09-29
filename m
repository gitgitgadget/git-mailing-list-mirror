From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 0/4] port upload-archive to Windows
Date: Thu, 29 Sep 2011 22:59:19 +0200
Message-ID: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
Cc: peff@peff.net, j6t@kdbg.org, gitster@pobox.com,
	rene.scharfe@lsrfire.ath.cx
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 22:59:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Nhe-0001vN-My
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 22:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757647Ab1I2U7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 16:59:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39978 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757497Ab1I2U73 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 16:59:29 -0400
Received: by bkbzt4 with SMTP id zt4so1097794bkb.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 13:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=PFUDtcfQz1VoQ9y+TFyyLgmVnpKP5NbmqmeG5RE4/FI=;
        b=IS+YrS160Wy3Elb9pt/XgVV9xMq8+LOHh45DJVmFxtCLuMM4ZGi43jDSeoPH4fHbP4
         5pG6OCPll0pi3xVrUXiSa3lcBecDpJcb8xJYrwCf4EAXqlV8T3gLdEHv0jemMYhL8sQl
         j15O2QWeyLvxAMxQxyPo5//AsvQ+YBY6NY8EY=
Received: by 10.204.130.219 with SMTP id u27mr7593340bks.21.1317329967808;
        Thu, 29 Sep 2011 13:59:27 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no. [84.215.188.225])
        by mx.google.com with ESMTPS id ex8sm2862151bkc.2.2011.09.29.13.59.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Sep 2011 13:59:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.355.g842ba.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182434>

It's been a while, but here's another updated version of this
series.

The only change since last time is that the series has been made
compatible with Peff's "when remote, disable some features"
changes.

Erik Faye-Lund (4):
  compat/win32/sys/poll.c: upgrade from upstream
  mingw: fix compilation of poll-emulation
  enter_repo: do not modify input
  upload-archive: use start_command instead of fork

 builtin/archive.c        |    6 +++-
 builtin/upload-archive.c |   68 ++++++++++++++-------------------------------
 cache.h                  |    2 +-
 compat/mingw.h           |    2 -
 compat/win32/sys/poll.c  |   17 ++++++++---
 daemon.c                 |    4 +-
 path.c                   |   30 +++++++++-----------
 t/t5000-tar-tree.sh      |   10 +++---
 8 files changed, 60 insertions(+), 79 deletions(-)

-- 
1.7.6.355.g842ba.dirty
