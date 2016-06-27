Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27FE92018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbcF0S0V (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:26:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32845 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbcF0SZt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id r201so26999293wme.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D6PcAJa4uGY6EqzWkO2Xo6t2sMhtFZmE/9MBZi1u0oI=;
        b=T3qrHUIJU1uFS7B6aO5citnARsx+ZvyIQilcmEGdSuieRKtwSOUpvaakDF0ZHBRonq
         FcSPGEPpaHziiUXhC6PWcSTa7EaTh+sycDUIylSQkM9T0pLGjRV+3/4SCRzIgeIk8aB5
         EAFxug/57aYxvT/Z3FGcczfUJYHOO3ZlCQuHnZz7ChiBDQLGINKQR/UNxHVKHsSUjV1S
         amIip8X+PMXa1ESr5e2mEubNQh9hJm1eRar9hMeDW/GFcz9BbFHTft7fO01Bc9B5xf0t
         toPSL8FaPVv/dKRYNG2J5boIpIyMGvWSL8o9+Zxqj4O5Afj4d8/S4tvGQ0gYdXXL3EhW
         HTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D6PcAJa4uGY6EqzWkO2Xo6t2sMhtFZmE/9MBZi1u0oI=;
        b=fz3TMScnJFV9AfxYdEbJo+uJ/gnSqczN0r0iv2BD08r77KNHKiG0iFfA+XHMnAzd9o
         etkr4SfApbZAPXwm88Piz+r9E4d15DlnKaD2lWR78qvfliZ04qBObnelxX+cdT1AzAro
         AYmZxPDW5QkvxlhXbnffCciBv2W+zPK+Ty/3+ka48oRzqiLjuwOhjOcEpVMIpO+Djs2R
         AfQEFd0YAcRfK+4/gi+iq/5LFpm8Z+LyEAURPak2apo7G35v2iWz0nrxTXDNTz+DDCHF
         +SHN2gWsaXKNvADgpGbt3C0Xiz4a7/u92kAdvWCgh8eBZS/WEELlK56IF7Exdx0HJvuZ
         8OLw==
X-Gm-Message-State: ALyK8tLzgqIMwswqtG+xjdtD5bS5lkpug6C8LjnZRKh+Oz+TTcug0coHhRPFuu2WRRQ9yw==
X-Received: by 10.194.2.44 with SMTP id 12mr2134388wjr.61.1467051948462;
        Mon, 27 Jun 2016 11:25:48 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:47 -0700 (PDT)
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
Subject: [PATCH v8 36/41] apply: don't print on stdout when be_silent is set
Date:	Mon, 27 Jun 2016 20:24:24 +0200
Message-Id: <20160627182429.31550-37-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This variable should prevent anything to be printed on both stderr
and stdout.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index 1435f85..e2acc18 100644
--- a/apply.c
+++ b/apply.c
@@ -4698,13 +4698,13 @@ static int apply_patch(struct apply_state *state,
 		goto end;
 	}
 
-	if (state->diffstat)
+	if (state->diffstat && !state->be_silent)
 		stat_patch_list(state, list);
 
-	if (state->numstat)
+	if (state->numstat && !state->be_silent)
 		numstat_patch_list(state, list);
 
-	if (state->summary)
+	if (state->summary && !state->be_silent)
 		summary_patch_list(list);
 
 end:
-- 
2.9.0.172.gfb57a78

