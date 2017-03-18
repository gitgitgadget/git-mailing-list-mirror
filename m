Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 662D32095D
	for <e@80x24.org>; Sat, 18 Mar 2017 03:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdCRDAY (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 23:00:24 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36759 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbdCRDAX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 23:00:23 -0400
Received: by mail-pf0-f194.google.com with SMTP id r137so6601307pfr.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 20:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iMouYPqgSHhpbkli7gTRZl+g6btibOMQ9LzHki6yCr4=;
        b=Ut9Lant4cWD4Ef9xBXVM0YtAqivQfwsCaQIiS3Fx4OhTsxBUA/ACMwh/WLlDRjNE06
         Z8tBbjvGFsd0/NllUU8ke6bSSlIZz8l+JO2FFrLCaM+G4cuwglPiEpHAGmnb4tY/O86r
         GBUYA1DvkS3ultKeA5dcArWS9gMxe3J+3hw+adS65ks1iKZkHey4vBd4RWwe1IgeFFTw
         0DDkdwIF4AIFOB3s+VKZN2xI5npv50EdFitPkEpixr0rwKL7BSTf8nNCz+1hkEFLdnfS
         NV9umtRnblsYlkRmOy7ccCVN+Vs7X1bu9HB6wkKDpkWG0wYZaSR4x0o+07UC503xAtTe
         IHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iMouYPqgSHhpbkli7gTRZl+g6btibOMQ9LzHki6yCr4=;
        b=M/P+QIPfsb641D6U31eac2A0zWsfbjyfEk7BHCrVn4xkW0WojeBbkq4JHzUXxMDkFF
         Y+J+ZyaJsphUby3dgIfdMNy8iRmqOTemYvVmcUqbEeCxqBm3pxwkhULn8YF02eYE1pza
         sgR/ysEt7sgXPxjms+9+0Tyi37CHLkPEf6lZAAVL6QtweOUZWKTYQXwD5RWOJ2J95Pzx
         Vv+N2oPotRnmu6KFSyFH64rTDw1J4QhgrBToeqiYhARAFNnvEFmNK/QI3GoBy5usRjrD
         KZcr3/ahQB4L2fuwYhIzYv+1Cg2xpifhXC8wuRJ7nsYvslWORcxce/3nM7JEYwhOjChJ
         /vPA==
X-Gm-Message-State: AFeK/H2uc51hAtBt9X5JpPAgTrFG3wggfRjQ5Ux1zxiIvLPWOdvGstGxQ4MK2Ytl9hwnwQ==
X-Received: by 10.84.215.155 with SMTP id l27mr24092011pli.31.1489802649385;
        Fri, 17 Mar 2017 19:04:09 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id k184sm19291525pgc.23.2017.03.17.19.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:04:08 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:04:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 01/27] refs.h: add forward declaration for structs used in this file
Date:   Sat, 18 Mar 2017 09:03:11 +0700
Message-Id: <20170318020337.22767-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/refs.h b/refs.h
index 3df0d45ebb..2d6b6263fc 100644
--- a/refs.h
+++ b/refs.h
@@ -1,6 +1,10 @@
 #ifndef REFS_H
 #define REFS_H
 
+struct object_id;
+struct strbuf;
+struct string_list;
+
 /*
  * Resolve a reference, recursively following symbolic refererences.
  *
-- 
2.11.0.157.gd943d85

