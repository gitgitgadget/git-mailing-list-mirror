Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0D1F20248
	for <e@80x24.org>; Fri, 22 Feb 2019 14:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfBVOlq (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 09:41:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33888 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfBVOlp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 09:41:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so9052731wmd.1
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 06:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BgVE0w7bPrTA+9VDpvEvfPMR9dlb31pdMoQs1NVAwfg=;
        b=venCf/L+v1Qsaq3Iw38t9qYbdTF0JD6PItFd7/foPFVkCaNcX/fvpBtEzZivQAGiYl
         yfIl9JgUDWjRbHd5fPXgbrEjevQkY80BRzTg+vI+CUK1SZye584MWZRDuCJgLtcviyOl
         CzGFDz7AIHkeGomOoa8f15CABcZ7VXT8KAGTEc/yIg4l1TioFJjxVINO7cighgXbj16A
         GRfnvwxpprka6U5MAedKz9KcO7ngheXYXjjBWVrzH5Ma/7ikpA7tfNqLZNPWmFh1DXxB
         r4ZBF/ZtHOP7WF399ymR9p2N+mI9UmNVu3Yd1cIUqQ6LcGAXqNa/d5i3gI9Cw4LsICcc
         g/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BgVE0w7bPrTA+9VDpvEvfPMR9dlb31pdMoQs1NVAwfg=;
        b=VwccOWSe2aw4J5kCshscFRBdgB2/N64VYaxehoOBeeu9gqLLszh3LrXCaKQfn4YWbY
         PqpT9UoT8R4sTz5+HHEHhMaPKtqtCsw7a5anVBGZ7uEYI3gTpX2fSUAUxzowfgIqDo9n
         oNYLNbcIxtjqYZGhhSX3T62r/kZv3hQFAJgHNQYfyfC4AbcTRrUfa0D7ab6K8xHZnjt4
         +MhvHvxES5vFLIujBXvSlLkMNyOq/X3314u/haO+muIxOohdqWmE91Rs+noi3peCyMbZ
         uU0E0Nz4kKl3QeDxlFArr1RLaubCheu6SfsVDyJPDTBvfKTvE6jr7tepAOmU/sVJU/Bi
         M0bA==
X-Gm-Message-State: AHQUAuYwzbLQyZyrjQ0e2gRJn+JD/Vc57Ad/p+MSFEw94FYzKCGhx7N8
        kqLWMEr1JsDROxOnXd18wnRhNmCJKWA=
X-Google-Smtp-Source: AHgI3IaXGfDW9lxRrkbaFQtLmzSx++8iWiEPw2qmp06E08/PfINlDLBtAsG1Ul42ti+zZpu592STYg==
X-Received: by 2002:a7b:cc18:: with SMTP id f24mr2926750wmh.42.1550846502914;
        Fri, 22 Feb 2019 06:41:42 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z15sm1481689wmi.46.2019.02.22.06.41.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Feb 2019 06:41:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] Makefile: move "strip" assignment down from flags
Date:   Fri, 22 Feb 2019 15:41:23 +0100
Message-Id: <20190222144127.32248-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <20190222105658.26831-1-avarab@gmail.com>
References: <20190222105658.26831-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the assignment of the "STRIP" variable down to where we're
setting variables with the names of other programs.

For consistency with those use "=" for the assignment instead of
"?=". I can't imagine why this would need to be different than the
rest, and 4dc00021f7 ("Makefile: add 'strip' target", 2006-01-12)
which added it doesn't provide an explanation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 97e922cc41..c53727e44b 100644
--- a/Makefile
+++ b/Makefile
@@ -512,7 +512,6 @@ CFLAGS = -g -O2 -Wall
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-STRIP ?= strip
 
 # Create as necessary, replace existing, make ranlib unneeded.
 ARFLAGS = rcs
@@ -576,6 +575,7 @@ CURL_CONFIG = curl-config
 PTHREAD_LIBS = -lpthread
 PTHREAD_CFLAGS =
 GCOV = gcov
+STRIP = strip
 SPATCH = spatch
 
 export TCL_PATH TCLTK_PATH
-- 
2.21.0.rc2.1.g2d5e20a900.dirty

