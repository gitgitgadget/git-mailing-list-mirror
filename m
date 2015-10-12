From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 04/44] refs.c: add a new refs.c file to hold all common refs code
Date: Mon, 12 Oct 2015 17:51:24 -0400
Message-ID: <1444686725-27660-5-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:52:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll18-0004JB-64
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbbJLVwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:22 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:34232 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbbJLVwS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:18 -0400
Received: by qgez77 with SMTP id z77so130215171qge.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZHZAfZD+5NjDu7BbVcJNGMW2t2O4USqqBwWT9+s+smo=;
        b=Hivdl7wrMw1mJu3pZwkhbBOyoe5wqmXPJrV6F+7hVAGEtpqWAZ1CuXRoT+L8raH0Ul
         7V9heTJ11xHCQd4LgQq9itmrsHyZweL7EMNO8+6a4ASvoXSM5LNCl25QZPqXEtK0ZmwO
         elRFl5L39ujViXUGUsZsQacqAGgWNE2z6WBvzM3d2o7UQHRopkKr4ryNi4uHnCel18bo
         hD1HGy/ixIJ58rK5YcLQWyLXXt49Q9dpX7S2Ue+8WzjgO/hVDGHvPGNCB9KDJIusfnaQ
         ecz5gbSBxWlSJ1uP+sMv5szcgEVFeZ6YmFwugAaqeJsyHJdw3Hg9dNHk3EZ6Qtr6/wWz
         KVsA==
X-Gm-Message-State: ALoCoQn/UXfr7gbTcCKTSG14Qlrb+FA9RpWU+nWKXXYf7K7zwFRiQwrty9bg0KuBLsGsMuBM0ufQ
X-Received: by 10.140.19.227 with SMTP id 90mr34666321qgh.51.1444686737740;
        Mon, 12 Oct 2015 14:52:17 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:17 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279420>

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
