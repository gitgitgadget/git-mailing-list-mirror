Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCB9E1F597
	for <e@80x24.org>; Sat,  4 Aug 2018 11:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeHDNgG (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 09:36:06 -0400
Received: from p3plsmtpa07-05.prod.phx3.secureserver.net ([173.201.192.234]:51487
        "EHLO p3plsmtpa07-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbeHDNgF (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 4 Aug 2018 09:36:05 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Aug 2018 09:36:05 EDT
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id lujGf72vkUUAHlujLfkkJt; Sat, 04 Aug 2018 04:28:21 -0700
Date:   Sat, 4 Aug 2018 14:28:14 +0300
From:   Max Kirillov <max@max630.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, manschwetus@cs-software-gmbh.de,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v9 2/3] http-backend: respect CONTENT_LENGTH as specified
 by rfc3875
Message-ID: <20180804112814.GA2060@jessie.local>
References: <20180727034859.15769-1-max@max630.net>
 <20180727034859.15769-3-max@max630.net>
 <CACsJy8DRNHVgYYH0AjdcU68PGg1anp5g+d7Up3cXp0bmDuC0Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DRNHVgYYH0AjdcU68PGg1anp5g+d7Up3cXp0bmDuC0Mg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfLf+X31vLS06T84j0sVlX1gfOYEBJ+3BVuj5hrUsT5Zug5ZZ/AP8Q86V3AinCCx0eVbS3gxspWwBHK/5VP7m2BZqMFPxLpY4kNTZOa5fbDESDoskXS2I
 Yx4hqZamU02V1C/Xozp7VtsmxIpZvksRiyDDuOW7FwC2y5+kPu7N779D7z2zSfyJ1NMpsDTTXJercZnMeVEFQu7Lt55mZVc2EIvFjbr2FTTtHETeMPJR9FHV
 quesgGt3P9C6M/LLVR9IY/rHJrPSPzI8a5ltVEzIAsRI/LiQlmAgBVsh0+TdG4fsrAaUObmfMdVtlI7BhIw4aaSGmd0ZkVZ+YXEJthvtS0hiMNP5g/4JGN3e
 SnF63FskFoc59OJJSqzyRaoRs9HS6yeGAvOD/i4eMhUT7o5aVsms7DBV4dxz7aVw6Kb1PXGl9rSG6Wuffqme4m1PzGIEDjlk+BncwZp7vlunVeSQObkJWV6f
 PbABjrvYLTvJ10FF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 04, 2018 at 08:34:08AM +0200, Duy Nguyen wrote:
> On Fri, Jul 27, 2018 at 5:50 AM Max Kirillov <max@max630.net> wrote:
>> +       if (max_request_buffer < req_len) {
>> +               die("request was larger than our maximum size (%lu): "
>> +                   "%" PRIuMAX "; try setting GIT_HTTP_MAX_REQUEST_BUFFER",
>> +                   max_request_buffer, (uintmax_t)req_len);
> 
> Please mark these strings for translation with _().

It has been discussed in [1]. Since it is not a local user
facing part, probably should not be translated.

[1] https://public-inbox.org/git/20180610150727.GE27650@jessie.local/

-- 
Max
