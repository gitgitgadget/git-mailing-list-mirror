Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40AAE2018B
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbcF0SZS (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36063 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbcF0SZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id c82so26935699wme.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:24:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vom7RXATRfclGwckafaFoFW30fkDJC9LenISrNW0yRY=;
        b=ue90aKYdTAkG2/gSySF0v3HNqyCaKwhw6jQZf0zVLB1P0y5s6gGabL8SZYp8E/KRtB
         dt8RD//cxLNt4wD4o7Qh64+UI+iuPjyOdT98kUW3bAHBBAB5Guvwh7cAXM/2gEuUwmX6
         wSyW5AD0prA/4cKE4krASjLLEqVag2SzeapKd5cAgDz5ivvNAESF795Tc0Voo+cJQOu4
         gJx6+hi73Yi3RiPsomCNGSBS/cMsz5VwaaLTtxMawWZaPvfRVpVarxmWjy1A/VldrlXv
         2Ap4SfBN1pn0SzrhI9Zv3F4Snp649+joxYYNOpA2McrwlI+an2Ew1vX/OrFVG2n1iSbM
         hwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vom7RXATRfclGwckafaFoFW30fkDJC9LenISrNW0yRY=;
        b=X5S4j0+drjI47t4rnJHXRLTqrihWkYn/+mknsJP9ifbtV8PcHX8Jwg3t4/A/mlKhh+
         l1PPFPsRLO2wi50DxfoavEjhZyzvwmPlEb/gHs3F2R5J526Oq/2YIvgXxghsT8ljhcwq
         bxBoOEuwuNU/aqZqL4u9+FcYyJQ7HjmfQZzvEmSpuT8toSviAGFbLgj9ZHaCzs08eHLY
         Z/YG7uML52vWj6QHu60fy/Bdn145jSJg4QChiuGxNkP3dWluA0IdnNx073rKfReCBRwI
         62XfeXXaScJ9nOgtlqCOjilWXjGs+xzfmVZtUnBEbSrbpk75dqSxwctzj3aWCLopWOC4
         PPew==
X-Gm-Message-State: ALyK8tKxdvRIeWoW7uV1NsQ2vTSCpkUMmi3NfXHXdCraV70iEemBe2vRFMoYVy1Ww4094g==
X-Received: by 10.28.166.150 with SMTP id p144mr11441595wme.57.1467051895776;
        Mon, 27 Jun 2016 11:24:55 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:24:55 -0700 (PDT)
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
Subject: [PATCH v8 04/41] builtin/apply: read_patch_file() return -1 instead of die()ing
Date:	Mon, 27 Jun 2016 20:23:52 +0200
Message-Id: <20160627182429.31550-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing. Let's do that by returning -1 instead of
die()ing in read_patch_file().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 2aea203..ba716c1 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -335,10 +335,10 @@ static void say_patch_name(FILE *output, const char *fmt, struct patch *patch)
 
 #define SLOP (16)
 
-static void read_patch_file(struct strbuf *sb, int fd)
+static int read_patch_file(struct strbuf *sb, int fd)
 {
 	if (strbuf_read(sb, fd, 0) < 0)
-		die_errno("git apply: failed to read");
+		return error_errno("git apply: failed to read");
 
 	/*
 	 * Make sure that we have some slop in the buffer
@@ -347,6 +347,7 @@ static void read_patch_file(struct strbuf *sb, int fd)
 	 */
 	strbuf_grow(sb, SLOP);
 	memset(sb->buf + sb->len, 0, SLOP);
+	return 0;
 }
 
 static unsigned long linelen(const char *buffer, unsigned long size)
@@ -4425,7 +4426,8 @@ static int apply_patch(struct apply_state *state,
 	int res = 0;
 
 	state->patch_input_file = filename;
-	read_patch_file(&buf, fd);
+	if (read_patch_file(&buf, fd))
+		return -128;
 	offset = 0;
 	while (offset < buf.len) {
 		struct patch *patch;
-- 
2.9.0.172.gfb57a78

