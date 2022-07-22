Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741BDC433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 08:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbiGVIT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 04:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiGVITp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 04:19:45 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94879E792
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 01:19:40 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f11so3849434pgj.7
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 01:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4XsBBvGVMADsYqss21XT4zLwJgE0p+wwyZ0rG8/PFRM=;
        b=U9MA6s7Mgz8AEVPgaWIu1f6GQXg37yz9rz3UYTJ84CKAebccRM5rnheOrcJ8QJg4oX
         xB66Cb3fgL8Zde9KTAtaiCKLlaoIdpCiGKyzJne6e6LdTRqEvdItdi8siRgB948TYOaa
         ZLMvrS+nak/4x9AKqWr4m2HADAggSqq3rlvQCTSGjzjzfrH2uhoJutuR2UBJkBHz5dam
         xPLNAjbxLcqMgfTLlBwdfHzoXgTWgcwAYbgsu68THaDqWpIB0Rhp4sYYORzo4pldoBL6
         yMOrC4XJGmFxSzy+hJuCsc+F2jcxXOVF0SBM6iRIFSpM5SZRB/IgI/EsKaNCz9ztbOKa
         Geqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4XsBBvGVMADsYqss21XT4zLwJgE0p+wwyZ0rG8/PFRM=;
        b=4F9HGjXtcXfQRDzlCHA14qxon5/7/Pn9UNSVQOUBToGxWsuTTwKnIxk0RJoxd6mJ1v
         gv3i/2qDzQJ0l0PrqGCqjEU9LfNmB7tfM0bTDnGeFt9PDbpyi00wqH4+LhYSb8+ZF8WN
         NMn0M7TtWdF5Fp6RPeoQXCBOKXbVwvxg7zQOTfWzwkuAh1K6NP1ol9jhDLlcq/RILACU
         rM91wBYZl+9UhhPLqptpp6EfoTXwdvIWrZ/1MPL4JvK2G+DLYPA8VzUEbkMxHTL6eADu
         119xqv67UBn6hqXnnHfEPTZRhYv0Z5fIA+mpXLMUif1bkxjNS5yLhEAzZMoji7jtsgVx
         mrVA==
X-Gm-Message-State: AJIora9D+BtKD+yfhOQWTC6D4crEd+GXWa2td74+/P3ckaZpoy5jcQtn
        N4JOHVnZl7Bzrm5Y1cckW5M=
X-Google-Smtp-Source: AGRyM1uq3QpExp+yJXnpaT2ClTnFYZTyn6Uvw8H3fDZagdxbRcMsD+nqHPCixhhz9x4luHpkJ43ACQ==
X-Received: by 2002:a05:6a00:1c94:b0:52a:b71d:5c65 with SMTP id y20-20020a056a001c9400b0052ab71d5c65mr2595172pfw.65.1658477979730;
        Fri, 22 Jul 2022 01:19:39 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id q9-20020aa78429000000b00528d580cb45sm3188734pfn.127.2022.07.22.01.19.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jul 2022 01:19:39 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@jeffhostetler.com, git@vger.kernel.org,
        gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v1 0/2] tr2: shows the scope unconditionally with config 
Date:   Fri, 22 Jul 2022 16:19:30 +0800
Message-Id: <cover.1658472474.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
In-Reply-To: <20220721132748.37848-1-tenglong.tl@alibaba-inc.com>
References: <20220721132748.37848-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Changes since the initial patch:

1. [1/2] optimize the "scope" field representation with real syntax and
concrete value.

Thanks.

Teng Long (2):
  api-trace2.txt: print config key-value pair
  tr2: shows scope unconditionally in addition to key-value pair

 Documentation/technical/api-trace2.txt | 41 ++++++++++++++++++++++++++
 trace2/tr2_tgt_event.c                 |  3 ++
 trace2/tr2_tgt_normal.c                |  5 +++-
 trace2/tr2_tgt_perf.c                  |  9 ++++--
 4 files changed, 55 insertions(+), 3 deletions(-)

Range-diff against v0:
1:  bebd97c832 ! 1:  32f8b9ae6b api-trace2.txt: print config key-value pair
    @@ Commit message
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
      ## Documentation/technical/api-trace2.txt ##
    +@@ Documentation/technical/api-trace2.txt: The "exec_id" field is a command-unique id and is only useful if the
    + {
    + 	"event":"def_param",
    + 	...
    ++	"scope":"global",
    + 	"param":"core.abbrev",
    + 	"value":"7"
    + }
     @@ Documentation/technical/api-trace2.txt: at offset 508.
      This example also shows that thread names are assigned in a racy manner
      as each thread starts and allocates TLS storage.
2:  2f8fce6599 ! 2:  78575cca0b tr2: shows scope unconditionally in addition to key-value pair
    @@ Commit message
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
      ## Documentation/technical/api-trace2.txt ##
    -@@ Documentation/technical/api-trace2.txt: The "exec_id" field is a command-unique id and is only useful if the
    - {
    - 	"event":"def_param",
    - 	...
    -+	scope: <a string that 'git config --show-scope' would return>
    - 	"param":"core.abbrev",
    - 	"value":"7"
    - }
     @@ Documentation/technical/api-trace2.txt: Print Configs::
      +
      The environment variable `GIT_TRACE2_CONFIG_PARAMS` and configuration
-- 
2.37.1.1.g8cbb44ffc4.dirty

