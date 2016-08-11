Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7D7203BD
	for <e@80x24.org>; Thu, 11 Aug 2016 18:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbcHKSrX (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:47:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34512 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219AbcHKSrN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:47:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so870363wma.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 11:47:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=voovGovDpCE9uEDEcc5yNJxg07bmFvm/1yl0I7dJrrs=;
        b=aml36lRwHo2yXCIf/6Jlg2ys6DB3b2GWcumco5AH3+iYPsSMo48sK8AhG4/eydy6IW
         mZY8In6EUqbx3wg7pPcLlUsyTZvkUycqlKmzNrZAce9KrqEgk9yAkHbLsUryXQn0jB/Y
         S1YlzT+7dcjnyihDzwJJEmwSCWyOwUh+ViHDKnGy/7UpR/CBQgPy5JFxGZPN/oJyT6Ja
         zGA/HihHAXsvLbrw4r9xc38KBkdS7h9JyF3Bj8ljaPEkFLS+dfzizeMu2ClNH6RtYy4S
         sqZXsUra3MUTIvyG+uW+PttAFKUOTHx04LNTjP2vEdVAGpzUKsuZjGKytX8IBMvTtxAp
         Z54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=voovGovDpCE9uEDEcc5yNJxg07bmFvm/1yl0I7dJrrs=;
        b=Rqws80YpA4gVWbp6bbdHK56lp4NehfCMz7Jw5ji89z6+uGNCxJCBmlR7OITYtbvoKS
         OFgstt57uCfa+sYm3b8zSJ15I5jov+0PYeRvq42ofdApXAVuslcaWg42z9JZV+xp6vt1
         mQCPmnKPZ9N1A5I/ceblQf7IWO7O7xlMyaaTwZuaQQta94SRwqdP+KKTbit47brKMiR0
         UXMDvEPzPI+VutLsUM3FAyQsYcjUiY6Yzp8fOsVy2MHApqLEzXQMfZLNF2U9l1QbRj1B
         g9iPMIEQIMCfUu+05dn3LTIqsOmwIYBmx8SNaEIKIcQufkcG3PhyLfhASBsGK+yoHsXi
         vLlQ==
X-Gm-Message-State: AEkoousHqLCGZUThhaEGe6AGrucHH58Ze8zRoJhTcPPG5HWu8Te9gizJKZw0tlez4B3jTg==
X-Received: by 10.194.178.193 with SMTP id da1mr13644294wjc.66.1470941232369;
        Thu, 11 Aug 2016 11:47:12 -0700 (PDT)
Received: from localhost.localdomain ([80.215.37.180])
        by smtp.gmail.com with ESMTPSA id 190sm1047236wmk.13.2016.08.11.11.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 11:47:11 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v12 12/13] apply: learn to use a different index file
Date:	Thu, 11 Aug 2016 20:45:00 +0200
Message-Id: <20160811184501.384-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.769.gc0f0333
In-Reply-To: <20160811184501.384-1-chriscool@tuxfamily.org>
References: <20160811184501.384-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Sometimes we want to apply in a different index file.

Before the apply functionality was libified it was possible to
use the GIT_INDEX_FILE environment variable, for this purpose.

But now, as the apply functionality has been libified, it should
be possible to do that in a libified way.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 10 ++++++++--
 apply.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 2ec2a8a..7e561a4 100644
--- a/apply.c
+++ b/apply.c
@@ -4674,8 +4674,14 @@ static int apply_patch(struct apply_state *state,
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
-	if (state->update_index && state->newfd < 0)
-		state->newfd = hold_locked_index(state->lock_file, 1);
+	if (state->update_index && state->newfd < 0) {
+		if (state->index_file)
+			state->newfd = hold_lock_file_for_update(state->lock_file,
+								 state->index_file,
+								 LOCK_DIE_ON_ERROR);
+		else
+			state->newfd = hold_locked_index(state->lock_file, 1);
+	}
 
 	if (state->check_index && read_cache() < 0) {
 		error(_("unable to read index file"));
diff --git a/apply.h b/apply.h
index e2b89e8..1ba4f8d 100644
--- a/apply.h
+++ b/apply.h
@@ -63,6 +63,7 @@ struct apply_state {
 	int unsafe_paths;
 
 	/* Other non boolean parameters */
+	const char *index_file;
 	enum apply_verbosity apply_verbosity;
 	const char *fake_ancestor;
 	const char *patch_input_file;
-- 
2.9.2.769.gc0f0333

