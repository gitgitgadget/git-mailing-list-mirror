Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D32971F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162550AbeBNTBj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:39 -0500
Received: from mail-vk0-f74.google.com ([209.85.213.74]:52643 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162541AbeBNTBg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:36 -0500
Received: by mail-vk0-f74.google.com with SMTP id o17so8439147vke.19
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=c+wnFIUlU1j7ERxDDg0nOjdIjr0KdzCZ5cHV4LSyAb8=;
        b=F/Ik6gAQLUn4SkTUGnYnlUX+xp8TkG2mDZTALOPVPP5V8VjkTDRSY9jMwr+odiN6Tf
         PU8nlAffLTGf3kjNm0vA/bb+PxrEWzoyhC7fQfYrHwI7Aa5DBD2oxyn9T9uV1O3lxI3N
         qWlGRI9m50ekEi+KfpO+aaQTAudIiYa/mWbec9tHyLJD5szgD6FaJN8J7rF31E0/9K75
         TmPRwCp06nx8itBDBuUIUiWf0//OoiB+/ZgugkolXPRBrjiX1a/a3M5sz5BLot8q/V3T
         VlJ2ZEVecLPaXonkp8mp7YGRb6QKSyBbWTk34VAu4IMIUQnohc2mch12d+j5AjeEBRm5
         h2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=c+wnFIUlU1j7ERxDDg0nOjdIjr0KdzCZ5cHV4LSyAb8=;
        b=Skfc+wdAIMR+0LYNzuIvyb6XxZbX37mP0Qo1N8yCpEdECRfyhmmnsqQsD8ximdrrpb
         fKMi8ABNtNoj0fW3oyTsRoVFHD3kpQIGF47OZGzOOA0jetbPUl/fL4K+G1z302pGVoGy
         FyGU3TnwLLHoi2SC8LICoAealwsB5bcHhs2XkSV9VpAWtmm1vqNI0edUfpt3RRtymDbm
         cgQNEvj4CPqDCr2Grd/5xYlLZfqSPINuqF8yUwuZscex/+iSTPZ2Heb/rpfGA9t1XEKR
         BO7bEfhcUKlxsqsx/ezf3vd5he784Xkag0HAWt708e7zOQsHGyx/EAVksfwoNOBnPPye
         dNGg==
X-Gm-Message-State: APf1xPBVpm4o7/Jbn5BZ96g1K/tJ1MgrEtXWKLgJvET2odDLeeCcdvvt
        M6ZjvSHIguH2msQoJhBfJTel/1XqJjVFf47J9oo4gf32Pr2uLv6yLWr/iJyM1+48x//k0R4HGmi
        2drmaHh1uLII45UjYK4XbtxuD7UazLaKXdOKBqGm87CpSp13UVuON45iXNw==
X-Google-Smtp-Source: AH8x226VrE4rPfYc4qF+IpkcTD74TGPWaYXzbDSGPD1R+Pg4MUnjLEekwDR+FAWwcxiKlNwTP1mrgZfBqt8=
MIME-Version: 1.0
X-Received: by 10.31.211.6 with SMTP id k6mr2737369vkg.103.1518634896156; Wed,
 14 Feb 2018 11:01:36 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:42 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-21-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 20/37] http: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/http.c b/http.c
index 597771271..41cfa41a9 100644
--- a/http.c
+++ b/http.c
@@ -1194,14 +1194,14 @@ static struct fill_chain *fill_cfg;
 
 void add_fill_function(void *data, int (*fill)(void *))
 {
-	struct fill_chain *new = xmalloc(sizeof(*new));
+	struct fill_chain *new_fill = xmalloc(sizeof(*new_fill));
 	struct fill_chain **linkp = &fill_cfg;
-	new->data = data;
-	new->fill = fill;
-	new->next = NULL;
+	new_fill->data = data;
+	new_fill->fill = fill;
+	new_fill->next = NULL;
 	while (*linkp)
 		linkp = &(*linkp)->next;
-	*linkp = new;
+	*linkp = new_fill;
 }
 
 void fill_active_slots(void)
-- 
2.16.1.291.g4437f3f132-goog

