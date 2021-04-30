Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D61C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F8561400
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhD3O5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 10:57:00 -0400
Received: from elephants.elehost.com ([216.66.27.132]:40914 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhD3O47 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 10:56:59 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 13UEu92w089450
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 10:56:09 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Patch 2/3] ssh.txt: document nonstopssh variant
Date:   Fri, 30 Apr 2021 10:56:03 -0400
Message-ID: <012001d73dd0$f42423a0$dc6c6ae0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: Adc90PCCfrDYsgcmQhWnYABFlj20lw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From 29158698900b312b20bfe46354d04898bf4eec04 Mon Sep 17 00:00:00 2001
From: "Randall S. Becker" <rsbecker@nexbridge.com>
Date: Fri, 30 Apr 2021 10:07:49 -0400
Subject: [Patch 2/3] ssh.txt: document nonstopssh variant

The documentation changes describe the new nonstopssh variant and
environment variables supporting the construction of the SSH command
on the NonStop x86 and ia64 platforms.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 Documentation/config/ssh.txt | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/ssh.txt b/Documentation/config/ssh.txt
index 2ca4bf93e1..75f5cc3a0e 100644
--- a/Documentation/config/ssh.txt
+++ b/Documentation/config/ssh.txt
@@ -11,7 +11,8 @@ ssh.variant::
 +
 The config variable `ssh.variant` can be set to override this detection.
 Valid values are `ssh` (to use OpenSSH options), `plink`, `putty`,
-`tortoiseplink`, `simple` (no options except the host and remote command).
+`tortoiseplink`, `simple` (no options except the host and remote command),
+`nonstopssh`.
 The default auto-detection can be explicitly requested using the value
 `auto`.  Any other value is treated as `ssh`.  This setting can also be
 overridden via the environment variable `GIT_SSH_VARIANT`.
@@ -29,7 +30,22 @@ follows:

 * `tortoiseplink` - [-P port] [-4] [-6] -batch [username@]host command

+* `nonstopssh` - [-p port] [-Z] [-Q] [-S ssh-process] [username@]host command
+
 --
 +
 Except for the `simple` variant, command-line parameters are likely to
 change as git gains new features.
+
+The `nonstopssh` variant is controlled using environment variables:
++
+--
+
+* SSH2_PROCESS_NAME defines the ssh-process to use for communications.
+
+* SSH_SUPPRESS_BANNER, if present, inhibits the -Z option.
+
+* SSH_SUPPRESS_QUIET, if present, inhibits the -Q option.
+--
++
+Consult the NonStop SSH manual for details on NonStop SSH options.
--
2.29.2


