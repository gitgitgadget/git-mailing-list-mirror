Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B18EF1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 21:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeKIGxI (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 01:53:08 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:35068 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeKIGxF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 01:53:05 -0500
Received: by mail-wr1-f54.google.com with SMTP id z16-v6so22773122wrv.2
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 13:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mleurfM+/mxqn2L6IWR7w3oI/20gdJY3eGg/L30hRkI=;
        b=r2sS9T/df1Y8m7FQ+DpsMwnjzeb1jquBYRlH85YdvnnM3fOjBpxPm3zuPix7QjCFuQ
         txIPZzAhHXHZ1UOFJ+bjx2X+yAg/LO7hsGMFk1eUrdLgN/dW4OVol3Wym5woojX60H2z
         oSmCk0Ox0NIYLxYGdJy115r1Hqq11A8acWlGHK+/PA9nZOIp6uRSWPlLDpE/FuYHHTHX
         rHCe4COyvSGODNSLbph8Cvfa2f4YzD3XmwyL6kahce7GH7UsGxBfK/cbbBwiBeK/y5RZ
         byL9tgW7hKl8doFtnmWkxtVyOhZc2BX/+8KcRYVWBr527VRHWQzc1YCYWTqhuQVYv4Np
         aLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mleurfM+/mxqn2L6IWR7w3oI/20gdJY3eGg/L30hRkI=;
        b=FSFK7vVXBUotE9gDlPpje08oOYygri92BA4pkXmJ1CV9CjQOW5oEP6AcBnvILHDjuS
         m/iW5zcfsjII0JMiqnhf7GfLJSYy4stYARUfqphwu+8yd5HSqWLaViuWFRHx1Mz+U2SV
         OC0bHJqYL5wLv1apvJKVE9bVT6R4LYZ77fH1VlUUCjA1o1HSpOqjG8rjVas4Kuyi3bPO
         6xX49bNn9XOV4tCAJ8nC2GdMHjhqiBgVSTmlU8vViRXiX4Bn9EyqsAI5gVo7xDxVEmQ7
         0BkU4tGilH6N+S9DEnVWJ1uYG93YLCd82AmE3le6yL5kRFkn/wo3jERqMqstTSn/q9CD
         dkNA==
X-Gm-Message-State: AGRZ1gJosMiY0VTPUgF+fymMczHvVW9DYUOU6FaIlF55aMu3s+BHK361
        2PFgigOWzVrnbID6yM4UdrazpOED
X-Google-Smtp-Source: AJdET5eZbfj3PYhqBe+5C49oDbhYYOZNRaiXoC707zYriPVE81DeS3m40+vj3wTptUoRT5k+eDZ+Lw==
X-Received: by 2002:adf:bb0f:: with SMTP id r15-v6mr5643453wrg.24.1541711744905;
        Thu, 08 Nov 2018 13:15:44 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e66-v6sm9036262wmf.40.2018.11.08.13.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 13:15:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/2] Makefile: ease dynamic-gettext-poison transition
Date:   Thu,  8 Nov 2018 21:15:30 +0000
Message-Id: <20181108211530.29017-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
In-Reply-To: <20181101193115.32681-1-avarab@gmail.com>
References: <20181101193115.32681-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Earlier we made the entire build to fail when GETTEXT_POISON=Yes is
given to make, to notify those who did not notice that text poisoning
is now a runtime behaviour.

It turns out that this is too irritating for those who need to build
and test different versions of Git that cross the boundary between
history with and without this topic to switch between two
environment variables.  Demote the error to a warning, so that you
can say something like

    make GETTEXT_POISON=Yes GIT_TEST_GETTEXT_POISON=Yes test

during the transition period, without having to worry about whether
exact version you are testing has or does not have this topic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f3a9995e50..6b492f44a6 100644
--- a/Makefile
+++ b/Makefile
@@ -1447,7 +1447,7 @@ ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
 endif
 ifdef GETTEXT_POISON
-$(error The GETTEXT_POISON option has been removed in favor of runtime GIT_TEST_GETTEXT_POISON. See t/README!)
+$(warning The GETTEXT_POISON option has been removed in favor of runtime GIT_TEST_GETTEXT_POISON. See t/README!)
 endif
 ifdef NO_GETTEXT
 	BASIC_CFLAGS += -DNO_GETTEXT
-- 
2.19.1.930.g4563a0d9d0

