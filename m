From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 04/26] refs.c: add a new refs.c file to hold all common refs code
Date: Thu, 15 Oct 2015 15:46:28 -0400
Message-ID: <1444938410-2345-5-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:48:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoVe-0007cu-OV
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbbJOTrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:12 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35984 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbbJOTrK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:10 -0400
Received: by qkht68 with SMTP id t68so44757650qkh.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HaXmcmeGHff7w+2qlXy+/vCyX2vHmyR9ka25cQYyiig=;
        b=JOGVcHwPJbx0X37ZDiev1u1kRTRQRi7vpiaTETEtyDdbKXC9367sRVO2cKXKK0HK5Q
         lj08LME9EnxLRiW9FY22Za8UmCap8f11NEkPx+PlV/dOd6GmbvG4IwT6shPxe7aZRKVi
         KyDmwjwnYYyD5Rmgf4mdM7bAv5mmc8Qvbu+3ZPbfX51+TPNeqUjyRezaBgbq4Ps+3Dxj
         WAKtLXb470BxA7mrAzuqSMDsBMeNRSd7vdfHv+5yRdFpthdtbcrhPrRfJ4LVQonGJi1o
         xrCsGrzHflwvDFfxMiPBXn+fjPzFYPZ8spb5LzWXCCCjI6+v9aiZ3rJzoPQClIO2g40J
         esuw==
X-Gm-Message-State: ALoCoQk+eaTbbXOw11m11eiA8hFOpJJtsc3Vd4BAkElAO+cU+iUHTyB+jdLQYbdfl15QCNoU393V
X-Received: by 10.55.19.211 with SMTP id 80mr13794387qkt.103.1444938429437;
        Thu, 15 Oct 2015 12:47:09 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:08 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279701>

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
2.4.2.644.g97b850b-twtrsrc
