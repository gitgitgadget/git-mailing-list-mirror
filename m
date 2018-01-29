Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06D301F404
	for <e@80x24.org>; Mon, 29 Jan 2018 15:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbeA2P7V (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 10:59:21 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:42831 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbeA2P7T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 10:59:19 -0500
Received: by mail-lf0-f47.google.com with SMTP id q17so10698622lfa.9
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 07:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=AEP100bvYHeFte3Q1keKeUWm/dgWSy4X+Mkf8ur+F8w=;
        b=dsOeCw47brOqP8IugODqKgxbAYmJsIHZ5g5mDEgpQ5OUP/awMPpdHZkDFJfVY9RoTc
         X2nEcbOUGngbE58FXKP0ElO3FAOINlqqTEbQQ66gZXrA2+NCMnohO9sCDfo/iyxQMl+Q
         hEvBO6TA96RMYSIzj8KUgjRHJdg70her72c66SKCdZm1+8v/KlDmiyekRr6LGl2ywm4f
         MlnMTcY7vahC7/8WMLJTaLeO0gZxyTf/I81e/Z9IACe33iUza99MOZBgex9mFCXIS828
         q8RuRVbbmDB4oJEaRbh1U97XMoRaMH2lvn8xCnGqGU2+pHMAyDs6DUbynbte7KKqAjmZ
         xU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=AEP100bvYHeFte3Q1keKeUWm/dgWSy4X+Mkf8ur+F8w=;
        b=E4DNYpGj0bOuKe9AYtEMAnjpcCrqwNV/DFeWEl/48GM5c/j5pT62SeODMibOquAxk6
         zrdVnHqOI5AEl9Vn3zQChFPx2pPoj1qgsSJ8CGDq7QvdAfwMOkGnRuH8TfM4+e5e1KTc
         LbF6U6TB9AGnEyaZFHsw6JePdJUfSdUoOHd9vBRh+hzorbf6+g2HL7rL1fd+CKeskpdu
         yhdbzPWN2YBvjqSRaU/SvGp9zjBaCd+Z7d4og1d8WQkJPb2/WKn0wSTLZ/CY8DU1CKY3
         KPtBtzmslQhI1cH+ivx1D7KR5Mg5SXb7bXKh6a3WJoybMImIeCb/79Vqy/d0jDYtmeE6
         dxKw==
X-Gm-Message-State: AKwxytdv3uIinIrZv3ohPit9DTfr+H2YF78Am5rn5j9vvksVJ9n4NJDI
        pJvSXq18QmurB72Lhv6kRBewZSP2
X-Google-Smtp-Source: AH8x225nftuSRR4ynO5rlj8n+QRi/b9lQe7BcxDOJwT2443lhvJ3+A7/HuqAbTh29rzWrCarSVeCaQ==
X-Received: by 10.46.29.76 with SMTP id d73mr3263364ljd.70.1517241557397;
        Mon, 29 Jan 2018 07:59:17 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id p74sm697995ljp.13.2018.01.29.07.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jan 2018 07:59:16 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.net
Subject: [PATCH v3 0/1] setup: recognise extensions.objectFormat
Date:   Mon, 29 Jan 2018 16:59:14 +0100
Message-Id: <cover.1517241235.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1517098675.git.patryk.obara@gmail.com>
References: <cover.1517098675.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compred to v2:

Fixed commit message.

Patryk Obara (1):
  setup: recognise extensions.objectFormat

 Documentation/technical/repository-version.txt | 12 ++++++++++++
 setup.c                                        | 27 ++++++++++++++++++++++++++
 t/t1302-repo-version.sh                        | 15 ++++++++++++++
 3 files changed, 54 insertions(+)


base-commit: 5be1f00a9a701532232f57958efab4be8c959a29
-- 
2.14.3

