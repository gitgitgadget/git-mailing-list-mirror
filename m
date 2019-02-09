Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90CAC1F453
	for <e@80x24.org>; Sat,  9 Feb 2019 18:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfBIS7p (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 13:59:45 -0500
Received: from sonic301-7.consmr.mail.bf2.yahoo.com ([74.6.129.46]:43030 "EHLO
        sonic301-7.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbfBIS7p (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Feb 2019 13:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1549738783; bh=USmud1e/0W9OrSa2RZy71j8gNEDYOvDBIAM8wbwRosk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=lbhCi4mAKeKawbAOnY0qC8uG9BArlqtP91JgdvznEMHa3Zog4KUocIYPinGhMvGeHBpvTHmWRCzsH2XH5kUbZ8NBOjeGo8osfkbA33eRrKA+P1Mn7Qumy6rdEImxUgSRVTNYhfPYRGKerTgsoMp8voYEzEMVHXwxXVDUfLPLS7mdLCmkWsAfU2W/dV5ZW+3RuPa6agu3cdBoJVxYvwuMsTLNAyk4KMf6ptKWpll35gH51hOLjT9VVtV3BkQeoaFHkNK605z0tRQ/btVP275qrWDhB5EfYZuubLM6I5TnSfy+rA8eW97VuNR+M/A1gyasP23qZ0aoQTniKTDq6Iagyg==
X-YMail-OSG: H6wFkw0VM1mik.YGgE7NCGQIdVlfstnyT33l5TUc2kiNUULgzFbG_OuKpJOgcZc
 5fcxsj_FwVJ69De7Ceip48hA6EWN1lMOrK__azE_8POL067dSL9o3d8NLF1.RJ.UzlGWzj43lD4c
 6iEMouNkUsq6vRq9NtV8g4u1PonhrAEqpMYLvZ_ytXQhkrtviwhlj6Zi5sF9xpLO5_0A5tTaeCZp
 a.iY64jBUZ7bx7B3ITvOl89T4M1Jw0XRkivel3V6BmOzUImM2KwusKV2V2U2X1v0FfteV3lHrL8f
 BvIMWgQXCg0flgSm.cg3d.d.ZaqV.MXvH7Jj9HsBAscnBqtdszr8J77FdFyNUCJP1RWuiiWSRKiF
 SPetuWa7RVDz2iCoQYxwN3QFcaOXCujGrvrtu3ketZH6PKKiVulAmaM6AAiJOaJpoAdwc.fsv_e6
 gEueDmKq9KEyp0vZixUurufqHryxMXMSarkHZ834.8ce1kLXEBT53PWVKRira6E2O58jHCu8POZB
 LdhjIszZlv6_KfM9g6ZwWJES7LJ5.zsyTODebL6nV6Qh1CS6KNqRLnDQThWSQs8E3G96e0aNhj_G
 bVOhsEMFZCZLbj6gdSkkwVbmVTwoAA6ANcVdjzOgTiGEIv_W7f3N2P5qLF5lvHpWqUtrGBYxOQhI
 KNij3swOor6qQxkmWAPTvVDpaz2i3iqCb1jztMlmW3eKg6afUwVH2OfRz1xVE2xPFcQ6H9XsUDX9
 Ycu5iXwaQIjpzmtJb4jD17r1nqjN6cpADPPAB4TVp_27hvevJzyRUdR2eav4PtybxYq9U4AWvdZk
 4zUBy.5cXbauetIdAhbw5q4BkQtxKosM77ngMETJM11K7b.N1XPO_l833qEqKMf3VNyF5178lbul
 79bC.TcgSHwUGd8ZCJRfssZ4N0bFdR.uhkO0Hi2awZBg_KDAbW_Ud.7HYZbEGYY8a.WsIV_PB6NL
 jTASgcBUYyKwgxGbLtzHvXP2nrrIFTQ10Ewd7YgExwwTCY2uvOSvKXIVP_b50gaK0O3tAu6qszEe
 vcPGlV5iZyaAvs.LD8Rvs1jCOQsVP_l27f79psveG38zh4rSS84Cue8J6gSyfSPRd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Sat, 9 Feb 2019 18:59:43 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp423.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 84a16d171cb60baba1591047a4493b27;
          Sat, 09 Feb 2019 18:59:43 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch v1 1/3] test-lib-functions.sh: add generate_zero_bytes function
Date:   Sat,  9 Feb 2019 13:59:28 -0500
Message-Id: <20190209185930.5256-2-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190209185930.5256-1-randall.s.becker@rogers.com>
References: <20190209185930.5256-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

t5318 and t5562 used /dev/zero, which is not portable. This function
provides both a fixed block of NUL bytes and an infinite stream of NULs.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 t/test-lib-functions.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 92cf8f812..bbf68712c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -116,6 +116,19 @@ remove_cr () {
 	tr '\015' Q | sed -e 's/Q$//'
 }
 
+# Generate an output of $1 bytes of all zeroes (NULs, not ASCII zeroes).
+# If $1 is 'infinity', output forever or until the receiving pipe stops reading,
+# whichever comes first.
+generate_zero_bytes () {
+	perl -e 'if ($ARGV[0] == "infinity") {
+		while (-1) {
+			print "\0"
+		}
+	} else {
+		print "\0" x $ARGV[0]
+	}' "$@"
+}
+
 # In some bourne shell implementations, the "unset" builtin returns
 # nonzero status when a variable to be unset was not set in the first
 # place.
-- 
2.12.3

