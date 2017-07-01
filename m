Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CEC420209
	for <e@80x24.org>; Sat,  1 Jul 2017 22:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbdGAWGI (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 18:06:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33755 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbdGAWGH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 18:06:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id j85so13860056wmj.0
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 15:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VP8yxWeP+jA8xTYk6CC5MmFc0fBjeqhyMe6p9fbHbfA=;
        b=EF16O4xHY5nXaw0QzOezHbx308/XJMkI8y0Q/N335nUCzTsX1IRONOU2AaeG3RQdcd
         HhL7FT6ilMOJ3ONaIcoxAeEMlR/0KW2T/O7+xDx2K3dLEm/Km7/EvL7orJFcjJ0D73nJ
         CzquRoDlfab8PqJ1d5qyFFy5UmlXogB3eIEdAvDRNAe/6W7up6FHAjVclMkZLmcB+vLd
         6S3Wlgtaq87hku4COcaAP3wcLJoDs7I5hGjRUFRwXBgox40UEOVThlTvCc3+Tn3HqCsz
         ddiCM8fdlgc+L2W2hAkhkpqht/qjOZ79q+eie7ibL3Tq/76St1Y8sOOdRfUvHWNRWpIh
         iykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VP8yxWeP+jA8xTYk6CC5MmFc0fBjeqhyMe6p9fbHbfA=;
        b=ErAsLqp7Ti41fQXNrig14+IVlzMIeGIsnjVt0T+gdr9rGiC9Lpa5+gx2kHr+emAeNW
         dGEm1NrEoI9wkW8qUCX2Mzo6bI8Tk8iYHc6DwO1A4CKhXGKxlTOXZV+RwgwqO3YT0NFN
         cLfQ9lPGzL6ol2zmHonMciZP2CtAQ7tInHFk8kt+BNBxPzHpbChoCWCuXo34SHMvEwvG
         8L8rGS2xXHSqvVdAWWIlejcMVh1g0V9qFxC6JQVdOB0P1PYDS3IoeZ6jM5uNYb67dwIg
         RL3dZmdbrJA5OYpxvTZjeLsO2joq2UWmelU3zlFSwnA8UBy6G1SRc8yltFLyigJUaCVE
         vaWQ==
X-Gm-Message-State: AKS2vOzKKDPPZ4YyE2YUH09A/JxJZw2J4/3nhYkyeOuwFGDz2lPOp1RH
        bXts2Vp0TbYVeogsoYY=
X-Received: by 10.80.154.98 with SMTP id o89mr9972838edb.137.1498946765443;
        Sat, 01 Jul 2017 15:06:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e54sm4208643eda.27.2017.07.01.15.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2017 15:06:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/3] sha1collisiondetection: automatically enable when submodule is populated
Date:   Sat,  1 Jul 2017 22:05:47 +0000
Message-Id: <20170701220547.10464-4-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170701220547.10464-1-avarab@gmail.com>
References: <20170701220547.10464-1-avarab@gmail.com>
In-Reply-To: <20170627121718.12078-1-avarab@gmail.com>
References: <20170627121718.12078-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

If a user wants to experiment with the version of collision
detecting sha1 from the submodule, the user needed to not just
populate the submodule but also needed to turn the knob.

A Makefile trick is easy enough to do so, so let's do this.  When
somebody with a copy of the submodule populated wants not to use it,
that can be done by overriding it in config.mak or from the command
line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index f0cac1f246..3baa1eac0b 100644
--- a/Makefile
+++ b/Makefile
@@ -1009,6 +1009,10 @@ EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
 
+ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
+DC_SHA1_SUBMODULE = auto
+endif
+
 include config.mak.uname
 -include config.mak.autogen
 -include config.mak
-- 
2.13.1.611.g7e3b11ae1

