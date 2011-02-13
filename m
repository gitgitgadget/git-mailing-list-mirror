From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 0/2] mergetool: don't skip modify/remove conflicts
Date: Sat, 12 Feb 2011 23:09:56 -0500
Message-ID: <1297570198-21103-1-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1297134518-4387-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 13 05:10:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoTII-0006L3-MS
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 05:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811Ab1BMEK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 23:10:29 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57724 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab1BMEK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 23:10:28 -0500
Received: by vws16 with SMTP id 16so2440224vws.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 20:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ZTrcXfCN3fGHcph3pw7O1a13aU4EN7L8K3xq84srMXQ=;
        b=dJS7r8At2SFpnrPnHYbYxblr2jbsIdwo/9Efq03v8Rb0GFDbMbGKxK8RBFjoFUGf7B
         lcvkD9NdTmjOYTYwIsJDAZKtw7uTNJQgwAIIEn+TiahaG8En9zMxa3xRe7HsgNtMwQe6
         yqzIrJyUKSNId6us19vNufStP8S3QWh6VGXU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=c9V2D4K1LpTAqMOrux8WZP8y8PaW3CiSEyFbevh5COYnH0qb/MXajfMCyj7cFF7b5h
         +lofILIgcWu9d4/yynIi+Z8a3l17qU7Gw37p3Rjl6aYeKqW+0QQh2OQFIiOlqrtCOkkI
         qPSW8ANHE4V/Q6jV2m6ibA2Fsnc+G3sq4xrUA=
Received: by 10.220.183.10 with SMTP id ce10mr2976582vcb.45.1297570227035;
        Sat, 12 Feb 2011 20:10:27 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id i1sm823215vby.11.2011.02.12.20.10.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 20:10:25 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297134518-4387-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166637>

Trying again. I hope it looks better this time. The second patch could
be squashed with the first one.

This applies on top of jc/rerere-remaining.

Martin von Zweigbergk (2):
  mergetool: don't skip modify/remove conflicts
  rerere: factor out common conflict search code

 builtin/rerere.c     |   21 +++++-----
 git-mergetool.sh     |    2 +-
 rerere.c             |  109 +++++++++++++++++++++++++++++---------------------
 rerere.h             |    8 ++++
 t/t7610-mergetool.sh |   40 +++++++++++++++---
 5 files changed, 117 insertions(+), 63 deletions(-)

-- 
1.7.4.rc2.33.g8a14f
