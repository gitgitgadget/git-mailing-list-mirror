Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7AF1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 02:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfBECZ5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 21:25:57 -0500
Received: from avasout04.plus.net ([212.159.14.19]:37243 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfBECZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 21:25:56 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id qqQsgsJLuAOoyqqQtgNq1J; Tue, 05 Feb 2019 02:25:56 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=1PHa_mihZMghVkqvNWUA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 1/2] config.mak.uname: remove obsolete SPARSE_FLAGS setting
Message-ID: <41d4bf8a-dea9-5ccd-9fad-e4604017661d@ramsayjones.plus.com>
Date:   Tue, 5 Feb 2019 02:25:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC2j/thzfiHlrh62WNX5Tc7TWOHdXxzSFPU6Z20bHbDEarKICciUeInnnarGyHigyu7LoDunbEk79yXrxrfQgYy8SnpmKhTmtQJtvQ15pq3WS//cBDmf
 VQRQRaFBiYyQ0MDgEfVCM4dvnC7x74ZT+yJFcM4CcSwC4H4gmkuR24tAFpmCVkwCB5W6Ysb7z1ZYJg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


An upcoming commit will change the semantics of the SPARSE_FLAGS
variable from an internal to a user only customisation variable.
The MinGW configuration section contains an obsolete setting for
this variable which was used (some years ago) to cater to an error
in the Win32 system header files. Since 'sparse' does not currently
support the MinGW platform, nobody on that platform can be relying
on this setting today. Remove this use of the SPARSE_FLAGS variable.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 7b36a1dfe7..786bb2f913 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -555,7 +555,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	RC = windres -O coff
 	NATIVE_CRLF = YesPlease
 	X = .exe
-	SPARSE_FLAGS = -Wno-one-bit-signed-bitfield
 ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	htmldir = doc/git/html/
 	prefix =
-- 
2.20.0
