Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C001F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbfA3Jtp (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:49:45 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39876 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbfA3Jto (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:49:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id r136so11178210pfc.6
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SmjGqYtJ8ynsE6cS6w95dHKYdgz60nXUccBzG4nqRRs=;
        b=qkq+9XivsblS2dqnKka6Pn+d1CV+ft3A/voiVhYSBFijiZqRNC89LnbedgbNNr0l1J
         SdBMj75oGW2ILYJOScOvfm5ia1iWeg2ms0xv8hCTQoDo6o0hjvxBN2c3H5KmkYRtkmSI
         ZxAJrqB+ZvVorKxWD6QkP6jqxAozGj/8m/Lu3pU9ott73bMGdf8UMkcYI7+aKzY5OIyq
         autvb1OBBFdNga1z8T/DWfmM6WkIQmsxpUddBzFqRnupm9ozTcpTCBt+4u0S0+E7QWRc
         20REinkpkM67CiQcAglilOi/Mdiy5sifCLWY6M8v/FoJxhLiN393JpxnSa3B2zJImVZO
         qe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SmjGqYtJ8ynsE6cS6w95dHKYdgz60nXUccBzG4nqRRs=;
        b=OVd6yK+Fc3E4iHw5G/GGz4QlQbF1eGeg+0PMVwBm8ugmKVgWkPgCFAB6ZudVUUebu7
         XsH+YSQy88x5HTPtRNyB7JxDOR8gqRKiqtK1QOh0wOsSL3Kz34heMTTVInaiYnQIS+Lp
         PzE5PxfP2a51+yABHzHYLvPZuf7x9hKUZ5cG04kjGKKi0MwM3Cbm7C4+k4lPGWcmuBBS
         wor6Zy/bqKrTFTh0TLGpnB5NHE3CP9JsdYwXh/1V90x6c8HFkkbaYTRWh3AcI0ZVeQmw
         dsQovwRqqLsg5JS1Ae50Q4wY+Kkka/oUm/4bvttUTvuOidb0XgTBguwyOi1xzn6jcMAV
         2ybQ==
X-Gm-Message-State: AJcUuke/25/XiYLZAhD63r5YRRgpzZrzCqmoY829vom6jGju5iIWpbsr
        bR0dq0a9NtH6JaNK1Mxh88+4CcN8
X-Google-Smtp-Source: ALg8bN7a2pFkx9wNfLSW8jhnE+/Wnh9zSKEumBc7NG7p7T5f+GEfX7SKqefGdN8HIRpY27DgnmNxTw==
X-Received: by 2002:a63:160d:: with SMTP id w13mr27598390pgl.43.1548841784076;
        Wed, 30 Jan 2019 01:49:44 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 24sm7821392pfl.32.2019.01.30.01.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:49:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:49:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/19] switch: add short option for --detach
Date:   Wed, 30 Jan 2019 16:48:26 +0700
Message-Id: <20190130094831.10420-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git checkout" automatically detaches branches and --detach is not
that useful (--no-detach is more likely). But for "switch", you
may want to use it more often once you're used to detached HEAD. This
of course adds -d to git-checkout but it does not harm (yet?) to do it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 69df3a1547..49c7ac211e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1381,7 +1381,7 @@ static struct option *add_common_switch_branch_options(
 	struct checkout_opts *opts, struct option *prevopts)
 {
 	struct option options[] = {
-		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
+		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
-- 
2.20.1.682.gd5861c6d90

