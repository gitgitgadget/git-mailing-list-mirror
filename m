From: Dinesh Polathula <dpdineshp2@gmail.com>
Subject: [PATCH] Allow "-" as a short-hand for "@{-1}" for branch deletion
Date: Sat,  5 Mar 2016 16:36:15 +0530
Message-ID: <1457175976-14732-1-git-send-email-dpdineshp2@gmail.com>
Cc: Dinesh <dpdineshp2@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 12:06:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acA2d-0007TA-Pu
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 12:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760490AbcCELG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 06:06:28 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32971 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760102AbcCELG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 06:06:27 -0500
Received: by mail-pf0-f176.google.com with SMTP id 124so51009201pfg.0
        for <git@vger.kernel.org>; Sat, 05 Mar 2016 03:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mWQa5mvOfonuWyZV2GCssfvwtrQ0C0e4xxXndRhDDaQ=;
        b=CUEqLWof8WlB/SzX6MpC8EB/aUpqs8CT/bgc8AGVRxnKCBgybIGagXAk3LL4laYF0K
         dFAZTNhzMYkWS4sxRaf9ZteQWtA1ERY4vgYnmCxMvUkaGCMSNuW49r89eCbiGA3Ozj24
         qrrmKxHCDjOuMOw2pEbsa9IS2WG5Tmv0zl7TNkLcT+1+sk2G8iHBxD0AsAJznAIFfDag
         hq3h9o12UjTmyjfA9x+G6kLpsdRn51EcPkje7blPPXlNGBGJs1FztKKrU1iGCBuvm86J
         tYpRc5qm1sLTtWi7K7ECiBB0Tj+WOE/6Lq9ltvCh6J2MSaQgFFc+AQEXUVr/vqwLAgwL
         h4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mWQa5mvOfonuWyZV2GCssfvwtrQ0C0e4xxXndRhDDaQ=;
        b=ZlokWFRHGdN49lSNs/mVdQl+dR6nmztOAMVtJnUKvopFZksfKxd3LJSi2ZhjQwfhpK
         8GjgBHuEknF13nRxRR5FLbHuwABhkVWIo59sMLY9x93pkmqPE7tFJV5W+tPprbFeTI9F
         xVc+0cfi4wC1rXTMTQlkDVxnFkbtzT9fj4669tQyWvGavEeWz9cYN23ZOme8m5tEFehD
         fDTm7R7dO4qOeeKV0lebWv991Pm8FkOusKfwv92xv2ekC/tMe0twKv372Td1VyIABMj9
         IgqCyzFZ9s0t/JZi7ItpOy0BdzkmTEvgoNCtARa8v6X9U7cRhz1J3CjCVqVbvfM9UBoq
         AalQ==
X-Gm-Message-State: AD7BkJJEWadW0y07yKYJSR8xaYO2h2/Hq5mXsX0ZZVRHYQI/84KbWfcicFU4yfVccDcuaQ==
X-Received: by 10.98.8.196 with SMTP id 65mr18914551pfi.53.1457175986379;
        Sat, 05 Mar 2016 03:06:26 -0800 (PST)
Received: from dinesh-pc.local.lan ([117.221.85.13])
        by smtp.gmail.com with ESMTPSA id sj4sm11676466pab.43.2016.03.05.03.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Mar 2016 03:06:25 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288310>

From: Dinesh <dpdineshp2@gmail.com>

This patch allows the usage of "-" as a short-hand for "@{-1}" in 
"git branch -d @{-1}".

Note : This is a microproject that is part of the Google Summer 
of Code application process.I am interested in working on the git 
Beginner mode implementation as part of Google Summer of Code. The 
mentor details for this particular project are not available on 
the Ideas page. The mentors are likely on this mailing list, so 
I request the mentors to drop me a mail so I can get in contact 
with you to further discuss the git Beginner mode project.
***

Dinesh (1):
  branch.c: Allow "-" as a short-hand for "@{-1}" in "git branch -d
    @{-1}"

 builtin/branch.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.8.0.rc0
