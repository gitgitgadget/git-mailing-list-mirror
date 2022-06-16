Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D533CC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 05:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350811AbiFPFEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 01:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349153AbiFPFEE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 01:04:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63966544EF
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 22:04:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h5so344794wrb.0
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 22:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tXMPoiGM3eUmc86fZkpV5Y8BDy83416sQIkbyZgSgM0=;
        b=PRguAry5o8dwlxMxMb2LE7fxtEeTm9WpmJM/SfUrcP85thszjnswrMbtwUaK46H8+8
         AGhsa6UYX41KgyGesyUBLWyhM8RIRPhYp463Kzd2JwNcOUN3YPwabTmiaXfs75yg37m+
         F73Q1sYeZU+UGOLatnHRMQ6NyhDNk8aV/BJCUarqjkcW4ACHTHTfWTyj1hS4BAzoDDyp
         12+pmNr3HWF/JoD5PNFY6i8czmZmEI2DV0u78xUKlJPIfVgZleAG2CKifAQ0CDiLCJVl
         3yR+ihtfTTGrUG6WWxYLpR+RkW+enNs8I5+6SojvHy2iY+Qs5d8uAmU52zqgKNaiOQos
         S40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tXMPoiGM3eUmc86fZkpV5Y8BDy83416sQIkbyZgSgM0=;
        b=UtdkMDofybrVLEmaGFb/U7wj2x+qpUZnbRbO1WE9NIiG+1X/5LHh0T0zMJEV2cLw88
         6xLi6wXjDc3utSUx/8qjblzebGRXvn/x5w6f7EpXSrSmfiymngG84n4GpTz8tNGY12Zy
         2b8r3Nvg8FgolLqOoMlStp/II4whwtBMDY4yPzRF+CbfFXrwlx+1nG7UNklQnRCpNxQw
         8dlYsagpUP2LCfuAI9FZ7wNC7kI/xM3pwSS4lrj/rE1163hNNhatkWBhqlrJcJ7RAjYp
         zbJa4K1/rpGuLjnLHkHTvOPOW048FL7LICHJ0uRjIqGZRnTQoqOhiFlypOAOKstRKuER
         gtFQ==
X-Gm-Message-State: AJIora9gQYlBTHCoVBVv7fbYQGmWaiD35PUx46xKP6/6YX8FjBBI3y7L
        yaBflXgcTCP73M9rR0950uituGRBGgaviQ==
X-Google-Smtp-Source: AGRyM1uxe1gCzUPV99BC5W0fYi+EtVyf3vosH82pL1ooSVmYUUJxL9lpJHtOG8wJRzsvR6R+k83kgQ==
X-Received: by 2002:a05:6000:11:b0:210:302d:e787 with SMTP id h17-20020a056000001100b00210302de787mr2788209wrx.535.1655355840544;
        Wed, 15 Jun 2022 22:04:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h28-20020adfa4dc000000b0020fff0ea0a3sm662341wrb.116.2022.06.15.22.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 22:03:59 -0700 (PDT)
Message-Id: <dbb86dca20574eef0cb783be597dbe05677f1efb.1655355834.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1246.v4.git.1655355834.gitgitgadget@gmail.com>
References: <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
        <pull.1246.v4.git.1655355834.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jun 2022 05:03:54 +0000
Subject: [PATCH v4 3/3] bitmap-format.txt: add information for trailing
 checksum
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Bitmap file has a trailing checksum at the end of the file. However
there is no information in the bitmap-format documentation about it.

Add a trailer section to include the trailing checksum info in the
`Documentation/technical/bitmap-format.txt` file.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/technical/bitmap-format.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index 49c8e819804..7be5f2318ba 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -138,6 +138,10 @@ in the index.
 
         ** The compressed bitmap itself, see Appendix A.
 
+	* {empty}
+	TRAILER: ::
+		Trailing checksum of the preceding contents.
+
 == Appendix A: Serialization format for an EWAH bitmap
 
 Ewah bitmaps are serialized in the same protocol as the JAVAEWAH
-- 
gitgitgadget
