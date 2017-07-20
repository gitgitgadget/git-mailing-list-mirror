Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C2C1F600
	for <e@80x24.org>; Thu, 20 Jul 2017 14:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965652AbdGTOT7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 10:19:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35989 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965637AbdGTOTs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 10:19:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id 184so1149679wmo.3
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ndJHMCYPSYmTTA9TaqK6HsL9U85IlMS/nRlQi2XfcLg=;
        b=DzewQP7T7yVmN045lkKQbB/eCctoR/A0xf8OXFiToYaBZs283z/vNt/UeQFx6fFTmW
         KRXeiDRECZAjmlTz3VpdhadcXPq+qaY+cujn3NpwjTO04boM9QG80p8OIC4IrmY7K8nc
         uw883d0M9OD+BL/xIe/rRv3NYVhrrfnb2n2ut7xLziamgXqJ5H8KQq7UiwDHR6VjI/0u
         yqknDZj36Roxr4fon5RF9NtBNSJ7qJt/EPah144gDYxzf+IWRInZf7niFnhpEz+XIdAt
         sCFpiaiXbGoIy5jUSTcCu6MPcTQTLsMX0MNDXX3SFCVCqkNwl69SwlbWnvTfqcGVdBe0
         WqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ndJHMCYPSYmTTA9TaqK6HsL9U85IlMS/nRlQi2XfcLg=;
        b=YNPeuHACH7zNIv4u5vmdnofEwMbNACoQkszgolIk2lPv1/cV5iPdr0oFUGVS/2GloF
         Q9NhT90ExaW1Eh2pj9emlXWC11iNCEtdO4Q7ohEPxcJhMuTNDEKCtnxSzO8DCMs1mzQZ
         4oGj9HAzSEhriQOpi8KuSYUtoDceg5mDekZqtW1sx8BirMA8F2CBgzaMWaeZo1lx8HF6
         rXPI49GIzGLol/wb+ZhRRjULOQiRTeQ4354H1X00CRV7kUbWA7az3vhg/YPYUkwY2NmK
         ApRComi+vKptZP/ZcrkFdcP6Jyil0ZA58fXSATdHBuT4S5dinCsdbAyUqvA3n7Qv1+5h
         JOeA==
X-Gm-Message-State: AIVw112xFdQSFG+yB1VrhVqzkmb3PsI/4q0hOeeAVFXhg066nwIPtSls
        SITVJOyqznYFosCU2Jk=
X-Received: by 10.80.134.185 with SMTP id r54mr3007157eda.29.1500560386391;
        Thu, 20 Jul 2017 07:19:46 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l24sm1630566eda.11.2017.07.20.07.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2017 07:19:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] RelNotes: mention that PCRE v2 exposes the same syntax
Date:   Thu, 20 Jul 2017 14:19:25 +0000
Message-Id: <20170720141927.18274-5-avarab@gmail.com>
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

For someone not familiar with PCRE or having read its own
documentation this isn't obvious, let's explicitly mention it so
package maintainers won't fear upgrading least they break things for
their users.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/RelNotes/2.14.0.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/RelNotes/2.14.0.txt b/Documentation/RelNotes/2.14.0.txt
index 7ed93bca37..0e363f2af3 100644
--- a/Documentation/RelNotes/2.14.0.txt
+++ b/Documentation/RelNotes/2.14.0.txt
@@ -28,6 +28,9 @@ Backward compatibility notes and other notable changes.
    upstream PCRE maintainer has abandoned v1 maintenance for all but
    the most critical bug fixes, use of v2 is recommended.
 
+   Version v2 of the library is fully backwards compatible with the
+   Perl-compatible regular expression syntax exposed by git (sans a
+   few obscure bugfixes).
 
 Updates since v2.13
 -------------------
-- 
2.13.2.932.g7449e964c

