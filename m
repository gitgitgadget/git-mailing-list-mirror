Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD25C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4688600D3
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbhGPOwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbhGPOww (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:52:52 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Jul 2021 07:49:57 PDT
Received: from mail.aixigo.de (mail.aixigo.de [IPv6:2001:67c:13b0:ffff::60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24AFEC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:49:56 -0700 (PDT)
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
        by mail.aixigo.de (OpenSMTPD) with ESMTPS id b154a719 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 16 Jul 2021 16:43:15 +0200 (CEST)
Received: from vmdpcl078.ac.aixigo.de ([172.19.100.218])
        by mailhost.ac.aixigo.de (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTPS id 16GEhFCH2350935
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 16:43:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aixigo.com;
        s=default; t=1626446595;
        bh=Q3HKAPptVnm8vGnhzEH+FUidthwalH4+2jpk1FwCId0=;
        h=To:From:Subject:Date:From;
        b=vdG9bIvqDYJoCxHlkLQrKeKAn96r0X3FeXJ9wG41Y12jEorCYLzN8EYvntIOr1oEa
         QP0DUS0TCFM1uTn/00hb0K1wz8EzNBl3B237xgHmvJ2/SJ9/j8mxWHilCTNNv7ZO6H
         pWg+hqXlcvoCn2AUaUyyJXyzl2WzW6i9aIrZf78k=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Subject: pull.rebase config vs. --ff-only on command line
Message-ID: <c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com>
Date:   Fri, 16 Jul 2021 16:43:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

this is my first time contacting you guys and girls so I hope this mail 
achieves the expected standard. I've discovered the following behaviour 
of git:

If pull.rebase is configured to true and git pull --ff-only is executed 
it seems like the config wins, i.e. issuing "Successfully rebased and 
updated refs/heads/...", which is not what I would expect. I always 
believed that command line options would overwrite configured options.

Is my assumption that command line options always win wrong or is this a 
bug?

Best regards,
Matthias

-- 
aixigo AG
Karl-Friedrich-Str. 68, 52072 Aachen, Germany
phone: +49 (0)241 559709-390, fax: +49 (0)241 559709-99
email: matthias.baumgarten@aixigo.com
web: https://www.aixigo.com
District Court Aachen – HRB 8057
Board: Christian Friedrich, Tobias Haustein
Chairman of the Supervisory Board: Dr. Roland Schlager
