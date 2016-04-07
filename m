From: David Turner <dturner@twopensource.com>
Subject: [PATCH 20/24] checkout_paths(): remove unneeded flag variable
Date: Thu,  7 Apr 2016 15:03:07 -0400
Message-ID: <1460055791-23313-21-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:04:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFEb-0007wR-6q
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346AbcDGTEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:04:30 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35167 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368AbcDGTDm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:42 -0400
Received: by mail-qk0-f170.google.com with SMTP id o6so34892725qkc.2
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=FwzaFb9ZBFm31DyUMWF220RC7r4FwqmyASNOSVlZMUQ=;
        b=PJx/h+w6VtKGd9zgCBFX6FHGhX9RXuWqxJN6P5CA08YVQI8vSALQGzgqc/T88oMwnt
         ExtXvRc9aH+4xkLr7ecu2e6EYe46RV8r55XKKwW+pK1Kr+b1V/57JvmlVAbizy2X8QMd
         3hSVOZRhnoUuS63zojl9lTdjoIeVH3VfjuUcx0KwoqNZ+r7bPbakUi2Pec8+NS3ReqjX
         qJJjcN/N9zxMSS1Hso5lMpIdPTUAJ4M7B4PqAbrJUUhTgyXKvr4x2lXS7QV/ccSjg05Q
         +Gpxpd/ud6SWk8QQYuLNOGi937/Q32Bh38OQkaaqKGNfuOMyXlltdpdQJVRUyiCUbDds
         DL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=FwzaFb9ZBFm31DyUMWF220RC7r4FwqmyASNOSVlZMUQ=;
        b=PpzWLP5QGzkJBF5Sxm9crbq9779Dx6GsxFY8ir9PiTIsfvTcFGz3YmuxZnc5cv7CH7
         STIJzfJGyoAcHfS8qhuBc89K+8wkhV0YYgEtABmlnwtx04GnU+J1c+kzR7e3B3HwpeQ+
         vEc50K6xv1wJ+wdW8pprySIwmN2CeEzFQ4KvVznAq3/NNgzHIRjuCnxQ4Q3pdNIU2jFR
         AkLggbaC8BqI3NEhP17dWE25LEd5or8hkBlgeTP2n7Gf8YWtu9DMoRSWUXXlxSlKw+w8
         /1DbA/0nq9GB+nGI+aGF7tPVJ4sKADE5vHIiBSuQ9pvpT5gcH5BRnpZ3hryuOBcK3Ljo
         6nqA==
X-Gm-Message-State: AD7BkJLuTG2oKC49YBYUAj5Lzx5l2BBa54VVVfnnzkXh0ynaQRi7hCDYHZ+fcA5w3E7NLQ==
X-Received: by 10.55.15.85 with SMTP id z82mr6177600qkg.15.1460055821874;
        Thu, 07 Apr 2016 12:03:41 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:40 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290974>

From: Michael Haggerty <mhagger@alum.mit.edu>

It is never read, so we can pass NULL to resolve_ref_unsafe().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/checkout.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index efcbd8f..ea2fe1c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -242,7 +242,6 @@ static int checkout_paths(const struct checkout_opts *opts,
 	struct checkout state;
 	static char *ps_matched;
 	unsigned char rev[20];
-	int flag;
 	struct commit *head;
 	int errs = 0;
 	struct lock_file *lock_file;
@@ -375,7 +374,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	read_ref_full("HEAD", 0, rev, &flag);
+	read_ref_full("HEAD", 0, rev, NULL);
 	head = lookup_commit_reference_gently(rev, 1);
 
 	errs |= post_checkout_hook(head, head, 0);
-- 
2.4.2.767.g62658d5-twtrsrc
