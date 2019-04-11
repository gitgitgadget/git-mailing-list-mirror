Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B937320248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDKNNY (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:13:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43685 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfDKNNY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:13:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so3390591plp.10
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWP1nSQ+qfGwGSpLxlmphWVkzXe+BevY9/QkrsOCV6U=;
        b=NXjOt+kvo6bfkD57LNVVkQP7njPHd6EJkHag0kl0Sioveid9kl/irP0TNp34I/1SuD
         ksPWpiC7nNHRj8XrbW0ecjFp9O0C2vRsktgKStk81MT2qwwCooB9e4lRhzOO3t0bzVm9
         KIWu1VVtZnKXmbWYz75ot99V6XU/eynYT9hOfLAJPuSBiXJUSb8GHgwkGvxnqDm0Todg
         Io0r1mKoViwe4v4j0W37xiyTBQyQomCsZ/l2Dx7HlFu3oGvG+VnX6EYxLhmnnhSi/6yi
         GPGKaQIHjBrlLr72HVS0DDVZcXvxSczVC1oD/CaDXDrQpRaQJlV76V67Y8aKb/TbuEfi
         DmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWP1nSQ+qfGwGSpLxlmphWVkzXe+BevY9/QkrsOCV6U=;
        b=RSIRBNUrvHcwM8ChshSbT/T6a3CX+l84lIRvTk7RoqgKekkKg7G1g9TTDXKF4NbJjl
         BhXXyoPI625VMSOpzy7eNOzjCY8oAQ8SpvZ2NSb4d6ZOqbkODMnsK4EJV5WFus43Agr7
         dvIPqmPALy0XqVLsTVFH7i3To2cTJxiNohcD3VCRh1Gvf5o7eL++Nw3JPzSVmm9xcBFy
         bwm1l4PjFJZlpgOs0E0x2+pxeT+dpIyYTBm/LGwyQRQ/l/ixDPey8oYeF0g2DsjX20B5
         5mfW9HV9RWSiBMYjL/S/zx9K3Lq+ZQ44cb0a7tSYKqrSUf7IbRFr4c/518SHW94vobl1
         F8MA==
X-Gm-Message-State: APjAAAV/wJ712G/5X2sOSukPivGbMX3jZ9clPT4ynmgK4y7GiWVQvWZn
        wNlBnR7R7wNmcqVuHNzUgq4=
X-Google-Smtp-Source: APXvYqwNa/e3DEqIh25Q4Jm7kXEKPXjOQrXE38ebwdGu66YEXIeeuiN/RX9ZmpjZc2w48+4bzTCAGQ==
X-Received: by 2002:a17:902:a607:: with SMTP id u7mr50958234plq.66.1554988403758;
        Thu, 11 Apr 2019 06:13:23 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id r87sm79603688pfa.71.2019.04.11.06.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:13:23 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:13:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 08/16] restore: default to --source=HEAD when only --staged is specified
Date:   Thu, 11 Apr 2019 20:12:10 +0700
Message-Id: <20190411131218.19195-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190411131218.19195-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git restore --staged" without --source does not make much sense since
by default we restore from the index.  Instead of copying the index to
itself, set the default source to HEAD in this case, yielding behavior
that matches "git reset -- <paths>".

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 71e2589340..09a03f1ff8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1524,6 +1524,12 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 	if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
 		BUG("these flags should be non-negative by now");
+	/*
+	 * convenient shortcut: "git restore --staged" equals
+	 * "git restore --staged --source HEAD"
+	 */
+	if (!opts->from_treeish && opts->checkout_index && !opts->checkout_worktree)
+		opts->from_treeish = "HEAD";
 
 	/*
 	 * From here on, new_branch will contain the branch to be checked out,
-- 
2.21.0.682.g30d2204636

