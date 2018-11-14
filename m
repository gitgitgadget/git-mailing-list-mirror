Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CF701F97E
	for <e@80x24.org>; Wed, 14 Nov 2018 00:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeKNKwe (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:52:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:38324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726193AbeKNKwe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:52:34 -0500
Received: (qmail 16327 invoked by uid 109); 14 Nov 2018 00:51:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Nov 2018 00:51:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28849 invoked by uid 111); 14 Nov 2018 00:51:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 13 Nov 2018 19:51:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2018 19:51:42 -0500
Date:   Tue, 13 Nov 2018 19:51:42 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 02/12] sha1-file: provide functions to look up hash
 algorithms
Message-ID: <20181114005142.GB5059@sigill.intra.peff.net>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-3-sandals@crustytoothpaste.net>
 <06e5bc95-b901-163a-5088-888878187ca2@gmail.com>
 <000ff851-3068-36f0-4fff-1e69cd24cbec@ramsayjones.plus.com>
 <aa5e6eb3-f823-e79b-df8b-7eed6fe3a2fe@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa5e6eb3-f823-e79b-df8b-7eed6fe3a2fe@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 12:42:45AM +0000, Ramsay Jones wrote:

> BTW, if you were puzzling over the 3rd symbol from sha1-file.o
> (which I wasn't counting in the 4 symbols above! ;-) ), then I
> believe that is because Jeff's commit 3a2e08245c ("object-store: 
> provide helpers for loose_objects_cache", 2018-11-12) effectively
> moved the only call outside of sha1-file.c (in sha1-name.c) back
> into sha1-file.c
> 
> So, for_each_file_in_obj_subdir() could now be marked 'static'.
> (whether it should is a different issue).

I think it would be reasonable to do so. Most code shouldn't have to
care about the on-disk hashing structure, so ideally it wouldn't be part
of the public interface.

-Peff
