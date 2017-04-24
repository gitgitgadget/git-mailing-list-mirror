Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300F4207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 20:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S977685AbdDXUjb (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 16:39:31 -0400
Received: from mout.web.de ([212.227.17.11]:53093 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S972941AbdDXUja (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 16:39:30 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Maaur-1cjAc33ry5-00K8lc; Mon, 24
 Apr 2017 22:39:27 +0200
Subject: Re: [PATCH v3 4/5] archive-zip: support archives bigger than 4GB
To:     Peter Krefting <peter@softwolves.pp.se>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
 <02ddca3c-a11f-7c0c-947e-5ca87a62cdee@web.de>
 <alpine.DEB.2.11.1704241912510.30460@perkele.intern.softwolves.pp.se>
 <d453610f-dbd5-3f6c-d386-69a74c238b11@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b9945842-7c34-fd02-0178-970613b242f6@web.de>
Date:   Mon, 24 Apr 2017 22:39:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <d453610f-dbd5-3f6c-d386-69a74c238b11@web.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:t4bavSvhfHclf1GIbBh5GEnHGHiqjIt8usEqaMQIgAMMB5vQuK6
 phkWcueP+HEUE93baPX9F6eSwgbpgCvfg2L9i6kyzAd+JssKPJgWqPf1yeR3R2Dsf8B6peq
 ku6ThiYmOkvQjrsq9oQ0j3N/AMSwYxuUDdb2k5M3nka28KgEV2NtNeqOyD6xbmBQ0dbx3jU
 u9X5LFGPODhvJzB5TR5gQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MMGjojaDzs0=:JrBz1wiavAidxCV0TEI1os
 S6g8fynAEF8h1s7w1VNG4ZVboDNQW4KJovLNBHy8ITrIO7K60fTVgXwsjD2nuZZ3WB1JG6sPd
 8DaL/A0eazZgb3AU+GQd7hKnhcVgDXNpnx3Tnq1jqnnOPeXFtKGekQgCf/HIo+euSYT5pkx9l
 6VXgVt16S2oz1nKGAzZQxlhl1zcp5Jn0Sjg4NsV0ouoCUzEWL1K3lO0Fb2WkCfrQOC97m1D6Y
 hx5c8Y4/XLM5zSJt4yyMEC/DQU6EvDW+QtU85ByGXIIOp4PYfDQDVBBdZMe1yQPU+nRzToWzT
 u4lCUBv056OJFnwURCZ29+eNuM0CDEcpsMLU/7IF0gnQ8j7OVK7cqw2nhhjWwwH0scTKDXxAZ
 okAekHLDJbcbzCuZ5nmuWqiEZ9a2T9NnwqHWiLNhjYcwh5nRDqRwCNwwQwxx8d0Jo9kXvqruu
 NEGyCFTosHG+HHLxnFK19+tL+76mtVZESzdrKS2UFYoeOPDMtOe52myrGpUvntu7vu4Fs4Cgk
 bgUtqNtoWCR44PNfrwWChpI0Vgf9Dcz26w0TyG+ziqBIgykfgQryUk+u9cYHy9UztzJtvVZhB
 wiB6xVp+R4XDEdHIb8/2lh66+6yHdd9secrRCkqptU3EUt00OmtWgbNSyb3nPm644MGyX/5c9
 Z3O/AkEQADMGF/3tAxyBio8UTG1zzEHwa2XfcJYNAtrrDnazJl+mwo8W3kdG6yHW2umpVQbUS
 H6VFMvDEoushJv8/VkmzYtbReP0y3GNE9wL5DlkVYEmPvceXk/eLRymQMFGIup3slhCY6rx2X
 1qs5Tty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.04.2017 um 22:06 schrieb René Scharfe:
> Am 24.04.2017 um 20:24 schrieb Peter Krefting:
>> René Scharfe:
>> Also set the version required to 45 (4.5) for any record that has 
>> zip64 fields.
> 
> Ah, yes indeed.

When I tried to implement this I realized that should set 20 for 
directories, but we use 10 for everything.  Then I compared with InfoZIP 
zip and noticed that they only ever sets 45 for the zip64 end of central 
directory record and 10 for everything else.  So I think we can/should 
keep it as it is, for compatibility's sake -- unless there is a problem 
with an old (but still relevant) extractor.

René
