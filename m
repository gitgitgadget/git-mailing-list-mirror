Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB0431F404
	for <e@80x24.org>; Thu,  5 Apr 2018 22:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbeDEWsz (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 18:48:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:59675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752448AbeDEWsy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 18:48:54 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmbZb-1eUbcR2yJ9-00aDEw; Fri, 06
 Apr 2018 00:48:48 +0200
Date:   Fri, 6 Apr 2018 00:48:48 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] Add a test to verify that push errors are colorful
In-Reply-To: <cover.1522968472.git.johannes.schindelin@gmx.de>
Message-ID: <021133cae0d27359a5e3ee520fc26f58b7030f59.1522968472.git.johannes.schindelin@gmx.de>
References: <cover.1518783709.git.johannes.schindelin@gmx.de> <cover.1522968472.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VGBd0imQ6/zOMcmmgIA+HmRS2wHFStTQvmQ+u+HUbh/e+RAR/lA
 F3WIR5uUP4MP8jPVpSk9cYbcRVhSl1mLu/spc0ElBbN+pjMCsP1H9pzIKi2LOHYhQCKM22Q
 Ie5sfCPgivW64N7fHSGOaNG2qHTmbhlrEktTbzyMsfkbSFXVeG8Ma0mdIpUvECYZPi3Q58R
 JZoAunZfQMhOJ6/Ry2Q/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JDbt3FlVyyM=:N7Z7CCLf4/jEpHUufaGSFi
 7ldPH0j5kcjyZejshGPZWPR8W5+tkNlIX9swwkGRomy5Enz/kwyBboyANd6/g2zgEuzEzVX1J
 0uaHpSMnfuA0EIvglBKGb5eBCmaCODrF3X0Tmia852qqIZm1lgfsFEtAbHjCuo0epmTkxR8lu
 QQrDd22O66/7hfmRvnBxVT+GnF5nHBlJTQHe4dLiofoHOr+0QJO9BL5Y9dpupHGKw2TH8E4Zv
 RvaOf6Hq6PoCRhH/plExKsiLNU2Ugn//dUF4GCaXm9yuDEWcan917Vz+4jUnmnpGN6HPmCD77
 QvJ2X8p+3hDBZIYKFE9ASSJhUKTUcJM12XLem5X1wlTNyC9hJ3TfZfp87MHpLlcmuw1d4v9Oi
 AOQPAxGrHBBudmoZsX1pJoGnNFoT0Pl2s5kzf1cnXv0e80MGI8Z3DWy9ILDXo+QB94oN16AxU
 5Dw4w4y9wYWxdV7cM9pEOFTBBKlaaV//4W5Y9sUmLUnqywipR7psy+gtskHFkuumIz7wz4Uei
 nhXBe3+7FQTCVKGAhQm/7cJ7g/L0vBXNuqcuLtgLNl1JFDlhnLiPQII3XUHtapQojHAwOFSED
 oyYcSKQe6ByZdBG/KyGWlZ7uDHGxM6uMpoTY1KiUQpPBiDcz2NPUTQS7UzUVbgD1h+mE+xlRC
 1zv6agWiCp1vy+kpmmExhh4Pe3SIdpnShVigkOJHJO3y+3PbVI7nydtoXbWTdTFgIOMPYG+g1
 2whtSbU0Im85WrgQI5/9ZhGxXaVN2Sa0zEnzkO7RvjpQkXu75a5BIAwySPAXGgEY7ADBJ+9Wg
 knFQEhCg8+Cx4paD2y5/azA3r9K29sUN3hoo9ikg/zyUX+GIU4Y/c84hLu6jPi43Q1o4V1p
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This actually only tests whether the push errors/hints are colored if
the respective color.* config settings are `always`, but in the regular
case they default to `auto` (in which case we color the messages when
stderr is connected to an interactive terminal), therefore these tests
should suffice.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5541-http-push-smart.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 21340e89c96..1c2be98dc2b 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -377,5 +377,23 @@ test_expect_success 'push status output scrubs password' '
 	grep "^To $HTTPD_URL/smart/test_repo.git" status
 '
 
+test_expect_success 'colorize errors/hints' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	cat >exp <<-EOF &&
+	To http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git
+	 <RED>! [rejected]       <RESET> origin/master^ -> master (non-fast-forward)
+	error: failed to push some refs to '\''http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git'\''
+	EOF
+
+	test_must_fail git -c color.transport=always -c color.advice=always \
+		-c color.push=always \
+		push origin origin/master^:master 2>act &&
+	test_decode_color <act >decoded &&
+	test_i18ngrep "<RED>.*rejected.*<RESET>" decoded &&
+	test_i18ngrep "<RED>error: failed to push some refs" decoded &&
+	test_i18ngrep "<YELLOW>hint: " decoded &&
+	test_i18ngrep ! "^hint: " decoded
+'
+
 stop_httpd
 test_done
-- 
2.17.0.windows.1.4.g7e4058d72e3


