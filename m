Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3C2C19F2A
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbiG2TaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbiG2TaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:30:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17C287367
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m13so3183756wrq.6
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UoY7mpk7Qo5GFKFqkKwE93tV0XG246YR3UoNXkoYwAU=;
        b=azt1GvXMai9fysHfNUblThRb5I2A9kxgbnqxOHzLQJ9gLn4Gp2QjqdZ+mvHGalr/C5
         R85rzegLetItZnL7BALSwxb2GzpMOyyQYqyiBtSsCJdqM8wCw5RUrzmzX27/gMNXTIa7
         4NKQW2Hn/qexkp+an/1Vwh3hKH3vEig+6X4Yj9Jm2mMBfR6A6k2t3TTl7LmzPjT1Kzje
         y33JTjmDrn8l3oS6VlDuaxbKI2z6sY1hAEwIayJKvkHCe7EWIgohSYzJN/4/WrumqWeM
         99oiGGNsgylZ2CWtyaTsXdKoHwzxQHbIMIJa7WEzjGIlNh83rjh9jMwZ8ZmHiI0e2FzZ
         c2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UoY7mpk7Qo5GFKFqkKwE93tV0XG246YR3UoNXkoYwAU=;
        b=4YoQqVCB1RiJh0yxvmQSO0PiN4Ct2SWO0dWq+YEPymTCXKTG/sdKf4uiwxI5NQcbaA
         0AkPBDIyzh8U+krDWf8lSAZSk2ti4mdsYqyZ5w+Wu9Eb6puI9P/wIRKrL5iZ6xlFMNXg
         87o680uqyDVwgx4uKer28cw6/ucvYQ0e8dhQHyQN++TmxIZDlfXPq25IbIEMkXxPwQZd
         b6i1nhrero6eQNb6MjQftJOl61CM8kUO/HdkPJXUWAZfhHs7dqgBa6/vicZ2T0RPv12+
         yYHJxPDTVRrkCNWADUymr6vpGKixjamrRaH3rg2PH0j0zi7GFh+dEK2rE7NGrZ+PUyr9
         O27w==
X-Gm-Message-State: ACgBeo0VSuLOW1NZSre1ibpecIPOaqoIGnmKYypf+pjgmJArSb5Y3z5+
        ZX9MnBRD+8oPO7tse5CgdVNHe9kIUdQ=
X-Google-Smtp-Source: AA6agR61O5SCkvzxiMkxsQz/cJLy+FFTOZWCnPdYUk9hssx5ncc8WXdF8krbGTt5RLbimdVpKnDGtA==
X-Received: by 2002:adf:efc3:0:b0:21f:15aa:1b40 with SMTP id i3-20020adfefc3000000b0021f15aa1b40mr1691260wrp.159.1659122992228;
        Fri, 29 Jul 2022 12:29:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b003a2ed2a40e4sm10007619wms.17.2022.07.29.12.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:29:51 -0700 (PDT)
Message-Id: <8599bb550457ea0edb3c412e84ee688061883e7f.1659122979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 19:29:39 +0000
Subject: [PATCH v2 10/10] fetch: use ref_namespaces during prefetch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The "refs/prefetch/" namespace is used by 'git fetch --prefetch' as a
replacement of the destination of the refpsec for a remote. Git also
removes refspecs that include tags.

Instead of using string literals for the 'refs/tags/ and
'refs/prefetch/' namespaces, use the entries in the ref_namespaces
array.

This kind of change could be done in many places around the codebase,
but we are isolating only to this change because of the way the
refs/prefetch/ namespace somewhat motivated the creation of the
ref_namespaces array.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/fetch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fc5cecb4835..004d92b3554 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -490,7 +490,9 @@ static void filter_prefetch_refspec(struct refspec *rs)
 			continue;
 		if (!rs->items[i].dst ||
 		    (rs->items[i].src &&
-		     !strncmp(rs->items[i].src, "refs/tags/", 10))) {
+		     !strncmp(rs->items[i].src,
+			      ref_namespaces[NAMESPACE_TAGS].ref,
+			      strlen(ref_namespaces[NAMESPACE_TAGS].ref)))) {
 			int j;
 
 			free(rs->items[i].src);
@@ -506,7 +508,7 @@ static void filter_prefetch_refspec(struct refspec *rs)
 		}
 
 		old_dst = rs->items[i].dst;
-		strbuf_addstr(&new_dst, "refs/prefetch/");
+		strbuf_addstr(&new_dst, ref_namespaces[NAMESPACE_PREFETCH].ref);
 
 		/*
 		 * If old_dst starts with "refs/", then place
-- 
gitgitgadget
