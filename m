Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845C220756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbdAQVuu (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:50:50 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:32865 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdAQVut (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:50:49 -0500
Received: by mail-qt0-f195.google.com with SMTP id n13so24637454qtc.0
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 13:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=WQSnSahsVhRXl9jqcheXbIo2ZrIyiHChddetrEL2xk0=;
        b=Yi6wf5xr/rLfBPvdV5lcEYkJMgSuV9gjJ1CF5jTIbHiU1+HZYthmjB9jGULn7RrdsZ
         dxGJEM6VHAoILIDTkRgRT/dMUx9NeSfYUihvVfM8Pb+kZHq2au1WDjqqICp1Ssj9C5xI
         eZB6skf4QlhC4JNqCBtsz6T2JW2M3jjHNdqmgiRVJtlrWcloP+OUuU0h8gQLOtHe+Y9g
         4eGlqg4wLU9Pc8AbzEoAZffvv7Jr9BPmB1LXdE+QXbI56EEfJ0tsUjyiRgqqjqWLPdnN
         UsDmwQE3P0qKRYSdJvO2JMew/03oIa9ontBRUIOacJNw/dlPcSPB1Z0yb/Xgv1RUOo+d
         ISSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=WQSnSahsVhRXl9jqcheXbIo2ZrIyiHChddetrEL2xk0=;
        b=PAl0fk9Q7RCRVGco7pGudApjH4DoJzYtYtNIYeWGcPCfR/TLFjG/Q27VnDqk99nwc8
         THB/wMS5SLJvAXmo1mmMk93osBbAnlHZJ3Y/9E7O8nVNyRGpuZNpPsvNQNNp4cKbahns
         R2UBBbLkLT4hAnUL9m4pXxMmpcytdbtCfMBN6H6FyIUnCmDvo6DJy2NrHHauYNn2p4IA
         ssM5DV3w4gMUzSgh1Mc9A8gUoIoIHfpCtOkEDk0abcX9+sPr5dVKdqVkWJqInzb60Ect
         z1Y2ZFSDaLZwTxywWIXgkpyBuqlC591VHMyHj0/h6nvwV7lij4sdZRQX6PDPd1DJ/vTs
         V1vA==
X-Gm-Message-State: AIkVDXI1/QQGB208TA4KK0ms+6EqefhXLzMJUw5otF05bekp5VL5aff6enhavBzboQGYcw==
X-Received: by 10.55.75.143 with SMTP id y137mr36040495qka.39.1484689848054;
        Tue, 17 Jan 2017 13:50:48 -0800 (PST)
Received: from BenPeartHP ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id s71sm19831165qkl.22.2017.01.17.13.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 13:50:47 -0800 (PST)
From:   "Ben Peart" <peartben@gmail.com>
To:     "'Jeff King'" <peff@peff.net>, "'Ben Peart'" <peartben@gmail.com>
Cc:     <git@vger.kernel.org>
References: <20170113155253.1644-1-benpeart@microsoft.com> <20170117184258.sd7h2hkv27w52gzt@sigill.intra.peff.net>
In-Reply-To: <20170117184258.sd7h2hkv27w52gzt@sigill.intra.peff.net>
Subject: RE: [RFC] Add support for downloading blobs on demand
Date:   Tue, 17 Jan 2017 16:50:47 -0500
Message-ID: <002601d2710b$c3715890$4a5409b0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHSbbUrOh3gS4IHmUmedTbh+1qHIqE9B6EAgAAHF1A=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the thoughtful response.  No need to appologize for the=20
length, it's a tough problem to solve so I don't expect it to be handled =

with a single, short email. :)

> -----Original Message-----
> From: Jeff King [mailto:peff@peff.net]
> Sent: Tuesday, January 17, 2017 1:43 PM
> To: Ben Peart <peartben@gmail.com>
> Cc: git@vger.kernel.org; Ben Peart <Ben.Peart@microsoft.com>
> Subject: Re: [RFC] Add support for downloading blobs on demand
>=20
> This is an issue I've thought a lot about. So apologies in advance =
that this
> response turned out a bit long. :)
>=20
> On Fri, Jan 13, 2017 at 10:52:53AM -0500, Ben Peart wrote:
>=20
> > Design
> > ~~~~~~
> >
> > Clone and fetch will pass a  --lazy-clone  flag (open to a better =
name
> > here) similar to  --depth  that instructs the server to only return
> > commits and trees and to ignore blobs.
> >
> > Later during git operations like checkout, when a blob cannot be =
found
> > after checking all the regular places (loose, pack, alternates, =
etc),
> > git will download the missing object and place it into the local
> > object store (currently as a loose object) then resume the =
operation.
>=20
> Have you looked at the "external odb" patches I wrote a while ago, and
> which Christian has been trying to resurrect?
>=20
>   =
https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fpublic-=

