Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A178202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 23:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbdIVXh3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 19:37:29 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35470 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbdIVXh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 19:37:28 -0400
Received: by mail-wr0-f194.google.com with SMTP id n64so1323014wrb.2
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 16:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ffysjx9zYnJFhZkKphqttVokeAsshaucFReEkpw6oj8=;
        b=JuRkh06xXIZ3XhyVZzi/6d5/1PB05b8lVnnIpe718vTky0lYcdU6Jww16spI7x6CFE
         gHN7QqCbCEZ+9d/NPfE66aMOJTvBZY7O87kY0x32gbMAdeL3MKjZU+qEURIH4uGZE8T0
         RG5JZyqB3Za6WlzvsX0iygpAWPmmIask3/Oy0/PXLYSSu5zu6/XGRa42GzHBqQOXYtja
         vRw3+OYTmoGRffNM3nISp15+KSkapmfQacjpnx6o+saKQA8yXoMogJfJedw2VL03hM01
         4nbBa33lJmo3Z6rwPnsq5yBRzZZd1h0wjFFPxmwS1okSVFisY39V93ibZbU1eGWUoQ5A
         TVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ffysjx9zYnJFhZkKphqttVokeAsshaucFReEkpw6oj8=;
        b=VOBg+u3tEBPQuBycZ68O9b4EIjvOL16PHPpeBVxvcqzTAYTXgPVDXdGg0mTvoyaVe5
         Rb7NQOYqsZRSJDr59WBQDFA8jSyS/IoXL1vQX023m4oSlQDwQu0J9fhCC6DYMOuRyoIB
         aaALpOgsUdbA8Pq9UiMRho/cfEvM7X6insRD82VZx7ZjweKLp7OrvYZJ/i/L958WfQq2
         S97C3uOGrWFRSA/xOnoqE/LYm3/YiUUBMSkaspBZunhDoxgN0tw4P5B3ggQjMqiGfDRj
         BItwti7pExWJvoP5Dx8cEpthWq3rJJgUsDI5FY0J77dhQk4632j95TltGR0F9NyZvuly
         YdcA==
X-Gm-Message-State: AHPjjUj+RYXS9Fu+aEW0Xh8db4DK814yqeBkb7ekcRp8PkQYawiNMutp
        uCFLvJEWSQBHDFrZ8gUMufHBkoEx
X-Google-Smtp-Source: AOwi7QBJdLvmfuXNiOPfN60EKI6IN1MHIIGwJQZWYGP1AfCxZso7TvSvtBOOfOeuehfXMn+cWMmgWg==
X-Received: by 10.223.171.206 with SMTP id s72mr472898wrc.27.1506123447792;
        Fri, 22 Sep 2017 16:37:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id b47sm1053276wra.73.2017.09.22.16.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 16:37:27 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     David Turner <David.Turner@twosigma.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 01/12] bswap: add 64 bit endianness helper get_be64
Date:   Sat, 23 Sep 2017 01:37:06 +0200
Message-Id: <20170922233707.25414-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <20170922163548.11288-2-benpeart@microsoft.com>
References: <20170922163548.11288-2-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 September 2017 at 18:35, Ben Peart <benpeart@microsoft.com> wrote:
> Add a new get_be64 macro to enable 64 bit endian conversions on memory
> that may or may not be aligned.

I needed this to compile and pass the tests with NO_UNALIGNED_LOADS.

Martin

diff --git a/compat/bswap.h b/compat/bswap.h
index 6b22c4621..9dc79bdf5 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -183,8 +183,8 @@ static inline uint32_t get_be32(const void *ptr)
 static inline uint64_t get_be64(const void *ptr)
 {
 	const unsigned char *p = ptr;
-	return	(uint64_t)get_be32(p[0]) << 32 |
-		(uint64_t)get_be32(p[4]) <<  0;
+	return	(uint64_t)get_be32(p + 0) << 32 |
+		(uint64_t)get_be32(p + 4) <<  0;
 }
 
 static inline void put_be32(void *ptr, uint32_t value)
-- 
2.14.1.727.g9ddaf86

