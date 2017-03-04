Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA0D32023D
	for <e@80x24.org>; Sat,  4 Mar 2017 18:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbdCDSIf (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 13:08:35 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:34707 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752108AbdCDSIe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 13:08:34 -0500
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v24I8LcO014311
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 4 Mar 2017 18:08:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.13.8/8.14.4) with ESMTP id v24I8Kn6023382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 4 Mar 2017 18:08:20 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v24I8Iq8032639;
        Sat, 4 Mar 2017 18:08:19 GMT
Received: from [10.175.200.62] (/10.175.200.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 04 Mar 2017 10:08:18 -0800
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
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
Date:   Sat, 4 Mar 2017 19:08:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/03/2017 18:23, Lars Schneider wrote:
> Did Travis find our first 32bit bug? I briefly looked into it
> and the following new topic on pu seems to cause the issue:
>
> http://public-inbox.org/git/20170302172902.16850-1-allan.x.xavier@oracle.com/
> https://github.com/git/git/commit/aaae0bf787f09ba102f69c3cf85d37e6554ab9fd
>
> The "git log" call in the new 4211 test fails with:
> *** Error in `/usr/src/git/git': malloc: top chunk is corrupt: 0x09ff4a78 ***
>
> More output here:
> https://travis-ci.org/larsxschneider/git/builds/207715343

It looks like it's hitting the bug the patch is supposed to fix.

Are you quite sure it's running the "git" binary that was just built (as
opposed to e.g. the system binary installed inside the container)?


Vegard
