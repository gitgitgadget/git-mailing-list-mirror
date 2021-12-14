Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFFEC433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 11:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhLNLsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 06:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbhLNLsA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 06:48:00 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE98C061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:00 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso13533816wmr.5
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4caTpC3+u83vTS7zkUHAtzr+4yoHPBYES+caC91RmF4=;
        b=hlOeNdh6eznDJlILO2ce2SZ0ZHd0hRov3vTCiz3VGXQt7RMWHcE60iXh+sHzs0GVjE
         3WzKvoy8UzDTPjll2ezCpD2ZCPvcYQmGXBhdQ1lv3ZicC4DAm1W26fSX+dirzR80m2k9
         g6niIV4R3Ly5YuqWmz8YXWqQPuKWOnrrbQXGlPMtJrfwSRaElm5EBMs+HzXuvAUwTz/0
         3ZXUjG9arwdgrNEBLdKG/gLFvm68VraAh4BVQoKc0jfzn2yMpGiys8+YmiOMKeJgETBw
         TRw2PzDF1CwppiF+ouByAKOBuTLJSmKImj+2DtQT/z0t73Ta+q8fPGqzfwQrQptL08k7
         PBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4caTpC3+u83vTS7zkUHAtzr+4yoHPBYES+caC91RmF4=;
        b=ywaByp+FTtKyKxWRYiE/4LT6sGEZNE2vzxM4MovBaPzWNarxn3nc7hIVlFd2m+ReH5
         6PDFmTdNy93sYuuz9fOdsagbyNAeHdyVOim3inis8BAs1Gprh+0Ct7Q1YAIEDQQIMvN7
         MMFEYME2Ua3g8Y1wSrDARUC+GMZ9kNBNqbSDlLVUdnQtT4gx2FoiK5BM7ku+i574ZuIB
         QfJetj4s7aVmxQYhYjN7G1PAJMz1oGzpUbV4XosmdyIul9KgNumoax3K/gAjYEtsbi8i
         Fx92Kd+zUsxxvtb9dAdZMT4i1m/cQ1S422Y2B+pjpCJKKHEMuOi2jFpu9lIxLS7WCOB/
         IHKw==
X-Gm-Message-State: AOAM530lAeXqFDbuTpqVxeCqOk/8/CwYFV1+bWAgY6wESHcOudbRJSwD
        FiadQI0O87Pik9MeZucQF/FKulebIIo=
X-Google-Smtp-Source: ABdhPJwwuy4H/4+63e79xKZR82wZtDFpoikyMzb0lHi7Kaw52Ige0/cErbvtQjwuC+XRSfH3QKl6pA==
X-Received: by 2002:a05:600c:4f14:: with SMTP id l20mr45154201wmq.164.1639482478937;
        Tue, 14 Dec 2021 03:47:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9sm1864171wmq.1.2021.12.14.03.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 03:47:58 -0800 (PST)
Message-Id: <1c1a3ff92bd24f7c588ce480983cecb3508a0add.1639482477.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
References: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
        <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 11:47:46 +0000
Subject: [PATCH v4 01/11] reftable: fix OOB stack write in print functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 6a5dac32dc6..8536bd03aa9 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -254,7 +254,7 @@ static void hex_format(char *dest, uint8_t *src, int hash_size)
 void reftable_ref_record_print(struct reftable_ref_record *ref,
 			       uint32_t hash_id)
 {
-	char hex[2 * GIT_SHA256_RAWSZ + 1] = { 0 }; /* BUG */
+	char hex[GIT_MAX_HEXSZ + 1] = { 0 }; /* BUG */
 	printf("ref{%s(%" PRIu64 ") ", ref->refname, ref->update_index);
 	switch (ref->value_type) {
 	case REFTABLE_REF_SYMREF:
@@ -586,7 +586,7 @@ static struct reftable_record_vtable reftable_obj_record_vtable = {
 void reftable_log_record_print(struct reftable_log_record *log,
 			       uint32_t hash_id)
 {
-	char hex[GIT_SHA256_RAWSZ + 1] = { 0 };
+	char hex[GIT_MAX_HEXSZ + 1] = { 0 };
 
 	switch (log->value_type) {
 	case REFTABLE_LOG_DELETION:
-- 
gitgitgadget

