From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 04/43] refs.c: add a new refs.c file to hold all common refs code
Date: Mon, 28 Sep 2015 18:01:39 -0400
Message-ID: <1443477738-32023-5-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:05:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggXs-0003BV-Uv
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbbI1WDC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:02 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33795 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbbI1WDB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:01 -0400
Received: by qgez77 with SMTP id z77so134276012qge.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZHZAfZD+5NjDu7BbVcJNGMW2t2O4USqqBwWT9+s+smo=;
        b=QGxLArh+VyVPdz4+9hN8v1WZbUJGuP45RSVPW/umFWU/vk0cyCQi3aSHQkbKDVFNai
         Qa2CcFO2+hKlPawSiYhMTaRK2bT/j6Vl/6xoG3Ac5tdNpxreaej6Qxp8sYySzzbTjrP/
         BD8mv3HgnYiPD2JOiDxZI7NbCQg0Uym3NFH1j03GFcp7xpFv3UXcFwPKsh7oxjkOtgpF
         6EN6C3EqBADn2YjAKr0CrpZatULV4+ww5D3pk2c8JDSe/uTA6RgwOxtUnxiZEZL1p3ii
         B6vEHjjXH/9HGSELeJEbcH47jlhRFlpLT1zsr5dEUcEO5V7ZTt8p/DCTWF8HQQD8jqmV
         0ZuQ==
X-Gm-Message-State: ALoCoQniTlUfXqzZXG76lPMc/RYZB1pennY8JlCqb6W+GgnIaVXV7PC5kuD3SrV1Bh9DNggBvr2o
X-Received: by 10.140.98.238 with SMTP id o101mr25234799qge.70.1443477780420;
        Mon, 28 Sep 2015 15:03:00 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.02.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:02:59 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278796>

From: Ronnie Sahlberg <sahlberg@google.com>

Create a new refs.c file that will be used to hold all the refs
code that is backend agnostic and will be shared across all backends.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 Makefile | 1 +
 refs.c   | 3 +++
 2 files changed, 4 insertions(+)
 create mode 100644 refs.c

diff --git a/Makefile b/Makefile
index 19036de..43ceab0 100644
--- a/Makefile
+++ b/Makefile
@@ -767,6 +767,7 @@ LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs-be-files.o
+LIB_OBJS += refs.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
diff --git a/refs.c b/refs.c
new file mode 100644
index 0000000..77492ff
--- /dev/null
+++ b/refs.c
@@ -0,0 +1,3 @@
+/*
+ * Common refs code for all backends.
+ */
-- 
2.4.2.644.g97b850b-twtrsrc
