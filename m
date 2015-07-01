From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 1/7] pack-protocol.txt: Add warning about protocol inaccuracies
Date: Wed,  1 Jul 2015 11:08:13 -0700
Message-ID: <1435774099-21260-2-git-send-email-dborowitz@google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 20:09:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAMSB-00057T-Ko
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 20:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbbGASJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 14:09:43 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34616 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbbGASIr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 14:08:47 -0400
Received: by igcsj18 with SMTP id sj18so141516027igc.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 11:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jk7KPwJuxuFITfXCOyLmLbZU74vAhTc18SCEhYph7cs=;
        b=KzMLmDULmtFQCkkogJg5Ma1kahs6ME1Tp5wZORHLTJlMwyj48aUnwVVcaMOhebvDo2
         EVy0r2tP1e0paQEchMA6JkcufVObSiUZXeNLN/S/mO4qSlpFRV7yjyMCn29FFyKVI9fK
         VCscLv9HXdmIRHNVWxZelEc7/nosYylkYGV6MzFT7oOXtRnrvm35oIyy9SCxiLcisRuk
         /0y9vk5c3MrXaphl1rMHPqj8qqnfIDZwS003N0UmuFhSoaa6hoGJThBoHC+ZY3Wl85p1
         2qnYR6AWO7xpB4ugeDOINr/9DUg7UQn1cAW6QGgSpHmQfY4QWclzd50/W9O96FYk0xwj
         yWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jk7KPwJuxuFITfXCOyLmLbZU74vAhTc18SCEhYph7cs=;
        b=FBntF5QkzOE51BQ6B6zbAflR9A3Ez+ih2t1+ydlE5kxrBy0fzT5HuDeZstAbuErpNc
         nuTkuIeQm5wHL0I/VBiUheAy5hbB01XZK1AnW2aboYeKHLg6PJ8Aqri+m4+j4ENXTny+
         WJOzJHLIXUwlElQ3Xejxz+DsR/6MUNvj8oaaeRvTfEwc1cIbCeRCJFqmeWCUo4YeL1/4
         f7PJR26EI9qr3krFMpo1b63kndMwIQS83fWG8VFX6+fc8KFc37U4hPJQu5wB6qjMmlti
         rHvyst87eO8oFo4h8MzesqftBEnLUtRuc4yybi/zYXsftm9PR51A/cAFnftJCIx88tD+
         1T5w==
X-Gm-Message-State: ALoCoQkTFTMrNlH/V9YRRbPid/yrs7q5M0BKfwGisi9gSXfgvqMCROZDYqdGFwUw25Rpif2BuQjK
X-Received: by 10.107.155.74 with SMTP id d71mr39493211ioe.29.1435774126893;
        Wed, 01 Jul 2015 11:08:46 -0700 (PDT)
Received: from serval.mtv.corp.google.com ([172.27.69.27])
        by smtp.gmail.com with ESMTPSA id k2sm2782076ige.1.2015.07.01.11.08.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Jul 2015 11:08:46 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.573.g4eafbef
In-Reply-To: <1435774099-21260-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273174>

We want to fix such inaccuracies, but there are a lot and there is no
guarantee at any particular point in time that this document will be
error-free.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/technical/pack-protocol.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 4064fc7..66d2d95 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -14,6 +14,17 @@ data.  The protocol functions to have a server tell a client what is
 currently on the server, then for the two to negotiate the smallest amount
 of data to send in order to fully update one or the other.
 
+Notes to Implementors
+---------------------
+
+WARNING: This document is a work in progress. Some of the protocol
+specifications below may be incomplete or inaccurate. When in doubt,
+refer to the C code.
+
+One particular example is that many of the LFs referenced in the
+specifications are optional, but may (yet) not be marked as such. If not
+explicitly marked one way or the other, double-check with the C code.
+
 Transports
 ----------
 There are three transports over which the packfile protocol is
-- 
2.4.3.573.g4eafbef
