Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9533202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 19:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbdGLT2g (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 15:28:36 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36474 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbdGLT2g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 15:28:36 -0400
Received: by mail-pf0-f196.google.com with SMTP id z6so4305203pfk.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 12:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gHDSQf4UiQBp+9MEZP0pONaNU69zQUq97od79ulJxo8=;
        b=am29sjV41siynoGZmJ6+kpWlpod+iIiV4P0mxnxTmu487tzURln5oQggQL4Nc+mb0Z
         qcI1pKHHXHpXkI/Ecj0S6c4Q4mt4jKexF9AX0vWLDdwC7N9wR82w52QmzVUplixdT9Tl
         z+vu2/ORdSTWkkgvdl0T+hug1hFTd7KXCRbBUu/RznFRsy1ISJ/o/nbn/yw4NVzeHvXY
         1VS9ZwFU7dAX/gGiGSf+pS/LYN5LTocdEFmRt4VOyPsbdvJ5BxITxkrJXmMmgMEpaUPt
         BGWOZ2wYUEOxVao5q3bgseLJ210EakrtBZREaGx87Wb/5ykzvmPcOEWC1iF0kpjRKb5y
         9g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gHDSQf4UiQBp+9MEZP0pONaNU69zQUq97od79ulJxo8=;
        b=jE8d8FxToXgKk2S71gdj0wP/Okd9oBjv19w5JmRIUv7iLU0sXv09GfDMgwVrrxXIIV
         jNT7+Ho/PPIh2VjMbXky/mRwQMjlvTUHP4OQu0oNdWWs1eoay9PX7lbkF55mmo1wcWML
         uInqZcY67pTZN6It/xCIdjutCdeJMDgaYkgVHnl09Z7NQD0zFcMQOxPecyaYbmi/fw8v
         g5v3MGueb6jFWHYnMpVB+3DIaBXDfTXt+sV04EyriJY6pF50nUMis24rULsCoiUfwiiM
         wJTRb3lc+XV34rflgpU/bp/G+jOyFU4NyXinwODbMPnlkNwY8ELsiZxRifTnnpI5gtjS
         whYQ==
X-Gm-Message-State: AIVw112YGXfcSbHXi5Jsz47leC35UEyLrv+Ke0vfL7jtw7A94SZPc5ry
        Li+58z172pbGXg==
X-Received: by 10.84.198.67 with SMTP id o61mr5649350pld.98.1499887715104;
        Wed, 12 Jul 2017 12:28:35 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:25ad:9264:1cd0:bb62])
        by smtp.gmail.com with ESMTPSA id c63sm7919056pfk.79.2017.07.12.12.28.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 12:28:34 -0700 (PDT)
Date:   Wed, 12 Jul 2017 12:28:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] promised-blob, fsck: introduce promised blobs
Message-ID: <20170712192831.GG93855@aiede.mtv.corp.google.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
 <f9c7d4b3f800ea31e85e4897ee7048fec1e3c2f0.1499800530.git.jonathantanmy@google.com>
 <890a36fc-be16-83bc-fec6-94e21d0f7d0a@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <890a36fc-be16-83bc-fec6-94e21d0f7d0a@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff Hostetler wrote:

> My primary concern is scale and managing the list of objects over time.
[...]
>                                                                  For
> example, on the Windows repo we have (conservatively) 100M+ blobs (and
> growing).  Assuming 28 bytes per, gives a 2.8GB list to be manipulated.
>
> If I understand your proposal, newly-omitted blobs would need to be
> merged into the promised-blob list after each fetch.  The fetch itself
> may not have that many new entries, but inserting them into the existing
> list will be slow.

This is a good point.  An alternative would be to avoid storing the
list and instead use a repository extension that treats all missing
blobs in the repository similarly to promised blobs (with a weaker
promise, where the server is allowed to return 404).  The downsides:

- blob sizes are not available without an additional request, e.g. for
  directory listings

- the semantics of has_object_file become more complicated.  If it
  is allowed to return false for omitted blobs, then callers have to
  be audited to tolerate that and try to look up the blob anyway.
  If it has to contact the server to find out whether an omitted blob
  is available, then callers have to be audited to skip this expensive
  operation when possible.

- similarly, the semantics of sha1_object_info{,_extended} become more
  complicated.  If they are allowed to return -1 for omitted blobs,
  then callers have to be audited to handle that. If they have to
  contact the server to find the object type and size, it becomes
  expensive in a way that affects callers.

- causes futile repeated requests to the server for objects that don't
  exist.  Caching negative lookups is fussy because a later push could
  cause those objects to exist --- though it should be possible for
  fetches to invalidate entries in such a cache using the list of
  promised blobs sent by the server.

[...]
> In such a "sparse clone", it would be nice to omit unneeded tree objects
> in addition to just blobs.   I say that because we are finding with GVFS
> on the Windows repo, that even with commits-and-trees-only filtering,
> the number of tree objects is overwhelming.  So I'm also concerned about
> limiting the list to just blobs.  If we need to have this list, it
> should be able to contain any object.  (Suggesting having an object type
> in the entry.)

Would it work to have a separate lists of blobs and trees (either in
separate files or in the same file)?

One option would be to add a version number / magic string to the start
of the file.  That would allow making format changes later without a
proliferation of distinct repository extensions.

[...]
> I assume that we'll also need a promised-blob.lock file to control
> access during list manipulation.  This is already a sore spot with the
> index; I'd hate to create another one.

Can you say more about this concern?  My experience with concurrent
fetches has already not been great (since one fetch process is not
aware of what the other has fetched) --- is your concern that the
promised-blob facility would affect pushes as well some day?

> I also have to wonder about the need to have a complete list of omitted
> blobs up front.  It may be better to just relax the consistency checks
> and assume a missing blob is "intentionally missing" rather than
> indicating a corruption somewhere.

We've discussed this previously on list and gone back and forth. :)

>                                     And then let the client do a later
> round-trip to either demand-load the object -or- demand-load the
> existence/size info if/when it really matters.

The cost of demand-loading this existence/size information is what
ultimately convinced me of this approach.

But I can see how the tradeoffs differ between the omit-large-blobs
case and the omit-all-blobs case.  We might end up having to support
both modes. :(

> Maybe we should add a verb to your new fetch-blob endpoint to just get
> the size of one or more objects to help with this.

No objections from me, though we don't need it yet.

Thanks,
Jonathan
