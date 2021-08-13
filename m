Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEE3C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 14:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1CB6103A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 14:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbhHMOW4 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 13 Aug 2021 10:22:56 -0400
Received: from elephants.elehost.com ([216.66.27.132]:30535 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbhHMOWz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 10:22:55 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 17DEMPmc009485
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 13 Aug 2021 10:22:25 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Subject: RE: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
Date:   Fri, 13 Aug 2021 10:22:19 -0400
Message-ID: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdeQTj5H2ihDLZOQQm6VoxVkMdaDeQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 11, 2021 6:31 PM, I wrote:
>To: 'Junio C Hamano' <gitster@pobox.com>; git@vger.kernel.org
>Subject: RE: [ANNOUNCE] Git v2.33.0-rc1 (Build/Test Report)
>
>On August 6, 2021 8:07 PM, Junio C Hamano wrote:
>>
>>A release candidate Git v2.33.0-rc1 is now available for testing at the
>>usual places.  It is comprised of 396 non-merge commits since v2.32.0, contributed by 63 people, 19 of which are new faces [*].
>
>Just a report that t0301.9 hung again on 2.32.0-rc1 on the NonStop ia64 platform, and t5563.8 hung on the x86 platform. These did not
>hang at rc0 or in 2.31.0. We have seen (and reported) these before and they do appear transient. I have been meaning to dig deeper into
>both of these tests to figure out why and what the conditions are, but there are many moving parts on the platform (it is MPP). It probably
>would take some brainstorming - I suspect there is something relating to timing in the message system that is causing this heartburn, but
>the features under test do not appear to be commonly used.

2.32.0-rc2 passes on the NonStop x86 platform. ia64 is slower and still running. The test failure is t9001 because there is no sendmail on the platform. Is there a suitable dependency that I can use add to bypass this test?

