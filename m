From: Pang Yan Han <pangyanhan@gmail.com>
Subject: [PATCH/RFCv2 0/2] format-patch: produce non colorized patches when color.ui=always
Date: Tue, 13 Sep 2011 01:46:39 +0800
Message-ID: <1315849601-26497-1-git-send-email-pangyanhan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, martin.von.zweigbergk@gmail.com,
	sdaoden@googlemail.com, ib@wupperonline.de,
	Pang Yan Han <pangyanhan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 19:49:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3AdE-0007y8-IJ
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 19:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab1ILRtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 13:49:12 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38982 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab1ILRtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 13:49:12 -0400
Received: by qyk7 with SMTP id 7so348573qyk.19
        for <git@vger.kernel.org>; Mon, 12 Sep 2011 10:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+YcgTRjIboPJl1iH0dgJqORTz1fPnogx++QnHvDEwRo=;
        b=MXuq9kardCiC7zFOmmNY3a7n6ciVDof+AJT81+WcrXmIA3TezTYe1hgfquZGD5ALTq
         65MGCCROtYuiwFZRKHAKsGxeMu+6xdLo8pfALRhAtLlTWpn5TfjVI2W9KVA37tez7nCD
         TeePDs0naN8KCIWs3zYnJkGuIG9PoyptvNS/A=
Received: by 10.224.212.129 with SMTP id gs1mr511615qab.91.1315849750744;
        Mon, 12 Sep 2011 10:49:10 -0700 (PDT)
Received: from localhost (bb219-74-111-93.singnet.com.sg. [219.74.111.93])
        by mx.google.com with ESMTPS id bf8sm2566023qab.22.2011.09.12.10.49.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Sep 2011 10:49:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.190.g713ddd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181226>

Hi list,

This 2-patch series has been rerolled with Jeff's suggestions.

For patch 1/2, I've renamed the new test file to t4051-format-patch-config.sh
and changed the description to "check that format-patch does not respect
porcelain config". In addition, I've slightly reworded the commit message to
include the date of the commit (c9bfb953) which introduces the regression.

For patch 2/2, as per Jeff's recommendation, teach git_format_config to
intercept color.ui in the same way as commit f3aafa4 (Disable color detection
during format-patch, 2006-07-09). This is inline with the way we avoid passing
down diff.color and color.diff to git_log_config and config functions further
down the callchain.

Pang Yan Han (2):
  format-patch: demonstrate that color.ui=always produces colorized
    patches
  format-patch: produce non colorized patches when ui.color=always

 builtin/log.c                  |    3 ++-
 t/t4051-format-patch-config.sh |   23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)
 create mode 100755 t/t4051-format-patch-config.sh

-- 
1.7.7.rc0.190.gb47b6
