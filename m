From: Jacob Nisnevich <jacob.nisnevich@gmail.com>
Subject: [PATCH 0/2] add support for ExamDiff
Date: Fri, 25 Mar 2016 15:52:54 -0700
Message-ID: <1458946376-30296-1-git-send-email-jacob.nisnevich@gmail.com>
References: <xmqq60wbc24h.fsf@gitster.mtv.corp.google.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jacob Nisnevich <jacob.nisnevich@gmail.com>
To: davvid@gmail.com
X-From: git-owner@vger.kernel.org Fri Mar 25 23:53:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajabt-0001Tf-Vj
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 23:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbcCYWxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 18:53:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35142 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828AbcCYWxe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 18:53:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id u190so12863498pfb.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2aJaR14eR2/P0qQGpct+xWjUkh8TT5/xVK2Bq4ovUGE=;
        b=jezLYH7mruqwn6wXg2tf5qD38m/r7pNVZIjx7o3GoZ6wqdzJQAY3qw0n9FfZnvMFBL
         TrPaZSyE6Ng1f5xU+68M+BgRPRmJuFU04OVn+sqQ264ofZ59F9IxfkmFVdwxZI+DL4d1
         OP4iahXlMkjBnkAAcjTPV1wnzXYh2Q+/PStQoyPJC9ankKnngWit6pbQgJ5nzWuTyy2Y
         AdwLQsMxBYwi05bVPlmjVjqf1jwLF5EEsasNobGLVZdcEcdgpQnDuS2VuSLPWmlWfJlu
         Nc6LJfnjKXTK+GAOx0rH6LaFWINzpfutED+L5coTY4rCJ2A01bflXAfHJEuVAUB1OJEu
         Bu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2aJaR14eR2/P0qQGpct+xWjUkh8TT5/xVK2Bq4ovUGE=;
        b=Q6sFfVsqCN/EPfMFlfp01I+UJnLhDIsqDht42MdY+XYQzdQ16bL/UogO3RnQJEBqsZ
         F9XWyQNegZrtiDf6Nuns8ZLbRBr+oP+uXIMS8wepN2UEzPld/QlECHK/Dof04zwRV1Qh
         ZEUaBMORpvVe0LBSM4uD21i5O/Iu/zZZfB4dwXOCaan88uZ3ecrPswcRi8MQuoz6RB6F
         vmRFyZbeBewUeAUWvz3zPNY4OEuy3ip1GunUCwkYnUnAj8oygarKQVv16IvnBETiu6aQ
         9ME6HoWFmHYd31+MvpEeTLr0iGYm433POQaGdnrC+riW2MQeDkhQmqfPUqp6Rw1V8VI2
         5CBg==
X-Gm-Message-State: AD7BkJJuJCqzSSj5FHv8KFCPkxSKd2zi/a78JMOpKtIzWJAOrhYbjBEQfbjOEtEx3h6hjw==
X-Received: by 10.98.86.157 with SMTP id h29mr24376641pfj.105.1458946413832;
        Fri, 25 Mar 2016 15:53:33 -0700 (PDT)
Received: from localhost.localdomain (cpe-108-185-180-179.socal.res.rr.com. [108.185.180.179])
        by smtp.gmail.com with ESMTPSA id 17sm18583342pfp.96.2016.03.25.15.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Mar 2016 15:53:33 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <xmqq60wbc24h.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289961>

I implemented all the changes you suggested and separated the patch into two
different patches. Thanks for all the help David.

Jacob Nisnevich (2):
  mergetools: create mergetool_find_win32_cmd() helper function for
    winmerge
  mergetools: add support for ExamDiff

 git-mergetool--lib.sh | 25 +++++++++++++++++++++++++
 mergetools/examdiff   | 18 ++++++++++++++++++
 mergetools/winmerge   | 21 +--------------------
 3 files changed, 44 insertions(+), 20 deletions(-)
 create mode 100644 mergetools/examdiff

-- 
1.9.1
