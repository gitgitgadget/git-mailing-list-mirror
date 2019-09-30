Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CB1E1F464
	for <e@80x24.org>; Mon, 30 Sep 2019 10:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbfI3Kjt (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 06:39:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37104 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbfI3Kjt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 06:39:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id EE8101F463;
        Mon, 30 Sep 2019 10:39:48 +0000 (UTC)
Date:   Mon, 30 Sep 2019 10:39:48 +0000
From:   Eric Wong <e@80x24.org>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 10/19] introduce container_of macro
Message-ID: <20190930103948.GA29474@dcvr>
References: <20190924010324.22619-1-e@80x24.org>
 <20190924010324.22619-11-e@80x24.org>
 <059c05bb-685a-7933-55ff-f18ed271ac3a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <059c05bb-685a-7933-55ff-f18ed271ac3a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> wrote:
> On 9/23/2019 9:03 PM, Eric Wong wrote:
> > This macro is popular within the Linux kernel for supporting
> > intrusive data structures such as linked lists, red-black trees,
> > and chained hash tables while allowing the compiler to do
> > type checking.
> > 
> > I intend to use this to remove the limitation of "hashmap_entry"
> > being location-dependent and to allow more compile-time type
> > checking.
> 
> nit: I don't know why the first-person singular language caused
> me to stumble during this message. Perhaps the following rewrite
> would convey the same information:
> 
>   Later patches will use container_of() to remove the limitation
>   of "hashmap_entry" being location-dependent. This will complete
>   the transition to compile-time type checking for the hashmap API.

Agreed.  Thanks.

> > This macro already exists in our source as "list_entry" in
> > list.h and making "list_entry" an alias to "container_of"
> > as the Linux kernel has done is a possibility.
> 
> If it is the same code, then I would prefer you do this conversion
> now so we can see that equivalence in the patch AND we know that
> existing code will test it.

One problem is I'm not sure if list.h should have an
#include for git-compat-util.h, since list.h comes from an
outside source....
