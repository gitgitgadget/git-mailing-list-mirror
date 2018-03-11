Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB4C1F404
	for <e@80x24.org>; Sun, 11 Mar 2018 13:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932201AbeCKN0Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 09:26:24 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35565 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932138AbeCKN0X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 09:26:23 -0400
Received: by mail-wr0-f194.google.com with SMTP id n12so1943182wra.2
        for <git@vger.kernel.org>; Sun, 11 Mar 2018 06:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2eR0P0pMMIx6v8a63+nDC+Szm4m65EjMlAW9rQoW/uY=;
        b=Ok5jSDJ+7VSIDC94kNttVavEfi7FeMoM+O7cEcAQjCklGvwf18dVz4kXPnbYwwOw6Q
         fV4ieiX+FYCwR8hyOlZN/eXY2oSHeg82FYF45I/bSbcRTfvBgXh7FLtQ+Z3cjNOTcQfB
         ZaeS8TK6AGyONd/M3ml+bjHgeK2mr8KU3gC3Nt9Ta/pXIoTLF4XaXu5luaGOmVQ2nNtp
         O9QNXqtz5WYBIUQI02h3R6fHq7FPmhM3RG2lmhnI+9fb3DeUQ4wMB/6Sh1LWRasl0i3v
         vp0D8in1392tuVX3UVx0NzXLm6BX9tW3N2hcaYxVy/pdj9FOf9dD2jsHj/SuB9fWAyUC
         IwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2eR0P0pMMIx6v8a63+nDC+Szm4m65EjMlAW9rQoW/uY=;
        b=sgVk0u5sK+Fno8VIs2UmUj6tm2aeXGorTSygaUl5dh6zJ1Gpi3GyAktx/L2J3059qo
         +FCDuFGmzyJ7/WN8jRH8Sf1wm99llb0vEg/zXgaxdB4C1W/XcYwTpxaZFHB4yYJobQRy
         G6ceMFyhH9ZVeE7UBwxByXjY1+PgMuGrJVn6GmbTXpioL4GMc7c2zaNyiE4pOeeDzOuD
         DgNSg6SvNSLEUUOAfcEXf/yu9IQ1Tg6PP1YDaQiwKmWSLuWGi48c+nkTOQw2DfDUfd0r
         bDd3Ob11kHUyXvnj+zbkfePhcDBb+3DCiwGQVfm0cN6GsCTV8T05/qzDUb9k2gJK6Oz4
         +pjw==
X-Gm-Message-State: AElRT7EYP3fv4yXnfmMXj1Q6ba4pbIgIC8AlBwdixi7djtu4k5hG5+mn
        2NPjybGZKKvAVzvTKEp+M5ZeF196
X-Google-Smtp-Source: AG47ELtfhuqNCAbo+p3ITItdxKwR/+qdpson0tuX4ywqFtv11M/30Vp3Lh/EZbwOpjhPQvXRJAHHew==
X-Received: by 10.223.146.102 with SMTP id 93mr3667490wrj.255.1520774781405;
        Sun, 11 Mar 2018 06:26:21 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d23sm3868563wma.20.2018.03.11.06.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Mar 2018 06:26:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] Switch the default PCRE from v1 to v2 + configure fixes
Date:   Sun, 11 Mar 2018 13:26:06 +0000
Message-Id: <20180311132609.32154-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This small series makes USE_LIBPCRE=YesPlease mean
USE_LIBPCRE2=YesPlease, instead of USE_LIBPCRE1=YesPlease is it does
now. Along the way I fixed a couple of minor issues in the PCRE
detection in the autoconf script.

Ævar Arnfjörð Bjarmason (3):
  configure: fix a regression in PCRE v1 detection
  configure: detect redundant --with-libpcre & --with-libpcre1
  Makefile: make USE_LIBPCRE=YesPlease mean v2, not v1

 Makefile     | 26 +++++++++++++-------------
 configure.ac | 26 +++++++++++++++-----------
 2 files changed, 28 insertions(+), 24 deletions(-)

-- 
2.15.1.424.g9478a66081

