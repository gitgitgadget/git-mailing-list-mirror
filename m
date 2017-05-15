Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FF821FAA8
	for <e@80x24.org>; Mon, 15 May 2017 11:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755997AbdEOLGa (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 07:06:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36330 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755812AbdEOLG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 07:06:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id u65so27275934wmu.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 04:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E9AKHIGelLK+WFQAHa2cSoPiR+65FEmQ2HmO6fqXqQo=;
        b=sB3ExLta4si+pzrpk/HybrORAzV5TnkKlMI7j4REzDUAhyJoqf6o8rsS03rp1we2FB
         KOaPfgqg7/TD19MXpxQMpKKQ73885Ab6J3uJ46rgr00dC6aXvapTe21TH5dbyfu+xEWe
         mzL6899AwGGE8VCiGgb4HVqZj4bxPPZB+ExDKNePMxefNS4RHfatkiY4aIfj7fyjwjuM
         J52tAbhd4Bw7mRJy6XXbe8LZ5SovwhboFLKxMYo0cZ+EmpaegJ0e1KB2oPWsRQrIC7Vz
         wkov33s61N1HvTAf1c+v931pXG69BEooCt7Zxx5o3Yzs8a2axS+A1lLhOSMMQGv0thmz
         aJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9AKHIGelLK+WFQAHa2cSoPiR+65FEmQ2HmO6fqXqQo=;
        b=pmGqPV8hohPXjPJ489NxqMHlS7Vr2jZwOjQcGixgAJaZBY2f+URdyyQE8XKGRABdBN
         8ld2TlUw1ZWwMwm/0ihG/cwzzxg+LA3jHKJKEa5Slo+/OVQ88rTIaKmqlayPy/Prmyf3
         TSxWtI9ZWVJJwIR/2uSxDqnkn+m0sUM1felMBqFqQ9HcT+a4OkwtqXCnYk6OX/mRatSK
         okLkoJX0k063iIxugJAyADzKLSEgwPmYsmtQl/rtIE9hk3rULcCKNIpny5H3Dw00tvnh
         Z/5dQRV8CJsSeluipjhDGAZRf3VD0BwpV2+zRsK369dI8IakCw2/Dg0J7V55RhtX5iZ3
         t2wQ==
X-Gm-Message-State: AODbwcDZUb7PdsreT4BK6jVa37eE++npqEEb7nbywvOFuPoZMJFAvKKP
        6GBuzpMmszV88g==
X-Received: by 10.28.178.197 with SMTP id b188mr3721722wmf.139.1494846387676;
        Mon, 15 May 2017 04:06:27 -0700 (PDT)
Received: from localhost.localdomain (62-165-238-151.pool.digikabel.hu. [62.165.238.151])
        by smtp.gmail.com with ESMTPSA id 20sm10363191wmk.17.2017.05.15.04.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 May 2017 04:06:27 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv3 2/4] Documentation/clone: document ignored configuration variables
Date:   Mon, 15 May 2017 13:05:55 +0200
Message-Id: <20170515110557.11913-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.35.g14b6294b1
In-Reply-To: <20170515110557.11913-1-szeder.dev@gmail.com>
References: <20170515110557.11913-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to limitations/bugs in the current implementation, some
configuration variables specified via 'git clone -c var=val' (or 'git
-c var=val clone') are ignored during the initial fetch and checkout.

Let the users know which configuration variables are known to be
ignored ('remote.origin.mirror' and 'remote.origin.tagOpt') under the
documentation of 'git clone -c'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/git-clone.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index ec41d3d69..4f1e7d4ba 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -186,6 +186,10 @@ objects from the source repository into a pack in the cloned repository.
 	values are given for the same key, each value will be written to
 	the config file. This makes it safe, for example, to add
 	additional fetch refspecs to the origin remote.
+	Note that due to limitations of the current implementation some
+	configuration variables don't take effect during the initial
+	fetch and checkout.  Configuration variables known to not take
+	effect are: `remote.<name>.mirror` and `remote.<name>.tagOpt`.
 
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
-- 
2.13.0.35.g14b6294b1

