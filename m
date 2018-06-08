Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD9461F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753220AbeFHWlz (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:41:55 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46508 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbeFHWly (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:41:54 -0400
Received: by mail-wr0-f194.google.com with SMTP id v13-v6so14768577wrp.13
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oCuMmKdv8WLUYg4XnrkN6RSsW9/FxYVSdSh75zrxPtA=;
        b=h58H8XD+U/UupPJwzgo7mgr2kFQKPVY4KOTva4xfLmOWskEuBsze5qffDamxjxFRJO
         c2me9JUF4ZpL7/XmPDa3SmpmXdJ775vBS13/VufUz7sZS08SwpP8oSwPjVGq7ahQe+jb
         OFkETbHxA99mUqfCrQfPk+TIhsIK+G4uoRYXoCyOsjHSvuyDCrolY+42JKSx0xcwcVuo
         E06Gj3T3P+GgmtHiYAoKhGQMtwaWfTeHKd5ZpRTgTiq0cz283R3noYUNZIFtzhhHfoVv
         ddTW6QBobiUBXwG+nBoAONjIeEaMhFUpr7W2v+BUEUi5QFSyuBNS5pTFpyfpS35tUDfQ
         ULkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCuMmKdv8WLUYg4XnrkN6RSsW9/FxYVSdSh75zrxPtA=;
        b=Zq/5icYtOegTpV/BVKForA78wR6Ymtqwa2nIujuYca8e1GyvryxPEFynGC5g9Y3NVZ
         Re3gx8cZYMwKuEUEY2mA6wogeLQpEMQeeZuivSsytUWu0LY+rMZnmf+zbQrMbVEsBXQT
         0Xl0H3O6wnc2pMBo1WASCBUotjhu0qpepKZhRhsFkkFaS7uzLLv2w+L7Qf8Qp+ULYqDD
         nuXGRYT8zYAuXv6up7o4uwvWoduOgC9tkono4/V8Wb6EuM4n2KGgrIF/PD3jZxQLiBv5
         cRihMIM8ed+jbZ3FdGVOgfgBaY9ewO21xisgiNcXQaJC+cezkLq5ofL1IFPNhPykrVCC
         xuXw==
X-Gm-Message-State: APt69E3at+KKzbGF7EiaV5K6lXLHd+bPYUZGlDp6rj3Bf1wa0yz1djUL
        KawjvuKOCnUFqwywPu/VaAylmzsJ
X-Google-Smtp-Source: ADUXVKJTRLZbQbTWsNifgFWdI1Ny1jdt68B6R+d+UXPk35Mqj0cApWq6iKwkAGtFx4izcLINGZxmZQ==
X-Received: by 2002:adf:a706:: with SMTP id c6-v6mr6737787wrd.61.1528497712703;
        Fri, 08 Jun 2018 15:41:52 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:41:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/20] t/README: clarify the description of test_line_count
Date:   Fri,  8 Jun 2018 22:41:17 +0000
Message-Id: <20180608224136.20220-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180608224136.20220-1-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Referring to the "length" of a file is ambiguous. We mean the number
of lines, so let's say that.

Changes the description added in fb3340a6a7 ("test-lib: introduce
test_line_count to measure files", 2010-10-31).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 8373a27fea..eede11d649 100644
--- a/t/README
+++ b/t/README
@@ -730,7 +730,7 @@ library for your script to use.
 
  - test_line_count (= | -lt | -ge | ...) <length> <file>
 
-   Check whether a file has the length it is expected to.
+   Check whether a file has the number of lines it is expected to.
 
  - test_path_is_file <path> [<diagnosis>]
    test_path_is_dir <path> [<diagnosis>]
-- 
2.17.0.290.gded63e768a

