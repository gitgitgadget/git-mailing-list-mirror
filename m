Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E3CC4332F
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357259AbiALT4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:56:52 -0500
Received: from elephants.elehost.com ([216.66.27.132]:43106 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350199AbiALT4o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:56:44 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 20CJugNF031702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 14:56:42 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [PATCH v1] Modify NonStop configuration to disable uncompress2
Date:   Wed, 12 Jan 2022 14:56:36 -0500
Organization: Nexbridge Inc.
Message-ID: <002901d807ee$84cd2f40$8e678dc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdgH7kdaFUKIQA6HSIO4w8SxwRwcbQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modify NonStop configuration to disable uncompress2.

The zlib version available on NonStop x86/ia64 does not contain the
uncompress2()
Procedure.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index a3a779327f..9b3e9bff5f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -576,6 +576,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
        NO_SETENV = YesPlease
        NO_UNSETENV = YesPlease
        NO_MKDTEMP = YesPlease
+       NO_UNCOMPRESS2 = YesPlease
        # Currently libiconv-1.9.1.
        OLD_ICONV = UnfortunatelyYes
        NO_REGEX = NeedsStartEnd
--
2.34.1



