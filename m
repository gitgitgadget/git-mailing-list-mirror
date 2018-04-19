Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8791F424
	for <e@80x24.org>; Thu, 19 Apr 2018 08:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeDSISc (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 04:18:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:37413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbeDSISb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 04:18:31 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lh6sJ-1egMfF2VcN-00oXl4; Thu, 19
 Apr 2018 10:18:26 +0200
Date:   Thu, 19 Apr 2018 10:18:10 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 3/7] Add a test for `git replace --convert-graft-file`
In-Reply-To: <cover.1524125760.git.johannes.schindelin@gmx.de>
Message-ID: <cf8169c80f08612185f81927ee6ff22e087b2835.1524125760.git.johannes.schindelin@gmx.de>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de> <cover.1524125760.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dFv3UqpQPPFI7ZbqFkN7AWxq2Fi9TRHs4lU/3OfG145wop17WHk
 h3maEGpKJO+JvdU2bh76td8RCx3pGTfpxID0YkOHBTDaj06wUxxTQpIAV9s/pA9kcBC5L4x
 VdBX8zoASDg+41EAOS7FSh5sFrRzRhIox73CPe0Ntyp3vBVCDvRnR5wfBRMWKZbTpFPiwhv
 qyK2qBkjERKWfRPWBwIyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tD7rcvoJp7M=:u0j1pvzj8z8ncUnVLsI6hS
 uvS3U9mB5jt/BuEMYL282aGLAbpzUE3LdK8pCzAiC8KjJSKduhu9rmGp3ZOpVvMUmKvlyWW7I
 JMej/NngNrJ9QEium6GG89xcGmEfLNzv1jK7/yCpof6BkdK6NXXPmEekpYcx2CUW5ltVlc4Xh
 7+uohVJzKkGUe9yu2RsvpnSr/iC4/ZZs41rrsovzhIkH37G8UzGGe5w9MRDreMGyGltAuNfZ4
 j8qjC1/fgfYXMTC6Urx2UE/lVwRMh90i4do/zcWRqgyhelvTg0jwRdAyZCvVVgmPPSj36WkBD
 u4KBeN1sJg+Uvfc0P7DgmA5kk2jM20S2pRnhLGypYwVW+hawMUCWKnOipXOptm1/8VJIt8eX/
 t4ptqjeRI8yOXVYOkgxeaquOapTY0L18VjNuhTZ3R6/OpOBInAWcK7II9PYX07Gg8jAIoJ9bW
 nsDnTbmy+a0dQnzdtzFhk9meIxwnejhPRNrykieYfWNdSdauZpRrdWMP02f7Ge96lnTT4gUCi
 JtDXE5tXujDYPa1ImGaorpCCpG+5EZMG5XVTV+VqUy43ttWXyhy/dXvEHDTg4+JkhzsbyH2BF
 YoPZNNES8yjkkEbS/PryJIIlsQziXQjWhq02hsdR4rnOm+msod5BDNgYTQeUVh36RdflVkaGy
 5VBuvyRfJ//zrXSY323dXK2cIG+s1zenzH7thPRp+LsIulKdtfCcJMXWT4MJC+RZEV123csP6
 Cnq7lTgOQKPlvmODtjbEummvo4KRokMbDlfbw+79vsIvAiuTD18K04aZuiLRli01WQUTGwUxa
 4CrBYhPyfRT7cfbIKz6th3rJr0SdXG8f0PfhzQbJzijIY3ond4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The proof, as the saying goes, lies in the pudding. So here is a
regression test that not only demonstrates what the option is supposed to
accomplish, but also demonstrates that it does accomplish it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6050-replace.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c630aba657e..77ded6df653 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -444,4 +444,24 @@ test_expect_success GPG '--graft on a commit with a mergetag' '
 	git replace -d $HASH10
 '
 
+test_expect_success '--convert-graft-file' '
+	: add and convert graft file &&
+	printf "%s\n%s %s\n%s\n" \
+		$(git rev-parse HEAD^^ HEAD^ HEAD^^ HEAD^2) \
+		>.git/info/grafts &&
+	git replace --convert-graft-file &&
+	test_path_is_missing .git/info/grafts &&
+
+	: verify that the history is now "grafted" &&
+	git rev-list HEAD >out &&
+	test_line_count = 4 out &&
+
+	: create invalid graft file and verify that it is not deleted &&
+	test_when_finished "rm -f .git/info/grafts" &&
+	echo $EMPTY_BLOB $EMPTY_TREE >.git/info/grafts &&
+	test_must_fail git replace --convert-graft-file 2>err &&
+	grep "$EMPTY_BLOB $EMPTY_TREE" err &&
+	grep "$EMPTY_BLOB $EMPTY_TREE" .git/info/grafts
+'
+
 test_done
-- 
2.17.0.windows.1.4.g7e4058d72e3


