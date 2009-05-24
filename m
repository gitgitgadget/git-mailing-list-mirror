From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 0/2] StGit patch series import
Date: Sun, 24 May 2009 09:19:16 +0200
Message-ID: <1243149558-17160-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 24 09:19:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M87zi-0005bT-I5
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 09:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbZEXHTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 03:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbZEXHT3
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 03:19:29 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:39484 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbZEXHT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 03:19:28 -0400
Received: by fxm12 with SMTP id 12so667450fxm.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 00:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=wvtkUc5UbqI0nki6Blr5M46NTQYamOL5F79u21mWakk=;
        b=Sg0W5XsnCxAGlhIAOdf5CqAlIYumd/PzP0HeMBZjDP/cbvN/EE3NA6WCE2js07pWNr
         Pztf68BYGmPHQ12JVXJkiHuk0eD+ky9do6BA0T8ftJ6ivMCnj9V52y3hbzxRdd7fnUeo
         MBuwGbg/UJU0GlwEQmCHGltLATQTCCjIErXfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=w6waC9RwdPmfjN9Zd59GOVJtJCQnXGvYHDfceYQq45+wuiKqtO6KK4+vPk0lvcYbWM
         X9e4CHRifo+IgiYDcviGE73CzB+rDLNt43jvMespCp33hU9KRx2PDRDtsTnFD+ETEDVO
         VAsBtwp0XXbQ0PlKM1tRoTexX+NfaFr5at2qE=
Received: by 10.103.189.18 with SMTP id r18mr2886473mup.80.1243149568386;
        Sun, 24 May 2009 00:19:28 -0700 (PDT)
Received: from localhost (host-78-15-2-20.cust-adsl.tiscali.it [78.15.2.20])
        by mx.google.com with ESMTPS id i5sm6636455mue.55.2009.05.24.00.19.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 00:19:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.212.g6c0d3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119811>

This small patch series implements support for Stacked Git patch
series import.

The first commit adds support for StGit patches to mailinfo, which is
required because StGit's default export template puts the From: line
between the subject and the body.

The second commit makes git-am autodetect an StGit patch series index
(when it's the only file passed to it) and proceeds to import the
patches indicated in the series.

Giuseppe Bilotta (2):
  mailinfo: handle StGit patches
  git-am: support StGit patch series

 builtin-mailinfo.c |   18 ++++++++++++++++++
 git-am.sh          |   22 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)
