Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB3E1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeBHQVM (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:21:12 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44311 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbeBHQUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:09 -0500
Received: by mail-wr0-f193.google.com with SMTP id v31so5283042wrc.11
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3uqBMSeJGt5aVACnS/d6hefrZCZrbS9j0DdqZ6VhFMo=;
        b=Mm/y0YHhmJdZjLse2dvbrVOZdmnxYU2gmWgvAcNlUQadvvJ5VJUkBNlRFhL3SienUm
         TxaNGXHzVlNoSP48tFGayjc54S3ziSmlsE6/4pFcn+jWjYF7dTcVvxtpm8+1UQ/5zBtX
         AIiUnQ8eew2NEeuNlItP6LLXIysypaV+DpFrwtklvhXPjFv/cNuAx3Q3CH8aeGwG5qEB
         fuxXa82IVhAzMe3pKRQVTC+/UPT3hkejRYOcY28xZAJs5oLmCO0jX1B7xU7Y3Q1njZri
         Nmvc/eh6OvGD9iJX5WYnE7wOqKjD8EYrhEcd1b3mihGjArzLfKLtebjrNPFUMEhcP5wZ
         J0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3uqBMSeJGt5aVACnS/d6hefrZCZrbS9j0DdqZ6VhFMo=;
        b=ube/VIRSURjZMwD9U/69EaPPTCo/0KbPTsAGb8XtcbDxGCejk29lbOwa0Hon8lGGc8
         4diJ1zU6k1YCppNtMRGFjHRDEKFSNd6iLv9RTONgzOr6JTUNRsS7oA+iOgFJLpH7jOjm
         b6uzWYVdJfK6l4r76qlnuIhPFraf4y4Xq8rhgkueYHmu/Rkx1KPuXgwwYUolGACElVF0
         Fv9fV90n6DTVr7SE4uFZt5s1SrsSi/J3nCBOMXB2i33pqe4YkRNYHnuRUfHjZZW8+LOq
         E6OdxCubrznYPNnNAOTbkuVNmMxLqUzt3u/acezA/al/96jZkswk++n7gXlV0F9N6ssU
         g9FQ==
X-Gm-Message-State: APf1xPCOBOIMGc5KJIW43ylvMD9tZzsCsLpgTqZ1p04xxR+VL0SqQNLB
        LoGYB9cUdQ2GOcvTG7KCEMWQmrZl
X-Google-Smtp-Source: AH8x226tGNPxDEIDiIS4s7s/Ad3/L7hk/f/AmVHc9wRGsRm21PD6UXRETLD80nq8y7T2gz0wxNL4VA==
X-Received: by 10.223.186.197 with SMTP id w5mr1395563wrg.155.1518106808330;
        Thu, 08 Feb 2018 08:20:08 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:20:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/17] remote: add a macro for "refs/tags/*:refs/tags/*"
Date:   Thu,  8 Feb 2018 16:19:23 +0000
Message-Id: <20180208161936.8196-5-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180208161936.8196-1-avarab@gmail.com>
References: <20180208161936.8196-1-avarab@gmail.com>
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a macro with the refspec string "refs/tags/*:refs/tags/*". There's
been a pre-defined struct version of this since e0aaa29ff3 ("Have a
constant extern refspec for "--tags"", 2008-04-17), but nothing that
could be passed to e.g. add_fetch_refspec().

This will be used in subsequent commits to avoid hardcoding this
string in multiple places.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c | 1 +
 remote.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/remote.c b/remote.c
index 4e93753e19..356c123e3e 100644
--- a/remote.c
+++ b/remote.c
@@ -22,6 +22,7 @@ static struct refspec s_tag_refspec = {
 	"refs/tags/*"
 };
 
+/* See TAG_REFSPEC for the string version */
 const struct refspec *tag_refspec = &s_tag_refspec;
 
 struct counted_string {
diff --git a/remote.h b/remote.h
index 1f6611be21..80fea6dd11 100644
--- a/remote.h
+++ b/remote.h
@@ -297,4 +297,6 @@ extern int parseopt_push_cas_option(const struct option *, const char *arg, int
 extern int is_empty_cas(const struct push_cas_option *);
 void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 
+#define TAG_REFSPEC "refs/tags/*:refs/tags/*"
+
 #endif
-- 
2.15.1.424.g9478a66081

