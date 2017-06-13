Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18AB81FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 12:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752987AbdFMMEt (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 08:04:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:61416 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752249AbdFMMEt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 08:04:49 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lb90f-1diZzt2FAH-00khO6; Tue, 13
 Jun 2017 14:04:32 +0200
Date:   Tue, 13 Jun 2017 14:04:31 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 4/6] t1308: relax the test verifying that empty alias
 values are disallowed
In-Reply-To: <cover.1497355444.git.johannes.schindelin@gmx.de>
Message-ID: <b1db4c96807da38cfe50148af36faf7ed28d6f4c.1497355444.git.johannes.schindelin@gmx.de>
References: <cover.1497355444.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:du+BQyEboJUbVJ++jzejOcAV5NFOuykXfKPLyqzFwHOmkSZGxBq
 BmlrXz5vkAis3RoGtowrzA+pp1lXSNZSZ+gXa8ABqoSr7jiNsHhinqFTp37DyzXGhrJnpNZ
 ciPZWWpg0RVn5QbvYt8+R1Dpnt87wLy+x9y1NgOLX2w09OBnyqYhB1a634SgBk8aykDzzp4
 08hd4uTjpyYDYdGQ2Xhaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fWtfHoMuSlQ=:B7MBouJUleD7u6qwCO3pP3
 OVNxhTOgcuHohYA3i9nFf43frU2PPOvdA3MWBrDIA8MsXHgI7UqJN9/brONH3vW7URh/SbJF4
 ug0GGUxv0kffuJ23CuXbJDAwHGCwzG3YKkBvUSUqIzf3LzAYQ1/SX94qYsMGaxh/QIDU4MDdH
 eZCjeuA3Y0cxak44bNnYaNGOVwvbUpF9TfG2La4S8Koq9WnLPDIgTLjY7enCW4rOTnpJmQi1O
 qwIXKcGCuaiJmmtqllkEh1BeYFGIKe6L0Mnfmbld2J8nZiy2SEcnlFPcgpf6kROBkTURb1NHK
 OkBoQG/1jSjWUVLnunMhtyqgDWO8d8ITBXl5eLaWLUKz9nGEpf+UHOHs+MMWnbqePhvO36KHc
 Auz2Jwyrr8WcmKwb57ouHXllU1a/4q2KKIIUMplSHhSGwBV52+eusoT5tZHOc+66b6UYMYojb
 tkUBy+3b5oVXA/aYLC02vxlsahEIhez8uuIetNag94eJr5bwI+kZgWIlBYvmAkP/PN4FlPTZR
 6C17fbRWinnNygG0w0bAAzf8G5CNOabyI1CfMtBfNJ/SRszKBw/OzoOrB9qVKGQm2UoA0RhUi
 nJ3E2DbCHPCDkWI7dYdW2H6CAU5IDGBC4tiD8K9kbonoAChXkk1Z+PE27j7E/avQmB1SP6Qp5
 XFqo0Ru8+MPMps3oo5GFeBpCKzePjo0wYsnSg50MpSinabJfFGVSG4QX2vAKHRLQTGMiV0mJy
 vbPpDDCZU06AO4bg3dXhBP9UqsP43v4cIkBBoVMTpNqIInDNEPQ8loOYVk2TgWATgN30stqut
 BrrVg0R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are about to change the way aliases are expanded, to use the early
config machinery.

This machinery reports errors in a slightly different manner than the
cached config machinery.

Let's not get hung up by the precise wording of the message mentioning
the line number. It is really sufficient to verify that all the relevant
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


