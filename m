Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72AC21FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 14:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbdBEODq (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 09:03:46 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33107 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdBEODo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 09:03:44 -0500
Received: by mail-lf0-f68.google.com with SMTP id x1so1818396lff.0
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 06:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Pc7iZvoeO/hnx0ittk/9DaDlJiUtYFLlZR6arxNBbEg=;
        b=EzCLEi6Fl1MVJUuihQp4iUSEnZJ54gqcK+wOWjakR1/LK1Iq//ftZHb64qJGLcPXy/
         2dYug6hwUu5fFJHTtzSwoXh1BMelxzyvY13LegAm/GZ5905BC/PzsaSi+0QAqEyXWoOR
         yfIsFtnYryoBx7pmq+RuIYNYHYVm4zIxTYbGPmzGB7v3nCleuJHN2YTg1hnrCQQvIlc/
         CVdGmj3CRiW0bypjo/cgEEzXZxd3u1Tb0GbsMQaVezb4nuUO2bdb/QTYFgdRNv32Rloh
         H+47r9Ifccckdp5d3U2MZiUTw5uplWHHpRbRbtpxm7BfR7t0VfejPBiZMpQdAfr/J51s
         H7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Pc7iZvoeO/hnx0ittk/9DaDlJiUtYFLlZR6arxNBbEg=;
        b=dLUQR1nXRGeTdx/X1on/whzqwMiyQNzNDJruvvESMJD9TmlSUCIcOSx0f7z4lixqS7
         w0HEpMdf7KSBMRfeYZBqJKfS1stZSn+OcKmP9D7MdGB61Uw4/l9o5mCa2AFNTv0k4Y/r
         kcNlgE/hTEHicajbsL2vuqOlK352YPwMOqoIlWPEP+vsmEoyeFO2ZeIoNKMfRcuvD0d3
         CiGkSWry1I90lnx/sbtiXQrEm3ucgeEpcurPPLzF31kBPbQA27VvSRNcFOUluigKQ3ix
         knjsiGrayXisSAdPqVc9nD5n92OEgtDUHoEqVr7GrAD7aMh+1vl+FmZqUQGj+LIreOGN
         FP+A==
X-Gm-Message-State: AMke39k5P/kRbbOnFQLlDmx0S4Bofgx/sVXL9exxgY0ushpY/AwKOSyrLQKpHHFDxzeN2zT0fpyL12MAmnzKbg==
X-Received: by 10.25.67.83 with SMTP id m19mr1745954lfj.24.1486303422078; Sun,
 05 Feb 2017 06:03:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Sun, 5 Feb 2017 06:03:41 -0800 (PST)
In-Reply-To: <002601d2710b$c3715890$4a5409b0$@gmail.com>
References: <20170113155253.1644-1-benpeart@microsoft.com> <20170117184258.sd7h2hkv27w52gzt@sigill.intra.peff.net>
 <002601d2710b$c3715890$4a5409b0$@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 5 Feb 2017 15:03:41 +0100
Message-ID: <CAP8UFD3R6nzDPApNvK6rcXR2qdAE6G4J3xbvEam3xsobO7viiA@mail.gmail.com>
Subject: Re: [RFC] Add support for downloading blobs on demand
To:     Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Sorry for the late reply and thanks to Dscho for pointing me to this thread.)

On Tue, Jan 17, 2017 at 10:50 PM, Ben Peart <peartben@gmail.com> wrote:
>> From: Jeff King [mailto:peff@peff.net]
>> On Fri, Jan 13, 2017 at 10:52:53AM -0500, Ben Peart wrote:
>>
>> > Clone and fetch will pass a  --lazy-clone  flag (open to a better name
>> > here) similar to  --depth  that instructs the server to only return
>> > commits and trees and to ignore blobs.
>> >
>> > Later during git operations like checkout, when a blob cannot be found
>> > after checking all the regular places (loose, pack, alternates, etc),
>> > git will download the missing object and place it into the local
>> > object store (currently as a loose object) then resume the operation.
>>
>> Have you looked at the "external odb" patches I wrote a while ago, and
>> which Christian has been trying to resurrect?
>>
>>   https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fpublic-
>> inbox.org%2Fgit%2F20161130210420.15982-1-
>> chriscool%40tuxfamily.org%2F&data=02%7C01%7CBen.Peart%40microsoft.c
>> om%7C9596d3bf32564f123e0c08d43f08a9e1%7C72f988bf86f141af91ab2d7c
>> d011db47%7C1%7C0%7C636202753822020527&sdata=a6%2BGOAQoRhjFoxS
>> vftY8JZAVUssmrXuDZ9OBy3xqNZk%3D&reserved=0
>>
>> This is a similar approach, though I pushed the policy for "how do you get the
>> objects" out into an external script. One advantage there is that large objects
>> could easily be fetched from another source entirely (e.g., S3 or equivalent)
>> rather than the repo itself.
>>
>> The downside is that it makes things more complicated, because a push or a
>> fetch now involves three parties (server, client, and the alternate object
>> store). So questions like "do I have all the objects I need" are hard to reason
>> about.
>>
>> If you assume that there's going to be _some_ central Git repo which has all
>> of the objects, you might as well fetch from there (and do it over normal git
>> protocols). And that simplifies things a bit, at the cost of being less flexible.
>
> We looked quite a bit at the external odb patches, as well as lfs and
> even using alternates.  They all share a common downside that you must
> maintain a separate service that contains _some_ of the files.