> inbox.org%2Fgit%2F20161130210420.15982-1-
> chriscool%40tuxfamily.org%2F&data=3D02%7C01%7CBen.Peart%40microsoft.c
> om%7C9596d3bf32564f123e0c08d43f08a9e1%7C72f988bf86f141af91ab2d7c
> d011db47%7C1%7C0%7C636202753822020527&sdata=3Da6%2BGOAQoRhjFoxS
> vftY8JZAVUssmrXuDZ9OBy3xqNZk%3D&reserved=3D0
>=20
> This is a similar approach, though I pushed the policy for "how do you =
get the
> objects" out into an external script. One advantage there is that =
large objects
> could easily be fetched from another source entirely (e.g., S3 or =
equivalent)
> rather than the repo itself.
>=20
> The downside is that it makes things more complicated, because a push =
or a
> fetch now involves three parties (server, client, and the alternate =
object
> store). So questions like "do I have all the objects I need" are hard =
to reason
> about.
>=20
> If you assume that there's going to be _some_ central Git repo which =
has all
> of the objects, you might as well fetch from there (and do it over =
normal git
> protocols). And that simplifies things a bit, at the cost of being =
less flexible.
>=20

We looked quite a bit at the external odb patches, as well as lfs and=20
even using alternates.  They all share a common downside that you must=20
maintain a separate service that contains _some_ of the files.  These=20
files must also be versioned, replicated, backed up and the service=20
itself scaled out to handle the load.  As you mentioned, having multiple =

services involved increases flexability but it also increases the=20
complexity and decreases the reliability of the overall version control=20
service. =20

For operational simplicity, we opted to go with a design that uses a=20
single, central git repo which has _all_ the objects and to focus on=20
enhancing it to handle large numbers of files efficiently.  This allows=20
us to focus our efforts on a great git service and to avoid having to=20
build out these other services.

> > To prevent git from accidentally downloading all missing blobs, some
> > git operations are updated to be aware of the potential for missing =
blobs.
> > The most obvious being check_connected which will return success as =
if
> > everything in the requested commits is available locally.
>=20
> Actually, Git is pretty good about trying not to access blobs when it =
doesn't
> need to. The important thing is that you know enough about the blobs =
to
> fulfill has_sha1_file() and sha1_object_info() requests without =
actually
> fetching the data.
>=20
> So the client definitely needs to have some list of which objects =
exist, and
> which it _could_ get if it needed to.
>=20
> The one place you'd probably want to tweak things is in the diff code, =
as a
> single "git log -Sfoo" would fault in all of the blobs.
>=20

It is an interesting idea to explore how we could be smarter about=20
preventing blobs from faulting in if we had enough info to fulfill=20
has_sha1_file() and sha1_object_info().  Given we also heavily prune the =

working directory using sparse-checkout, this hasn't been our top focus=20
but it is certainly something worth looking into.

> > To minimize the impact on the server, the existing dumb HTTP =
protocol
> > endpoint  objects/<sha>  can be used to retrieve the individual
> > missing blobs when needed.
>=20
> This is going to behave badly on well-packed repositories, because =
there isn't
> a good way to fetch a single object. The best case (which is not =
implemented
> at all in Git) is that you grab the pack .idx, then grab "slices" of =
the pack
> corresponding to specific objects, including hunting down delta bases.
>=20
> But then next time the server repacks, you have to throw away your =
.idx file.
> And those can be big. The .idx for linux.git is 135MB. You really =
wouldn't=09
> want to do an incremental fetch of 1MB worth of objects and have to =
grab
> the whole .idx just to figure out which bytes you needed.
>=20
> You can solve this by replacing the dumb-http server with a smart one =
that
> actually serves up the individual objects as if they were truly =
sitting on the
> filesystem. But then you haven't really minimized impact on the =
server, and
> you might as well teach the smart protocols to do blob fetches.
>=20

