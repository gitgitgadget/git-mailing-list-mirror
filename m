Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E526C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3753622201
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziggo.nl header.i=@ziggo.nl header.b="ENCSdK54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391386AbgJPWuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 18:50:05 -0400
Received: from smtpq3.tb.mail.iss.as9143.net ([212.54.42.166]:35438 "EHLO
        smtpq3.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390253AbgJPWuE (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Oct 2020 18:50:04 -0400
X-Greylist: delayed 1112 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Oct 2020 18:50:03 EDT
Received: from [212.54.42.137] (helo=smtp6.tb.mail.iss.as9143.net)
        by smtpq3.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <erwindon@ziggo.nl>)
        id 1kTYG2-0002ty-BH
        for git@vger.kernel.org; Sat, 17 Oct 2020 00:31:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ziggo.nl;
         s=202002corplgsmtpnl; h=Date:Subject:From:To;
        bh=6JMdL5uxmaUb1K8ih0wM7oWyeCWDAdSPFjSET9iMu64=; b=ENCSdK54jm/Gir/62/JvtiWK4U
        4h6MiNoH6s33zggJpGxrb9if0H25BtYyoM2+0JXwHP5nuN7uYUnbYHvXHno1hl2ZAb+BJMYafvIYy
        NdALDUeBROFF+/mPwnFHFZEuQfzZzxnMVH2l3+6k5ueOFUcD1zSnJkMAAJqifuodgPQxf28M9ab9C
        qnEKYKGdJMPoTXPV1hbZuXCJS40OGofQBeEhMAsTk03lunRIXNFZx+cQwl6snjXrRKEun3XF5bpnb
        mXZFs6MUlu0SzIOg5JCfqg0i/N9cPZ2Lvcf5eLI7/Fn1wEjyz5iXoMvFYY3EKetGlNAS3INOrvSLG
        5/WJ14Ww==;
Received: from 94-211-46-235.cable.dynamic.v4.ziggo.nl ([94.211.46.235] helo=[192.168.1.101])
        by smtp6.tb.mail.iss.as9143.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <erwindon@ziggo.nl>)
        id 1kTYG1-001nAP-G9
        for git@vger.kernel.org; Sat, 17 Oct 2020 00:31:29 +0200
To:     git@vger.kernel.org
From:   Erwin Dondorp <erwindon@ziggo.nl>
Subject: question on "git subtree split"
Message-ID: <a21e69ca-4a44-2d2f-339c-0b3f3fdd867a@ziggo.nl>
Date:   Sat, 17 Oct 2020 00:31:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: nl
X-SourceIP: 94.211.46.235
X-Authenticated-Sender: erwindon@ziggo.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.4 cv=UZjv9IeN c=1 sm=1 tr=0 ts=5f8a1f41 a=94fhqBjo3BnQsa8EFWpL5A==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=IkcTkHD0fZMA:10 a=afefHYAZSVUA:10 a=uPZiAMpXAAAA:8 a=OxCnMaZgw1TWx1HfN2UA:9 a=QEXdDO2ut3YA:10 a=kKlv5diQZ1kA:10 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Ziggo-Spam-Status: No
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm splitting the directories of one large repository into multiple 
repositories using "git subtree split".
Everything is clear and understandable thanks to 
https://stackoverflow.com/questions/359424/detach-move-subdirectory-into-separate-git-repository#17864475
The new branch is created and contains exactly the expected commits.

But the oldest commit from the new branch is not connected to the 
initial (empty) commit of the repository.
Instead, it is a new parent-less commit.
This causes problems with some of the next operations that I need to 
perform as project cleanup, like squashing/re-ordering commits.

Is this intentional that the oldest commit of the new branch is parent-less?

Erwin

