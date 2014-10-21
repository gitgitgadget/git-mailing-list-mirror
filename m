From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 10/15] refs.c: make repack_without_refs static
Date: Tue, 21 Oct 2014 13:36:55 -0700
Message-ID: <1413923820-14457-11-git-send-email-sahlberg@google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:44:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggIH-0003nv-6m
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933336AbaJUUo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:44:27 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:62903 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932842AbaJUUo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:44:26 -0400
Received: by mail-yh0-f73.google.com with SMTP id i57so202922yha.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1hTZwMgiw3XB3Yb9v5naZnJ5chQDy5CoZ/XDjfs1VUM=;
        b=BX5hmABpE6VnJqA/5Q1lFsC+znM0rDJXfntJWY54hBRZLCNP0uHzR1JmiD0WWf2NOF
         4O9HNYQ1ExApu9tkVg9zp0MRnfqzJTdlNJSudVlj18gLPPb2zX4vFT7Niu5QIo1f1SuU
         tDr1k0uYIRRdpvn2KUDUqkH2O0tVm5jqI+b6q6UsawJXIjK3oNSjxEpgdXCFIhzkey4l
         LuBeCdVKcvXqY9xi4kHa3OqZpd/304VcYD463c17UrAUwlifgBVIAqpEB7r1dObfkBbb
         2PB5FMx9P2eyrOLvTxUf8UoY9/DYfBvV/X+Gs2FhCowFrLrG8O/3Ibp/TXc0V2jDPcyl
         cCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1hTZwMgiw3XB3Yb9v5naZnJ5chQDy5CoZ/XDjfs1VUM=;
        b=lIWUhyw062L83VnUAnmTSgGXE4gjzvUGORicAmeSwNRH+eJcTt2u7twYppfE1WjU6t
         kpjkGp2uIhM8VKD3926JCfVvqr58nO0MtHrOqkxNVK4Jg0PmNC05tY4vfHYanEltGMFI
         vE86uSNxgL86fKjdWyzoqYRwHzHiP12TJpeyK+IhNkxjYfYIqVKIvmADEY406GeoDgP8
         A3sz31l1w9N5jRTNjJ7Uh0eOEWzMhPftJNmtOh9qWe31zu5AmiSgH9krD0NebfFoEhRb
         EPWoWjfTvHm+nYOy5+x0LwlbVHrQX3lQV6GFnN6V4EpdwOtvAlZEb+R1wg/E3E7pkBAW
         NSzA==
X-Gm-Message-State: ALoCoQkxg8AHhsEoKalDSai2dzhRXtbb6sIjB3Pw3VJWooNM8U0UbkY5KhW5SpImdO8NSVT8V/PM
X-Received: by 10.236.11.194 with SMTP id 42mr24356919yhx.19.1413923824108;
        Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id t28si594349yhb.4.2014.10.21.13.37.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id c0drKly6.1; Tue, 21 Oct 2014 13:37:04 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1A39BE1170; Tue, 21 Oct 2014 13:37:02 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change-Id: Ibf02549e5485ad07da66fe4b1c84f9e2b76b2aca
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index b64d0c7..fddd59c 100644
--- a/refs.c
+++ b/refs.c
@@ -2663,7 +2663,7 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 /*
  * Must be called with packed refs already locked (and sorted)
  */
-int repack_without_refs(struct string_list *without, struct strbuf *err)
+static int repack_without_refs(struct string_list *without, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
diff --git a/refs.h b/refs.h
index d174380..db435bf 100644
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
