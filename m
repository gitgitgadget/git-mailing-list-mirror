From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 4/5] refs.c: make repack_without_refs static
Date: Wed, 30 Jul 2014 14:55:40 -0700
Message-ID: <1406757341-4096-5-git-send-email-sahlberg@google.com>
References: <1406757341-4096-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 23:56:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCbqu-0008BX-Vn
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 23:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbaG3Vzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 17:55:55 -0400
Received: from mail-qg0-f73.google.com ([209.85.192.73]:37701 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbaG3Vzo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 17:55:44 -0400
Received: by mail-qg0-f73.google.com with SMTP id q107so84010qgd.0
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jTDjVRBvGFZWkAJ5tbCW5OB6SPUfkkKUpbw+xbfu7+E=;
        b=D1Ga/1+Uuqw55BncRsENlOtGPF/aGQm4fBQd9Pn9cusqg8pjhlX1uRXX/tplpOpJ+e
         WBda970BrIN0C1ApCgCR99GZ5L+OSkERp+yAGjgGfK/OF4i45YO0MlcQeOX6QgelDwUU
         snhpdezo1nIzBV1FrUvSjp1xwCLV6pwKBudVWsXbJeZ5j6ieaQ8jM1NK1Wa2YkJJ27Cp
         Khxjb0hvQjB8trC8toATZlStmo8D6HLXB3/vALdp5jS2oZ7j1xONheuiaCCJgtyfvXQS
         js1ZZzQgW12pAxsradm4/pNG8PH9awNWaXG35o73IeQe4q//q18X9ZKmMevR2Ax/iNw9
         +ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jTDjVRBvGFZWkAJ5tbCW5OB6SPUfkkKUpbw+xbfu7+E=;
        b=ROYHfJHkiaw+rzG2zfoVFGvASxqdykBfMXF2vcNFb7U6T4AUJmj/z9zOI8wW1w6D3q
         zrLiNB5u5t9h+oifJD5TqA2LVk+KUr6xnc0AwwviUBI9AWLlAM5L2GQQKFZmAu5eFV1u
         4B/RTn+JxW5NhlEtmqapK69ZZ8nZNM2QuU7xnmvaFmikP0c2kb/DzjH+0psnoKv8D/Y6
         d6gjtNHYH4S/phGZ6qRCZGGR4oN+SWAfD2e3w+5nFQ2OWrJrJUv1Vqkx7sF49yaMAiGi
         S5JZWK/MrC5eaKU4fumtRN2Tc6wXMteGoFTdrrmZflglw/H9JNeg1ORjH0Bhm/m9snof
         O+YA==
X-Gm-Message-State: ALoCoQnruTXKel7EYUIXK9u3dCr7tpY+8tQuzHCUZ1LwBBPPVB2zncS9g0wVmZBtQ4QisHVMQelN
X-Received: by 10.236.92.69 with SMTP id i45mr2588980yhf.20.1406757343379;
        Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si225623yhk.4.2014.07.30.14.55.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3FAB15A4434;
	Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BAF07E0959; Wed, 30 Jul 2014 14:55:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g0041e8a
In-Reply-To: <1406757341-4096-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254529>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index bacce94..fc445e8 100644
--- a/refs.c
+++ b/refs.c
@@ -2538,7 +2538,7 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 /*
  * Must be called with packed refs already locked (and sorted)
  */
-int repack_without_refs(const char **refnames, int n, struct strbuf *err)
+static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
diff --git a/refs.h b/refs.h
index 23067a2..93f7bd5 100644
--- a/refs.h
+++ b/refs.h
@@ -155,9 +155,6 @@ extern void rollback_packed_refs(void);
  */
 int pack_refs(unsigned int flags);
 
-extern int repack_without_refs(const char **refnames, int n,
-			       struct strbuf *err);
-
 extern int ref_exists(const char *);
 
 /*
-- 
2.0.1.523.g0041e8a
