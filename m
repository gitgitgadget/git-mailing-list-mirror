Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D06F20281
	for <e@80x24.org>; Sun,  5 Nov 2017 21:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbdKEVjO (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 16:39:14 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52154 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdKEVis (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 16:38:48 -0500
Received: by mail-wm0-f68.google.com with SMTP id b9so10652468wmh.0
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 13:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3W2qVeCfONxqqubqJx2DdTAfhwfVlzJ7vHHvqRBOXx4=;
        b=GQvYaW4otitjOkxhURoB1qU5AWlsahaVE5drY/OO3XDHtP9c/zNcU8uqycgUGr0OHi
         nWmE0bUurk6ZC2XpQE8KAigBc+zXppsqEv8EsQbxcKGuDk7/MQVHCWPzfYAfZOZjrzRB
         zrUTfjYwQ2KsDxqTQ7SR/+FMP9/hCoZ4vZaWzUURix41kdptuQdC/wncP9o+ybdpwRLK
         cad9GYTbl3diGTdkl6//PmXnCeFvmzQqSnwq1rii5igJ1J2RFvLH33bWcb07GJ2qKsNE
         F3MZHT78wyxUzeYaFUVJQu5I0usQKfB2xEbPnh2QzINOha9zIsUFhk4g3j9Ou/bzgR/h
         BneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3W2qVeCfONxqqubqJx2DdTAfhwfVlzJ7vHHvqRBOXx4=;
        b=mQt08Ycj0izXx2SZAqYn6dFOa3Wk3NsBQe7ongfMMRZntyBZGxysfJMFGbLv09YtAN
         StftveP5P6BEg0MfmEcqqZe0nySrDZH3GiKpQcTQtvGXDc0n6M8RgVRJ8c29PzBZecSZ
         Sa+slRTZ6653ZfgkAfzfU144LVIliKhwSXmdUXuX20b+qBa/uSGBoHY/tq/SGzYN+TT3
         EhN3szCVe5svwewIsMRZ0FGsyI2sdwbFB/+D8afEi7v6TdYzPZ4oHG66GAVOJzGfXm77
         aw2N+oT6/reBAH4+7PILOums/2fuVZFhY36mwW4b7BzXaLfRScaUlFkX6Zbz7iwTx4xM
         sRLg==
X-Gm-Message-State: AJaThX5DNlWop9DssTwQbBei/Ud+98bYMo+95MzpuLYRgX0ey2bFhI8z
        MELX5iiWqxpAiI5nxjnLEUNSnKFW
X-Google-Smtp-Source: ABhQp+TRmKMYvLyWPRTPO5ek6r0jJktQLES7kWzquGD2bJdDhPgJiu/zim4h8rZo/b/2cZicM8BlMQ==
X-Received: by 10.28.12.18 with SMTP id 18mr4263762wmm.129.1509917927033;
        Sun, 05 Nov 2017 13:38:47 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id h2sm5147323wrf.47.2017.11.05.13.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 13:38:46 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/8] t0021/rot13-filter: improve error message
Date:   Sun,  5 Nov 2017 22:38:32 +0100
Message-Id: <20171105213836.11717-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.8.g15d566f848
In-Reply-To: <20171105213836.11717-1-chriscool@tuxfamily.org>
References: <20171105213836.11717-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If there is no new line at the end of something it receives,
the packet_txt_read() function die()s, but it's difficult to
debug without much context.

Let's give a bit more information when that happens.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 37cecd8654..f31ff595fe 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -96,7 +96,8 @@ sub packet_bin_read {
 sub packet_txt_read {
 	my ( $res, $buf ) = packet_bin_read();
 	unless ( $res == -1 or $buf eq '' or $buf =~ s/\n$// ) {
-		die "A non-binary line MUST be terminated by an LF.";
+		die "A non-binary line MUST be terminated by an LF.\n"
+		    . "Received: '$buf'";
 	}
 	return ( $res, $buf );
 }
-- 
2.15.0.7.ga9ff306ed9.dirty

