Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0210C43461
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 17:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA31D20732
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 17:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgINRnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 13:43:25 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52407 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgINMTd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 08:19:33 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MTRIg-1k5eNG0BcC-00TlKr; Mon, 14 Sep 2020 14:19:02 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 1F3231E01E7;
        Mon, 14 Sep 2020 12:19:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9PCofhs3QeK3; Mon, 14 Sep 2020 14:19:00 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id E2FC01E01E6;
        Mon, 14 Sep 2020 14:19:00 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id BE78480518; Mon, 14 Sep 2020 14:19:06 +0200 (CEST)
Date:   Mon, 14 Sep 2020 14:19:06 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     git@vger.kernel.org
Cc:     Eric Wong <normalperson@yhbt.net>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: sub-fetches discard --ipv4|6 option
Message-ID: <20200914121906.GD4705@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:POhfEKciG2/X/6yr9QNG4gBUNju+G7IlHpHquhe9eVt4LlMXSkQ
 jgk5rSatwgR2mTibTHi3D0BmZ0dbhfxRHIelKNAHPN6Ninc0oQ1lXnkx4jdjqyXNiGLtRdK
 qsyjsI3F/xG5ekfV+2D6dzVw/GRTQcWdf6StK36Bb6uizDhxQIsf8MwlbHMXfarFG7szAFe
 L4W3rsVLj2U4BuMrK0c+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ukPNx49RFV0=:GWNwnjib1+DdONv4chyguc
 OmjqnVN3gxWcN9+Gi7qsPi1SzqGW5Toz/J/yHpffL7PMB0hdZ11Huar3pExqjXqdILMCFvzXa
 Ied3sPqwk/rsOvxlfNZoR7xA4zve4uJomo4nao0G2xT7sob5tF7lD7dGtBxfSLuxMs2ndpVqE
 O7ipz8PswNYtMJh1ro/V9HurURV7r9tCXUVxvmyArO4a6BC7+5cL35ZIbt+WTSknGZsIMUUv1
 wCMIwEjOfx2SdV8oGca4gsAT+lQjZI2qjN68Vfaj+HJ2LvaQ5amS86SPS1QT0gM5PZ4pna7JS
 rRNF+Vq4ZMJdrdS5dCgF4IzLWMUOsVlGXNUeIPCUcc2N/Pz51V+Eku1R98z+KIW1rY+IfK/Zg
 JwoWfhKTgAr/g8WoN1LkrzJ5Wi+njaubE8i2wVWz7Kp1tSEw5oDcxzFwtJppZ85hm7h/CaOoe
 A3AJoasA8qEM1wf0z0Eitz4+RLV/xvEU8ZyZhr0vjiFXBejF4luM890oBFffZXJBkbLyzKNMS
 kjNm6Xvm8YftaS/HqY4Wr7EIVbE1MkWNXoGttwbxt8DUTU/RS519cOHjlNxi9ZLitqB/BK41Y
 epoCXaTPvomcfdwAdLTZUnC+i3I8i9/KYHmnVtjAUU9bn6WR/2ZcpXymzzxjJlmj9Zs9pyQAi
 XpwaBIAP/hOLcunE315bXmaHGIymq4o/ZI4PCdNBWFo0I7zMuuTGLR+ed0DJ0Sn2djTmZzGeB
 spAyguRv29T+sHVTtsLL8f0H/wtA1agAhDYF+BktM5GL9Q5NKQ7/ID/28a42hRz+0SaLSV48K
 g/p9GeoPVBXp5TqZM++NevfDFuUaI+axHcZz4p78YSwkUHbcoLNkAqiCl3pE3OHcPIJ+5hVYa
 0DUTAVDyxqJSxCIXbHWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I have a slight problem with IPv6 configuration in my local network (connect
works but transfers do not) and would like to temporarily disable use of the
transport for a series of fetches. The fetches are all done from within a
script to which I can pass options for "git fetch" commands in its
command-line. The options will be appended to the fetch commands, i.e.:

    git fetch <hard-coded-script-options> --ipv4

Unfortunately, it only worked for the fetches which didn't use --all or
--multiple. After a light searching, I failed to find an explanation as to
why --all|--multiple are handled so inconsistently with single remote fetches
and added the options (similar to --force or --keep) to the argument list for
sub-fetches:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 82ac4be8a5..5e06c07106 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1531,6 +1531,10 @@ static void add_options_to_argv(struct argv_array *argv)
 		argv_array_push(argv, "-v");
 	else if (verbosity < 0)
 		argv_array_push(argv, "-q");
+	if (family == TRANSPORT_FAMILY_IPV4)
+		argv_array_push(argv, "--ipv4");
+	else if (family == TRANSPORT_FAMILY_IPV6)
+		argv_array_push(argv, "--ipv6");
 
 }
 
Am I missing something obvious?

Regards,
Alex
