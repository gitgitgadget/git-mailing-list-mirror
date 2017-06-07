Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60E531FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 16:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbdFGQHN (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 12:07:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:60865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751072AbdFGQHM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 12:07:12 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGip3-1d5hBh23oP-00Dbce; Wed, 07
 Jun 2017 18:06:48 +0200
Date:   Wed, 7 Jun 2017 18:06:47 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/9] t1308: relax the test verifying that empty alias values
 are disallowed
In-Reply-To: <cover.1496851544.git.johannes.schindelin@gmx.de>
Message-ID: <3325827e66b1a9e693f81e8aa4cae44f41dfdc25.1496851544.git.johannes.schindelin@gmx.de>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9Ke0bFWBwHQHuuJlJcDaIYDY4g+hiR4h5ms+elsRTogLNAiItBZ
 FYxL7IrS2QWGjkHSlPrd1zK6rCuxvombdVVjySP72xAD059fbaX9J/5hTznpP4/3uuQg6BF
 tsYppHAvk8ps8Iiy42NHdwvgiY/HZHex+N0cwBxGtXk/OCZs/Q0u6LtiCn2XDaCJs/d2t8S
 uyXKoU911rALLpC/TKhsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f7gdOtg1zM8=:91MlLQX9A9Pu954/cFqOT2
 C9XNDp7NB8i1dPe1UXKY8WRML8gUMzyXtPoLfk2HVpYkIoYep1yb9AxP7TR47qK4q3iISwWwT
 183WSpwpc3UWklZ8iT3TOMEgHZ3PlN6/bHSvNsMOnqQTmS/LvwIA6sD4d6jzLGuQf3F8xoEb7
 f+9GMiaRQ+J5ye/JVbo7yaE68YxVh5LGkmqXbJnB11FQTNpYz5CR9wxpt594CcQrlQo5RTuMH
 XQUp9Q2CWNVSlY/VwlkPXYXgRKW0MN1V+F9l4Uuehr+GOCu6tdf6OQMqTTOfAwqSiEYi55La+
 7RQ0vBkaj5DSETErgjEZTGKJ5D8s9ujvFp5MicQWA+j0hYQBM60ZZnlUm5emNpBRVXCtm9Pna
 ZIIcjn5pYibQtmj6DBsAaJEiyLaKjuvWU3VNzrhUtbMv3Yrf2m2XyE1Vtm/cIp90hyqdI9MIf
 pRJnO2+QwbfNc0Q5+pW1Uyos2/VfHM+1F6ApZxqIQ1rq3gLwudejTIkNbLeDinZmmTfNlSNGU
 uGjx8j6Z3hwiwl+fAllehlD/7oau6aF7HEdloVZeDpYW9xnscRWEP/tekibdpQP2VBBblrC2v
 i2LKOxL2qQPjqTHNdCCaPDgMYpROms/umkOiFnOGWK0P88YIsJ1MajO2TY/Pyea9kU3FJ1igr
 7NMsS8S8Cw3ykAS5vPIac6gq4AoCj54+lAEj4zWu5TG/VHfBQaDhz2CP2azUBa8H5IgFWVyyn
 7zuoIdZ4m/UH5wFg92dxkRE1X3O3uaSiE/nZdwpUuLt9lrfMblAy+KiStMG5y3+9Y54dKKA1M
 VKPGZSl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are about to change the way aliases are expanded, to use the early
config machinery.

This machinery reports errors in a slightly different manner than the
cached config machinery.

Let's not get hung up by the precise wording of the message mentioning
the lin number. It is really sufficient to verify that all the relevant
information is given to the user.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1308-config-set.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index ff50960ccae..69a0aa56d6d 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -215,7 +215,9 @@ test_expect_success 'check line errors for malformed values' '
 		br
 	EOF
 	test_expect_code 128 git br 2>result &&
-	test_i18ngrep "fatal: .*alias\.br.*\.git/config.*line 2" result
+	test_i18ngrep "missing value for .alias\.br" result &&
+	test_i18ngrep "fatal: .*\.git/config" result &&
+	test_i18ngrep "fatal: .*line 2" result
 '
 
 test_expect_success 'error on modifying repo config without repo' '
-- 
2.13.0.windows.1.460.g13f583bedb5