Pushing the policy for "how do you get the objects" out into an
external helper doesn't mean that the external helper cannot use the
main service.
The external helper is still free to do whatever it wants including
calling the main service if it thinks it's better.

> These
> files must also be versioned, replicated, backed up and the service
> itself scaled out to handle the load.  As you mentioned, having multiple
> services involved increases flexability but it also increases the
> complexity and decreases the reliability of the overall version control
> service.

About reliability, I think it depends a lot on the use case. If you
want to get very big files over an unreliable connection, it can
better if you send those big files over a restartable protocol and
service like HTTP/S on a regular web server.

> For operational simplicity, we opted to go with a design that uses a
> single, central git repo which has _all_ the objects and to focus on
> enhancing it to handle large numbers of files efficiently.  This allows
> us to focus our efforts on a great git service and to avoid having to
> build out these other services.

Ok, but I don't think it prevents you from using at least some of the
same mechanisms that the external odb series is using.
And reducing the number of mechanisms in Git itself is great for its
maintainability and simplicity.

>> > To prevent git from accidentally downloading all missing blobs, some
>> > git operations are updated to be aware of the potential for missing blobs.
>> > The most obvious being check_connected which will return success as if
>> > everything in the requested commits is available locally.
>>
>> Actually, Git is pretty good about trying not to access blobs when it doesn't
>> need to. The important thing is that you know enough about the blobs to
>> fulfill has_sha1_file() and sha1_object_info() requests without actually
>> fetching the data.
>>
>> So the client definitely needs to have some list of which objects exist, and
>> which it _could_ get if it needed to.

Yeah, and the external odb series handles that already, thanks to
Peff's initial work.

>> The one place you'd probably want to tweak things is in the diff code, as a
>> single "git log -Sfoo" would fault in all of the blobs.
>
> It is an interesting idea to explore how we could be smarter about
> preventing blobs from faulting in if we had enough info to fulfill
> has_sha1_file() and sha1_object_info().  Given we also heavily prune the
> working directory using sparse-checkout, this hasn't been our top focus
> but it is certainly something worth looking into.

The external odb series doesn't handle preventing blobs from faulting
in yet, so this could be a common problem.

[...]

>> One big hurdle to this approach, no matter the protocol, is how you are
>> going to handle deltas. Right now, a git client tells the server "I have this
>> commit, but I want this other one". And the server knows which objects the
>> client has from the first, and which it needs from the second. Moreover, it
>> knows that it can send objects in delta form directly from disk if the other
>> side has the delta base.
>>
>> So what happens in this system? We know we don't need to send any blobs
>> in a regular fetch, because the whole idea is that we only send blobs on
>> demand. So we wait for the client to ask us for blob A. But then what do we
>> send? If we send the whole blob without deltas, we're going to waste a lot of
>> bandwidth.
>>
>> The on-disk size of all of the blobs in linux.git is ~500MB. The actual data size
>> is ~48GB. Some of that is from zlib, which you get even for non-deltas. But
>> the rest of it is from the delta compression. I don't think it's feasible to give
>> that up, at least not for "normal" source repos like linux.git (more on that in
>> a minute).
>>
>> So ideally you do want to send deltas. But how do you know which objects
>> the other side already has, which you can use as a delta base? Sending the
>> list of "here are the blobs I have" doesn't scale. Just the sha1s start to add
>> up, especially when you are doing incremental fetches.

To initialize some paths that the client wants, it could perhaps just
ask for some pack files, or maybe bundle files, related to these
paths.
Those packs or bundles could be downloaded either directly from the
main server or from other web or proxy servers.

