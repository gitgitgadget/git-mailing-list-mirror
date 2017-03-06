Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6B41FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 11:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753553AbdCFLlD (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 06:41:03 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34644 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752799AbdCFLlA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 06:41:00 -0500
Received: by mail-wr0-f195.google.com with SMTP id u48so21396313wrc.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 03:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fC5JCMoKPUsMs1j3G0eJmyqo0hdX5oxL72E2nEVrnxY=;
        b=oYgh/cUWn0Pv9lEr+jT3s2tbimEnnLxF9edseiPaRrNz9TqXNDj8QBpEh2BgH4Ugxk
         mp7cb9dGTzOua4GNI5iZfcxRwH3odScftnj9haYsYQ2uFz8xpYHWez2TuOWNPSpQnLfK
         GuVpy7/SoVCaU4gOS0J2SNC2HLPkqapntjh7obbg4NW5XK9GO+n9D3Rorz4ec0ciW5zH
         DwpS73B4+q4PCTFNktVk3a4pAmE34YjHghgx9r4gbi3D6jFNNXJmeWQz64K/LHxmSbpq
         eDJPhV/3+l4fkWd4jWwfm5BornlO6GF10rzSrH3haGILo+AqQ2I0Zt5DmmFRUwLNg+Vj
         di0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fC5JCMoKPUsMs1j3G0eJmyqo0hdX5oxL72E2nEVrnxY=;
        b=Tr1uE4NpSs1ZEbniP6pmusQMWE9tdyDObT/Towde6osHjIvgvz1+P2paDhcPAKFsuS
         HUagrnJwTUImvsbqtqzP87WbCR3f9BClAQ6uakaG2XX0xSuOpdh+LoEfAbcDM5h9miWj
         JSCIkkwOGE/FU6T092T8eS3T0XNClJpTijqXmCZMDvvhmjvvwol802Jq+trSns0aPK+f
         xf3yLuRfq0u/FfVtoolIngo4n6ZP92iGchL4Y+Tr/lKX5k1C4KCTlKYEsRGD6oUoRpGI
         4BirpGdT+FhB8/VxPExx1XVVpy1pYq9cq+cV56sSi5f/vBz2L9mLwkSSMthNIzOQe4Tu
         gJLQ==
X-Gm-Message-State: AMke39m9E+WMFRrbCTiOLy1rxljqZFIdu4QlBWFJv0QSLqJQK6dz2pm0eLXi1/jyJomCtw==
X-Received: by 10.223.161.204 with SMTP id v12mr14863017wrv.36.1488793338573;
        Mon, 06 Mar 2017 01:42:18 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:17 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 01/22] config: mark an error message up for translation
Date:   Mon,  6 Mar 2017 10:41:42 +0100
Message-Id: <20170306094203.28250-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index c6b874a7bf..2ac1aa19b0 100644
--- a/config.c
+++ b/config.c
@@ -1728,8 +1728,8 @@ int git_config_get_untracked_cache(void)
 		if (!strcasecmp(v, "keep"))
 			return -1;
 
-		error("unknown core.untrackedCache value '%s'; "
-		      "using 'keep' default value", v);
+		error(_("unknown core.untrackedCache value '%s'; "
+			"using 'keep' default value"), v);
 		return -1;
 	}
 
-- 
2.12.0.206.g74921e51d6.dirty

