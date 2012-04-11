From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 0/2] Dynamic long options for bash completion
Date: Wed, 11 Apr 2012 03:29:23 -0700
Message-ID: <1334140165-24958-1-git-send-email-bebarino@gmail.com>
Cc: spearce@spearce.org, szeder@ira.uka.de, felipe.contreras@gmail.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 12:29:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHuns-0003sK-Gi
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 12:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756420Ab2DKK32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 06:29:28 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39952 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab2DKK31 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 06:29:27 -0400
Received: by obbtb18 with SMTP id tb18so1037432obb.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 03:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=z5wI8ock3q+zwL7bSwPK4FMqfmLqadm1HwDtFeQSpq4=;
        b=bPLpPVDVPn8/xovJHpw8Lv0Nua2HY8nMyUWr9rSRAmpA7wMGPc60PmwRasZkMKq+OX
         XgUqYy6zYJk9uqVcgOnYdrFC4EsWShyxNg2kvaEW3XXfYFcAL4I3kAwcFF9Axrcq7jLC
         3Cat8DzUKxAry/mrQomwAQbsMHcQMNChXKQrpoEZXstUTsgLBBFjisyZG1PbsLMbr2wE
         lDgzC/UG4z7xqMzC6wdw0vM2lRlcyauVE4QIlienihdTn45Tbhhgde2H/S+v5KitGDkn
         dKrafEJzemVPS9dJJ4eyZM+ITXkRkrxqAUApC+bwFbN74GK7HTwwmdn6JDjEKKyOHEUT
         Wq7g==
Received: by 10.60.4.170 with SMTP id l10mr20903808oel.67.1334140166978;
        Wed, 11 Apr 2012 03:29:26 -0700 (PDT)
Received: from earth (ip68-105-100-241.sd.sd.cox.net. [68.105.100.241])
        by mx.google.com with ESMTPS id in4sm2426796obb.2.2012.04.11.03.29.24
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 03:29:26 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 11 Apr 2012 03:29:25 -0700
X-Mailer: git-send-email 1.7.10.128.g7945c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195158>

I've been meaning to do this for a while. I realize we gain some more
lines but it seems better to just generate these lists automatically
instead of managing them by hand.

Stephen Boyd (2):
  parse-options: Add support for dumping out long options
  completion: Use parse-options raw output for simple long options

 contrib/completion/git-completion.bash |  298 +++++++++++++++++++-------------
 parse-options.c                        |   41 +++++
 2 files changed, 217 insertions(+), 122 deletions(-)

-- 
1.7.10.128.g7945c.dirty
