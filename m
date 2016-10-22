Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587E220986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756159AbcJVXF1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:05:27 -0400
Received: from srv1.79p.de ([213.239.234.118]:45622 "EHLO srv1.79p.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752134AbcJVXF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:05:27 -0400
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Oct 2016 19:05:26 EDT
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:88:6f7c:da00:1827:11c5:e19d:6fd5] (p200300886F7CDA00182711C5E19D6FD5.dip0.t-ipconnect.de [IPv6:2003:88:6f7c:da00:1827:11c5:e19d:6fd5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sven@cs-ware.de)
        by srv1.79p.de (Postfix) with ESMTPSA id BFE4C22009E;
        Sun, 23 Oct 2016 00:59:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2016; t=1477177148;
        bh=VMa4BU/QcadFXrDuKcipTf755cWihdTXNc8/qsVqJfE=;
        h=To:From:Subject:Date;
        b=iVUkJ9W6BTZR6Xz1glQ59oizIn6ku3RIeG/VoC8ksnIADAlKhSyMUUC0JhRO55NWy
         FXDeoFu3Ucu6HphgKJiHRkY/JFkWH0HB2pIVXm4P8i5QdThMTzVm7ZST7m/IWAPMoj
         ZtLv6+vRQrKiEduyDue0tiuZE1ojs8DTxp0Y/Pas4K23cCQsZwcqxde+DDXk36IS4n
         IKD8NBPTmU3SAcvPAdKe4zg2jGee3khjKDgfAiUrrtR0sbG5S8EzCG9/15n4W+XCzd
         ACKM6cshRHX09XlH87RdrP6OgC/yqyeKzkwZ7INv6a4VRpAEH+AOoxhENtZmDQND8Z
         extCDq5TWlwFw==
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
From:   Sven Strickroth <sven@cs-ware.de>
Subject: Stash pop/apply conflict and --theirs and --ours
Message-ID: <169639c9-054f-8f4c-26bd-3f130fa4c1ee@cs-ware.de>
Date:   Sun, 23 Oct 2016 00:58:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I regularly experience that beginners have problems unterstanding that
--ours and --theirs are swapped when a conflict occurrs on git stash
apply or stash pop.

From the HCI perspective this is really counter intuitive.

So, I'd like to propose that on git shash pop/apply theirs and ours
should be swapped in git index, so that git checkout --theirs and --ours
work as expected.

PS: I'm sorry if this was already discussed, I haven't found any discussion.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
