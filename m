Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 239821F51C
	for <e@80x24.org>; Wed, 23 May 2018 05:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753936AbeEWFz0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 01:55:26 -0400
Received: from giant.haxx.se ([80.67.6.50]:46098 "EHLO giant.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753918AbeEWFzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 01:55:25 -0400
Received: from giant.haxx.se (mail [127.0.0.1])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id w4N5tJti026571
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 May 2018 07:55:19 +0200
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id w4N5tJ7W026565;
        Wed, 23 May 2018 07:55:19 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Wed, 23 May 2018 07:55:19 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     Junio C Hamano <gitster@pobox.com>
cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, sbeller@google.com
Subject: Re: [PATCH v2 1/2] remote-curl: accept all encodings supported by
 curl
In-Reply-To: <xmqqwovvw4fl.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.DEB.2.20.1805230751370.6210@tvnag.unkk.fr>
References: <20180521234004.142548-1-bmwill@google.com>        <20180522184204.47332-1-bmwill@google.com> <xmqqwovvw4fl.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 23 May 2018, Junio C Hamano wrote:

>> -> Accept-Encoding: gzip
>> +> Accept-Encoding: ENCODINGS
>
> Is the ordering of these headers determined by the user of cURL library 
> (i.e. Git), or whatever the version of cURL we happened to link with happens 
> to produce?
>
> The point is whether the order is expected to be stable, or we are better 
> off sorting the actual log before comparing.

The order is not guaranteed by libcurl to be fixed, but it is likely to remain 
stable since we too have test cases and compare outputs with expected outputs! 
=)

Going forward, brotli (br) is going to become more commonly present in that 
header.

-- 

  / daniel.haxx.se
