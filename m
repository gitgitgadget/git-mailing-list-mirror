Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63B1207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 12:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1169464AbdDXMEW (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 08:04:22 -0400
Received: from mout.web.de ([212.227.17.12]:61944 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1169422AbdDXMEU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 08:04:20 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPpE6-1cynFC2FvO-004xlZ; Mon, 24
 Apr 2017 14:04:16 +0200
Subject: Re: [PATCH v2] archive-zip: Add zip64 headers when file size is too
 large for 32 bits
To:     Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Keith Goldfarb <keith@blackthorn-media.com>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
Date:   Mon, 24 Apr 2017 14:04:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:lWKMx9iiMGHVxDEizQfcJf2ew7DFVgYjpIZdoZAWV7xKFWHfV5j
 2+TW39QborcrPVB0qbMfSP0OMsvQ8LfJq1FEqYC2MHN9mxxi6E7jVTJ+Q29zdWpSfVA93BO
 U3dGLFEC9Buc4Bx7F+nfmgEZeefl99UcFH5IRYTjsP7GNiojBrd6s1aYtIlS3AJOLhTzBrX
 i85JPEeU4GAT52NuZS7Cw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6LPXubmjExc=:ZS/O1M9uyPH+HXpV8asO1z
 1kVRgBec74yapVvbl5faBh/7JcnmUYQDJqhaKaHyGsO7fqsM2OxxzvZKUd7O1Ntmq9aA11dwy
 A6RtOFathe8rxhHxrUCYiA5Bl5ehOrjZRbz06FRSsPVgLy8wQeXKevW5l3IXguZZcchGg2Yzq
 9uGH7b75opaLPBqT/W0h0Q9BmUrH3jQDjEZEyw4390UUOrK7gR/8GkI62ufdnA+qR19NeeWKH
 Py0ZuXTKZ/WE3PqKRdGarvjEUPs/p5yC+pPbORZQwrIL9CuKXBczAoTuYupA7CaEpkjWxiPJS
 9Hcpgkkl+9b1S+9+buQe64TQlwTFPosSwoSCnsSuZEhhoJ6Sm3Vhpx0ci4Utdli1QAm2Av/vF
 1w07jnq1sk+VOPbfbClgSRpLegIvHBL5y1Y8KxqHkcdAV8cRzqAoCLlIl9g47/9E81+mePNiW
 dTqzRJdUgo2811oD1U86MpmIhwX1yo88OugqdM3OcN4AvaqF0Uhby0U7zQBWBSG6wK9Pd0lgj
 ohJyFk91qPo2J6yYlHWMG0DbnhWubZtwmwjdIbODRZxRqorCjBGTMBQWZ24lTL22gMhJWnW2h
 javxTbT0RXmFNlcF8nptBA7+PbJlF0iNMlzFI9HLeZ62bp6JG2XV1hsDzEEnZqMs9310y4KbT
 Sdo5qG7tP1yOVoeXKvUjRt8kiMMDkqA3x2i9QgaB/2BuLiGoPqvPuq6wdS139ffQkkeGhofR3
 0aW7EHuQZmGxOUzy9t1Ip4N91+6Lg6RpPr8fMiVHJkpA0CnAEMzrq5L7c1K5tZdHEkJr6wR+o
 12hJ2gM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.04.2017 um 10:04 schrieb Peter Krefting:
> Johannes Sixt:
> 
>> There is no "zip64 central directory". There is a "zip64 end of 
>> central directory record";
> 
> Not strange that I was confused and couldn't find it, then... :-)
> 
> All right, I need to fix up my patch to make sure I add the zip64 extra 
> record to both the central directory entry and to the local header, and 
> make sure to trigger the zip64 end of central directory whenever the zip 
> file is large enough to warrant one.
> 
>> In summary, yes, when the central directory is constructed, it must 
>> use the zip64 extra record to note the values of uncompressed size, 
>> compressed size, and the offset to the local header when they overflow 
>> 4GB.
> 
> At least that makes it easier to construct, as we only have one central 
> directory and can just extend the records that need extending.
> 
> Will fix soon.

I have a few patches for that as well.  Testing in particular is a bit 
tricky -- how to avoid creating multi-GB files just for this small 
feature?  I hope to have something to show later today.

René
