Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21C24207D6
	for <e@80x24.org>; Thu,  4 May 2017 18:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756333AbdEDSmZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 14:42:25 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35937 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756306AbdEDSmV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 14:42:21 -0400
Received: by mail-pg0-f67.google.com with SMTP id v1so3358122pgv.3
        for <git@vger.kernel.org>; Thu, 04 May 2017 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E8U3rHgCGqvTbkGTkn8F5ySibPbFHzJ0c93l4frITh8=;
        b=OjzxMXzAtgmcdZZuBbDWKybReYL/JSz9myttHIm2Xxuvdal11E+95ckVxPrxg+sL2c
         lpAlRebiY/+avqLqCfoxfxQ2dxeGUpVw1ZKVZZOm6AKpAiko0O/E4D2OP4Vh+DiA4oeO
         Dd+/Q0HdKbl2u4cZA3yYHWEz25oHw4TIvx6YnZZT0duW2j4JFO4rVxNE8JFYHsMjfUBl
         89bSOw6U7cHGttN3oiNYOIJIITLP0ahda20iy84Z+1JuTHeKG8sj8itliMTpEGMO0B8a
         lFzfvBiZvrNzElwYDZIPn/PeHHFDMwpDmDzkWJAlS6VQvg0/hE89Q49x1lhuBsQF2h+r
         nnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E8U3rHgCGqvTbkGTkn8F5ySibPbFHzJ0c93l4frITh8=;
        b=WlKKfEDxHS5Go4cF7SKR79w1M6SCs+KGNnNBkdruiaqggTiPqMWp+AKhnfTlyMwWeR
         VQICGz5uJWhWydBVjVfCJeRn+FAUYHEJfFSfO1tLTTuIwFUfVvbzMTVd7tRNsi4eMuLD
         Lf9BXFJCvTNXvmuO8I3YJIEXywMarK0493eYfJSa+rxIkREpLseOzjGMfAXGgxklf4fm
         8voZrsoCVbGX+vIWvwUvQjs93AKP+VavaTA9eN48bDjdMYMfj3/zXLybqhxjtEi0JA4i
         uiMxhDCj2D756D8HwL/pN/Na5P52iLzW4QgQX4nXUJ0U5+PiarzBrTVOhLlWuI4ck5zr
         YeYg==
X-Gm-Message-State: AN3rC/7qJSv8S6rkQmt8Q64614gcBH2OaplMpbvFee3fziS1mAXMQ/yP
        NSWfgB4VxcgSwA/oiuY=
X-Received: by 10.84.224.70 with SMTP id a6mr33702428plt.57.1493923340512;
        Thu, 04 May 2017 11:42:20 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:5588:c10f:2622:1a6])
        by smtp.gmail.com with ESMTPSA id d83sm5889931pfe.40.2017.05.04.11.42.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 May 2017 11:42:19 -0700 (PDT)
Date:   Thu, 4 May 2017 11:41:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com, peff@peff.net,
        gitster@pobox.com, markbt@efaref.net, benpeart@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 00/10] RFC Partial Clone and Fetch
Message-ID: <20170504184150.GA15203@aiede.svl.corp.google.com>
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
 <777ab8f2-c31a-d07b-ffe3-f8333f408ea1@jeffhostetler.com>
 <20170503182725.GC28740@aiede.svl.corp.google.com>
 <9b58bec9-dafb-aebc-d421-5327f2f607eb@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b58bec9-dafb-aebc-d421-5327f2f607eb@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Jeff Hostetler wrote:

> In my original RFC there were comments/complaints that with
> missing blobs we lose the ability to detect corruptions.  My
> proposed changes to index-pack and rev-list (and suggestions
> for other commands like fsck) just disabled those errors.
> Personally, I'm OK with that, but I understand that others
> would like to save the ability to distinguish between missing
> and corrupted.

I'm also okay with it.  In a partial clone, in the same way as a
missing ref represents a different valid state and thus passes fsck
regardless of how it happened, a missing blob is a valid state and it
is sensible for it to pass fsck.

A person might object that previously a repository that passed "git
fsck" was a repository where "git fast-export --all" would succeed,
and if I omit a blob that is not present on the remote server then
that invariant is gone.  But that problem exists even if we have a
list of missing blobs.  The server could rewind history and garbage
collect, causing attempts on the client to fetch a previously
advertised missing blob to fail.  Or the server can disappear
completely, or it can lose all its data and have to be restored from
an older backup that is missing newer blobs.

