Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46B51F428
	for <e@80x24.org>; Sat, 28 Apr 2018 22:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbeD1Woe (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 18:44:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:47971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeD1Wod (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 18:44:33 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Li0dC-1eZK5j2m8I-00n7Kl; Sun, 29 Apr 2018 00:44:25 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v7 03/12] replace: avoid using die() to indicate a bug
Date:   Sun, 29 Apr 2018 00:44:24 +0200
Message-Id: <05642a8fb58086c9cc638fec1b4e61ffa8cc7506.1524955439.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
MIME-Version: 1.0
In-Reply-To: <cover.1524955439.git.johannes.schindelin@gmx.de>
References: <cover.1524865158.git.johannes.schindelin@gmx.de> <cover.1524955439.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:iXzRg9G3fcG03vGI8sgfA0kaUQd+a6mk4mc+QgtlQV+/KJ1x/kn
 82mB1s3dFVj1BZ45tkon7ESNcm3fD1wYxhOWGFKwCyW9D0bVL1Dvnyaqedgaco3AQiTlOFl
 LFimk3Yx2v1iyhf4cD9KrPLIODMeasAxXQ5Uo6IcqAUz6jwYr54lSBOT5wvH+aNSnxtuo+4
 06+97fjC873JlvMBF1WBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CgEvsJ52aLg=:Ppiyi9ZTChDK9x5LzYr/8j
 bswY9Msx2cBGQT/mha6BWt1Ghwaav18TEo7P86Sn1fnC3sbYV1qvnkGda31SdeiIl/qkrnwkv
 bPeGoXxeZq4QuxtFklQtU8HhYn4A8rV+uXyjjWmzzlDbJi8aKNfge3u0KwPsJHWakofwzEOb9
 l+c0apHVc/xr6XGwG1mZKEkkds/haDIO7MVLiEZ10SEsF5QKr1Jo6u9uTlE10gRhjdGVpQGoE
 dagqzLNrDpJJ6vzbEwvFF3c7UnkV0ab2HPB7rvogCEK+CMJIon6cn25sOTKpN9hOPpif427iW
 wwnbtWj5wMmw3K4mIyKT9OegBb0y5bDd1GcNXx+gIuGDTqtqSS+ldWAtO7IZcuMcyBRUYTIry
 mMraUxvlqGnaghLICkzdAVJKRm8g2+hIEH2YsrJ/PzRjxh1nyYguRPzvdPy1qLJtOiFByURmX
 ADGSUbucP3VUBM0pfhJDNlfduPKOa3NE5bD+aRKO5s7LH8ktfDWE7epEhJ5WtMr1vqLP7P6VP
 F7aiBZl25vkUApiY39xHq3Cv2Y4SPZqG5M6bM4RuuYcRoZZ+7W5Hio9W86XqybXe7WEjlyAr+
 px+k7pivA7VElqz9+dr4cKVbQF+3IRn7yOGSEFXabeWujyZs93DkFQjy1dkbBc87wnrSm8mEc
 dYKyWuQWkz5XOfm1SkEwosBOskmczKVLhckfLzcSl6mktWU0/FQKhwHO+pJAIifAXpS7HM0Bn
 ZjDef1z1UVoTRtNyGJY6VapNt+9QHfgrK4f4WmuByw5pDEPoyCc1okNZO8PuiMEDUr5H6Ok2w
 aFrWCuF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have the BUG() macro for that purpose.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/replace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 245d3f4164e..e345a5a0f1c 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -501,6 +501,6 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		return list_replace_refs(argv[0], format);
 
 	default:
-		die("BUG: invalid cmdmode %d", (int)cmdmode);
+		BUG("invalid cmdmode %d", (int)cmdmode);
 	}
 }
-- 
2.17.0.windows.1.36.gdf4ca5fb72a


