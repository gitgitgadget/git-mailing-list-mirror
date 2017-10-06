Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730B820372
	for <e@80x24.org>; Fri,  6 Oct 2017 20:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbdJFUMv (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 16:12:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:47837 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbdJFUMp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 16:12:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id t69so9598726wmt.2
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 13:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4i9h9kP3PXdehtFU/o7P+gAsOwr3HMEHiEt7x3LBFs4=;
        b=bzYmcCZtQa+uAXHbAYicXmSEamHrMlNUWTUEEKgZAMApDDTd5kO1X2XdlsdLKi2SaQ
         OAumTL5OhBdbTE+/Ot4Oe080lDEfTTsHugOoYWOPPYXkUOJJRkHNnnBl1bfWCX/yi0Ld
         mo70vx/79+2rhh0NCXiEy45Xo5D1MgragyzIJLaXQE20BcRjYGhhR3nSlshWxOfiQ8Zv
         YCvyil9CIbtSTBlQn9TbfhGQfTITVWUHYUbHp2MFBUnv17fX0e6Ze5aB74+wg7XX1iTi
         vEFAUG/ZDF1FhCEWXuniHwVjwO4Mj7TL63AYCtlbT31PuwVcrE4d76imyL+XiGJ0SlQK
         56pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4i9h9kP3PXdehtFU/o7P+gAsOwr3HMEHiEt7x3LBFs4=;
        b=oP3r8/ZiTjqXA7n6krC12Y6Pu9RIhuzUjBeX/1Q8DaeoXDZ+6vHHXY0ISZeVZlhVog
         H5AwnHQjGKRV2pvkTgfxMd9qZPqdomh6puCmWGV5QoxPRqFciFn6vP62IG9NyaNw/BUe
         1JxjRPMjaJszGv7K7WXeW8hmnV9Uz4cQbybrOlfNksSGl4voUv2i468GclS9u0Y1Y4uy
         4d0eEiMepwPOts9rDZ+92oNjToYBxvA3Fg1ZkGFUPiG/k0DHpO0N5iGf2DP4/B5Ml3P9
         vDfIS7uwEkoyas/iDqkzEOhZMSbmvxTvmJHfTZ38PrjMMcMxaOjlzlmEFcPUzxmTCCBz
         o2VA==
X-Gm-Message-State: AMCzsaXlnX8x4mbHg23djTt1Tln0rqKb/8oHKSx4MCj9IyadiYqxjArR
        k2Bghoj2wCdFOIAedEhOV3iDrhtPpag=
X-Google-Smtp-Source: AOwi7QBMPdCuhJLDt20rx9vzrDleW+sN/E788k2mpjr5jH0M39wA3sBuDKpf48+tlPzrL8D9AHqQEw==
X-Received: by 10.28.51.133 with SMTP id z127mr2524979wmz.110.1507320764223;
        Fri, 06 Oct 2017 13:12:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id h45sm2906522wrf.36.2017.10.06.13.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 13:12:43 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/12] checkout-index: simplify locking logic
Date:   Fri,  6 Oct 2017 22:12:07 +0200
Message-Id: <02ae242fdde2ba8acb6b87e32df2b1e33786e78b.1507320376.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0
In-Reply-To: <cover.1507320376.git.martin.agren@gmail.com>
References: <CAN0heSqr77dptPG2mixnLdNKKcgD36aPnEFtnTB6Oyip6WfQBA@mail.gmail.com> <cover.1507320376.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`newfd` starts out negative. If we then take the lock, `newfd` will
become non-negative. We later check for exactly that property before
calling `write_locked_index()`. That is, we are simply using `newfd` as
a boolean to keep track of whether we took the lock or not. (We always
use `newfd` and `lock_file` together, so they really are mirroring each
other.)

Drop `newfd` and check with `is_lock_file_locked()` instead. While at
it, move the `static struct lock_file` into `cmd_checkout_index()` and
make it non-static. It is only used in this function, and after
076aa2cbd (tempfile: auto-allocate tempfiles on heap, 2017-09-05), we
can have lockfiles on the stack.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout-index.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 39c8be05d..b0e78b819 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -129,8 +129,6 @@ static const char * const builtin_checkout_index_usage[] = {
 	NULL
 };
 
-static struct lock_file lock_file;
-
 static int option_parse_stage(const struct option *opt,
 			      const char *arg, int unset)
 {
@@ -150,7 +148,7 @@ static int option_parse_stage(const struct option *opt,
 int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	int newfd = -1;
+	struct lock_file lock_file = LOCK_INIT;
 	int all = 0;
 	int read_from_stdin = 0;
 	int prefix_length;
@@ -206,7 +204,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	if (index_opt && !state.base_dir_len && !to_tempfile) {
 		state.refresh_cache = 1;
 		state.istate = &the_index;
-		newfd = hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+		hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	}
 
 	/* Check out named files first */
@@ -251,7 +249,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	if (all)
 		checkout_all(prefix, prefix_length);
 
-	if (0 <= newfd &&
+	if (is_lock_file_locked(&lock_file) &&
 	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die("Unable to write new index file");
 	return 0;
-- 
2.15.0.rc0

