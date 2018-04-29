Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 518A91F428
	for <e@80x24.org>; Sun, 29 Apr 2018 22:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754416AbeD2WSH (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 18:18:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:58447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754352AbeD2WSG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 18:18:06 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LoVja-1ejvg01v34-00gXuJ; Mon, 30 Apr 2018 00:17:58 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 1/6] test_must_fail: support ok=sigabrt
Date:   Mon, 30 Apr 2018 00:17:39 +0200
Message-Id: <97894dd28d752ffce30312650c775d9e1b891cb8.1525040253.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
In-Reply-To: <cover.1525040253.git.johannes.schindelin@gmx.de>
References: <cover.1525040253.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1JydE3pzEW8lxq+nen3rKAFxro28k93Uag2g1a0EnbquUO2POoG
 eWO4kkVAld2FkGMl3C+KiKJwIPjggP1TjYjGmQGsvwlM4v7fkctOjHALqjF7aYKjq95b6t0
 WfYQe4xdvX8C77fzY29SPkfoUyH7NyRepn1lihy4v60AKlq8g5BWBPfR7GZov0DFjG1Ldrs
 csNngbVSJysUsl/H+rNGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Jb3r57Abhc4=:+JVP7PTbpnhrAEM5b5uRlM
 aVNyfSozlbcjCReGR5DYZWxbp3+gO60L9H1nKR2JrOHoPGxpRwtlplI309Wb6DSM+OA1hnmkj
 CJeZ2ROImoxbnMhOs6TeMAFKYiRoQf4Ry+P874/YQblv31h352s9qBTNE9VIuRVrTFCdo6376
 2x04waUU7UBgDY5ypjB6lULSWyLsThDAIC1HzypFpZGRqhNBL5lk8dKyjnYNceg54YCpvhscj
 Os+UvEfKz4zVByYvRME8GSSvXpIYKGaFblvI7HJu7rCqn9vyEP8CSWj6qtc6buq/Kc5zHaxNl
 JgfQi1z3+Plo1sQWlozfXvZXxU1Fqu7s/M2PUz8t/XUGarc0PVf/OhSX4/Jqq2CR6AcQ00JbL
 zltXK6QavufyAbK4RMPW3gerrlamausQokvSDeBR08V/FEleAkfH0FVy4lcTeaAdjET+eD8F1
 tkCHcpbR5JqX/tLCKBqWoqrVeBlU5umxrtUSPSXagEJQemUG3DlMnaxWuBLnCg23Hdz4HNIUV
 N7XsGCBULhBk2mU4VpG8U5mPEFEFwSf9oHlhY5RtjFT71DJdS0EmiiqOyxJ32hY3NoaJeCqJy
 PE10npIW7t45183JP/g9cbE6g+2r/P5bEmOD7hOmjtgLIXZIcEQwNH3v/IWRBIcwRZa42Syo2
 IGA9xPifMYAQa1qceTbXQF1jUkgyivDcYWlkdup/0nrBg7WvWkeBrHGxfHtTFRgs0tmwmeU1v
 6XWE4v7+lxBVReDs54AH/iCBn5LIzsiNKA9ZVuzE/0uhLzPJhO8xEzmuzTs9OsRKhjBc18eW6
 Is5wDre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the upcoming patch, we will prepare t1406 to handle the conversion of
refs/files-backend.c to call BUG() instead of die("BUG: ..."). This will
require handling SIGABRT as valid failure case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib-functions.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 7d620bf2a9a..926aefd1551 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -616,7 +616,7 @@ list_contains () {
 #   ok=<signal-name>[,<...>]:
 #     Don't treat an exit caused by the given signal as error.
 #     Multiple signals can be specified as a comma separated list.
-#     Currently recognized signal names are: sigpipe, success.
+#     Currently recognized signal names are: sigabrt, sigpipe, success.
 #     (Don't use 'success', use 'test_might_fail' instead.)
 
 test_must_fail () {
@@ -636,6 +636,9 @@ test_must_fail () {
 		echo >&4 "test_must_fail: command succeeded: $*"
 		return 1
 	elif test_match_signal 13 $exit_code && list_contains "$_test_ok" sigpipe
+	then
+		return 0
+	elif test_match_signal 6 $exit_code && list_contains "$_test_ok" sigabrt
 	then
 		return 0
 	elif test $exit_code -gt 129 && test $exit_code -le 192
-- 
2.17.0.windows.1.36.gdf4ca5fb72a


