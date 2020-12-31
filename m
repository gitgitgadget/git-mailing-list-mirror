Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3C3C433DB
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 16:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48D6222BB
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 16:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgLaQ1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 11:27:01 -0500
Received: from elephants.elehost.com ([216.66.27.132]:18064 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgLaQ1B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 11:27:01 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 0BVGQJ5w015155
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 11:26:19 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'git'" <git@vger.kernel.org>
Subject: [BUG] git 2.30.0 t0301 hangs on x86 NonStop
Date:   Thu, 31 Dec 2020 11:26:13 -0500
Message-ID: <029001d6df91$ab5a4480$020ecd80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_0284_01D6DF63.C75856A0";
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGOXOOjL3O33Nb/iJvQ6OGj+GtrMg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Team,

We had a strange situation on t0301. Subtests 9 and 24 hung while 22 failed.
This did not happen either in rc1 or in a prior test run of the same commit.
This is not the first time we have had issues with t0301 on NonStop, but it
has been a year or so. The hangs seem to have been in the main git process
waiting for the child to disappear. We do have occasional issues with
deferred signals (mostly on the ia64 platform), so is this a surprise? Not
really. The situation appears (gut feeling) timing related and where
processes are distributed across logical CPUs - this is an MPP box. While
this isn't going to hold up our release of 2.23.0 to the community, I was
hoping for some wisdom on how this might be further examined.

Thanks,
Randall


--
Randall S. Becker
ITUGLIB Process Designer, Repository Manager, Occasional Porting Dude
+1.416.984.9826
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
-- In my real life, I talk too much.


