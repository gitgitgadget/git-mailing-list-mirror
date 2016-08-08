Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 296082018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbcHHVFE (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:05:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35078 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbcHHVEu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so17868660wmg.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bd4BY5DmLcb5vqzatFOiI6so5PfhUctMrJnNaTCgcao=;
        b=PI7c6CLfZYDSZeq2sZCMVDCIR9EV8sOMoYWLNr/HndQF6PKbDL+IIw5F8EYGUqQiXr
         gDrmo7/0zOhmqm+w7N2pyJDI68D0bdjCf22Sq7+ZIXm78x+JQipGaTc6GbKV91ZXek+P
         Q90HNDsXGay3bn4bjAFYIvJU43GhjZVA+hW6y9M+X/YVmG9M8B8swLpOzzOgC9XjBByW
         eMxeWYXu5ma1hXLjTW7MDWNyGQv+3CuMDLYKYLJYYt3CIQp/Y7XyxYdoLlox5iROrJFJ
         4lravWMw4X9B926wrK3WPVoDCVIhc7oXTDBAHLy1cnTtY9bErmmtDe7lgHVKB84Fx91J
         SJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bd4BY5DmLcb5vqzatFOiI6so5PfhUctMrJnNaTCgcao=;
        b=DdqCRGg1MjMNQv2qhknIfzI8iVhVPpPTJeWZ1CoRx2HqoDFbyzhYpDWVOw138UBD55
         7GmsXFepmajS4z9bdIIQZCl7oAH8axAZfgHAJ3SN2MpZKK+R1tKwTUne7bKzeiKcg4l+
         ydmUPmaLavIbHmapZOTTad6zK/Lq4LpmfXsRHaxuOr8Co/ZnLm/9ZD9cmVsa14jOsXXB
         znNW8QnCeykygepqc5Rju67RxkJhKd4GNIfOyttduvHKAED7Lwlms/rpTnRi7JeJcA2d
         5/QvNoUll33w8V8e+aCfT2HFF3tVjXgvZ+ZwIRML+IwKqd7YTuWAiJ9fMdc09rZYly1Y
         CF4g==
X-Gm-Message-State: AEkoouvddncWpn82X694nJ8VAclIhvGd+vq/CwK/OG6TktvxCnraFDGNdOlBChD+Qq/CsA==
X-Received: by 10.194.38.166 with SMTP id h6mr86952171wjk.101.1470690289574;
        Mon, 08 Aug 2016 14:04:49 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:48 -0700 (PDT)
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
Subject: [PATCH v10 35/40] apply: don't print on stdout in verbosity_silent mode
Date:	Mon,  8 Aug 2016 23:03:32 +0200
Message-Id: <20160808210337.5038-36-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When apply_verbosity is set to verbosity_silent nothing should be
printed on both stderr and stdout.

To avoid printing on stdout, we can just skip calling the following
functions:

	- stat_patch_list(),
	- numstat_patch_list(),
	- summary_patch_list().

It is safe to do that because the above functions have no side
effects other than printing:

- stat_patch_list() only computes some local values and then call
show_stats() and print_stat_summary(), those two functions only
compute local values and call printing functions,
- numstat_patch_list() also only computes local values and calls
printing functions,
- summary_patch_list() calls show_file_mode_name(), printf(),
show_rename_copy(), show_mode_change() that are only printing.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index df85cbc..ddbb0a2 100644
--- a/apply.c
+++ b/apply.c
@@ -4702,13 +4702,13 @@ static int apply_patch(struct apply_state *state,
 		goto end;
 	}
 
-	if (state->diffstat)
+	if (state->diffstat && state->apply_verbosity > verbosity_silent)
 		stat_patch_list(state, list);
 
-	if (state->numstat)
+	if (state->numstat && state->apply_verbosity > verbosity_silent)
 		numstat_patch_list(state, list);
 
-	if (state->summary)
+	if (state->summary && state->apply_verbosity > verbosity_silent)
 		summary_patch_list(list);
 
 end:
-- 
2.9.2.614.g4980f51

