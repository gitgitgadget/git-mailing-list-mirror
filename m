From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v4 0/2] push: submodule support
Date: Sat, 20 Aug 2011 00:08:46 +0200
Message-ID: <1313791728-11328-1-git-send-email-iveqy@iveqy.com>
Cc: iveqy@iveqy.com, hvoigt@hvoigt.net, jens.lehmann@web.de,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 00:08:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuXFG-0002Ow-KS
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 00:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab1HSWIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 18:08:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38248 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467Ab1HSWIr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 18:08:47 -0400
Received: by fxh19 with SMTP id 19so2200998fxh.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 15:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=mC4yE2J0uGCcHfPbG6WY9DJEmLpS/ofkDeI/QhRKo+E=;
        b=B3o5Ni7yMBB7MLdViHrJHEooDt9MfqZlJ61nmA5PBORM2Sgl3NZDUav1hRmS4ko78s
         okpAUlRjRknyOedki63Ve+CJJdiolYaFJyZayRVe35DtPNtY7KdfX62Z57L25jEtNhY8
         ueenuAhLi8DbAfpYR0YgLTQHuc5GqEyZJ2YXY=
Received: by 10.223.6.91 with SMTP id 27mr264349fay.145.1313791726498;
        Fri, 19 Aug 2011 15:08:46 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id b14sm2900890fab.19.2011.08.19.15.08.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Aug 2011 15:08:45 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QuXFG-0002xJ-7C; Sat, 20 Aug 2011 00:08:54 +0200
X-Mailer: git-send-email 1.7.6.551.gfb18e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179731>

The first iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/176328/focus=176327

The second iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/177992

The third iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/179037/focus=179048

Fredrik Gustafsson (2):
  push: Don't push a repository with unpushed submodules
  push: teach --recurse-submodules the on-demand option

 Documentation/git-push.txt     |    9 ++
 builtin/push.c                 |   26 +++++++
 combine-diff.c                 |    2 +-
 submodule.c                    |  161 ++++++++++++++++++++++++++++++++++++++++
 submodule.h                    |    2 +
 t/t5531-deep-submodule-push.sh |  111 +++++++++++++++++++++++++++
 transport.c                    |   17 ++++
 transport.h                    |    2 +
 8 files changed, 329 insertions(+), 1 deletions(-)

-- 
1.7.6.551.gfb18e
