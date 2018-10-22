Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 410CE1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 05:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeJVNxT (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 09:53:19 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:41625 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeJVNxT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 09:53:19 -0400
Received: by mail-pg1-f176.google.com with SMTP id 23-v6so18469270pgc.8
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 22:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXH5HHCkqKYjS9lxe135VIij9abk40VCmBKT/f4OGXY=;
        b=eHrW9TA0oO9+EEYWOTLBiTfshROXwXkhaWOqerMA36nQjlJsO26xLqwtS7U02VIQKg
         /tQcPtZctNLUmb1xG858zNvmQEJTFoRNOcWYn+PXQC2v4nHXVuEPm70KrZ6GTqM7v4C2
         S8Tlddw40AO9jrJHlEaSznv9l4oIqmkJbMylLwaSJeNkdYy/3OobIy/7q56kn5OpbrNi
         Ae++XqrCTfP7lRTxMaTDw7ld+9StiAEd3FZyu3Y/2jF48+0jioVU6AF/PELO2CSBju+W
         uAtEJUaqTq1sRgJH7PwnUaxnwQ0GVM5AtxEa+c4+YttjqgGavvn/NamNFJGHuE/BvGyu
         n9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXH5HHCkqKYjS9lxe135VIij9abk40VCmBKT/f4OGXY=;
        b=hVoRP9MxF1VpF7LCIrZFE/2sw8b1ifAlWdvFNm/J8BW916BG+r/woWaHUA76h5DM09
         hgr/8jPrJ1NosYRZ5X4u57GAPTftLZFLkVwnn1pQuZi9nwphcmDvyY6YfLLFnDKw4+gO
         twupPRW1MfiwXvA9LldEgs5yukaFIV4rxdhQJPHYwYmrQxzJsjq9i/Zp5FjsAWlLoPiw
         BPS2eTzAT99ZtRKpywZ/23nO49A9dAG9/uzWUxffDqTTuZRdI2Y3OQBigXW0ednmcwTd
         pKjkPWAhqNESUAXR8hN+o0Bc9L+dz5sK2avD1+rBarCs4/Cu1tnadYDpZevsM4mGSyPo
         q9Bg==
X-Gm-Message-State: AGRZ1gJtrM6t/wEndk/1Kqm0lvJH2ztDG3KHPG4FzEigF5cHLvV5RkNB
        oi1k/cpro7yZwfVEqOhjilFbI3g3
X-Google-Smtp-Source: AJdET5e1o/GAX884/NlNYNNLVjIU+OOGA3hRjpdOdREbGmMtdP4I+JqxCSd2vwaAhU3uzx3OTO6Ekg==
X-Received: by 2002:a63:50b:: with SMTP id 11mr3130590pgf.411.1540186579969;
        Sun, 21 Oct 2018 22:36:19 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id n63-v6sm38004733pfn.9.2018.10.21.22.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Oct 2018 22:36:19 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net
Subject: [RFC/PATCH 0/3] refactor MIN macro
Date:   Sun, 21 Oct 2018 22:36:02 -0700
Message-Id: <20181022053605.81048-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

otherwise will warn on platforms where it is already defined (macOS)

convert the internal version from xdiff to a common one from
the compatibilty header additionally


