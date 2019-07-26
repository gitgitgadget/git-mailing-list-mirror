Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91BA11F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbfGZPJG (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:09:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39865 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387749AbfGZPJE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:09:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so37617407wmc.4
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5VK7GSe3vK933aCGBev1CIXdxyB0Q+tZ+wQj2qxGq3Q=;
        b=CijPiRh+YXjQU0DB/QudEjnJy7FmDd3uAhCyLTv7BhwWvUbNZOh4jquekBgWy7WGKy
         OfBoaVJyj5kqdpuw6faV6fqBCnzAnQh/ZkT31sRXD6INJrle7nmSfOMd6BmiXpzfYWaL
         rkrMgsXisZMyn4duJ41vtsKBYXGTBmtKdLzkytQmnAV7N0bhS+gofNS/ov1TPIR8x1Ae
         2MK3LMWr4gVdawrgrLyshz4mvM/WgL6f1ip7FuUZ81OnBqglkAoSCjcFW3z+SaHf4Rtj
         9C05xoMBwZKNb1VPILQY93e+uiYq3UcF+RGDtk1PI3l0byuhamptgoU+SHWlwmIohbMA
         pwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5VK7GSe3vK933aCGBev1CIXdxyB0Q+tZ+wQj2qxGq3Q=;
        b=PdbpRJwBNP0bGJ/YZ+fwNXFZjSlQgGxaNHZBIDNRxBTJIDYRAG1DTiukKlc1dpQ+jN
         yisQjDEe4KUNHxGSNm2etN7et+X7rYsspMuZMBdbtMpyzvugvOM0Fc+Jorq+nWxnRDRe
         i/CnI7vGWgKHiJn7In0cdUsuv+CxiovmfuosRu+zrfWEOF4owS/qgjezjHElsppRxScw
         vUCMzXsngiuCsQFskCXgvEpQAIDvvyfNYb3kZZOgzswEjgkk/pSEPRxyhPdVhZdb09ls
         plky1jfzF7jm0MN6V2pEja/nVMRE2ayQFdkl7BfrjUJH+tk0Aymqdl/6jxU4vxbv6bYh
         yGoA==
X-Gm-Message-State: APjAAAUjp1GhcQ5lw1JHB8C1J2u2QIz/Hpm166664+fP48UKRUPSBM69
        S0TotZQyrTQ3GBjxCCgwGQMefZiEPKQ=
X-Google-Smtp-Source: APXvYqyQEUNLIG+KXEI3fmPRlp+mRw8bilYEnHxZs2YLtxUUysiW7Grm0/fAUFn6xrwK7n8Z2sZnCg==
X-Received: by 2002:a1c:2ec6:: with SMTP id u189mr33263760wmu.67.1564153741848;
        Fri, 26 Jul 2019 08:09:01 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p63sm4814341wmp.45.2019.07.26.08.09.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 08:09:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/8] grep: consistently use "p->fixed" in compile_regexp()
Date:   Fri, 26 Jul 2019 17:08:14 +0200
Message-Id: <20190726150818.6373-5-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190724151415.3698-1-avarab@gmail.com>
References: <20190724151415.3698-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the start of this function we do:

    p->fixed = opt->fixed;

It's less confusing to use that variable consistently that switch back
& forth between the two.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 9c2b259771..b94e998680 100644
--- a/grep.c
+++ b/grep.c
@@ -616,7 +616,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
 
 	pat_is_fixed = is_fixed(p->pattern, p->patternlen);
-	if (opt->fixed || pat_is_fixed) {
+	if (p->fixed || pat_is_fixed) {
 #ifdef USE_LIBPCRE2
 		opt->pcre2 = 1;
 		if (pat_is_fixed) {
-- 
2.22.0.455.g172b71a6c5