Yea, we actually implemented a new endpoint that we are using to fetch=20
individual blobs, I just found the dumb endpoint recently and thought=20
"hey, maybe we can us this to make it easier for other git servers." =20
For a number of good reasons, I don't think this is the right approach.

>=20
> One big hurdle to this approach, no matter the protocol, is how you =
are
> going to handle deltas. Right now, a git client tells the server "I =
have this
> commit, but I want this other one". And the server knows which objects =
the
> client has from the first, and which it needs from the second. =
Moreover, it
> knows that it can send objects in delta form directly from disk if the =
other
> side has the delta base.
>=20
> So what happens in this system? We know we don't need to send any =
blobs
> in a regular fetch, because the whole idea is that we only send blobs =
on
> demand. So we wait for the client to ask us for blob A. But then what =
do we
> send? If we send the whole blob without deltas, we're going to waste a =
lot of
> bandwidth.
>=20
> The on-disk size of all of the blobs in linux.git is ~500MB. The =
actual data size
> is ~48GB. Some of that is from zlib, which you get even for =
non-deltas. But
> the rest of it is from the delta compression. I don't think it's =
feasible to give
> that up, at least not for "normal" source repos like linux.git (more =
on that in
> a minute).
>=20
> So ideally you do want to send deltas. But how do you know which =
objects
> the other side already has, which you can use as a delta base? Sending =
the
> list of "here are the blobs I have" doesn't scale. Just the sha1s =
start to add
> up, especially when you are doing incremental fetches.
>=20
> I think this sort of things performs a lot better when you just focus =
on large
> objects. Because they don't tend to delta well anyway, and the savings =
are
> much bigger by avoiding ones you don't want. So a directive like =
"don't
> bother sending blobs larger than 1MB" avoids a lot of these issues. In =
other
> words, you have some quick shorthand to communicate between the client
> and server: this what I have, and what I don't.
> Normal git relies on commit reachability for that, but there are =
obviously
> other dimensions. The key thing is that both sides be able to express =
the
> filters succinctly, and apply them efficiently.
>=20

Our challenge has been more the sheer _number_ of files that exist in=20
the repo rather than the _size_ of the files in the repo.  With >3M=20
source files and any typical developer only needing a small percentage=20
of those files to do their job, our focus has been pruning the tree as=20
much as possible such that they only pay the cost for the files they=20
actually need.  With typical text source files being 10K - 20K in size,=20
the overhead of the round trip is a significant part of the overall=20
transfer time so deltas don't help as much.  I agree that large files=20
are also a problem but it isn't my top focus at this point in time. =20

> > After cloning, the developer can use sparse-checkout to limit the =
set
> > of files to the subset they need (typically only 1-10% in these =
large
> > repos).  This allows the initial checkout to only download the set =
of
> > files actually needed to complete their task.  At any point, the
> > sparse-checkout file can be updated to include additional files =
which
> > will be fetched transparently on demand.
>=20
> If most of your benefits are not from avoiding blobs in general, but =
rather
> just from sparsely populating the tree, then it sounds like sparse =
clone might
> be an easier path forward. The general idea is to restrict not just =
the
> checkout, but the actual object transfer and reachability (in the tree
> dimension, the way shallow clone limits it in the time dimension, =
which will
> require cooperation between the client and server).
>=20
> So that's another dimension of filtering, which should be expressed =
pretty
> succinctly: "I'm interested in these paths, and not these other ones." =
It's
> pretty easy to compute on the server side during graph traversal =
(though it
> interacts badly with reachability bitmaps, so there would need to be =
some
> hacks there).
>=20
> It's an idea that's been talked about many times, but I don't recall =
that there
> were ever working patches. You might dig around in the list archive =
under
> the name "sparse clone" or possibly "narrow clone".

