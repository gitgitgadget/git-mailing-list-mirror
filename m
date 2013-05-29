From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 0/7] Rebase topology test
Date: Tue, 28 May 2013 23:39:25 -0700
Message-ID: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 08:47:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhaAL-0008AQ-TE
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 08:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759495Ab3E2GrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 02:47:17 -0400
Received: from mail-vb0-f73.google.com ([209.85.212.73]:60688 "EHLO
	mail-vb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745Ab3E2GrR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 02:47:17 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2013 02:47:17 EDT
Received: by mail-vb0-f73.google.com with SMTP id x16so602619vbf.4
        for <git@vger.kernel.org>; Tue, 28 May 2013 23:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=pryAwBVQFOc+YNV0gGzlb+AROSyy5L30iIA4rK/UwH0=;
        b=lc2Z3cwTm61E4hwCaG8dzFpBiHNQgGTtxh+7I5wOJwW4qJPoIK15saWmDEVmNXkPSs
         LG+NSC2FQqE+n6gY6SPuVa/y0ycuL4j8G27fPH+EjskF7nbSOhQIrlWKxmS5Cc3N8jIg
         DegU5Dx55Fp74QiTM1tSZzOQzRX77GnuKvxD2pPQDtxu/SsK7AhUajjz84JlZxUg554v
         CJhazuNmDGcE2LATS2GwuW/O89yNO6wkIOdjJKJMzcfxymGcH74L+JVWnFgU1NbSuF1k
         oIBYALJ6YO2tbfh++yw4txzXs91QBqb7yMenPeUVucQtNbE9StiEdb5KM+oav2F5mPb+
         48aw==
X-Received: by 10.236.134.14 with SMTP id r14mr639748yhi.39.1369809604861;
        Tue, 28 May 2013 23:40:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y4si1051545yhi.3.2013.05.28.23.40.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Tue, 28 May 2013 23:40:04 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B18AF31C1EB;
	Tue, 28 May 2013 23:40:04 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 247121007B4; Tue, 28 May 2013 23:40:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.674.gd17d3d2
In-Reply-To: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmsQnT4JUy+ewNT1KHl5cVObdAW99Ocgt7RQZ3bxqVAkgcWOvRSq1PLZWoAkwpaasICOzg2HRbPLkIN0YmEAiIGA59KqjZzSJb1XJAbUFGDPEWevoXG40tkO0iKVOE/8IcPCd+SsSk9Dli5v4+qcxdXC1fb37OfWaeKGTl5IkyCqLmN8piJvlobO8ZHr6NJfO9ZBZ77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225762>

After way too long, here is finally a new version of the tests I sent
at: http://thread.gmane.org/gmane.comp.version-control.git/205796.

I have split the test up into two files. They stil take quite some
time to run.

Martin von Zweigbergk (7):
  add simple tests of consistency across rebase types
  add tests for rebasing with patch-equivalence present
  add tests for rebasing of empty commits
  add tests for rebasing root
  add tests for rebasing merged history
  t3406: modernize style
  tests: move test for rebase messages from t3400 to t3406

 t/lib-rebase.sh                   |  32 ++++
 t/t3400-rebase.sh                 |  53 +-----
 t/t3401-rebase-partial.sh         |  69 --------
 t/t3404-rebase-interactive.sh     |  10 +-
 t/t3406-rebase-message.sh         |  50 +++---
 t/t3409-rebase-preserve-merges.sh |  53 ------
 t/t3420-rebase-topology-linear.sh | 350 ++++++++++++++++++++++++++++++++++++++
 t/t3425-rebase-topology-merges.sh | 250 +++++++++++++++++++++++++++
 8 files changed, 664 insertions(+), 203 deletions(-)
 delete mode 100755 t/t3401-rebase-partial.sh
 create mode 100755 t/t3420-rebase-topology-linear.sh
 create mode 100755 t/t3425-rebase-topology-merges.sh

-- 
1.8.2.674.gd17d3d2
