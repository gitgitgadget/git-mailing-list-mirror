From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 04/26] refs.c: add a new refs.c file to hold all common refs code
Date: Tue, 27 Oct 2015 22:14:05 -0400
Message-ID: <1445998467-11511-5-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:14:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGGN-0000pm-7J
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216AbbJ1COt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:14:49 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35778 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207AbbJ1COq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:14:46 -0400
Received: by igbkq10 with SMTP id kq10so96954586igb.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yrsRlcJCcAvwMBgXY/PQ3PpyNaElJfFQEZOQmPX2sOA=;
        b=xBcn7JtdGErAvhBH6O5cujYPdLaGitVH+I6M7qFvS19PLSv8boPRidmDy8sotk5VCd
         BYLSWte0ND6ZDgt8GBcWH8c9ptftUzXFsn3zENM9+YF4fjgn3LXiLApD1gHwF6sMkdUd
         WRbdI+b9VcA357XSCQ5RHWcMLCviV+1gygGmSaVyeUavJQvW6CYzErlMd176jb9bH2V6
         fTG/2AAXmUktyX8noUljA/+HPKxI1E65wEt/YbIlrnCRsb0RDDdR6eZkeDx5TeNvEe1k
         HNcadzb2XvJ9SsFYJVsybY4Nq1mymxDWY4J7qEbCG0xad3zmViWu2GVagWFHuBhCgK+8
         KSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yrsRlcJCcAvwMBgXY/PQ3PpyNaElJfFQEZOQmPX2sOA=;
        b=E63IWxTL+5d5h5rizzRmr94O+h93Qif8rTq0jJJ0e4wLatsFfUT9CTz7CcLe+WZXMA
         FHgnzz9pgKN76eu1FfrI5CxMwWiVCLoomsI+Tn7ZiFpOhlRsXqCVe3dNhDBMHXx8Iqz2
         mCEpKzEQ723Ek606JiQydCvoP0DoRrdVWXoVZjzO0jKhtX24iCIrCV3AM5Ku2M51XyC4
         Wb7RiIw1/63+T2QPrFvYy6fHjF0rFMKHvPoc1mLdETiXr4l8gnH1c0mj35FQfjkuULJT
         PU2X7qCG++oG2V0H/uXgfwbKdIE96x4KGpm4+vPfIecF2o4QtvmYIi8425qWdyZhMkmw
         5Ncw==
X-Gm-Message-State: ALoCoQm4oIGxgeI7ObFhuUPGF7FLWtyAJjCzx+R1rvH37zOwuIuyFbp5ImItm4Fkpqub9PFwJT3B
X-Received: by 10.50.43.162 with SMTP id x2mr326392igl.82.1445998486108;
        Tue, 27 Oct 2015 19:14:46 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.14.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:14:45 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280329>

From: Ronnie Sahlberg <sahlberg@google.com>

Create a new refs.c file that will be used to hold all the refs
code that is backend agnostic and will be shared across all backends.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 1 +
 refs.c   | 3 +++
 2 files changed, 4 insertions(+)
 create mode 100644 refs.c

diff --git a/Makefile b/Makefile
index 173b9d4..b37eae3 100644
--- a/Makefile
+++ b/Makefile
@@ -763,6 +763,7 @@ LIB_OBJS += reachable.o
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
2.4.2.658.g6d8523e-twtrsrc
