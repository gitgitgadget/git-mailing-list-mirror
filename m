Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA5BC433EF
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 18:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhLKScT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 13:32:19 -0500
Received: from elephants.elehost.com ([216.66.27.132]:15357 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhLKScS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 13:32:18 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1BBIWGuS019291
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 13:32:16 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [RFE] git submodule foreach where initialized
Date:   Sat, 11 Dec 2021 13:32:11 -0500
Organization: Nexbridge Inc.
Message-ID: <024501d7eebd$6cc88830$46599890$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdfuvOL/58jTV/0OS120pfj1FbQFBg==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I have hit an edge condition that I think may need a command option. When
cloning, we sometimes ignore a specific submodule (because we don't need it
on the platform we are building in this case).

The git submodule foreach command reports an error: fatal: No url found for
submodule path 'sub1' in .gitmodules

In our situation, this can be bypassed because we don't care about sub1. My
thought is that some option like --init-only or --ignore-uninit might be
useful to bypass this condition and allow the foreach to run on all valid
submodules. Does that make sense?

Regards,
Randall



