Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84AC1202BB
	for <e@80x24.org>; Thu,  7 Mar 2019 08:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfCGIpd (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 03:45:33 -0500
Received: from smtpout25.ngs.ru ([195.19.71.8]:39787 "EHLO smtpout.ngs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCGIpd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 03:45:33 -0500
X-Greylist: delayed 653 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Mar 2019 03:45:30 EST
Received: from smtpout.ngs.ru (postfix_iface [172.16.113.66])
        by mc-spool1.in.ngs.ru (fallback) with ESMTP id 3915E187410
        for <git@vger.kernel.org>; Thu,  7 Mar 2019 15:34:38 +0700 (+07)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ngs.ru; s=mail1;
        t=1551947668; bh=R8N0Vd33BVi7pfe38fWeFMDYcY7cDztMqD4x0C+1Q10=;
        l=595;
        h=From:Subject:To:Date:Message-ID:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=PRDgRUuWEQ4s9UETCfv6ROvZk9tm9xLY0gkRvISDUcDn8Rps/diTXK9/KD9pl1Xk/
         JMDwfYh5EhHOqHzEFbH5m4wAlsizp/FpQjqcAg1IEU9pXb3gd1YW4N0fM4itFmwomf
         F3zhD9JX0gyt5OFLRoJiM0dGYy8CjQr61naULjWU=
Received: from [192.162.88.2] (account __vic@ngs.ru)
        by mx30.intranet.ru with HTTP id 53867248 for git@vger.kernel.org; Thu, 07 Mar 2019 15:34:27 +0700      
From:   "Victor" <__vic@ngs.ru>
Subject: Strange behaviour of git log --follow
To:     git@vger.kernel.org
Date:   Thu, 07 Mar 2019 11:34:27 +0300
Message-ID: <web-53867248@mx30.intranet.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="KOI8-R"; format="flowed"
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 136597 [Mar 07 2019]
X-KLMS-AntiSpam-Version: 5.8.6.0
X-KLMS-AntiSpam-Envelope-From: __vic@ngs.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 246 246 98f1ad12ad1c8b7e9e8cf47c7fca9f23065dbd7d, {Tracking_text_let_digits}, mx14.intranet.ru:7.1.1;mx30.intranet.ru:7.1.1;github.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;192.162.88.2:7.1.2;127.0.0.199:7.1.2;ngs.ru:7.1.1, Auth:dkim=none
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: not scanned, disabled by settings
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.705, not scanned, license restriction
X-Spamd-Result: default: False [0.00 / 13.00]
 R_SPF_ALLOW(0.00)
 R_DKIM_ALLOW(0.00)
X-Spamd-Server: localhost
X-Spamd-Scan-Time: 0.21
X-Spamd-Queue-ID: DE71718466A
X-Virus-Scanned: clamav-milter 0.98.6 at mc-filter2
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

$ git log include/__vic/mutex.h
commit 9429293f8f8fb0819c77cf1f723567f6edc8fb6a
Merge: 96dd9a2 f484f4e
Author: __vic <__vic@ngs.ru>
Date:   2017-12-13 10:41:32 +0300

     Merge branch 'generic' into posix

commit f484f4e8aae32041ba56bdce12d1efd8491e94d5
Merge: 86b848a b9bbbe6
Author: __vic <__vic@ngs.ru>
Date:   2017-12-12 17:35:10 +0300

     waitable_event, thread, mutex
$ git log --follow include/__vic/mutex.h
$

Why --follow makes git produce truncated history for file 
that wasn't renamed?

My repository is available here 
https://github.com/2underscores-vic/__vic
