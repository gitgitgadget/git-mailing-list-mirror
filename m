Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA1A1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 20:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbeCMUkU (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 16:40:20 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33058 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752740AbeCMUj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 16:39:56 -0400
Received: by mail-wr0-f193.google.com with SMTP id r8so2328068wrg.0
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 13:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mph3K9L4jwZso876bvHyXOiN/Z4un/WuZBWpmm95zZw=;
        b=q/7nPke4Izva3vUW/csgcI5n81Y68AaakM7JxJF5903vkxWOC+PJy25apbIiaAEuku
         oq6biMONdaMxM/CbU0uSltUq/abDsXDTzu0P/Ig510dBdRuPlWlHN1GXZrGFvXBc3ToD
         FxEZq+vxx+K0Alyn+qJ44cBHie71wdQnPUCzROnpaxwd4IWoEm/DP8I4VpG2EUaqB08L
         28F3EpXTNiG5gtQe2X0y+Mc2LjaOos4lyTn+wuyZnKBJDda3X/Z623Cg3WGOG85hqpwW
         4JzaPr+uTQv0XXqEBuvn3dnlZ+xN7JDSOMWwzx9aJW9zrWB3l6eCMcyJLRN/9pKaKy15
         EZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mph3K9L4jwZso876bvHyXOiN/Z4un/WuZBWpmm95zZw=;
        b=GTthuPI5l9DDFl5vMiVWug7LPkcpjZslELLKvjeusRL8n9+x/kx7wBap5FQ/x2Gr+7
         pGsnXqZWzTMlJWZQBx8LH5t0Uqz4n0VdhqUodvqdld777RLrEDqo7bEKlthIVpo4jpZv
         23YF4DHPfhSIbWWBQUkS+sKmyapvrg+PuZ3bDWONLYo7RZIX+jadfsbQ81zw7U8ElscM
         pKerN595UgKRSSlPD8LhBFxngzqzcsgC9uSOGUiERCa6KGYI3ZCCplQeSz5HmrqTDHE3
         6M8hiBy2WJjZ6T+Q/3cHtfBV3mdK7dp7gA+IuJCGrR+H88CjrNG2nLFOs8XqjqwsqpvB
         cmzA==
X-Gm-Message-State: AElRT7HTdqiQD4QWAufl2xH2W+FJ8GcQbJ3zWfS6bgPVvyFhDdgFojuI
        WBWnpo5lmicekg7TXe1ZjQ9zDzd+
X-Google-Smtp-Source: AG47ELukPmXOw0witEoY9yAjkcg8KWkeLawBD5PEcdl/6YrEz2WTcqMJVR6OIl5kkSspAPy0ZfWc1w==
X-Received: by 10.223.134.42 with SMTP id 39mr1755817wrv.10.1520973594544;
        Tue, 13 Mar 2018 13:39:54 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m9sm1424203wrf.13.2018.03.13.13.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Mar 2018 13:39:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] Makefile: add a gitexecdir_relative variable
Date:   Tue, 13 Mar 2018 20:39:34 +0000
Message-Id: <20180313203935.5084-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180313203935.5084-1-avarab@gmail.com>
References: <20180313203935.5084-1-avarab@gmail.com>
In-Reply-To: <xmqqfu533jrk.fsf@gitster-ct.c.googlers.com>
References: <xmqqfu533jrk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable will be e.g. "libexec/git-core" if
gitexecdir=/tmp/git/libexec/git-core is given. It'll be used by a
subsequent change.

This is stolen from the yet-to-be integrated (needs resubmission)
"Makefile: add Perl runtime prefix support" patch on the mailing
list. See
<20180108030239.92036-3-dnj@google.com> (https://public-inbox.org/git/20180108030239.92036-3-dnj@google.com/).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index b2f8f2b171..ee0b6c8940 100644
--- a/Makefile
+++ b/Makefile
@@ -488,6 +488,7 @@ pathsep = :
 bindir_relative = $(patsubst $(prefix)/%,%,$(bindir))
 mandir_relative = $(patsubst $(prefix)/%,%,$(mandir))
 infodir_relative = $(patsubst $(prefix)/%,%,$(infodir))
+gitexecdir_relative = $(patsubst $(prefix)/%,%,$(gitexecdir))
 htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
 
 export prefix bindir sharedir sysconfdir gitwebdir perllibdir localedir
@@ -1735,6 +1736,7 @@ infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
 perllibdir_SQ = $(subst ','\'',$(perllibdir))
 localedir_SQ = $(subst ','\'',$(localedir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
+gitexecdir_relative_SQ = $(subst ','\'',$(gitexecdir_relative))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
 prefix_SQ = $(subst ','\'',$(prefix))
-- 
2.15.1.424.g9478a66081