While a sparse/narrow clone would work with this proposal, it isn't=20
required.  You'd still probably want all the commits and trees but the=20
clone would also bring down the specified blobs.  Combined with using=20
"depth" you could further limit it to those blobs at tip.=20

We did run into problems with this model however as our usage patterns=20
are such that our working directories often contain very sparse trees=20
and as a result, we can end up with thousands of entries in the sparse=20
checkout file.  This makes it difficult for users to manually specify a=20
sparse-checkout before they even do a clone.  We have implemented a=20
hashmap based sparse-checkout to deal with the performance issues of=20
having that many entries but that's a different RFC/PATCH.  In short, we =

found that a "lazy-clone" and downloading blobs on demand provided a=20
better developer experience.

>=20
> > Now some numbers
> > ~~~~~~~~~~~~~~~~
> >
> > One repo has 3+ million files at tip across 500K folders with 5-6K
> > active developers.  They have done a lot of work to remove large =
files
> > from the repo so it is down to < 100GB.
> >
> > Before changes: clone took hours to transfer the 87GB .pack + 119MB
> > .idx
> >
> > After changes: clone took 4 minutes to transfer 305MB .pack + 37MB
> > .idx
> >
> > After hydrating 35K files (the typical number any individual =
developer
> > needs to do their work), there was an additional 460 MB of loose =
files
> > downloaded.
>=20
> It sounds like you have a case where the repository has a lot of large =
files
> that are either historical, or uninteresting the sparse-tree =
dimension.
>=20
> How big is that 460MB if it were actually packed with deltas?
>=20

Uninteresting in the sparse-tree dimension.  460 MB divided by 35K files =

is less than 13 KB per file which is fairly typical for source code. =20
Given there are no versions to calculate deltas from, compressing them=20
into a pack file would help some but I don't have the numbers as to how=20
much.  When we get to the "future work" below and start batching up=20
requests, we'll have better data on that.

> > Future Work
> > ~~~~~~~~~~~
> >
> > The current prototype calls a new hook proc in
> > sha1_object_info_extended and read_object, to download each missing
> > blob.  A better solution would be to implement this via a long =
running
> > process that is spawned on the first download and listens for =
requests
> > to download additional objects until it terminates when the parent =
git
> > operation exits (similar to the recent long running smudge and clean =
filter
> work).
>=20
> Yeah, see the external-odb discussion. Those prototypes use a process =
per
> object, but I think we all agree after seeing how the git-lfs =
interface has
> scaled that this is a non-starter. Recent versions of git-lfs do the =
single-
> process thing, and I think any sort of external-odb hook should be =
modeled
> on that protocol.
>=20

I'm looking into this now and plan to re-implement it this way before=20
sending out the first patch series.  Glad to hear you think it is a good =

protocol to model it on.

> > Need to investigate an alternate batching scheme where we can make a
> > single request for a set of "related" blobs and receive single a
> > packfile (especially during checkout).
>=20
> I think this sort of batching is going to be the really hard part to =
retrofit onto
> git. Because you're throwing out the procedural notion that you can =
loop
> over a set of objects and ask for each individually.
> You have to start deferring computation until answers are ready. Some
> operations can do that reasonably well (e.g., checkout), but something =
like
> "git log -p" is constantly digging down into history. I suppose you =
could just
> perform the skeleton of the operation _twice_, once to find the list =
of objects
> to fault in, and the second time to actually do it.
>=20
> That will make git feel a lot slower, because a lot of the illusion of =
speed is
> the way it streams out results. OTOH, if you have to wait to fault in =
objects
> from the network, it's going to feel pretty slow anyway. :)
>=20

The good news is that for most operations, git doesn't need to access to =

all the blobs.  You're right, any command that does ends up faulting in=20
a bunch of blobs from the network can get pretty slow.  Sometimes you=20
get streaming results and sometimes it just "hangs" while we go off=20
downloading blobs in the background.  We capture telemetry to detect=20
these types of issues but typically the users are more than happy to=20
send us an "I just ran command 'foo' and it hung" email. :)

> -Peff

