Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB291F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeDSMTH (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 08:19:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:39287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752028AbeDSMTH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:19:07 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MV5tl-1evEAG46ZB-00YQEM; Thu, 19
 Apr 2018 14:18:58 +0200
Date:   Thu, 19 Apr 2018 14:18:41 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v7 02/17] sequencer: make rearrange_squash() a bit more
 obvious
In-Reply-To: <cover.1524139900.git.johannes.schindelin@gmx.de>
Message-ID: <1bea3d4cd72e8631780bb460148ad94636427744.1524139900.git.johannes.schindelin@gmx.de>
References: <cover.1523362469.git.johannes.schindelin@gmx.de> <cover.1524139900.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GfNVak2ThBBQOaAQcB/rvGA6fEtfXcSSGI+2+lcIrxX7bASdW27
 F+/Uqn0H6nGWF5m1CLmIAIiImRpPxvRinxxH6zCoUMjN2CyDXvNbn5KafZI5LH9wzIuioLN
 vAUt/2sk9W2GhfaDUaA/kPcy1qEeP33WKrYML5wteAYrQ03urIlrWPzRTqyGrM8zTtr/BEc
 13Tx3ZYtS1JNUpk2ugrbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IjOGtda3XYs=:F57UmoraSNENa7cwPRGnKW
 jM94kdvhIM27KrHKvNq3Kwm8Fj2kZmJJieFr/9tlVo7CCYuCeSTS0FnAjiAmVIpBE7jmzGBJd
 233oCEzS032HY5xFHndtKVoqKbCtktwmj8YaSzVVvgIHA9BnlSLIOo5wdshvg7YBZSi2b3z6+
 26G0WYr/X4SG07M0Yt6DN+KSSLiaA2mFMGEzr85YO3TPN/EDGIvSz+k4gfEIyUzedrv5gwz2U
 tY3AMdnFIjhoBXlvl+UMvbiB+YCTwQmuHrkXlv8opcCtkpSyKfwduYRyOHoNP0SeACPz/v97X
 /ymSpFlp5hHlpY3MEaZw0L5m6mNh69dddYBnOP45IKxyJW3vJq0u4r4MalDOJZwcIY8OhRoBs
 pDAwcrlko6okjSjICXAqZyXIe5pPdGfBP6y4CuTexDDlsyqrLhLca/XrUZjlJyBim1V1LS6oa
 yxtIxpZlxmYw3g36ujonWPc/1sIfeyOnRyDO5x2payWHw200URAocSe9d3QvPF5leJ/tSWJSC
 NPQq1IYUFuBMpWLrPMtgbSTPyW+I0urIQ/zj5Sl2yRM1s0ErITwVQDMCyiOIxoV0a0QE+T5VJ
 w3QOsMrvWAH3aPAKIb9ozL/6tZPWFUWUdLqdAEs9mqCGJBO1esBHjps5SeKsmy2wLBgF0raWW
 u++60U9y23gi7cKDT8E7Fn9SXiR8txdSJV6RZWPUi+i2BUWLij3JaMvU5CHOhFfdOeuhaMGO7
 vBmeIOVRqeqAxDteJ3tvbW7k3OsQK8hPz/88AE8iI2sGdZ7xPzWYKQn1UHIZrygWOb0zWnsIU
 +/Mz7wV6q0LJfmKXgGmDLbeEpk1sZ+lMUigyEgPhv9db4Uly0Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are some commands that have to be skipped from rearranging by virtue
of not handling any commits.

However, the logic was not quite obvious: it skipped commands based on
their position in the enum todo_command.

Instead, let's make it explicit that we skip all commands that do not
handle any commit. With one exception: the `drop` command, because it,
well, drops the commit and is therefore not eligible to rearranging.

Note: this is a bit academic at the moment because the only time we call
`rearrange_squash()` is directly after generating the todo list, when we
have nothing but `pick` commands anyway.

However, the upcoming `merge` command *will* want to be handled by that
function, and it *can* handle commits.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 096e6d241e0..1ee70d843c1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3393,7 +3393,7 @@ int rearrange_squash(void)
 		struct subject2item_entry *entry;
 
 		next[i] = tail[i] = -1;
-		if (item->command >= TODO_EXEC) {
+		if (!item->commit || item->command == TODO_DROP) {
 			subjects[i] = NULL;
 			continue;
 		}
-- 
2.17.0.windows.1.4.g7e4058d72e3


