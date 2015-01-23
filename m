From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: correct --prepare-p4-only instructions
Date: Fri, 23 Jan 2015 09:15:11 +0000
Message-ID: <1422004512-10049-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 10:16:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEaLp-0000kF-JB
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 10:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009AbbAWJQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 04:16:18 -0500
Received: from mail-we0-f172.google.com ([74.125.82.172]:56140 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbbAWJQL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 04:16:11 -0500
Received: by mail-we0-f172.google.com with SMTP id q59so2818556wes.3
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 01:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hrJFiLXXXt0CS2FMXfdoCbwrZYL3LYrFmnTzrjj28Rk=;
        b=hLEpByZFgQOfOAXhqICionh7eXBlXxHvzqt+mi5ZGV+Umam0SFJmEbuqs4s/zw7zNj
         c9Xkr7+weq8BpJLuThBHjbwKA3yMMJv+R3suJxWvn9ruS/H0amJgqlLqwy9h+bCnLqPW
         FZH66kl6V8/IFj9QneF6YEANjAWpjNg63Ue0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hrJFiLXXXt0CS2FMXfdoCbwrZYL3LYrFmnTzrjj28Rk=;
        b=hoMzXDbu6EDHhlCOhVkdrrN80Sxl1onW9OdPBUQv33OvIR1JEVjPajHy3ondEwaZd3
         YKAYixehESKepQntw4iRgk+mD0c9lFDekiuQNO9dfE2ugFEQhbojtda0i+i1J3zcSpZE
         6Sk9yoiaAuLclBkMk2AirneiBwEAQhy3x/V9VrFdXlgpCQcMrl9dheZSKkVefQYiWT8a
         JMJo3BErNycvM1CITV++ZExcOaJkVbEpv27zBbGuaKLIx/YtXaTBjXeD5XuHTfcVMXaS
         uwBAW9hAPSFOos0y9Gv+OQLpsbSK4CcnWarDbWw9pWhg5Yp4MryadPuxin5Ub6H7APbW
         1jFA==
X-Gm-Message-State: ALoCoQkDNSTXMIJ4GrJp5RWdX/uoaVcC/iyUea+ue7J7oyNb4TqBqUEXPqv3mc8Qulo8M3mRlIQ5
X-Received: by 10.194.62.19 with SMTP id u19mr12376089wjr.0.1422004569764;
        Fri, 23 Jan 2015 01:16:09 -0800 (PST)
Received: from ethel.local.diamand.org (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id cf12sm1372311wjb.10.2015.01.23.01.16.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jan 2015 01:16:09 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc1.30.g76afe74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262903>

This fixes a small error in the command that git-p4 suggests when
the user gives the --prepare-p4-only option.

It tells the user to use "p4 submit -i filename" but the p4 submit
command reads a change specification on standard input. The correct
command line is therefore:

   p4 submit -i <filename

Luke Diamand (1):
  git-p4: correct --prepare-p4-only instructions

 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.1.3.1037.g95a6691.dirty