> Right, only the .pack is sent over the wire.  And that's why I
> suggest listing the missing SHAs in it.  I think we need the server
> to send a list of them -- whether in individual per-file type-5
> records as I suggested, or a single record containing a list of
> SHAs+data (which I think I prefer in hindsight).

A list of SHAs+data sounds sensible as a way of conveying additional
per-blob information (such as size).

> WRT being able to discover the missing blobs, is that true in
> all cases?  I don't think it is for thin-packs -- where the server
> only sends stuff you don't (supposedly) already have, right ?

Generate the list of blobs referenced by trees in the pack, when you
are inflating them in git index-pack.  Omit any objects that you
already know about.  The remainder is the set of missing blobs.

One thing this doesn't tell you is if the same missing blob is
available from multiple remotes.  It associates each blob with a
single remote, the first one it was discovered from.

> If instead, we have pack-object indicate that it *would have*
> sent this blob normally, we don't change any of the semantics
> of how pack files are assembled.  This gives the client a
> definitive list of what's missing.

If there is additional information the server wants to convey about
the missing blobs, then this makes sense to me --- it has to send it
somewhere, and a separate list outside the pack seems like a good
place to put that.

When there is no additional information beyond "this is a blob I am
omitting", there is nothing the wire protocol needs to convey.  But
you've convinced me that that's usually moot because the blob size
is valuable information.

[...]
> The more I think about it, I'd like to NOT put the list in the .idx
> file.  If we put it in a separate peer file next to the *.{pack,idx}
> we could decorate it with the name of the remote used in the fetch
> or clone.

I have no strong opinions about this in either direction.

Since it only affects the local repository format and doesn't affect
the protocol, we can experiment without too much fuss. :)

[...]
> I've always wondered if repack, fetch, and friends should build
> a meta-idx that merges all of the current .idx files, but that
> is a different conversation....

Yes, we've been thinking about a one-index-for-many-packs facility
to deal with the proliferation of packfiles with only one or a few
large objects without having to waste I/O copying them into a
concatenated pack file.

Another thing we're looking into is incorporating something like
Martin Fick's "git exproll" (
http://public-inbox.org/git/1375756727-1275-1-git-send-email-artagnon@gmail.com/)
into "git gc --auto" to more aggressively keep the number of packs
down.

> On 5/3/2017 2:27 PM, Jonathan Nieder wrote:

>> If we were starting over, would this belong in the tree object?
>> (Part of the reason I ask is that we have an opportunity to sort
>> of start over as part of the transition away from SHA-1.)
>
> Yes, putting the size in the tree would be nice.  That does
> add 5-8 bytes to every entry in every tree (on top of the
> larger hash), but it would be useful.
>
> If we're going there, we might just define the new hash
> as the concatenation of the SHA* and the length of the data
> hashed.  So instead of a 32-byte SHA256, we'd have a (32 + 8)
> byte value.  (Or maybe a (32 + 5) if we want to squeeze it.)

Thanks --- that feedback helps.

It doesn't stop us from having to figure something else out in the
short term, of course.

[...]
>> I am worried about the implications of storing this kind of policy
>> information in the pack file.  There may be useful information along
>> these lines for a server to advertise, but I don't think it belongs in
>> the pack file.  Git protocol relies on it being cheap to stream pack
>> files as is.
>
> Perhaps.  I'm not sure it would be that expensive -- I'm thinking
> about it being a server constant rather than a per-user/per-fetch
> field.  But maybe we don't need it.  Assuming we can correctly
> associate a missing blob with the server/remote that omitted it.

Right.

I think we're heading toward a consensus:

- that the server should (at least if requested?) inform the client of
  the blobs it is omitting and their sizes

- that this would go in the same response as the packfile, but
  out-of-line from the pack

- that it (at least optionally?) gets stored *somewhere* locally
  associated with the pack --- either through an extension to the idx
  file format or in a separate file alongside the pack file and idx
  file.  This doesn't affect the protocol so it's not expensive to
  experiment

Thanks for the thoughtful replies.

Sincerely,
Jonathan
