Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43C23208CD
	for <e@80x24.org>; Thu,  7 Sep 2017 14:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755400AbdIGOCn (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 10:02:43 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:57924 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755384AbdIGOCl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 10:02:41 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue002
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0Lodqd-1dExsC1R51-00gsIV; Thu, 07
 Sep 2017 16:02:31 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] t6120: test name-rev --all and --stdin
Date:   Thu,  7 Sep 2017 16:02:21 +0200
Message-Id: <eb1b76068d898dd5fe1d4549c8985796a083ce18.1504792601.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.603.gf58147c36e
In-Reply-To: <c1cb526d-a567-b598-d980-5dbe695b7d6a@grubix.eu>
References: <c1cb526d-a567-b598-d980-5dbe695b7d6a@grubix.eu>
In-Reply-To: <cover.1504792601.git.git@grubix.eu>
References: <cover.1504792601.git.git@grubix.eu>
X-Provags-ID: V03:K0:A9p/MxexItVQ5RGN3xxjTcT+AErWb/tTSX0ao15N5JHGfetb0io
 yy7rTA+NyzcPk1gMfPBSOg0k+cDJYL3WORfX/T0t7NFCtXLGmqHNOoTkEQzrt7moD0yhi8m
 DKYHEQgg2+gacwahV0djEKYweJEn3LxZvgaAob6EgLOCyB7m5FK4+ca0JjcYsWOCtGtxTF+
 LJyZ+ZhqDhuyzJDPpAzWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0/SL6CSPGTk=:8+ToaJt/yLAV6B/846XA80
 SLK8N0cXAFzlG0h5CGTWhZrX2WvuRcsFMc1voK+ukLv/L/kXx5Qr04xfkP18Zjmmu2Ji1BvxH
 OUDxPHeGE6sTb+kNIhfQgTHn7cAgIw89YLaLqkErq1i92XkoxFGGtPLqffSZpd58Dc5Ftsug3
 cRwModYR+jLXBud52cFE6+jzxK+E94E9WQyNHHzfUnjdLCPEYW+x/HccVfGfrmEat36XegU3u
 q6aicf6DCfs7SxT+CZPPwTlOcYjvJUCY/+blUGOryE2+AyxaCUbCYkBA5Tqiga9qYMCMTSMx9
 PFZ7RN27Cft+Q8sLtpBQLk6e6x16Fdk5PHs8iMDxzVFYGMdEehz7FVZLLooHrNLFK2TfIRLtd
 DGt0QiwJXS25nGXNKCCHUKFb4BxWwh8mR5TDKk+vMZRUTRYq4jCrtrVUo88xNOxCbH7Z/cZQ+
 OUfEKJ4Z0JZkpPJ6ydH3TJbLvMbuD+zId77CEfiUJ2TB3gfQ0culCtrnggRjt/x2Ek69qagYv
 TExUjTtOUka1KUe5usUkzJIE8WIv2HLn7TS2IvFCsICLtH+VZ1F6ZlLuXCPYoZet9HhiNkSxH
 aNod4z7vTAnAfVPnIpsyIvMFMz7HyRCteNdKdYogskeWrKuizwn2NWcuXzMTZnF2b8comBptm
 3Pb09ookt2d9Vx8TdldvB98QrJUB+TDpWq3qFzTC2/DOgDyNtDw1YY0mmwiTPU+BGcWDd+TW8
 4r0xsHmUESUh21xNYkO+fV4abKMWirvDT9YI+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

name-rev is used in a few tests, but tested only in t6120 along with
describe so far.

Add tests for name-rev with --all and --stdin.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 t/t6120-describe.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index aa74eb8f0d..7c5728ebd5 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -198,6 +198,31 @@ test_expect_success 'name-rev with exact tags' '
 	test_cmp expect actual
 '
 
+test_expect_success 'name-rev --all' '
+	>expect.unsorted &&
+	for rev in $(git rev-list --all)
+	do
+		git name-rev $rev >>expect.unsorted
+	done &&
+	sort <expect.unsorted >expect &&
+	git name-rev --all >actual.unsorted &&
+	sort <actual.unsorted >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'name-rev --stdin' '
+	>expect.unsorted &&
+	for rev in $(git rev-list --all)
+	do
+		name=$(git name-rev --name-only $rev) &&
+		echo "$rev ($name)" >>expect.unsorted
+	done &&
+	sort <expect.unsorted >expect &&
+	git rev-list --all | git name-rev --stdin >actual.unsorted &&
+	sort <actual.unsorted >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'describe --contains with the exact tags' '
 	echo "A^0" >expect &&
 	tag_object=$(git rev-parse refs/tags/A) &&
-- 
2.14.1.603.gf58147c36e

