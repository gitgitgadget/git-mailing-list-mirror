Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3F620756
	for <e@80x24.org>; Thu, 19 Jan 2017 11:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbdASLlh (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 06:41:37 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36692 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbdASLlg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 06:41:36 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so3214525pfo.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 03:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNf0lvjtzeUYXs1QPC3tlemoWVqPdtlQ8iL8X/cWV3o=;
        b=rP73zgOg0PT7sNKiVx4Ll+ofh++A/im02Qpq2Q+3FlyZeoAAdUuMkBnqTjMTLcSjfH
         ozRBsa6l2aS5lPSJs9WQGxAkACUTSswhMTLZcAT6zNaWGVqbZNz9+S12uUuL1hO5qixA
         1auILtxXiFtA+pjsvE8ZgmwrO1kLdpnEIhhknwHOIeLevjQiDrxBl0wNmM+Ubtu+jtLB
         q+lfAIQqARvamoJFwBjcQgzcA0BioPgP/Zh6n1ydISKAuJe4nz2OQ4CXvww5v4H3MD9F
         dqRoEw0EMjVCH0EVRDrTKyilyhmq5lt3BW2HepoZrTrk3c9AutADAATyoMAHCu6t+f4Z
         6iNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNf0lvjtzeUYXs1QPC3tlemoWVqPdtlQ8iL8X/cWV3o=;
        b=MLwrZD7HkcAaL5VQSI0GhRYKDey62NRwLczwOuujNs/Hogld/Xp4E8OOpsnhmJk7wN
         tTh3I3EJ4sfOrgelFhPtxe1Ei0UeOKh3xemJeo4EyT3strz/v0ri9EWhODz7hkGLJWg9
         7hcEZuLuZlDiuotXye+cPtRcy9j+jrA1q5V02bUvU5D2bQb6hacCcNWzqd+XDs7ibmxS
         Y4lTftUKUMwb9B4saijUj9Ke5eskcYMHPmufKZKI+b9NJ4Db3AM7l1mr6BwqurQlwgTP
         qfxjj+n79FIU3Xf83CZ4E2v+ca0qHn/cJkPZQHntriaeHay7XxEN81fkYkMbAgslX21Z
         +hlg==
X-Gm-Message-State: AIkVDXLlUyLWLX7Z/CbCGtX/uot3OhQiSGBxC0KE8cnZmk/zAujB2wvOHIxcArx1RBcqHg==
X-Received: by 10.99.168.2 with SMTP id o2mr9802273pgf.159.1484826095778;
        Thu, 19 Jan 2017 03:41:35 -0800 (PST)
Received: from ash ([115.72.179.24])
        by smtp.gmail.com with ESMTPSA id s136sm8169483pgc.38.2017.01.19.03.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jan 2017 03:41:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 19 Jan 2017 18:41:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 0/3] nd/log-graph-configurable-colors
Date:   Thu, 19 Jan 2017 18:41:20 +0700
Message-Id: <20170119114123.23784-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20170109103258.25341-1-pclouds@gmail.com>
References: <20170109103258.25341-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v5 moves space trimming to color_parse_mem() from read_graph_colors_config,
which is renamed to parse_graph... because the config reading is moved
back to graph_init.

I think it looks better, but we may be pushing the limits of
argv_array's abuse.

Nguyễn Thái Ngọc Duy (3):
  color.c: fix color_parse_mem() with value_len == 0
  color.c: trim leading spaces in color_parse_mem()
  log --graph: customize the graph lines with config log.graphColors

 Documentation/config.txt |  4 ++++
 color.c                  | 10 +++++++++-
 graph.c                  | 42 +++++++++++++++++++++++++++++++++++++++---
 t/t4202-log.sh           | 22 ++++++++++++++++++++++
 4 files changed, 74 insertions(+), 4 deletions(-)

-- 
2.8.2.524.g6ff3d78

