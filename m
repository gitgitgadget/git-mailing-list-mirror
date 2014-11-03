From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 12/17] refs.c: make repack_without_refs static
Date: Mon,  3 Nov 2014 11:02:14 -0800
Message-ID: <1415041339-18450-13-git-send-email-sahlberg@google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:03:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMuG-0001m8-Ou
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466AbaKCTCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:02:52 -0500
Received: from mail-ig0-f201.google.com ([209.85.213.201]:55588 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbaKCTCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:02:25 -0500
Received: by mail-ig0-f201.google.com with SMTP id h15so783553igd.4
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HFEbDas7o+UQ/GDv8PwRuUGMKtTn/vBPfcleq6d8owM=;
        b=pJJD4U8kjjHa3o7rwAYcUCUx8yJi/H1wLEWfDeMTxuT0XLapktSZTDaZumB2Z1XzSf
         9/fccI43Ceen3evDt6A8gfjQdzomGFo1YVXQG96EDgJZX+PA4VxgPC7zKAx6ZBey6tS8
         T7BP0pjpPSi/ZbHybTyS1zdYwVQj3G2vWYd45jxlBUyO/nbnaU3TUjFQmf8SJWMbJ55x
         caiYrmZySw2A91anoXkQqn7vwkkBbLcyMxFEgEucPbPUpUriNMVmkUaDMqKF8g/UK4LL
         HrCsAeT41sIHEscMcIQE+0besmprtXRdM8vSWi0/ghA7yRjwJ7LK/vNDXvi3qQ7xtRtj
         C8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HFEbDas7o+UQ/GDv8PwRuUGMKtTn/vBPfcleq6d8owM=;
        b=gZmJ5s6bVm9M7TdZ0ubARb78LOQsovFTPKJYbzWAZuHjuWP6k9yHhqBSwg70Et/eQl
         UlFgvxCYWDaegBtAg8VnjzSFI6NOvF2GpW3Z3XLaJ8VSQ2GT94QphjLEODcxcvs760OK
         +IiujNrvQwVho1MGto786V5XrigZBZtFK0HmGUa5SRn8OleFP3DagrGDF5SMWHTrmOAa
         5xfqvLEkZN6oW3Le9qGI5a6RL+1lyctqbyYl6JS/hQk/TV9d5W2a5GpD2nEHaugTcf9H
         xqnDTYee5pDGm9krBJDYL6/72hPhZ7JkUyMt387OQUnQ6NvhtbBAPNI99KLf/7qlHx7b
         x5/A==
X-Gm-Message-State: ALoCoQmxvxnyzrNPzh7BUUhcxADU5AgomBGtbPZMDKn4FkHbOLh4QOKUvokYtU5kxbL1JbqcHtb1
X-Received: by 10.43.97.66 with SMTP id cj2mr32532609icc.8.1415041344163;
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id t28si974949yhb.4.2014.11.03.11.02.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id J95ZVEsi.1; Mon, 03 Nov 2014 11:02:24 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D9254E0FD8; Mon,  3 Nov 2014 11:02:22 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 57e5d2f..56b0360 100644
--- a/refs.c
+++ b/refs.c
@@ -2668,7 +2668,7 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 /*
  * Must be called with packed refs already locked (and sorted)
  */
-int repack_without_refs(struct string_list *without, struct strbuf *err)
+static int repack_without_refs(struct string_list *without, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
diff --git a/refs.h b/refs.h
index ec4965f..f5ba534 100644
--- a/refs.h
+++ b/refs.h
@@ -163,9 +163,6 @@ extern void rollback_packed_refs(void);
  */
 int pack_refs(unsigned int flags);
 
-extern int repack_without_refs(struct string_list *without,
-			       struct strbuf *err);
-
 extern int ref_exists(const char *);
 
 extern int is_branch(const char *refname);
-- 
2.1.0.rc2.206.gedb03e5
