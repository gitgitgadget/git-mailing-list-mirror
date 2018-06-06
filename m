Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DA91F403
	for <e@80x24.org>; Wed,  6 Jun 2018 10:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932382AbeFFK1e (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 06:27:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51097 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbeFFK1d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 06:27:33 -0400
Received: by mail-wm0-f65.google.com with SMTP id e16-v6so10491258wmd.0
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 03:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6FO0uMqEdpdcyF/+doPYrsiuidCu6TyyguACx6h+MaI=;
        b=VkjSNb+mFQ4xhpnhxcCfKphojsd6BUDq7GglYdn39BRgaVDoFWm5G+ppvqQK6wjwfC
         JPGylCwOaKiW4shEbcRxM357AFOcPnPEBvzEik6xDUR8URLgZCQAYfrDl+Y/MiimOXbx
         JyxcyKgQsuPlEX336I9TZB9q+wOv59zzektetAKCjFLRA0EwwgnloYggUQFFdbBLrVt7
         H5d9hh1uuh987VJxZTr2hAEix5iwP9TiJOsbQ35ivDi5oO9SxURmsVl+91DB1T3Lo5l4
         R0trCv/B+LeqbiPNgPVwAobY3lHesMNPf5J6bKVk7foIdcfcrIP8P+Ymg3vji9YWR1zM
         lPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6FO0uMqEdpdcyF/+doPYrsiuidCu6TyyguACx6h+MaI=;
        b=k3PJ+0cdlVDRDg632GuxJVNDHv4CzBM/v/pDcbSJGvUdrErHG2tX9uMP/ReOkrRBQH
         fBIMdYK/qr3ThhajfPWUVsH6uj0QSnVmKFER4dP/zyn4t5okrDV/8HqXq4RZxW5YY1tr
         cTrjNjN9inesSAjXHVpyRWNbcmaFk5Fgc4KBqnvod1ETs14/OLYK8YGxDl0Z7HgoYaxI
         Vwj31KQFY9KpMQ9Eq7l6Cq/8j8lXroMXF0Y4WmwFJ8dUe1gHbJ/avBD2JbAgAqC4bhbk
         ToU9P88B+rlZOxZXI94CFNlKh/5Fw5HCnW+C147hTSfq6aZSgZAjclunFGEDryBEQ34t
         A8qQ==
X-Gm-Message-State: APt69E31tZvHz17G3UB7qeGM7uYu8wSq/AAQQlVgjegzSI//ktjy+EhK
        QRY4FmmGl5lS2GzdxxDeSSIHsPoZ
X-Google-Smtp-Source: ADUXVKL5EHur7OlD7OAImY4+1dAdg4fnaLpJapw7xPBmy3mms/y2WlGlHPlQVUo9FVDw9T2jJIOhlA==
X-Received: by 2002:a1c:7204:: with SMTP id n4-v6mr1299857wmc.138.1528280851836;
        Wed, 06 Jun 2018 03:27:31 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id u108-v6sm63722766wrc.40.2018.06.06.03.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 03:27:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/2] config.c: use braces on multiple conditional arms
Date:   Wed,  6 Jun 2018 10:27:18 +0000
Message-Id: <20180606102719.27145-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180606102719.27145-1-avarab@gmail.com>
References: <20180606102719.27145-1-avarab@gmail.com>
In-Reply-To: <87lgbsz61p.fsf@evledraar.gmail.com>
References: <87lgbsz61p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust this code that'll be modified in a subsequent change per the
CodingGuidelines.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index fbbf0f8e9f..12f762ad92 100644
--- a/config.c
+++ b/config.c
@@ -1149,9 +1149,9 @@ static int git_default_core_config(const char *var, const char *value)
 	if (!strcmp(var, "core.abbrev")) {
 		if (!value)
 			return config_error_nonbool(var);
-		if (!strcasecmp(value, "auto"))
+		if (!strcasecmp(value, "auto")) {
 			default_abbrev = -1;
-		else {
+		} else {
 			int abbrev = git_config_int(var, value);
 			if (abbrev < minimum_abbrev || abbrev > 40)
 				return error("abbrev length out of range: %d", abbrev);
-- 
2.17.0.290.gded63e768a

