From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 09/33] refs: reduce the visibility of do_for_each_ref()
Date: Mon, 29 Feb 2016 19:52:42 -0500
Message-ID: <1456793586-22082-10-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYaP-0007bz-Ck
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbcCAAyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:54:46 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33592 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbcCAAxg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:36 -0500
Received: by mail-qg0-f47.google.com with SMTP id d32so74635462qgd.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0HEBpkEuMGhTbAVKBmYvzSJ+WsE8Ns8NPw+LyiEZFOY=;
        b=M6bKMLtCbgmm+e7QeN1E2UaGE0+eXBb4OXOTBGyVRFnUic/jYt7TmryT6AJ7+WrOLz
         10LCjMPZapXMBhKnUtryHBeOYOXrtKXjQ4vy+O3A/1k5bIgtUEsp/KqRZZ88tonZPjaM
         iMp4BTOlLJgvC3RBmXIHYcDsH8vL9cic3ik7+UMZTvzXvZ4pokmZslhAWlcGRsFQ7ZKK
         l5Mtc7t4dSFZBCDWW0F/63AV/DIrcmP7NIZeZskRQZtt/VljlG1e74CWXfMC3+xW7CDe
         kdV08KWhrkYrN/+YBjBFGxZZUS1bL214sz2WM3DY8V87rI9f4POptyda/W5XaITizBSr
         UPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0HEBpkEuMGhTbAVKBmYvzSJ+WsE8Ns8NPw+LyiEZFOY=;
        b=FvFgxlyCw8T8EpHZMEQghVvMmFO9SIx07Vp71rNSugGt47MW6JEW8+nObhSqaJlDYv
         YGWpgsdupHhDye29mMYHLjgc9eiWG1nG4G/JWU7uCjnN7CbVT6/MsJShWWb658NgQjvN
         h2VA4mNBQoKa6cwxdqLz2nuq9AcpF5X0qInse1448Jkdc6PqVZNzHSzOEDkcicBpfA0J
         KBvMRNY12kRZbtx3qseRCTnENJ7j4ckn87X5ftBxjQFky1LJ2UIFPYjQVkYwQh2HbFWH
         QtiZIYVx0EudkC58PyNku7DF3ON/uZjBtc+nQlgALBPhDLAQBiE8G1glXzaw00ywZ15R
         npRQ==
X-Gm-Message-State: AD7BkJLh+wWjyQjmzEq7WP+e1QL4fY5GxYWJKDFL/W2fPKFwVAnR3ac0DNWkFv5n2OfCWw==
X-Received: by 10.140.105.97 with SMTP id b88mr22846650qgf.74.1456793615868;
        Mon, 29 Feb 2016 16:53:35 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:35 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287973>

From: Ramsay Jones <ramsay@ramsayjones.plus.com>

Now that we have moved do_for_each_ref into refs.c, it no longer needs
to be public.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 19 +++++++++++--------
 refs/refs-internal.h |  6 ------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index dc5682a..cea5997 100644
--- a/refs.c
+++ b/refs.c
@@ -1142,6 +1142,17 @@ int head_ref(each_ref_fn fn, void *cb_data)
 	return head_ref_submodule(NULL, fn, cb_data);
 }
 
+/*
+ * The common backend for the for_each_*ref* functions
+ */
+static int do_for_each_ref(const char *submodule, const char *base,
+		    each_ref_fn fn, int trim, int flags,
+		    void *cb_data)
+{
+	return the_refs_backend->do_for_each_ref(submodule, base, fn, trim,
+						 flags, cb_data);
+}
+
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(NULL, "", fn, 0, 0, cb_data);
@@ -1342,11 +1353,3 @@ int resolve_gitlink_ref(const char *path, const char *refname,
 {
 	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
 }
-
-int do_for_each_ref(const char *submodule, const char *base,
-		    each_ref_fn fn, int trim, int flags,
-		    void *cb_data)
-{
-	return the_refs_backend->do_for_each_ref(submodule, base, fn, trim,
-						 flags, cb_data);
-}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c9b6745..3702737 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -203,12 +203,6 @@ int rename_ref_available(const char *oldname, const char *newname);
 /* Include broken references in a do_for_each_ref*() iteration: */
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
-/*
- * The common backend for the for_each_*ref* functions
- */
-int do_for_each_ref(const char *submodule, const char *base,
-		    each_ref_fn fn, int trim, int flags, void *cb_data);
-
 /* refs backends */
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
 				      struct strbuf *err);
-- 
2.4.2.767.g62658d5-twtrsrc
