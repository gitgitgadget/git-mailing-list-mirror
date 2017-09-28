Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33D8820A26
	for <e@80x24.org>; Thu, 28 Sep 2017 00:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbdI1AFg (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 20:05:36 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:54004 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbdI1AFg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 20:05:36 -0400
Received: by mail-pf0-f180.google.com with SMTP id x78so8051043pff.10
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 17:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xiwsNAuJhTiaaHCBqNJ9fKoa1UCl74zViQGKFub1uSo=;
        b=t476I7P9e36y9QXVZ1dQ8PPpLtb9j7SsqLGQzVREsj+d9wlHCwcY8soVPMeseBC3PK
         M9SwBko/ArqSrVfpQTPC5pyfm/zRDE9ekMmS3Z6qoC1RKNcZCgLio18lSFDkxE+NDHo8
         J0qqnRbt/cR7VLpizqT7jHw8gT+fccUxWq0oN/VOkEnXCsxJP3OrR/5FGh29T2IMneeH
         NKV6FIaAGmOdluZ7+STikPvacs+pE3CauQZ7/ve3uMyntjmzAsddfpEZzKAtVhR+vZRd
         Rf1ukta0yjYLxtwVwCFOT6xJGCROef6/ecF0iVbo+NSSaX+FcRi5EDk4bLKR6+mRSNf6
         juoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xiwsNAuJhTiaaHCBqNJ9fKoa1UCl74zViQGKFub1uSo=;
        b=TWVMtrXYfyvlaVoIyv3rMNj5PELBFzIyCMMpBvMqNADGFBx9VUmzdRWD1fiVV2YLCn
         N4dpNHUiOoMTtbjIz0Qf/elJlDiW5QNc5NBn99VY5HyVtRnbBTBscVtYnZAZnSq/PBsk
         7NBJc1Ic1FxwymMJrb2wiyHe6h5rVNvbPAFhLVgGgO5kuuGMbz2QBOEl18I905PC1JCf
         u1wbZm/NhrksF2BuHy7NQix6K47rHAUz1+mAMMTCOj6/Xx2/582gwIA5HVJKtW/2Pjoj
         njjqJokMsmv15vUf8hrHxMvivWkJ1zkwIg8OwdHtnfMiWM9u8IX+hj3i8udTrXye1gDG
         JLiw==
X-Gm-Message-State: AHPjjUi0ahBiB2KCNqT7JKDe5EO3CkpD56uZ7l1LDqtjTJMb+ExVeYyw
        WRzPKZQAEYqwaMY/VXQWViecsA==
X-Google-Smtp-Source: AOwi7QB5UUL9sQuy8PrXF+ubRFIE9D2hUk95yj0411/iELUSE4kHASICcpj3jJ5LwV5GyAK6/jOMkA==
X-Received: by 10.98.34.85 with SMTP id i82mr2645923pfi.111.1506557135316;
        Wed, 27 Sep 2017 17:05:35 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:6d10:3370:77a8:b2d0])
        by smtp.gmail.com with ESMTPSA id s81sm165398pfg.162.2017.09.27.17.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Sep 2017 17:05:34 -0700 (PDT)
Date:   Wed, 27 Sep 2017 17:05:33 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 07/13] object-filter: common declarations for object
 filtering
Message-Id: <20170927170533.65498396e008fa148a3fda90@google.com>
In-Reply-To: <7774ff8d-3a53-860d-9343-292938d59d12@jeffhostetler.com>
References: <20170922203017.53986-6-git@jeffhostetler.com>
        <20170922203017.53986-8-git@jeffhostetler.com>
        <20170926153950.a147c48ce62f73702eff7ebb@google.com>
        <7774ff8d-3a53-860d-9343-292938d59d12@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Sep 2017 13:09:42 -0400
Jeff Hostetler <git@jeffhostetler.com> wrote:

> On 9/26/2017 6:39 PM, Jonathan Tan wrote:
> > On Fri, 22 Sep 2017 20:30:11 +0000
> > Jeff Hostetler <git@jeffhostetler.com> wrote:
> > 
> >>   Makefile        |   1 +
> >>   object-filter.c | 269 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   object-filter.h | 173 ++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 443 insertions(+)
> >>   create mode 100644 object-filter.c
> >>   create mode 100644 object-filter.h
> > 
> > I think these and list-objects-filter-* are multiple levels of
> > indirection too many. Would a single file with a few implementations of
> > filter_object_fn be sufficient?
> 
> I did that in my first draft and I found it confusing.
> 
> Each filter has 3 parts (some filter-specific data structures,
> a filter callback routine, a driver to call the traverse code).
> I found it easier to reason about each filter in isolation.
> And it makes it easier to work on each independently and keep
> their inclusion in separate commits.

I looked at object-filter.{c,h} a bit more. It seems that these files:
 1) define a struct that contains all the options that we would want
 2) supplies a way to populate this struct from code that uses parse-options
 3) supplies a way to populate this struct from code that calculates
    options by hand
 4) supplies a way to populate this struct from "protocol" ("<key>" or
    "<key> <value>" strings)

And the next commit takes the struct that object-filter.{c,h} produces
and actually performs the traversal.

I think this can be significantly simplified, though. Would this work:
 a) Define the object_filter_options struct, but make all fields
    correspond to a single parameter each. Define
    OBJECT_FILTER_OPTIONS_INIT to initialize everything to 0 except for
    large_byte_limit to ULONG_MAX (so that we can detect if something
    else is set to it).
 b) Define one single OPT_PARSE_FILTER macro containing all the
    parameters. We can use the non-callback macros here. That solves 2)
    above.
 c) Define a function that takes in (int *argc, char ***argv) that can
    "massage" it to remove all filter-related arguments, storing them in
    a object_filter_options struct. That solves 3) above. As discussed
    in the API documentation, this means that argument lists of the form
    "--unknown --known" (where "--unknown" takes an argument) are
    processed differently, but then again, rev-list never supported them
    anyway (it required "--unknown=<arg>").
 d) Define a function that converts "<key>" into "--<key>" and "<key>
    <value>" into "--<key>=<value>", and use the existing mechanism.
    That solves 4) above.

This removes the need to maintain the lists of one-per-argument
functions, including the parse_filter_* and opt_parse_filter_* functions
declared in the header file. If we were to add a feature, we wouldn't
need to change anything in the caller, and wouldn't need to hand-edit
object_filter_hand_parse_arg() and object_filter_hand_parse_protocol().
