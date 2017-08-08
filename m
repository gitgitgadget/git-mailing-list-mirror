Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96E5120899
	for <e@80x24.org>; Tue,  8 Aug 2017 19:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbdHHTWC (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 15:22:02 -0400
Received: from mout.web.de ([212.227.15.4]:53918 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752037AbdHHTWB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 15:22:01 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfAbI-1dH90I17m4-00ooah; Tue, 08
 Aug 2017 21:21:42 +0200
Subject: [PATCH v2] t3700: fix broken test under !POSIXPERM
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Edward Thomson <ethomson@edwardthomson.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
References: <ed5c4105-a383-ef7c-c8de-75f22d41edbe@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7c104440-5903-472c-36c2-779cd0e81be5@web.de>
Date:   Tue, 8 Aug 2017 21:21:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <ed5c4105-a383-ef7c-c8de-75f22d41edbe@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:dox/4aIDaIRWfzRDkUFYot4kYTJMcgnGGkiM2Iy3Efcoq59Eakw
 r9m77DjSskr0B+8RcFhypQ4nMZxJf8M74SitubIs0YGZ2upf2Ifb6kzvH1lJNH2/Qyg9Byq
 SLpxNr+WjXNJPXJLCN1iX1eOc/xkV6qGhUhhTLyBs/uEtAAcR2qIIbDjkDcO/A3bcMU8ueH
 YsLEYoS3hhkyhLpA3eKNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xdBXY6zDbP0=:npiVtadDZUPzhAJDkp/9B3
 hJP9Kr4j86h5oANTxsOqbDW0hOUe66g88p6NiUbnS/RyWJXGoy6bjxLHlaHyjD7FSmstNzRPF
 fJbXV6f7ORLuAR10mT9YKJ5QLIxIRTZ+PwgGg0b1HFj9xpw2ZeTfrxSfzcfc6a3v6yawob/wE
 3I2fmPQgCzcUzcGJY3cnh7d6izSP0HrjKes8QpOptBw4Wo3REt39vrZmZ/zY3f7MuRuZ0CMWG
 v6aPjBbaMCBtOMtLGnLCZQOg0NInlG+JAFSItNZnQdbYicEA706oIV+grJiwtdK4WNw7Rvpo5
 fZYqUcBO4vE1HOCy2owCcetkoln1gYlW/mw1XX5zs8cP0UjAhbPvDf7cycS2eeoxlvCWYdBj0
 q6U1fn968mcSx56cdqyNasGaxwlRbS6NmnS3J69blOAPW0iul+LHIeq5pbesQ80vLTr/MWBAN
 b8ZTz/WbWwgT/FNPdbffaO3AJwl37WEAZX4stt3ryVQxjIBT9jFOro0HVmWrrLnvTSiY0PVZA
 ZUIp9TGASwJmaqIEb6TH49PVzWZSq08m5/q7eXHboDgrB0IyzwIZ9TGNYr4m789kB+26wbG08
 NJQmcyNW2JzVfmMlgnJkTxLqCUXvQHLeNsHZKofOkDT5kV8qOxgprO2a2y+euPBjX7la/AagS
 ufDtTbePcS0ZFn/JxHYu1EYjPXNXbUx/4fuhJQTAGMUhSCu7WzV1x1KjXGMLx4fmVeRpgY7EL
 fLPZC5h8ASge9JWMKLxsKpV4GN5OP5DpHLIhyuG9KPbfLdEIuU/HXEz/96ZLCmBoEjXTaClJM
 RvxhgS7Np/J+b3cv/3WFxoQsB5dbDJC8bAXosya9IZuKTGUhh0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

76e368c378 (t3700: fix broken test under !SANITY) explains that the test
'git add --chmod=[+-]x changes index with already added file' can fail
if xfoo3 is still present as a symlink from a previous test and deletes
it with rm(1).  That still leaves it present in the index, which causes
the test to fail if POSIXPERM is not defined.  Get rid of it by calling
"git reset --hard" as well, as 76e368c378 already mentioned in passing.

Helped-by: Adam Dinwoodie <adam@dinwoodie.org>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Change since v1: Keep the rm(1) call to avoid a problem on Cygwin.

 t/t3700-add.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index f3a4b4a913..0aae21d698 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -356,6 +356,7 @@ test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
 
 test_expect_success 'git add --chmod=[+-]x changes index with already added file' '
 	rm -f foo3 xfoo3 &&
+	git reset --hard &&
 	echo foo >foo3 &&
 	git add foo3 &&
 	git add --chmod=+x foo3 &&
-- 
2.14.0
