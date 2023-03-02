Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFADC7EE2F
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 16:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCBQnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 11:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCBQnb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 11:43:31 -0500
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491B8D312
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 08:43:30 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 322Gh0g91929320
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Thu, 2 Mar 2023 16:43:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Git List'" <git@vger.kernel.org>
Subject: [Failure] Re: git 2.40.0-rc1
Date:   Thu, 2 Mar 2023 11:43:23 -0500
Organization: Nexbridge Inc.
Message-ID: <000001d94d26$1e52a910$5af7fb30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdlNJQmdN7M+65xxQIKSSpJHBpUu0w==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

Git 2.40.0-rc2 was a regression from rc1. The following new tests failed:

t3206 - virtually all subtests failed. An example of this failure is a
results comparison in subtest 1 (seemingly relating to abbreviation):
+ test_cmp expect actual
--- expect      2023-03-02 16:39:23 +0000
+++ actual      2023-03-02 16:39:23 +0000
@@ -1,4 +1,4 @@
-1:  4de457d = 1:  35b9b25 s/5/A/
-2:  fccce22 = 2:  de345ab s/4/A/
-3:  147e64e = 3:  9af6654 s/11/B/
-4:  a63e992 = 4:  2901f77 s/12/B/
+1:  4de457d2c0d218f48d66f45f9b30f3aa62562105 = 1:
35b9b25f76d404d09a23e6c8efa96c3ce19e19aa s/5/A/
+2:  fccce22f8c95220a7283f047ecc6f042a54ad902 = 2:
de345ab3de2b56a1e208e46197bb77829a6e1f3a s/4/A/
+3:  147e64ef5365f843f378dcfd60c4b8115146a35a = 3:
9af6654000a6c3235196f874c6fa58c970fcf233 s/11/B/
+4:  a63e992599e14e34a5664fe3f213fa8ad8977fe1 = 4:
2901f773f3f322646e189b37ffe99a47ad6d456a s/12/B/

t5562.13,14 failed on gzip problems. This is a transient failure and only
occurs sometimes.

Regards,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.





