Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409CC2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbcF0SZy (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35290 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbcF0SZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id a66so26934441wme.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=epbeGeBLySE8uLhy+XDmnDTsWhdH2h1oAVj9L0O7NUQ=;
        b=Z5wxzmTzuJ3C5zEdiiPyoRgIsNTUZB6UrBuJGvPeEEErxj0T+xA+dPqY29yLXRDg/c
         J+MsnaePcH+ikaateBnGPYkeSC54CFyuS2L/cQsFZUB+86XI19SWByrpFcR7aTNN+61P
         Fn/L+COWYWSexbiC7xZ3nb5Yy77D5aAVUmzGgFAiTkLH06v/20dYia9kuYwTNr9yI5sn
         yjdz3hwAOta201XypD1DC6MXLM7uu7t2YiEQKrp+tgOc+ud0rtiokQFVLol31OhNU6My
         rPWTqi4Oq/XyRWf4wlDZXjsegwouQfI1C+JeLbivVMB06UmF3Nia1uVkIbWlqYP3g+se
         hm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=epbeGeBLySE8uLhy+XDmnDTsWhdH2h1oAVj9L0O7NUQ=;
        b=hfh1xIgcdCRGFR4YCb7+gpw4zKOLjFNg59KUYuhGTZIDiAzvP6rM0oV58VRc0/Bbdj
         foUZGFwTtfpQd5zh+WooHO/6fCBWMHILkBr66e1oaIengX/znGNlc9h0FhhPcYXuypLy
         HHwCYCmu9xa35lHC9o4sViZbYnLbXkbyfNLIRKlO2mnSTQgvaZvdb6ZK+qR8feHvrzC6
         luoPm7nOjgIEwXO42UdhBWtV7Qgs8XOAjxyNJBPJ9h3mO6X5e4aEftk8hp3MGl0Ith0E
         4nu1IU6nwcS8s8Xs/y8GzbWLCyRWB5MGNxevlJUWJQV9DntQoeD7gTVc8JqxtbCLK3ly
         zb8Q==
X-Gm-Message-State: ALyK8tLcb252NE/h5tiOfmp7h4MUpwXi0g3V0Y2PhoNXiZ8oB3Q/m1qcwGKC+x+J+Ay9Ug==
X-Received: by 10.28.93.65 with SMTP id r62mr5028017wmb.51.1467051947203;
        Mon, 27 Jun 2016 11:25:47 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:46 -0700 (PDT)
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
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 35/41] apply: make 'be_silent' incompatible with 'apply_verbosely'
Date:	Mon, 27 Jun 2016 20:24:23 +0200
Message-Id: <20160627182429.31550-36-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It should be an error to have both be_silent and apply_verbosely set,
so let's check that in check_apply_state().

And by the way let's not automatically set apply_verbosely when
be_silent is set.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 802fa79..1435f85 100644
--- a/apply.c
+++ b/apply.c
@@ -122,8 +122,11 @@ int check_apply_state(struct apply_state *state, int force_apply)
 			return error(_("--3way outside a repository"));
 		state->check_index = 1;
 	}
-	if (state->apply_with_reject)
-		state->apply = state->apply_verbosely = 1;
+	if (state->apply_with_reject) {
+		state->apply = 1;
+		if (!state->be_silent)
+			state->apply_verbosely = 1;
+	}
 	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
 		state->apply = 0;
 	if (state->check_index && is_not_gitdir)
@@ -135,6 +138,8 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
+	if (state->be_silent && state->apply_verbosely)
+		return error(_("incompatible internal 'be_silent' and 'apply_verbosely' flags"));
 	if (!state->lock_file)
 		return error("BUG: state->lock_file should not be NULL");
 
-- 
2.9.0.172.gfb57a78

