Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 534E21F597
	for <e@80x24.org>; Wed, 25 Jul 2018 21:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbeGYXJ5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 19:09:57 -0400
Received: from s019.cyon.net ([149.126.4.28]:35460 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731174AbeGYXJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 19:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
        :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rqJ2bhbPqVwBwWUA44oacyFI/fRXoLLoGTY7M3IsKW4=; b=oOBV4yKfvfE/28MPQEI0hKl4Uz
        fPvikHkV4HoeCFDlShgNEFdMOM7Hq1uzq/iC6t9Oy2kN2a0Qfb1za1C67fVRzfO2Kuhmlyr6UNXxa
        tCob5ypQHgalg991At7qqx6rMF3XimfTV2/sIPHPqVBqYD/qHr76f38TJtmtK+i6nr5FCfCz8AMej
        5hVvi2BV+cmsvYanCrfwMV0fciuc3bwwW/tE6R8pTb1lWm6NlLBhsbaAQKYqOkvo9ml5lj+fkBJAF
        06TZu/jCa5pl70SyxyEAqhnHQX/gn7OFyEN56bu3Clf6pDZolHW+8iLTwKFSi8S17ycjXz/Zc/aiR
        cDo6qYUA==;
Received: from [10.20.10.230] (port=46906 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fiRlX-000Wvq-Mn; Wed, 25 Jul 2018 23:56:17 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 64F2920E54; Wed, 25 Jul 2018 23:56:15 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 0/1] Pedantic fix for Apple clang
Date:   Wed, 25 Jul 2018 23:56:06 +0200
Message-Id: <20180725215607.19910-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following up on my previous series bb/pedantic for gcc, this is a fix
for pedantic compilation under MacOS 10.13.6 (High Sierra) with the
command line tools of Xcode Version 9.4.1 (9F2000).

Changes against v1:

- [1/2]: include cache.h in packfile.h.

- [2/2]: drop it. Christian Couder is going to include this in the next
  version of the cc/remote-odb topic.

Beat Bolli (1):
  packfile: drop a repeated enum declaration

 packfile.h   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.18.0

