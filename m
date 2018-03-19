Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2C81F404
	for <e@80x24.org>; Mon, 19 Mar 2018 20:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971491AbeCSUpK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 19 Mar 2018 16:45:10 -0400
Received: from mx0a-001d5301.pphosted.com ([67.231.148.98]:33850 "EHLO
        mx0b-001d5301.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S971480AbeCSUpH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Mar 2018 16:45:07 -0400
X-Greylist: delayed 1276 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Mar 2018 16:45:07 EDT
Received: from pps.filterd (m0084119.ppops.net [127.0.0.1])
        by mx0a-001d5301.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2JKMiEt022980
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 16:23:51 -0400
Received: from dc2-mx6.bnh.com (edge-2.bhphoto.net [74.113.190.228] (may be forged))
        by mx0a-001d5301.pphosted.com with ESMTP id 2grusbwn11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 16:23:51 -0400
Received: from DC2-DLPMTA1 (lb-fmg-svc.bhphoto.net [10.50.8.10])
        by dc2-mx6.bnh.com (8.15.1+Sun/8.14.9) with ESMTP id w2JKNnH3007059
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 16:23:49 -0400 (EDT)
Received: from [10.150.2.236] (helo=GTB)
        by DC2-DLPMTA1 with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.88)
        (envelope-from <josephst@bhphoto.com>)
        id 1ey1Jt-00083B-Gk
        for git@vger.kernel.org; Mon, 19 Mar 2018 16:23:49 -0400
Received: from EXMBX02B.bhphotovideo.local (10.150.2.237) by
 EXMBX01B.bhphotovideo.local (10.150.2.236) with Microsoft SMTP Server (TLS)
 id 15.0.1347.2; Mon, 19 Mar 2018 16:23:49 -0400
Received: from EXMBX02B.bhphotovideo.local ([fe80::e062:366f:3c94:9917]) by
 EXMBX02B.bhphotovideo.local ([fe80::e062:366f:3c94:9917%17]) with mapi id
 15.00.1347.000; Mon, 19 Mar 2018 16:23:49 -0400
From:   Joseph Strauss <josephst@bhphoto.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug With git rebase -p
Thread-Topic: Bug With git rebase -p
Thread-Index: AdO/wC9oROpH+fLZQPeiJyRnBL5/Fg==
Date:   Mon, 19 Mar 2018 20:23:48 +0000
Message-ID: <9a1c2c55ff7f412f8830dbdc4bc033bc@EXMBX02B.bhphotovideo.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.50.0.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MTA-device-Scanned: Yes (on DC2-DLPMTA1) 593 bytes in 0 secs
X-UOID: 4C47ED8A-E306-4BA3-87A5-64C08FDCDD1F
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-19_12:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found the following erroneous behavior with "git rebase -p".

My current version is git version 2.16.2.windows.1

I made an example at GitHub, https://github.com/jkstrauss/git-bug/

There seem to be two problems when rebasing merge commits with git rebase -p :
  1. All lines of merge commits' messages get collapse into a single line.
  2. When an asterisk is present in the middle of the line it gets replaced with the file names of the current directory.

  


Joseph Kalman Strauss
Lifecycle Management Engineer
B&H Photo
212-239-7500 x2212
josephst@bhphoto.com
