Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0F7B1F45F
	for <e@80x24.org>; Thu,  9 May 2019 23:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEIXX3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 19:23:29 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:46031 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfEIXX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 19:23:29 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id OsNqhEAjrp7QXOsNqhUwME; Fri, 10 May 2019 00:23:26 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=drql9Go4 c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=IkcTkHD0fZMA:10 a=uJ0n3W4yp3rZpPJ3VQUA:9
 a=QEXdDO2ut3YA:10 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
To:     Git List <git@vger.kernel.org>
From:   Philip Oakley <philipoakley@iee.org>
Subject: How to exchange rerere/redo resolutions?
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <b8e56556-6c83-9e37-38e9-ac67f51b5cd2@iee.org>
Date:   Fri, 10 May 2019 00:23:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfNff+ip9RsrA0EXdbXpMe81RBnXSO5d8u2oOJnnZ9ROSEzhW3r/MV3+LST6vzEMylRcXgjqyB38rEJ8DZxnrfwraOdj9KjxLSx6We9SJ4Og1VkZnewPV
 P5ZbBw3bQDgJlgEdTwHdtFtVi5uJlWSD1irFwumG4uoyRMiX7cGrP5cET2KLURrGlc8wUQfRXoL95SYUXNKWhYz2J+WuRKb3AIHDS7PZDQ8CjEqqsxZl2NDL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Is there a mechanism for exchanging the rerere resolutions, so that 
future fixups, e.g. future clashes on pu rather than master, can be sent 
with patch series?

My current use case that there is a large patch [1] for updating long to 
size_t for use on Windows, which notes that it will have clashes with 
pu, but doesn't appear to have any method  of sending a rerere 
resolution (which the author is already aware of) to the list. Being 
able to flag up such fixes should simplify such conflict resolutions.

I had some very rough ideas about how the resolutions should look rather 
similar to three-way conflict markers, with the resolution as the 'base' 
(between the ||| - ||| marks), which would be resolved via a --base 
merge strategy.

However if there is already a method for exchanging resolutions, where 
should I look?

Philip

[1] <20190413151850.29037-1-tboegi@web.de> [PATCH v3 1/1] Use size_t 
instead of 'unsigned long' for data in memory

-- 
Philip

