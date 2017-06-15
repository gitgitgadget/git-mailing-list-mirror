Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 901161FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 10:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbdFOKgP (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 06:36:15 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33646 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdFOKgO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 06:36:14 -0400
Received: by mail-wr0-f196.google.com with SMTP id x23so2666674wrb.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 03:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pjwB3HQFBWJdbtXGHvyxRfbTikL/kKw2mxYAa9YxPsI=;
        b=e7byfUWNZ2MoRZEwHncEljZu0DZEJXo41o+wDFrlW3hIoBqbYaPM83j8B1rY3Te2Wt
         YzYgEl0OfycSmrgz/kgnBHAZTyOqX+q8ZTS9ZewehPpIlh57rEQQzukMedesFgykY8Yu
         dEbFBtUdHJkQQar4l/uP8rEMWpKWlEx+8WwUOyOYVWwCsZcmnnfC6gt8KW6n35Hgx6St
         cZs6whgN1grJiCQlZsBb+7qVc+ARW/+rqK71hwE8/1lxXOYAls8HF+BF1xyKo+40RAn9
         seGt/2d+vpsxo3Pm0KRawRitdI4wAKromwPbbi3JzkAHi1J/zZDPSQHolrsoSyzpUcjG
         06jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pjwB3HQFBWJdbtXGHvyxRfbTikL/kKw2mxYAa9YxPsI=;
        b=cVPXFgH49rGC1BwatF4LryL4CQ+nijljD/piJmSwxJ25JDM5WiWdQmP+yIj9qdu4Cy
         2gj3IVEHOGP37dWnz6GJD/9w82xvgrckLGqXrzEu4erZTyBz1YFz+K98h+w4yhJ5gUUi
         zotVMfHvzcPdPK9Ys/EdCBA5rJ6/lAjIjFimEl1SEdJ6qSfI+KYUbRHejVf86VLZrlWD
         j9EDH7LhjBwdWZQ0dk2y1tczBkLONfTyjXyJXpM2pKuusydNwVu3x+4q07AJ4W3PTZdI
         4+lvlsbjrAXemmGkNeucrJEdtTH7stG9IQJcxC3pxngIjxLXrQrd2jJY97sN7yAAum2v
         DNgw==
X-Gm-Message-State: AKS2vOzs8CsifNkUUk7jqTIq8E/fqkrylM+qUyQAySxR2CPic8H1tval
        akgztLOd7JXsUA==
X-Received: by 10.28.181.201 with SMTP id e192mr3106532wmf.48.1497522973349;
        Thu, 15 Jun 2017 03:36:13 -0700 (PDT)
Received: from localhost.localdomain (x4db032c5.dyn.telefonica.de. [77.176.50.197])
        by smtp.gmail.com with ESMTPSA id z32sm3998244wrc.12.2017.06.15.03.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 03:36:12 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] docs/pretty-formats: stress that %- removes all preceding line-feeds
Date:   Thu, 15 Jun 2017 12:36:07 +0200
Message-Id: <20170615103607.11119-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.1.505.g7cc9fcafb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

A mere plural "line-feeds" was too subtle for me to grasp on first
(and second...) reading.

 Documentation/pretty-formats.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 38040e95b..a48d267e2 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -213,8 +213,8 @@ If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
 is inserted immediately before the expansion if and only if the
 placeholder expands to a non-empty string.
 
-If you add a `-` (minus sign) after '%' of a placeholder, line-feeds that
-immediately precede the expansion are deleted if and only if the
+If you add a `-` (minus sign) after '%' of a placeholder, all consecutive
+line-feeds immediately preceding the expansion are deleted if and only if the
 placeholder expands to an empty string.
 
 If you add a ` ` (space) after '%' of a placeholder, a space
-- 
2.13.1.505.g7cc9fcafb

