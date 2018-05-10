Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AABB41F406
	for <e@80x24.org>; Thu, 10 May 2018 12:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935481AbeEJMnX (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 08:43:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40186 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935042AbeEJMnV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 08:43:21 -0400
Received: by mail-wr0-f194.google.com with SMTP id v60-v6so1883960wrc.7
        for <git@vger.kernel.org>; Thu, 10 May 2018 05:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7EJyZks7UpvTuUeVcMVGTbkrFu1IVRwoznayoXBCZrA=;
        b=Gs3yVe9OzDIGgYi7vdKbrWyJB+xidb1NoBU/JGU8VALA85wxigCGTQ1NYiKUewiZto
         7CTc9HQO+/Ar93/eDQ09e8trHjRUhLuOIdAOs/kXc87c+6qdroMVy9etNhRk+k3mQ4V3
         ZB5VXtkuVB7CFA38LVEfNHhaJ4Q9YQJ705imd4WaxwIjDMEScpn9FrjbxJVBOqG7EBE5
         hMXB0YiPJR7hZIzw8VSxNaqKeBRc2J2mjc+51q/B6+5WrV8c5iDUYRpJzg0z+FIyRaI5
         MHNBbuFf0TPb9ReR1yDI0YBaJAIDsFYPAqR+fzmPoMOvnf4taQhGSppwezmcp/ycAAUz
         GBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7EJyZks7UpvTuUeVcMVGTbkrFu1IVRwoznayoXBCZrA=;
        b=SNMycUHWHmoeG9Oaj2IX5teVqsU8q0PJldqBt3JDzDbj3oGu8u+RkmCEWf9gNfjRp+
         FprYYVTty6Pv+jwFVlEHGDPBzOp1yrZSbYAx8HYvDTq0Jbv6I0b040XyeLNrGFKkZWXg
         Zyavugzq3zyLWeTe2kvkqK//GaHT7XInvHVSyQJ6jhimhVkEnpvSkIjJcxF+rtcsLuPc
         riaxgGPoVvb/pqsWKy7n7p4SBDDeYrW3LhvsaihswyVPDNFK94rWz22TK23EBzMdU/Xu
         Q5IO+TPfxKjWSJeVjsvXRoZzYAUxr2lQ2lIyGPZojAE22yifRanXBnDc6T5dTbrESsIc
         89gw==
X-Gm-Message-State: ALKqPwcXJNTyeLptCa83r5KowR37vNXXQ0LuBC1hDooGt7ANRXW0qMpp
        MqJD8WKOpjXe2qQHSoPzQQeql3jB
X-Google-Smtp-Source: AB8JxZr9BwHbvbSqIFmegFxe1uGAbbpZqJ/UFZyIV7rsosSaFl7b5ai2F1Qr6ju83ubDx0LjBwwqTQ==
X-Received: by 2002:adf:e550:: with SMTP id z16-v6mr1213881wrm.194.1525956199900;
        Thu, 10 May 2018 05:43:19 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q7-v6sm1203303wrf.49.2018.05.10.05.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 05:43:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/6] sha1-name.c: remove stray newline
Date:   Thu, 10 May 2018 12:42:58 +0000
Message-Id: <20180510124303.6020-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g4ac3413cc8
In-Reply-To: <20180510124303.6020-1-avarab@gmail.com>
References: <20180510124303.6020-1-avarab@gmail.com>
In-Reply-To: <20180501184016.15061-10-avarab@gmail.com>
References: <20180501184016.15061-10-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This stray newline was accidentally introduced in
d2b7d9c7ed ("sha1_name: convert disambiguate_hint_fn to take
object_id", 2017-03-26).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-name.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sha1-name.c b/sha1-name.c
index 5b93bf8da3..cd3b133aae 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -346,7 +346,6 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	struct strbuf desc = STRBUF_INIT;
 	int type;
 
-
 	if (ds->fn && !ds->fn(oid, ds->cb_data))
 		return 0;
 
-- 
2.17.0.410.g4ac3413cc8

