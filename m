Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E2F20966
	for <e@80x24.org>; Thu, 30 Mar 2017 17:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933270AbdC3RBy (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 13:01:54 -0400
Received: from mout.web.de ([212.227.17.11]:54250 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932582AbdC3RBy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 13:01:54 -0400
Received: from birne12.local ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOAnY-1co7fk3fQy-005YVn; Thu, 30
 Mar 2017 19:01:48 +0200
Subject: Re: [PATCH v2 1/2] pkt-line: add packet_writel() and
 packet_read_line_gently()
To:     Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20170324152726.14632-1-benpeart@microsoft.com>
 <20170324152726.14632-2-benpeart@microsoft.com>
 <7a2c73c8-bb09-12ec-dd8d-99c5363f9bb4@web.de>
 <BL2PR03MB3233616BE57BB7D911B1AAEF4330@BL2PR03MB323.namprd03.prod.outlook.com>
 <a5e259bd-d994-6ddb-9dae-43531ee2e875@web.de>
 <BL2PR03MB3237F4B369C0E00168D7291F4340@BL2PR03MB323.namprd03.prod.outlook.com>
Cc:     "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <d8bb326c-6aec-9379-a5a6-051fa72f8d77@web.de>
Date:   Thu, 30 Mar 2017 19:01:42 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <BL2PR03MB3237F4B369C0E00168D7291F4340@BL2PR03MB323.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:eSGtsuxU6IPPzccxJ7trElrLNlxBYRagAiARXGCmdM3KPkNOjHG
 5j6F3pU+n3UREcp30POC8/q2RBbg0L3AXsDoNgt4EcUvjkxdKw+r7QJap27UFe82ZV5YQq8
 lxh6+b7tEzQAadCio+djMNAOg5Lxy0B2wXmj+ZZItYg3bdMgntwArUJBjCNUBDgzNnHxLSx
 vxbCCeD1OO0sxnJPj9L9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o8agdZWdQnw=:VrzghNslOpdPYbiil8yB5C
 n6QMqGB2u8hkTaRH6pbHEUupoLm2jhC9IOfck9s0jIOMCL+5+6LVk5xBSkpVQ4xDpGRo6abLp
 6aIT7LOn/Vdsm+H68Fc3v+KJqCxUEP0kM9tPGRErdWkIVYGipSvKXtV2IQIMHKH5jvhXKw4OX
 0YjmoyHZ9/QGDKlV3cLM48kLtSbJ2u7i3wEx2ON0umt5htS5lFGLt0HWLO2fRJ9mbnbAaOO8J
 GCPIvb7k57yQXb1z5ztHz4go1iQvcFI+Cdh9Ane0LZkHxchje7cmf24mHXv6tRifg5YppWbwU
 ihK11ZJYDG0CeE2habcL4Nk+T0veDxLWBMtTwJDRZ/JbZsNEfILNnLZVF8kTQxiAZKSOsibgx
 rWtsb/J8vGX3qKXvf7wJww6HI2/MAjNqcM2f9VlFza/kh/T5gNs2w/VXO23MRY4OyG+yJkSHM
 eB+r9kG1g9WlA6Lb6lfWTLD+/on+0j1wP8bq45EFJg2HtGP8F6mKhA2DQOLTJyK4UM24NPb8h
 DEzwCDb5JOUXGmYPN6/HJGhzNkW/b+veyMMl0Rv3CyuFh0SCBKIL3Ncp0Jv0Pws36aqh1h/Hz
 vUqj67jdNd8LUbukLZbj9JgQLkgGjwbKY+4EKEbsaeRVUmV72Pz1Zk3ChS+M7Mfd06yRn5I3g
 YzdqldJidGACakaoPGChd6t9y9VhIwaSR1ZX2nEW0DQt3VO+xNmS/p509vEPUWB8c054dFEoW
 Twn8NDq+vyZJ51eOOmWQRY/uNOATR0dDT62eODM6I+CA9EQruobEkr9pJAh6BKPhgUXF/iW0C
 5EL+9XD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30.03.17 18:01, Ben Peart wrote:
>> From: Torsten Bögershausen [mailto:tboegi@web.de]
>>
>>
>> Does this work ?
>> I would have expected
>> packet_writel(fd, "line one", "line two", "line n"), NULL; 
Typo.
Should have been:
packet_writel(fd, "line one", "line two", "line n", NULL);
>>
> 
> No, that's actually not valid C syntax.
> 
>>>
>>> which requires the use of variable number of arguments.  With your
>> proposal that convenience is lost as you have to create an array of strings
>> and pass that instead.  The usage just isn't as simple as the current model.
>>>
>> What is wrong with
>>
>> int packet_write_fmt_gently(int fd, const char *fmt, ...) and we use it like
>> this:
>> if packet_write_fmt_gently(fd, "%s%s%s", "line one", "line two", "line n")
>>
> 
> Packets are not just strings; see pkt-line.h for more details-
>  but basically they are a length packet, followed by the data (in this particular case a string). 
> The packet_writel function is a convenience function to write out a variable number of
> packetized strings followed by a flush packet.
> You're sample above would simply concatenate the three strings and then write a single packet. 
> A very different outcome. :)

Got it.
