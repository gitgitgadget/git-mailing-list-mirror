Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B0581FADF
	for <e@80x24.org>; Sat, 13 Jan 2018 06:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965464AbeAMGur (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 01:50:47 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33389 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965425AbeAMGur (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 01:50:47 -0500
Received: by mail-pg0-f68.google.com with SMTP id i196so5906873pgd.0
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 22:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWC2gXfQDv3IvT4SLyvfKmW8yJC2wW60UjA+L70soHY=;
        b=sfa0w56e0iQr7eYliS8vpU434xC8+zgsiHiDPedgPV0ppikBUUBMlkZcT9TLaDEDyz
         S3vML89tCpDvWKIkI68H1V6Ah0PkVWg2650Zp+71A1oD6dwp131OQEuXTe0D95FM8+B1
         GF4Zkokdxq00tOWlidUG1Wv3gncPXyeqLRTvrwbNc/IMQqHwQ736AI6Xf3MRqHbswAuz
         X4n32ax1Woe5syXpQv4Uokx0dQcaJKafp84UfLDVIDYUPKHZMaNT04gsj9SFEsE2ODtz
         xEdcYnJ1yIj8zJCORgrU01h/UGRAF7SdXmRZ8VA/dn0ETixGKqmXVtjLeDcBD9HXWeRd
         Lg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWC2gXfQDv3IvT4SLyvfKmW8yJC2wW60UjA+L70soHY=;
        b=EXgnA1nu4SItSp7deuYDDCgjjOrozL2l0SBhPlTmBqJK/Orvtss9cwmCCtZOp7sMd4
         OGKNER//y9dj8yIWexMfhPp1qAe6CYunv7Ahgt6J3p6wqy4dXLws5lK98XVlR/ENTwP0
         oeJMaK/1weEO5ulB3AOb3pMWwDFa5eNa0DOsSl/nsxdQimUa5yw5yWjc7bwoEDWdQaDK
         jzEkman37ciDX03rVclgN+n0UDm6GYmKminWcDr1NnSLpnsuURuC4PsKy6CelRrSX9jd
         KAwp22nRUpdgljtBuugWdxtT2FHA2utvSNZkcd9H9qWN4RrzuqUkn1VRukG56lHFApiQ
         t0mg==
X-Gm-Message-State: AKGB3mIDhPphv5ZeVguZf1zzSoMPAr70n54UqVOATo1pDOum76sy4PU2
        Pzfy6gnJj3oBKdcSgP4WJ2lI/w==
X-Google-Smtp-Source: ACJfBos55E4UDKcMx68Y6y/bHFFfscf+zypyvBTF4DL0JmLX2XADES8tH2wsb7MUp3/cEP7h2QKkAQ==
X-Received: by 10.98.147.7 with SMTP id b7mr25300390pfe.236.1515826246402;
        Fri, 12 Jan 2018 22:50:46 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id n24sm48867380pfi.33.2018.01.12.22.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2018 22:50:45 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 13 Jan 2018 13:50:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 7/7] trace.c: print new cwd in trace_run_command()
Date:   Sat, 13 Jan 2018 13:49:49 +0700
Message-Id: <20180113064949.6043-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180113064949.6043-1-pclouds@gmail.com>
References: <20180112095607.18293-1-pclouds@gmail.com>
 <20180113064949.6043-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a command sets a new env variable GIT_DIR=.git, we need more context
to know where that '.git' is related to.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/trace.c b/trace.c
index ffa1cf9b91..4bfd3fce10 100644
--- a/trace.c
+++ b/trace.c
@@ -342,6 +342,12 @@ void trace_run_command(const struct child_process *cp)
 
 	strbuf_addf(&buf, "trace: run_command:");
 
+	if (cp->dir) {
+		strbuf_addstr(&buf, " cd ");
+		sq_quote_buf_pretty(&buf, cp->dir);
+		strbuf_addch(&buf, ';');
+	}
+
 	/*
 	 * The caller is responsible for initializing cp->env from
 	 * cp->env_array if needed. We only check one place.
-- 
2.15.1.600.g899a5f85c6

