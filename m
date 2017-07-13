Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9744F202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbdGMTkD (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:40:03 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36146 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752970AbdGMTkC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:40:02 -0400
Received: by mail-pg0-f51.google.com with SMTP id u62so34267559pgb.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yXjzrZmtxtgIcB8yjsj7R7RX16xeZ4aL0nOr4IMPMRQ=;
        b=TZDgWS9CuyE8MmVezaHCqc9SLmyn0Lw2FsouvSc4SfX3PMITi/BLZxaMOYWD9cF7zD
         oljRp1dzG0KJtF/j5O22R7yAuYv4yc/T8vOwGPzAMDtPhx9Y4Oenw/YNi9pXTdH+jcC+
         TY+VKgzAtlvRStNucs9ZTzKnh7DzTF4Rx01/raqadvGva3J/8APdbipzVg0pcDrZvrao
         r9dE8MiL9o3960CwWC3GvqoKPLV/fQDmmXduYjuHJ++WY+AuZyaJSHjkGNlvaZvzx95E
         xU5vvwTLe91tqHy46XTUOMH9y90XX60Ria9/qq4S0HWw5lKuhRK4iseFhB4hXsc+0Tqs
         tcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yXjzrZmtxtgIcB8yjsj7R7RX16xeZ4aL0nOr4IMPMRQ=;
        b=GZJsK95mgXXHbByTAp5dtaC7UTF6BUFQHOns/0OLaPxFlb6GTr1BOpKfUkwIDNSQap
         VQ/K9uFBGc346jKjzpNrKekF2OkIzncTpP7nd3usNImOmqX93dUWOwHRdOebMzYSQ3JL
         AanQC/syklfzS9xZhANQgaT/k29AX87m8Qyg9EOrnbxFPI248TKa9Ydl9EKTeQbdRs35
         Xxf72HzxhZSyF5jZZmvAcJ783M59bPcNpTlNab1+hSTrqLqu4u9ODTxEs27/q1ygSwb3
         qb7UyT2yjcol6AJAD4bW5jeiPGmU+KaaiydDztU6s6G2zFX7AwAUG2tySQH/MWMtLP1g
         tkrA==
X-Gm-Message-State: AIVw113L8Z6YGFjGDWY7pnJQEr92nurZmss1ntr3HUqKuO13kR+L2jxL
        3JKNzadDz/LFHnQA
X-Received: by 10.98.158.139 with SMTP id f11mr1233104pfk.208.1499974796474;
        Thu, 13 Jul 2017 12:39:56 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:fdeb:d456:6ee8:3fad])
        by smtp.gmail.com with ESMTPSA id z74sm14936333pfd.112.2017.07.13.12.39.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 12:39:56 -0700 (PDT)
Date:   Thu, 13 Jul 2017 12:39:51 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [RFC PATCH 1/3] promised-blob, fsck: introduce promised blobs
Message-ID: <20170713123951.5cab1adc@twelve2.svl.corp.google.com>
In-Reply-To: <890a36fc-be16-83bc-fec6-94e21d0f7d0a@jeffhostetler.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
        <f9c7d4b3f800ea31e85e4897ee7048fec1e3c2f0.1499800530.git.jonathantanmy@google.com>
        <890a36fc-be16-83bc-fec6-94e21d0f7d0a@jeffhostetler.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 Jul 2017 13:29:11 -0400
Jeff Hostetler <git@jeffhostetler.com> wrote:

> My primary concern is scale and managing the list of objects over time.
> 
> My fear is that this list will be quite large.  If we only want to omit
> the very large blobs, then maybe not.  But if we want to expand that
> scope to also omit other objects (such as a clone synchronized with a
> sparse checkout), then that list will get large on large repos.  For
> example, on the Windows repo we have (conservatively) 100M+ blobs (and
> growing).  Assuming 28 bytes per, gives a 2.8GB list to be manipulated.
> 
> If I understand your proposal, newly-omitted blobs would need to be
> merged into the promised-blob list after each fetch.  The fetch itself
> may not have that many new entries, but inserting them into the existing
> list will be slow.  Also, mmap'ing and bsearch'ing will likely have
> issues.  And there's likely to be a very expensive step to remove
> entries from the list as new blobs are received (or locally created).
> 
> In such a "sparse clone", it would be nice to omit unneeded tree objects
> in addition to just blobs.   I say that because we are finding with GVFS
> on the Windows repo, that even with commits-and-trees-only filtering,
> the number of tree objects is overwhelming.

I know that discussion has shifted to the possibility of not having this
list at all, and not sending size information together with the fetch,
but going back to this...maybe omitting trees *is* the solution to both
the large local list and the large amount of size information needing to
be transferred.

So the large-blob (e.g. Android) and many-blob (e.g. Windows) cases
would look like this:

 * Large-blob repositories have no trees omitted and a few blobs
   omitted, and we have sizes for all of them.
 * Many-blob repositories have many trees omitted and either all
   blobs omitted (and we have size information for them, useful for FUSE
   or FUSE-like things, for example) or possibly no blobs omitted (for
   example, if shallow clones are going to be the norm, there won't be
   many blobs to begin with if trees are omitted).

This seems better than an intermediate solution for the many-blob
repository case in which we still keep all the trees but also try to
avoid sending and storing as much information about the blobs as
possible, because that doesn't seem to provide us with much savings
(because the trees as a whole are just as large, if not larger, than the
blob information).

> So I'm also concerned about
> limiting the list to just blobs.  If we need to have this list, it
> should be able to contain any object.  (Suggesting having an object type
> in the entry.)

This makes sense - I'll add it in.

> I also have to wonder about the need to have a complete list of omitted
> blobs up front.  It may be better to just relax the consistency checks
> and assume a missing blob is "intentionally missing" rather than
> indicating a corruption somewhere.  And then let the client do a later
> round-trip to either demand-load the object -or- demand-load the
> existence/size info if/when it really matters.
> 
> Maybe we should add a verb to your new fetch-blob endpoint to just get
> the size of one or more objects to help with this.

If we allow the omission of trees, I don't think the added complexity of
demand-loading sizes is worth it.

What do you think of doing this:
 * add a "type" field to the list of promised objects (formerly the list
   of promised blobs)
 * retain mandatory size for blobs
 * retain single file containing list of promised objects (I don't feel
   too strongly about this, but it has a slight simplicity and
   in-between-GC performance advantage)