>> I think this sort of things performs a lot better when you just focus on large
>> objects. Because they don't tend to delta well anyway, and the savings are
>> much bigger by avoiding ones you don't want. So a directive like "don't
>> bother sending blobs larger than 1MB" avoids a lot of these issues. In other
>> words, you have some quick shorthand to communicate between the client
>> and server: this what I have, and what I don't.
>> Normal git relies on commit reachability for that, but there are obviously
>> other dimensions. The key thing is that both sides be able to express the
>> filters succinctly, and apply them efficiently.
>
> Our challenge has been more the sheer _number_ of files that exist in
> the repo rather than the _size_ of the files in the repo.  With >3M
> source files and any typical developer only needing a small percentage
> of those files to do their job, our focus has been pruning the tree as
> much as possible such that they only pay the cost for the files they
> actually need.  With typical text source files being 10K - 20K in size,
> the overhead of the round trip is a significant part of the overall
> transfer time so deltas don't help as much.  I agree that large files
> are also a problem but it isn't my top focus at this point in time.

Ok, but it would be nice if both problems could be solved using some
common mechanisms.
This way it could probably work better in situations where there are
both a large number of files _and_ some big files.
And from what I am seeing, there could be no real downside from using
some common mechanisms.

>> If most of your benefits are not from avoiding blobs in general, but rather
>> just from sparsely populating the tree, then it sounds like sparse clone might
>> be an easier path forward. The general idea is to restrict not just the
>> checkout, but the actual object transfer and reachability (in the tree
>> dimension, the way shallow clone limits it in the time dimension, which will
>> require cooperation between the client and server).
>>
>> So that's another dimension of filtering, which should be expressed pretty
>> succinctly: "I'm interested in these paths, and not these other ones." It's
>> pretty easy to compute on the server side during graph traversal (though it
>> interacts badly with reachability bitmaps, so there would need to be some
>> hacks there).
>>
>> It's an idea that's been talked about many times, but I don't recall that there
>> were ever working patches. You might dig around in the list archive under
>> the name "sparse clone" or possibly "narrow clone".
>
> While a sparse/narrow clone would work with this proposal, it isn't
> required.  You'd still probably want all the commits and trees but the
> clone would also bring down the specified blobs.  Combined with using
> "depth" you could further limit it to those blobs at tip.
>
> We did run into problems with this model however as our usage patterns
> are such that our working directories often contain very sparse trees
> and as a result, we can end up with thousands of entries in the sparse
> checkout file.  This makes it difficult for users to manually specify a
> sparse-checkout before they even do a clone.  We have implemented a
> hashmap based sparse-checkout to deal with the performance issues of
> having that many entries but that's a different RFC/PATCH.  In short, we
> found that a "lazy-clone" and downloading blobs on demand provided a
> better developer experience.

I think both ways are possible using the external odb mechanism.

>> > Future Work
>> > ~~~~~~~~~~~
>> >
>> > The current prototype calls a new hook proc in
>> > sha1_object_info_extended and read_object, to download each missing
>> > blob.  A better solution would be to implement this via a long running
>> > process that is spawned on the first download and listens for requests
>> > to download additional objects until it terminates when the parent git
>> > operation exits (similar to the recent long running smudge and clean filter
>> work).
>>
>> Yeah, see the external-odb discussion. Those prototypes use a process per
>> object, but I think we all agree after seeing how the git-lfs interface has
>> scaled that this is a non-starter. Recent versions of git-lfs do the single-
>> process thing, and I think any sort of external-odb hook should be modeled
>> on that protocol.

I agree that the git-lfs scaling work is great, but I think it's not
necessary in the external odb work to have the same kind of
single-process protocol from the beginning (though it should be
possible and easy to add it).
For example if the external odb work can be used or extended to handle
restartable clone by downloading a single bundle when cloning, this
would not need that kind of protocol.

> I'm looking into this now and plan to re-implement it this way before
> sending out the first patch series.  Glad to hear you think it is a good
> protocol to model it on.

Yeah, for your use case on Windows, it looks really worth it to use
this kind of protocol.

>> > Need to investigate an alternate batching scheme where we can make a
>> > single request for a set of "related" blobs and receive single a
>> > packfile (especially during checkout).
>>
>> I think this sort of batching is going to be the really hard part to retrofit onto
>> git. Because you're throwing out the procedural notion that you can loop
>> over a set of objects and ask for each individually.
>> You have to start deferring computation until answers are ready. Some
>> operations can do that reasonably well (e.g., checkout), but something like
>> "git log -p" is constantly digging down into history. I suppose you could just
>> perform the skeleton of the operation _twice_, once to find the list of objects
>> to fault in, and the second time to actually do it.

In my opinion, perhaps we can just prevent "git log -p" from faulting
in blobs and have it show a warning saying that it was performed only
on a subset of all the blobs.

[...]
