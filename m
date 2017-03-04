Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 578192023D
	for <e@80x24.org>; Sat,  4 Mar 2017 20:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbdCDUJo (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 15:09:44 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:17725 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbdCDUJn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 15:09:43 -0500
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v24K8jH9003282
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 4 Mar 2017 20:08:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id v24K8i7l020711
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 4 Mar 2017 20:08:45 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id v24K8h71027257;
        Sat, 4 Mar 2017 20:08:43 GMT
Received: from [10.175.200.62] (/10.175.200.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 04 Mar 2017 12:08:43 -0800
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
To:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        allan.x.xavier@oracle.com, Jeff King <peff@peff.net>
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
 <20170302105157.59791-1-larsxschneider@gmail.com>
 <alpine.DEB.2.20.1703021210170.3767@virtualbox>
 <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com>
 <xmqqinnrd098.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703030315580.3767@virtualbox>
 <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
 <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
 <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
 <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
 <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
 <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
Date:   Sat, 4 Mar 2017 21:08:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
Content-Type: multipart/mixed;
 boundary="------------9884BCCE0190D13C53266DF9"
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------9884BCCE0190D13C53266DF9
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 04/03/2017 20:49, Vegard Nossum wrote:
> On 04/03/2017 19:08, Vegard Nossum wrote:
>> On 04/03/2017 18:23, Lars Schneider wrote:
>>> Did Travis find our first 32bit bug? I briefly looked into it
>>> and the following new topic on pu seems to cause the issue:
>>>
>>> http://public-inbox.org/git/20170302172902.16850-1-allan.x.xavier@oracle.com/
>>>
>>>
>>> https://github.com/git/git/commit/aaae0bf787f09ba102f69c3cf85d37e6554ab9fd
>>>
>>>
>>>
>>> The "git log" call in the new 4211 test fails with:
>>> *** Error in `/usr/src/git/git': malloc: top chunk is corrupt:
>>> 0x09ff4a78 ***
>>>
>>> More output here:
>>> https://travis-ci.org/larsxschneider/git/builds/207715343
[...]
> At a glance, looks like range_set_copy() is using
> sizeof(struct range_set) == 12, but
> range_set_init/range_set_grow/ALLOC_GROW/REALLOC_ARRAY is using
> sizeof(rs->range) == 8.

Attached patch seems to fix it -- basically, range_set_copy() is trying
to copy more than it should. It was uncovered with the test case from
Allan's commit because it's creating enough ranges to overflow the
initial allocation on 32-bit.


Vegard

--------------9884BCCE0190D13C53266DF9
Content-Type: text/x-patch;
 name="range_set_copy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="range_set_copy.patch"

diff --git a/line-log.c b/line-log.c
index 951029665..cb0dc1110 100644
--- a/line-log.c
+++ b/line-log.c
@@ -43,7 +43,7 @@ void range_set_release(struct range_set *rs)
 static void range_set_copy(struct range_set *dst, struct range_set *src)
 {
 	range_set_init(dst, src->nr);
-	memcpy(dst->ranges, src->ranges, src->nr*sizeof(struct range_set));
+	memcpy(dst->ranges, src->ranges, src->nr*sizeof(struct range));
 	dst->nr = src->nr;
 }
 static void range_set_move(struct range_set *dst, struct range_set *src)

--------------9884BCCE0190D13C53266DF9--
