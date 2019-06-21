Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB05B1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 10:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfFUKSg (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 06:18:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46242 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfFUKSf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 06:18:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so5968473wrw.13
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u3sXNR/uk3730rKhBr46qXt/A79m86WhaGryYWzrqL4=;
        b=YEnLSfKfOtoKoi/k/nPW+rF2UecWTA6rpCNdaWpsxNJIsc7bYejaDeEIMx7Ql5phf5
         4R1iiROw0hgRzLTWIVtvNDGiWThH/iDOU80VAO3XF9dAMVWAIymFU8psZU5C8flTdhos
         xTLBQO9VGS+ukcrqoAijs2AMlbqNZiHS4nen9SzyNKS/6dhzDkwXui4Zh2cylQgkPzv+
         FCN7t94kW+Nd/j8l7OfYpJT3vLmsac71HgmbY2rTMNUip81PtZJURUhPAARYVLHmXEol
         kb2IpPF6yThzoRPXnU1lI7/b5EBZATepKI9CYuFsrExXOC0r8lGkCzmfUhhntlcjP/7P
         rjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3sXNR/uk3730rKhBr46qXt/A79m86WhaGryYWzrqL4=;
        b=azePSwnKcR7LxUjuDRZvrrbqlL9dggMj2afZeWxkfjWKkKL9G5GOdNkLx17uSVwLhy
         MUnGwXR9xF2JZkdD5rRA49zQdYrP2BfdNrN7Ld9nXkJyYmyRdYtWZkYBNRnOPc+CcZgy
         juxTwSvgIb0Cn6HFHLG9wnp+/naRUJbgTy5Kk2iJPtbAu8vybnIE7zeCABnwqwj/xL94
         8NBXeXNQFC+sHiBSZyECljbm9ASq91uiq3FEMJgdedabKgyL11GUOsHmpPvBDAZ2rUOs
         ytXDZIS3fmNPsGOsb8wIW43ASxoCT6EkBPUcFUgZJ0yNEhWWOOYOhCqEAoSLgj2PubQt
         Nc9w==
X-Gm-Message-State: APjAAAVEfibkKpdZv6QshdRW4eGgPu+tFsHtCjDodollok0gLFHTx8rh
        RL2/hWS44YS/SibU/nUj0FS/FVNJcVk=
X-Google-Smtp-Source: APXvYqz26u7Zz+zYHn5W0pxLHyQeqod5Meu8zQ2d6XiqtOMfW+x/YkxfCn2qT++N8Kt08sVn7opN1Q==
X-Received: by 2002:a5d:4ec1:: with SMTP id s1mr42158194wrv.19.1561112312629;
        Fri, 21 Jun 2019 03:18:32 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y184sm1878193wmg.14.2019.06.21.03.18.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 03:18:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/8] tests README: re-flow a previously changed paragraph
Date:   Fri, 21 Jun 2019 12:18:10 +0200
Message-Id: <20190621101812.27300-7-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190620210915.11297-1-avarab@gmail.com>
References: <20190620210915.11297-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A previous change to the "GIT_TEST_GETTEXT_POISON" variable left this
paragraph needing to be re-flowed. Let's do that in this separate
change to make it easy to see that there's no change here when viewed
with "--word-diff".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index 9a131f472e..072c9854d1 100644
--- a/t/README
+++ b/t/README
@@ -344,10 +344,10 @@ refactor to deal with it. The "SYMLINKS" prerequisite is currently
 excluded as so much relies on it, but this might change in the future.
 
 GIT_TEST_GETTEXT_POISON=<boolean> turns all strings marked for
-translation into gibberish if true. Used for
-spotting those tests that need to be marked with a C_LOCALE_OUTPUT
-prerequisite when adding more strings for translation. See "Testing
-marked strings" in po/README for details.
+translation into gibberish if true. Used for spotting those tests that
+need to be marked with a C_LOCALE_OUTPUT prerequisite when adding more
+strings for translation. See "Testing marked strings" in po/README for
+details.
 
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
-- 
2.22.0.455.g172b71a6c5

