From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH 0/7] build system: support automatic reconfiguration for autotools user
Date: Thu, 19 Jul 2012 00:34:55 +0200
Message-ID: <cover.1342649928.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 00:35:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srcq5-00056I-Md
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 00:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813Ab2GRWfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 18:35:20 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63398 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab2GRWfT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 18:35:19 -0400
Received: by wgbdr13 with SMTP id dr13so1790594wgb.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=gRc2dc9Bx23xbh/FRAXc2GomRM+A7gYOIBMimqbRWVg=;
        b=TS8iWbg9LlpzjG5K1aG6Ko2/Qe8pyk0xrLQxV+H+J7ZNKU0bl1f5/94IGt/3dhGPCl
         Ctc/Js0AKlP2hn56FRp/UQh73AUu9j810+9npmbTH8Aj6vndxjKpUcdeCNVEPjWeah/E
         WLr9t+rnR1R10S61NGjyvJ/tbM4+AfqOxltSL/8x+pHhSDGytFNWlpaTaf6QWLadDb35
         rbJLD5188sFnXieJwhvaQ4K1yiJVyvyDTUCy85/q4oPlgTWdSaos1QE/RjxvaeHnh9gc
         jivNBJx//Li1wWlTb7wCGyEk03124xNHqH2N4LQy4zaUXAbjHX8AcKsTfyNNJjY0jT0F
         AMvg==
Received: by 10.216.68.18 with SMTP id k18mr1583775wed.74.1342650917937;
        Wed, 18 Jul 2012 15:35:17 -0700 (PDT)
Received: from localhost.localdomain (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id el6sm35011908wib.8.2012.07.18.15.35.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Jul 2012 15:35:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.1067.g553d16e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201698>

This series aims at improving the user experience for those people who
(like me) use that Autotools-based interface to the build system of Git.

The two actual improvements (equipped with proper explanations and
rationales) are implemented in the last two patches.  The other five
patches are just preparatory changes.

The series as general or as clean as it could actually be, but it's
enough to scratch the itch that motivated me to write it.

Thanks,
  Stefano

Stefano Lattarini (7):
  autoconf: GIT_CONF_APPEND_LINE: change signature
  autoconf: GIT_CONF_APPEND_LINE -> GIT_CONF_SUBST
  autoconf: remove some redundant shell indirections
  autoconf: remove few redundant semicolons
  autoconf: use AC_CONFIG_COMMANDS instead of ad-hoc 'config.mak.append'
  build: "make clean" should not remove configure-generated files
  build: reconfigure automatically if configure.ac changes

 Makefile     | 17 +++++++++++++++--
 configure.ac | 53 ++++++++++++++++++++++++++++++-----------------------
 2 files changed, 45 insertions(+), 25 deletions(-)

-- 
1.7.10.2.1067.g553d16e
