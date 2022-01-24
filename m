Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A95C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346530AbiAXTjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352685AbiAXTa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:30:56 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B3DC02983B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso75262wmf.1
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i2f7QHneSrgd8E5xUIeesO4h/9FI000eSeYDY3cV1H8=;
        b=LdpuExOgSfZ9sSVCoI1q/AnjiFFkk4YspfSMoz8ZTwKDIC/SXTo5XFvCvQfKd9wJaI
         lSRmD6cWmnpqWEYdY5EwKIzGaSar1ctAK8kVhxseg2YmWGBrvH+JVT8mInYpXK8AL4ez
         DGYVmC0bEaK907UBVj07UaKg4pVf+Yn+oc+gGOWrGF7/NeEVpbR+hnzJ5sebMTpHiKBS
         f8IcPwi0JkfmCOZrtpqsODQVTMxFLXeixVNvzcK5DDoF1VIxblAdLurLyDT1Dcw1wMyh
         BYBc2GpGxx6b5OTjAVzBd73TKQ5ot/4XOTF6DwiZOvPLeBdbVwt0srLr/lLhDczhfKJH
         pI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i2f7QHneSrgd8E5xUIeesO4h/9FI000eSeYDY3cV1H8=;
        b=gWORh+swTghjpDlceUW/kqrE+povwFBxJUZ5DuxEPYhUJ8sAAMrGnUhSgRz6pycd7S
         HZhDbe9hjtDMd+hEazHPHjiomYsvgTY6Gmh7e8FuQtfwfvS/qSDHQZoqONNiqahOgiRP
         IugnFFQzTE9DSa2aosa5hHvLbB7J2QJMUHzxLRX7FGeGDeE7fVeTJuSAXJUjgVh/OPcG
         UL7ePbFvTbHNh08d4sI/xKsluPtFjRDimvxFH1tR4wvrJUVKl/F5ksZqEcWL3S87y4hK
         /HVir8UwNXeAVt4tj6xEYZRtWWnSqhUW1ZexIsqIntkFB9WZp/KGXVqJ1CC/bE6MKHWr
         Clvw==
X-Gm-Message-State: AOAM531zPXWzGWxwxaKoP/LqN78ICWLfy8nB3S/p2+3kyLnFhysh66pv
        HXL03ObSVUyvnioCGXUHjAKoJpcdoS/KeQ==
X-Google-Smtp-Source: ABdhPJxqGHG6ARDWQF9WUEdHLGG+WicaFzfzkrIH4PBtqatpmxYsVUjXDUidygX/1O7kZXN5RsH0zA==
X-Received: by 2002:a7b:c187:: with SMTP id y7mr3034782wmi.93.1643051634542;
        Mon, 24 Jan 2022 11:13:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2sm5088011wri.88.2022.01.24.11.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:13:54 -0800 (PST)
Message-Id: <1d5cfbbc47a36e1f94d8432900da064a15c61b2d.1643051624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
        <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 19:13:38 +0000
Subject: [PATCH v7 10/16] reftable: handle null refnames in
 reftable_ref_record_equal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Spotted by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 1f236b47d1c..53d83e4a41a 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1154,9 +1154,11 @@ int reftable_ref_record_equal(struct reftable_ref_record *a,
 			      struct reftable_ref_record *b, int hash_size)
 {
 	assert(hash_size > 0);
-	if (!(0 == strcmp(a->refname, b->refname) &&
-	      a->update_index == b->update_index &&
-	      a->value_type == b->value_type))
+	if (!null_streq(a->refname, b->refname))
+		return 0;
+
+	if (a->update_index != b->update_index ||
+	    a->value_type != b->value_type)
 		return 0;
 
 	switch (a->value_type) {
-- 
gitgitgadget

