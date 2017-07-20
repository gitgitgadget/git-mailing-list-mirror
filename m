Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED5811F600
	for <e@80x24.org>; Thu, 20 Jul 2017 14:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965641AbdGTOTt (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 10:19:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34133 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965632AbdGTOTq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 10:19:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id p204so3744804wmg.1
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HJ+AfnoXkoWdsxnoFgWI4lD4Spl40iI0noPmR6WIF3o=;
        b=jM4bZqxHUHxoYpSJItZkfv+n4QuUTWnYREdctM6RPTnlWMEpAkTxhdawf19D3r0hs7
         DsLBTtbMD9DcdgST+tCmnWFpZbGtyCdZNlTDntmcb7E62JwKHgW7/FW3PXvj//kBEXYn
         Gk3iZwjrkBCRjBIipz0yCIcCHZ0DkgXifHx70kU0KZ9jm1w6JpQqTmX4Nqb5uj8NFQne
         fja1JXq9GzNdjt9KyeCIcgah8e4OfV9A0po9958zd0kdUkHzi3dzeuV0xzwxhkhKfemS
         W8vad+B1++IpfQjEebbE31y56+16vwq7m3pzai712OjkmlY5WIIMeGYqD6xHkv60qmub
         Mhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HJ+AfnoXkoWdsxnoFgWI4lD4Spl40iI0noPmR6WIF3o=;
        b=VTSFMXFR8vso1igkE5K2qQCdlWnHGmmYTR2e2Yw3Od2a2wAWvSRRedkDqsdFX35YxM
         Dm/YcLj/ckTDNSkjIADX3sPKXe1Jb1IXYwAQvFF5MODvFVYShrN7+45+lvtN1NkThKvM
         Xer9NHe1Wjx8PZiZlahOQOq5wUWN3kgR2FYYPFujE6rHUC442omkBoJ8MPtxbKgoLwIJ
         Qcsb7pMdWUXvemXVzpsqe2NDrx9U4BmjNer+4g3tejDbILE5W2djndGo7j9ACNdIMoN3
         Z0qNeDC87XSdPgK6kf/wOz04wGOnb9mCHQ2djDZDCrf5YBA8Shc6J1JXDGGv4QUqfSRb
         BgGA==
X-Gm-Message-State: AIVw113PcVSiQJQzY5Y1ZEzdIr9rjMXlg1MwCmcA50JnkHTd3d8azSVR
        5e8UJ7pwFpDum1IudYo=
X-Received: by 10.80.225.203 with SMTP id m11mr2964193edl.107.1500560384632;
        Thu, 20 Jul 2017 07:19:44 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l24sm1630566eda.11.2017.07.20.07.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2017 07:19:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] RelNotes: mention "sha1dc: optionally use sha1collisiondetection as a submodule"
Date:   Thu, 20 Jul 2017 14:19:24 +0000
Message-Id: <20170720141927.18274-4-avarab@gmail.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
In-Reply-To: <20170720141927.18274-1-avarab@gmail.com>
References: <20170720141927.18274-1-avarab@gmail.com>
In-Reply-To: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
References: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To note that merely cloning git.git without --recurse-submodules
doesn't get you a full copy of the code anymore. See
5f6482d642 ("RelNotes: mention "log: make --regexp-ignore-case work
with --perl-regexp"", 2017-07-20).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/RelNotes/2.14.0.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/RelNotes/2.14.0.txt b/Documentation/RelNotes/2.14.0.txt
index c125f8fd68..7ed93bca37 100644
--- a/Documentation/RelNotes/2.14.0.txt
+++ b/Documentation/RelNotes/2.14.0.txt
@@ -235,6 +235,11 @@ Performance, Internal Implementation, Development Support etc.
    behaviour of the comparison function can be specified at the time a
    hashmap is initialized.
 
+ * The "collision detecting" SHA-1 implementation shipped with 2.13 is
+   now integrated into git.git as a submodule (the first submodule to
+   ship with git.git). Clone git.git with --recurse-submodules to get
+   it. For now a non-submodule copy of the same code is also shipped
+   as part of the tree.
 
 Also contains various documentation updates and code clean-ups.
 
-- 
2.13.2.932.g7449e964c

