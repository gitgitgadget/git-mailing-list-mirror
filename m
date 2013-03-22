From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/6] Support triangular workflows
Date: Fri, 22 Mar 2013 13:22:30 +0530
Message-ID: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 08:51:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIwlW-0002GW-L5
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 08:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489Ab3CVHv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 03:51:27 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36543 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab3CVHv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 03:51:26 -0400
Received: by mail-pd0-f178.google.com with SMTP id u10so1459827pdi.23
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=qS2ouyXiWRsXIsGJ9i4zl0doA85KNjMp3af67QfY6oA=;
        b=RFCXTaxirTgppYB9BnsF5MHqluyTTpT2iO65WQbVNQkuPdP0y5TN9EMoimvzZorhNa
         R+wCEYVyxtGhzTnSmDvwBEiRljvjgV7pZgSr+YcLIlimGY+IL7UpPJjktAtMT3OVxkeC
         JXeC/ZK5HgCJUOAOo3olEvIP/sQSQEVV7wzGniXw/kOW0ehOwCKuJhTDH/Wd3eqnrcy3
         fBsFuZBVV4knyq2RjEO1L6ktXhnI2vW3l9Wd4k4ancXzNjXgTesDX3EO+Nry/9eDCS1I
         r/C0zskQ3/sA6KmtF010zyFeOHQ2amkRvprFPqoUxR3R2qYU11djq3QRaF5Vos6G1Atq
         htzQ==
X-Received: by 10.68.170.193 with SMTP id ao1mr1126223pbc.129.1363938686084;
        Fri, 22 Mar 2013 00:51:26 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id fh1sm2025227pac.1.2013.03.22.00.51.23
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 00:51:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.62.ga35d936.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218778>

After Jonathan's review of [1], I've decided to pick two changes to
apply in this iteration:

1. [1/6], [5/6] and [6/6] now use the return value of
   git_config_string(), hence handling configuration errors properly.
   I consider this a major and important improvement.

2. The commit message in [4/6] has been augmented with a small
   example.  This is mainly a nit, as full-blown examples are already
   present in the next two patches in the series.

Thanks.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/218598

Ramkumar Ramachandra (6):
  remote.c: simplify a bit of code using git_config_string()
  t5516 (fetch-push): update test description
  t5516 (fetch-push): introduce mk_test_with_name()
  remote.c: introduce a way to have different remotes for fetch/push
  remote.c: introduce remote.pushdefault
  remote.c: introduce branch.<name>.pushremote

 Documentation/config.txt | 23 +++++++++++++++---
 builtin/push.c           |  2 +-
 remote.c                 | 39 ++++++++++++++++++++++++------
 remote.h                 |  1 +
 t/t5516-fetch-push.sh    | 63 ++++++++++++++++++++++++++++++++++++++++--------
 5 files changed, 107 insertions(+), 21 deletions(-)

-- 
1.8.2.62.ga35d936.dirty
