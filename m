From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 0/2] add strbuf_set operations
Date: Thu, 12 Jun 2014 00:29:32 -0700
Message-ID: <cover.1402557437.git.jmmahler@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 09:30:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuzSe-0003rv-Rc
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 09:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbaFLHaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 03:30:07 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:42634 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128AbaFLHaG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 03:30:06 -0400
Received: by mail-pd0-f180.google.com with SMTP id ft15so678633pdb.25
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 00:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8jfjaXHzg9brbHVg5STC1Wi7ExE1qmnsjImmWlFu1JA=;
        b=JUhDWJc6IX8RIfsr+bbRN0kEF0J22W3AYRd/YOTCpYBkhEfXBKD2Bs0TmIPBqPMRrn
         r09vacgGxtN4MsDG1ZQenNCkBDr4GR99MalUzuJ9AEnu/BAXlUd84dJRr2o4AhbjOuIj
         +2/oV5+pB2iYCFgdEQ/8U9Rt2GMCK71Y6ECBHhNg9kiC6MxilHJ6b2mZ020luhQYZLQH
         3Du1fC0LAa88lA8lqHjubP3G5FYsIToAw0MIcCMmyaLklatCblyGjtidzRioXmfN2jm+
         DamkU/MWkKTTcl6moP2psac+FAuq/Kx2xEdgVr+s9j2C6RBf+HIAiQs0TOINrdthegPz
         gzQg==
X-Received: by 10.66.254.136 with SMTP id ai8mr18992075pad.37.1402558205578;
        Thu, 12 Jun 2014 00:30:05 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id bu3sm973241pac.28.2014.06.12.00.30.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2014 00:30:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.660.g82aec34
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251398>

Addition of strbuf_set operations, version 3.

Includes suggestions from Eric Sunshine [1]:

  - Revise log message to better argue why this patch is worthwhile.

  - Avoid documentation redundancy: "Setting buffer", "Replace buffer".

  - Remove unnecessary changes which didn't have a significant benefit
	to avoid unnecessary "code churn".  builtin/remote.c was the one
	file which showed a significant benefit.  Others with negligible
	benefits have been left as is.

The possible performance improvements using a strbuf_grow_to() operation
as suggested by Michael Haggerty [2] has been left for a later patch.

[1]: http://marc.info/?l=git&m=140247618416057&w=2

[2]: http://marc.info/?l=git&m=140248834420244&w=2

Jeremiah Mahler (2):
  add strbuf_set operations
  builtin/remote: improve readability via strbuf_set()

 Documentation/technical/api-strbuf.txt | 18 ++++++++++
 builtin/remote.c                       | 63 +++++++++++++---------------------
 strbuf.c                               | 21 ++++++++++++
 strbuf.h                               | 13 +++++++
 4 files changed, 75 insertions(+), 40 deletions(-)

-- 
2.0.0
