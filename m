Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C441C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 11:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhLNLsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 06:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhLNLsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 06:48:05 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91598C06173F
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:04 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o13so31857054wrs.12
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mj3roB/KNfN5aSaawhZhUchjzd3HSZTsombt9lwgcBE=;
        b=TAKvQglnmb6e4IKXg+2EzZAkdj/M0HiAXsl3XyKuDpxCPbmjLhS0k0T7TN9KNnEMyR
         YqPW7YZ/VIztPLORi7VVId3Sj3+pSdt4vytvVsRCQ4t0ZwD1kOLZ4bssyUtFqccUj0EF
         eTJxLcmR0yv+JwGBAPk/Rw8ejmE6684JzE9EYZCryDHdYmBm4Mg5dm8uaoqRDtV/qpu/
         cn5UDFi2jCKdeKRTZ4aCgliZ27zIlhOpduYyMJjZfptkrexiV3n/iGTUPnmBADyrdMh6
         pBc3EUoVbvGIt3rLEzEkrPBWWJUKjOXCsV3Df/q44izMHcLcFmY2niI0kS7YaFSAYpzL
         I/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mj3roB/KNfN5aSaawhZhUchjzd3HSZTsombt9lwgcBE=;
        b=wwyqoe/AQxWIdTSxQ0Ggf6lrZx3yq3JsiL8PxN4Mh1ScoPyMZobhaDS87SN4C2KI9H
         f8CqQsEHgR5i3zqLMCgXDsZ8LMSrqpVZp3C3n0d2bJo3jqJ1GGRQi1rcPqTmBA4mg2sk
         JlKn1b/PHXAjiV6GRGrU4a7NjKykCt2lnfWESG3WZxD7aPJ09lQe3u0e07AZYdjN3DNv
         X520dcKZa6ne0zV+Szz1W9CP6WLrGsD3CTprTqMejYzNVBvV8V6a396YlnWhNbS8GFay
         Zj9dRn7kd1hg3i6zm/DVFQvCB6CMo65IIY0FJoeYZmG0xyyUcZLirTH4MrJtRuhsulm9
         Tfrg==
X-Gm-Message-State: AOAM5328QTzlfoLnq/BID4lCxEtAb+71DBQcksK5NUX+VNlOzbg8+mg/
        VVL3mYJdJnpRurCV1pNXRCUDcUWsjJ0=
X-Google-Smtp-Source: ABdhPJx+TWFjBAzCdAmUdJySzq8anELw+6Kq69NqV8YbdRIphiOWpSFrhFvuHs5OodRF5ytF5vP5mQ==
X-Received: by 2002:adf:fc0d:: with SMTP id i13mr4890137wrr.699.1639482483111;
        Tue, 14 Dec 2021 03:48:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7sm17448118wrg.31.2021.12.14.03.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 03:48:02 -0800 (PST)
Message-Id: <47ba5ddceb8cc864cdc3006f7718e00f6ea2c7fc.1639482477.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
References: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
        <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 11:47:52 +0000
Subject: [PATCH v4 07/11] reftable: all xxx_free() functions accept NULL
 arguments
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

This fixes NULL derefs in error paths. Spotted by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/reader.c | 2 ++
 reftable/writer.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/reftable/reader.c b/reftable/reader.c
index 006709a645a..733509606a9 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -641,6 +641,8 @@ int reftable_new_reader(struct reftable_reader **p,
 
 void reftable_reader_free(struct reftable_reader *r)
 {
+	if (!r)
+		return;
 	reader_close(r);
 	reftable_free(r);
 }
diff --git a/reftable/writer.c b/reftable/writer.c
index 3ca721e9f64..9fd24fa93ce 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -150,6 +150,8 @@ void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
 
 void reftable_writer_free(struct reftable_writer *w)
 {
+	if (!w)
+		return;
 	reftable_free(w->block);
 	reftable_free(w);
 }
-- 
gitgitgadget

