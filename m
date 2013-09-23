From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 0/3] Add cleanup action to perf-lib
Date: Mon, 23 Sep 2013 23:08:43 +0200
Message-ID: <1379970526-27997-1-git-send-email-t.gummerer@gmail.com>
References: <xmqqtxhgsi5p.fsf@gitster.dls.corp.google.com>
Cc: trast@inf.ethz.ch, git@vger.kernel.org, t.gummerer@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 23 23:09:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VODO8-0007op-Pv
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 23:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883Ab3IWVJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 17:09:44 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:56145 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab3IWVJn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 17:09:43 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so3682392pbc.11
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T+4wC3ljYzLsvp3hPng3DyzmVUtk0OX/bEVLl25YYx4=;
        b=I9GFcB+YTl/bDVHaCHhiuiRiLes4+UN+d+VWiOP9JIJAAcC9SJ0oy4XJ5lRtLux9kG
         jPHrER4HepTezVGt63fYIaqAJqTNwhESJ5NbCicvVgjGTFT6Bp1Wg8IeNRajsgkb9whf
         2g5sF0vPQoA5OxjRKEEI710apU6zPt1SgNTDuLQbYz1cpU8n3BI2OBSmNffBu+zSNBq0
         V6DsTHk4e8Fwmdwf6pVLh6Yy946AgTuSf6k+bJn5MJdYAEx2rD+0W7tSauYKzI5pYRaz
         FyTXghZ5aLdsXa+OrkQRPrrKEE4vfc/qWB+6tkFNZQtJa+bfdbkUmsdXFI3PZgo9aYIQ
         Rf2w==
X-Received: by 10.67.23.164 with SMTP id ib4mr26579803pad.42.1379970583325;
        Mon, 23 Sep 2013 14:09:43 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPSA id ct4sm36169961pbb.41.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 14:09:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1241.g1ce9896
In-Reply-To: <xmqqtxhgsi5p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235241>

This patch series comes out of the discussion at $gmane/234874, adding
a new (modern) form of writing tests.  This form allows easier
extensibility of test cases.  In the next patch a --cleanup option is
added for performance tests.  The option does nothing for normal
tests, as test_when_finished is the better option for them.

The last patch adds a few simple tests to show the capabilities of the
new --cleanup option.

Junio C Hamano (1):
  test-lib: introduce "modern" style tests

Thomas Gummerer (1):
  perf-lib: add cleanup option

Thomas Rast (1):
  p0003-index.sh: add perf test for the index formats

 t/README                | 24 +++++++++++++--
 t/perf/README           | 21 ++++++++++++-
 t/perf/p0003-index.sh   | 56 +++++++++++++++++++++++++++++++++++
 t/perf/perf-lib.sh      | 32 +++++++++++++-------
 t/t0008-ignores.sh      | 34 ++++++++++-----------
 t/test-lib-functions.sh | 78 +++++++++++++++++++++++++++++++++++++++----------
 6 files changed, 200 insertions(+), 45 deletions(-)
 create mode 100755 t/perf/p0003-index.sh

-- 
1.8.3.4.1241.g1ce9896
