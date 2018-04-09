Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A14B71F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeDIIcM (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:32:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:46897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751998AbeDIIcK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:32:10 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfW5D-1epKHa1fVz-00P2Pu; Mon, 09
 Apr 2018 10:32:01 +0200
Date:   Mon, 9 Apr 2018 10:32:02 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 08/15] t1300: `--unset-all` can leave an empty section
 behind (bug)
In-Reply-To: <cover.1523262449.git.johannes.schindelin@gmx.de>
Message-ID: <c3cf926667ef4a071016507ae902aaa9e7518ea4.1523262449.git.johannes.schindelin@gmx.de>
References: <cover.1522772789.git.johannes.schindelin@gmx.de> <cover.1523262449.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VDRCHr9jC4Yzx+13ODFwRcrb66NnI9SGdv0IykNtC8zGKowF+Js
 rjDQb5arsbAbvFxQam+drE0bmxerHwTc5EVN8tPvSZXJwJhkfBpCUJoYWDgW1RkkfduRBQe
 qD3ZUj6naZrewA579z8f6xQeL8v98tlW0j+7K7Su7UhIqk2UpWfbWAB7H7BHbwyk/UpILKU
 TXJNi3YRcNLQHxXtsG2xQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gc8fgRZjeNE=:nb6l11J5zPJbd2szAXj3xV
 NGm7JrFSLBTiDMce2lfEsQCKzP7wlzV3Ku/5ocB9PaV8oAt9685shbkFDIniIH+A+yVTOf33Q
 hX0gMDRwaLMmd9woX9Itj1P68lFduRl/k3LlJ67Afp5kHTbCEBuOKOm9p8Wqajoe2AOosul3l
 CPvh2SqdkAKZ/Pho4B2MdfJHHd34va2Ze++hDL6erkSQOWCmOVS3HbdJV9fUle8wqRmdyckhf
 6sjHziGvvCiaPru5MDjeB/1x07MyxJ6EwQ+quN+djoKBhzeDJkifmjb9s5U8slErc7bXAmfm0
 FRCr65RDN+K8SJ9uLTTnHNsR7ToriyoehFY6SS5SbA7wZgFhhDz11czKT9nTpVjWx5IrI4IJr
 gefFKDz6IiVu8IS/Wtcd6k9BRM8A51YooC2yB3jXzGwDsFLGO24zSlbrFFrUDfMFpt4GMud0x
 CMBsf02JjUV6xn7O9S2Pnn8Lre6OD/1Jnq6+HidiG3j3BHJ79/PdLj03NqFQK1+ow3AqWodj2
 v7tzwrGitSmjksozLeJP4MAkcC1EZotTW2UFwFPD9HioXKudEsdM+HP0YOUs/zNfobR3QpVPC
 Xi54EkTbUn9P0HLEYmBxa1C1GBtOSYYz92LEBbOWmqBiVEyscjjb9Ey7ukjoNNLQrR54LEqcT
 /t0KFAde1zrXdbS0eg85Dc/5KUP5MmoOLPRd8reTOWwrNFp9+fOLS4bXSfbRg2tFrgujDT5RW
 o8K1ETh4VmpE2CbXazeLiVmHKQKOgZYb+5mW2kHpG4DK5LpiC2JLOl3b49SAczp2VUnldQeKA
 rkBvnnW67kMv3ndj4d5y2ff+kGUKt5MA7i9GPLKQrN4+EwRjQU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have a test demonstrating that removing the last entry from a
config section fails to remove the section header of the now-empty
section.

The same can happen, of course, if we remove the last entries in one fell
swoop. This is *also* a bug, and should be fixed at the same time.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1300-config.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index bc30cfb3468..9d23a8ca972 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1495,6 +1495,17 @@ test_expect_failure '--unset last key removes section (except if commented)' '
 	test_line_count = 3 .git/config
 '
 
+test_expect_failure '--unset-all removes section if empty & uncommented' '
+	cat >.git/config <<-\EOF &&
+	[section]
+	key = value1
+	key = value2
+	EOF
+
+	git config --unset-all section.key &&
+	test_line_count = 0 .git/config
+'
+
 test_expect_failure 'adding a key into an empty section reuses header' '
 	cat >.git/config <<-\EOF &&
 	[section]
-- 
2.17.0.windows.1.4.g7e4058d72e3


