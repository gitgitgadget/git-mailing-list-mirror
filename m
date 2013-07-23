From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/5] range-set and line-log bug fixes
Date: Tue, 23 Jul 2013 10:28:03 -0400
Message-ID: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 23 16:28:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1dZw-0004qk-QM
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 16:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757434Ab3GWO2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 10:28:36 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:38064 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757277Ab3GWO2g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 10:28:36 -0400
Received: by mail-oa0-f42.google.com with SMTP id j6so11547264oag.29
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=Y9J7oZW0JxYYj8yCTxEmsgYcSJv9xz4j2nHvQIZXiTk=;
        b=f18DSnZb/DhCrFK7+YEmiD/m6i72Ssrisx0xtfGfRTaXMVhdTBfxP69laiPIwTGFMq
         b1EXgDUhjTrqUv+DiZEORGq21piJVScJc11Ap3PBft5xxXo6bJ6CiJwTZA5aMRpssfOP
         xTXMYFUJIih00pqlEuhrm9hVagCo6dBk/VVKE/fPnXqhUdBebPBJS2yfXuQfSurhCD1x
         qaE91vVsbAj8tSseHmCdydl+LSGE3KlHSlbopP2ZQ0iip7qxh3A0Sr14Bd8OI4+jpdv9
         8RCkAiDy78vQMS9FV0kfmV+1f+LNSU0I0ZgQ/DwFKJqAhH+NhSkewWn9NCleAE08BMBc
         VOsw==
X-Received: by 10.60.83.116 with SMTP id p20mr30664906oey.83.1374589715573;
        Tue, 23 Jul 2013 07:28:35 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id rs4sm40422546obc.10.2013.07.23.07.28.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 07:28:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231035>

While implementing multiple -L support for git-blame, I encountered
several bugs in range-set and line-log resulting in crashes. This
series fixes those bugs.

Eric Sunshine (5):
  range-set: fix sort_and_merge_range_set() corner case bug
  t4211: demonstrate empty -L range crash
  range-set: satisfy non-empty ranges invariant
  t4211: demonstrate crash when first -L encountered is empty range
  line-log: fix "log -LN" crash when N is last line of file

 line-log.c          |  9 ++++++---
 t/t4211-line-log.sh | 13 +++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
1.8.3.4.1120.gc240c48
