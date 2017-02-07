Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA531FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 18:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754812AbdBGSVS (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 13:21:18 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35787 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754498AbdBGSVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 13:21:16 -0500
Received: by mail-qt0-f193.google.com with SMTP id s58so20182599qtc.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 10:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=wrxw5xlWB08GWIKxXOIVWN55FmrpcblQ+ftfaGX3wkI=;
        b=K3cazwvZQ8wtAzbbNhguM4Qh5jzIDfpX5I68pT9RM8oZk/Z8VOWH0bSLw4fesgREX3
         86OmGls+gS1YjAHjSsf2J7bhNG5Tg2pDajMCG43yGk9SE5ZlThV1XJZkmKZoIwcyvaQJ
         Xa3EmgaHX4nRnktjjx4ZDlZcKf+Ea4sjz8DrtpV2CYMTKkOvoASS8Oii8Uya1JAD3QfJ
         HKqGW+NFwmIYsMQcv4mc8CueDhUdtXVyWtLvZQauIVQ5VjLRO4FCzBhHC5R3NIbjUGAl
         UJ+5mHpxyfhhhTxbMBlrFP3qPKcgaZ5XbQieoAWTRiDNQtzgBPjnEouXBlduMo7kQF+o
         ddpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=wrxw5xlWB08GWIKxXOIVWN55FmrpcblQ+ftfaGX3wkI=;
        b=lNBhqvZj2cvLFAJKddsNpZy6QcZU93a4FRVBTyraK3a8bYhBGn2Gs22SRuzLm5voez
         1lJWfWUCjSn3tIUoG+Kv0QThaY08c6D26dRq/DxSroSFSASYOep5q9ImtVSsuiCLb6v9
         YPzGclSxwxWvkUYtqcdwxgl9RDMrgq4x7ywn6ZIz/5dForxk8iACiQMGj48LfbkpSNDV
         syNtZ+0OYs1BtgIC6849PXSEfL+vYYVwqo9aTNg9OcZEqPPaSjgV81Nlpy2sUkHAH1Ox
         pN8f+hNgSGjnYr13/wg6nZN6w/FZquvuydI/rxUQ57J9guPHAMGHANno1ILWrn2D2iMP
         n38g==
X-Gm-Message-State: AMke39n4zFoFLkonXooXtL9cXC3uWGFQrCTxHnWVFT4FCQU4pQhudEkI4gR/ofaXJOKBKA==
X-Received: by 10.200.44.185 with SMTP id 54mr15141462qtw.224.1486491670502;
        Tue, 07 Feb 2017 10:21:10 -0800 (PST)
Received: from BenPeartHP ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id b1sm4013621qkc.33.2017.02.07.10.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 10:21:09 -0800 (PST)
From:   "Ben Peart" <peartben@gmail.com>
To:     "'Christian Couder'" <christian.couder@gmail.com>
Cc:     "'Jeff King'" <peff@peff.net>, "'git'" <git@vger.kernel.org>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "Ben Peart" <benpeart@microsoft.com>
References: <20170113155253.1644-1-benpeart@microsoft.com> <20170117184258.sd7h2hkv27w52gzt@sigill.intra.peff.net> <002601d2710b$c3715890$4a5409b0$@gmail.com> <CAP8UFD3R6nzDPApNvK6rcXR2qdAE6G4J3xbvEam3xsobO7viiA@mail.gmail.com>
In-Reply-To: <CAP8UFD3R6nzDPApNvK6rcXR2qdAE6G4J3xbvEam3xsobO7viiA@mail.gmail.com>
Subject: RE: [RFC] Add support for downloading blobs on demand
Date:   Tue, 7 Feb 2017 13:21:08 -0500
Message-ID: <002701d2816e$f4682fa0$dd388ee0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHeqv64Rhj1j9YcMHkE7nrdCUWdigFWth5RAVxc1xMBPYXSo6El/MTA
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No worries about a late response, I'm sure this is the start of a long =
conversation. :)

> -----Original Message-----
> From: Christian Couder [mailto:christian.couder@gmail.com]
> Sent: Sunday, February 5, 2017 9:04 AM
> To: Ben Peart <peartben@gmail.com>
> Cc: Jeff King <peff@peff.net>; git <git@vger.kernel.org>; Johannes =
Schindelin
> <Johannes.Schindelin@gmx.de>
> Subject: Re: [RFC] Add support for downloading blobs on demand
>=20
> (Sorry for the late reply and thanks to Dscho for pointing me to this =
thread.)
>=20
> On Tue, Jan 17, 2017 at 10:50 PM, Ben Peart <peartben@gmail.com> =
wrote:
> >> From: Jeff King [mailto:peff@peff.net] On Fri, Jan 13, 2017 at
> >> 10:52:53AM -0500, Ben Peart wrote:
> >>
> >> > Clone and fetch will pass a  --lazy-clone  flag (open to a better
> >> > name
> >> > here) similar to  --depth  that instructs the server to only =
return
> >> > commits and trees and to ignore blobs.
> >> >
> >> > Later during git operations like checkout, when a blob cannot be
> >> > found after checking all the regular places (loose, pack,
> >> > alternates, etc), git will download the missing object and place =
it
> >> > into the local object store (currently as a loose object) then =
resume the
> operation.
> >>
> >> Have you looked at the "external odb" patches I wrote a while ago,
> >> and which Christian has been trying to resurrect?
> >>
> >>
> >> =
https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fpubli
> >> c-
> >> inbox.org%2Fgit%2F20161130210420.15982-1-
> >>
> chriscool%40tuxfamily.org%2F&data=3D02%7C01%7CBen.Peart%40microsoft.c
> >>
> om%7C9596d3bf32564f123e0c08d43f08a9e1%7C72f988bf86f141af91ab2d7c
> >>
> d011db47%7C1%7C0%7C636202753822020527&sdata=3Da6%2BGOAQoRhjFoxS
> >> vftY8JZAVUssmrXuDZ9OBy3xqNZk%3D&reserved=3D0
> >>
> >> This is a similar approach, though I pushed the policy for "how do
> >> you get the objects" out into an external script. One advantage =
there
> >> is that large objects could easily be fetched from another source
> >> entirely (e.g., S3 or equivalent) rather than the repo itself.
> >>
> >> The downside is that it makes things more complicated, because a =
push
> >> or a fetch now involves three parties (server, client, and the
> >> alternate object store). So questions like "do I have all the =
objects
> >> I need" are hard to reason about.
> >>
> >> If you assume that there's going to be _some_ central Git repo =
which
> >> has all of the objects, you might as well fetch from there (and do =
it
> >> over normal git protocols). And that simplifies things a bit, at =
the cost of
> being less flexible.
> >
> > We looked quite a bit at the external odb patches, as well as lfs =
and
> > even using alternates.  They all share a common downside that you =
must
> > maintain a separate service that contains _some_ of the files.
>=20
> Pushing the policy for "how do you get the objects" out into an =
external
> helper doesn't mean that the external helper cannot use the main =
service.
> The external helper is still free to do whatever it wants including =
calling the
> main service if it thinks it's better.

That is a good point and you're correct, that means you can avoid having =
to build out multiple services.

>=20
> > These
> > files must also be versioned, replicated, backed up and the service
> > itself scaled out to handle the load.  As you mentioned, having
> > multiple services involved increases flexability but it also =
increases
> > the complexity and decreases the reliability of the overall version
> > control service.
>=20
> About reliability, I think it depends a lot on the use case. If you =
want to get
> very big files over an unreliable connection, it can better if you =
send those big
> files over a restartable protocol and service like HTTP/S on a regular =
web
> server.
>=20

My primary concern about reliability was the multiplicative effect of =
making multiple requests across multiple servers to complete a single =
request.  Having putting this all in a single service like you suggested =
above brings us back to parity on the complexity.

> > For operational simplicity, we opted to go with a design that uses a
> > single, central git repo which has _all_ the objects and to focus on
> > enhancing it to handle large numbers of files efficiently.  This
> > allows us to focus our efforts on a great git service and to avoid
> > having to build out these other services.
>=20
> Ok, but I don't think it prevents you from using at least some of the =
same
> mechanisms that the external odb series is using.
> And reducing the number of mechanisms in Git itself is great for its
> maintainability and simplicity.

I completely agree with the goal of reducing the number of mechanisms in =
Git itself.  Our proposal is primarily targeting speeding operations =
when dealing with large numbers of files.  ObjectDB is primarily =
targeting large objects but there is a lot of similarity in how we're =
approaching the solution.  I hope/believe we can come to a common =
solution that will solve both.

>=20
> >> > To prevent git from accidentally downloading all missing blobs,
> >> > some git operations are updated to be aware of the potential for
> missing blobs.
> >> > The most obvious being check_connected which will return success =
as
> >> > if everything in the requested commits is available locally.
> >>
> >> Actually, Git is pretty good about trying not to access blobs when =
it
> >> doesn't need to. The important thing is that you know enough about
> >> the blobs to fulfill has_sha1_file() and sha1_object_info() =
requests
> >> without actually fetching the data.
> >>
> >> So the client definitely needs to have some list of which objects
> >> exist, and which it _could_ get if it needed to.
>=20
> Yeah, and the external odb series handles that already, thanks to =
Peff's initial
> work.
>=20

I'm currently working on a patch series that will reimplement our =
current read-object hook to use the LFS model for long running =
background processes.  As part of that, I am building a versioned =
interface that will support multiple commands (like get, have, put).  In =
my initial implementation, I'm only supporting the "get" verb as that is =
what we currently need but my intent is to build it so that we could add =
have and put in future versions.  When I have the first iteration ready, =
I'll push it up to our fork on github for review as code is clearer than =
my description in email.

Moving forward, the "have" verb is a little problematic as we would =
"have" 3+ million shas that we'd be required to fetch from the server =
and then pass along to git when requested.  It would be nice to come up =
with a way to avoid or reduce that cost.

> >> The one place you'd probably want to tweak things is in the diff
> >> code, as a single "git log -Sfoo" would fault in all of the blobs.
> >
> > It is an interesting idea to explore how we could be smarter about
> > preventing blobs from faulting in if we had enough info to fulfill
> > has_sha1_file() and sha1_object_info().  Given we also heavily prune
> > the working directory using sparse-checkout, this hasn't been our =
top
> > focus but it is certainly something worth looking into.
>=20
> The external odb series doesn't handle preventing blobs from faulting =
in yet,
> so this could be a common problem.
>=20

Agreed.  This is one we've been working on quite a bit out of necessity. =
 If you look at our patch series, most of the changes are related to =
dealing with missing objects.

> [...]
>=20
> >> One big hurdle to this approach, no matter the protocol, is how you
> >> are going to handle deltas. Right now, a git client tells the =
server
> >> "I have this commit, but I want this other one". And the server =
knows
> >> which objects the client has from the first, and which it needs =
from
> >> the second. Moreover, it knows that it can send objects in delta =
form
> >> directly from disk if the other side has the delta base.
> >>
> >> So what happens in this system? We know we don't need to send any
> >> blobs in a regular fetch, because the whole idea is that we only =
send
> >> blobs on demand. So we wait for the client to ask us for blob A. =
But
> >> then what do we send? If we send the whole blob without deltas, =
we're
> >> going to waste a lot of bandwidth.
> >>
> >> The on-disk size of all of the blobs in linux.git is ~500MB. The
> >> actual data size is ~48GB. Some of that is from zlib, which you get
> >> even for non-deltas. But the rest of it is from the delta
> >> compression. I don't think it's feasible to give that up, at least
> >> not for "normal" source repos like linux.git (more on that in a =
minute).
> >>
> >> So ideally you do want to send deltas. But how do you know which
> >> objects the other side already has, which you can use as a delta
> >> base? Sending the list of "here are the blobs I have" doesn't =
scale.
> >> Just the sha1s start to add up, especially when you are doing =
incremental
> fetches.
>=20
> To initialize some paths that the client wants, it could perhaps just =
ask for
> some pack files, or maybe bundle files, related to these paths.
> Those packs or bundles could be downloaded either directly from the =
main
> server or from other web or proxy servers.
>=20
> >> I think this sort of things performs a lot better when you just =
focus
> >> on large objects. Because they don't tend to delta well anyway, and
> >> the savings are much bigger by avoiding ones you don't want. So a
> >> directive like "don't bother sending blobs larger than 1MB" avoids =
a
> >> lot of these issues. In other words, you have some quick shorthand =
to
> >> communicate between the client and server: this what I have, and =
what I
> don't.
> >> Normal git relies on commit reachability for that, but there are
> >> obviously other dimensions. The key thing is that both sides be =
able
> >> to express the filters succinctly, and apply them efficiently.
> >
> > Our challenge has been more the sheer _number_ of files that exist =
in
> > the repo rather than the _size_ of the files in the repo.  With >3M
> > source files and any typical developer only needing a small =
percentage
> > of those files to do their job, our focus has been pruning the tree =
as
> > much as possible such that they only pay the cost for the files they
> > actually need.  With typical text source files being 10K - 20K in
> > size, the overhead of the round trip is a significant part of the
> > overall transfer time so deltas don't help as much.  I agree that
> > large files are also a problem but it isn't my top focus at this =
point in time.
>=20
> Ok, but it would be nice if both problems could be solved using some
> common mechanisms.
> This way it could probably work better in situations where there are =
both a
> large number of files _and_ some big files.
> And from what I am seeing, there could be no real downside from using
> some common mechanisms.
>=20

Agree completely.  I'm hopeful that we can come up with some common =
mechanisms that will allow us to solve both problems.

> >> If most of your benefits are not from avoiding blobs in general, =
but
> >> rather just from sparsely populating the tree, then it sounds like
> >> sparse clone might be an easier path forward. The general idea is =
to
> >> restrict not just the checkout, but the actual object transfer and
> >> reachability (in the tree dimension, the way shallow clone limits =
it
> >> in the time dimension, which will require cooperation between the =
client
> and server).
> >>
> >> So that's another dimension of filtering, which should be expressed
> >> pretty
> >> succinctly: "I'm interested in these paths, and not these other
> >> ones." It's pretty easy to compute on the server side during graph
> >> traversal (though it interacts badly with reachability bitmaps, so
> >> there would need to be some hacks there).
> >>
> >> It's an idea that's been talked about many times, but I don't =
recall
> >> that there were ever working patches. You might dig around in the
> >> list archive under the name "sparse clone" or possibly "narrow =
clone".
> >
> > While a sparse/narrow clone would work with this proposal, it isn't
> > required.  You'd still probably want all the commits and trees but =
the
> > clone would also bring down the specified blobs.  Combined with =
using
> > "depth" you could further limit it to those blobs at tip.
> >
> > We did run into problems with this model however as our usage =
patterns
> > are such that our working directories often contain very sparse =
trees
> > and as a result, we can end up with thousands of entries in the =
sparse
> > checkout file.  This makes it difficult for users to manually =
specify
> > a sparse-checkout before they even do a clone.  We have implemented =
a
> > hashmap based sparse-checkout to deal with the performance issues of
> > having that many entries but that's a different RFC/PATCH.  In =
short,
> > we found that a "lazy-clone" and downloading blobs on demand =
provided
> > a better developer experience.
>=20
> I think both ways are possible using the external odb mechanism.
>=20
> >> > Future Work
> >> > ~~~~~~~~~~~
> >> >
> >> > The current prototype calls a new hook proc in
> >> > sha1_object_info_extended and read_object, to download each =
missing
> >> > blob.  A better solution would be to implement this via a long
> >> > running process that is spawned on the first download and listens
> >> > for requests to download additional objects until it terminates
> >> > when the parent git operation exits (similar to the recent long
> >> > running smudge and clean filter
> >> work).
> >>
> >> Yeah, see the external-odb discussion. Those prototypes use a =
process
> >> per object, but I think we all agree after seeing how the git-lfs
> >> interface has scaled that this is a non-starter. Recent versions of
> >> git-lfs do the single- process thing, and I think any sort of
> >> external-odb hook should be modeled on that protocol.
>=20
> I agree that the git-lfs scaling work is great, but I think it's not =
necessary in the
> external odb work to have the same kind of single-process protocol =
from the
> beginning (though it should be possible and easy to add it).
> For example if the external odb work can be used or extended to handle
> restartable clone by downloading a single bundle when cloning, this =
would
> not need that kind of protocol.
>=20
> > I'm looking into this now and plan to re-implement it this way =
before
> > sending out the first patch series.  Glad to hear you think it is a
> > good protocol to model it on.
>=20
> Yeah, for your use case on Windows, it looks really worth it to use =
this kind
> of protocol.
>=20
> >> > Need to investigate an alternate batching scheme where we can =
make
> >> > a single request for a set of "related" blobs and receive single =
a
> >> > packfile (especially during checkout).
> >>
> >> I think this sort of batching is going to be the really hard part =
to
> >> retrofit onto git. Because you're throwing out the procedural =
notion
> >> that you can loop over a set of objects and ask for each =
individually.
> >> You have to start deferring computation until answers are ready. =
Some
> >> operations can do that reasonably well (e.g., checkout), but
> >> something like "git log -p" is constantly digging down into =
history.
> >> I suppose you could just perform the skeleton of the operation
> >> _twice_, once to find the list of objects to fault in, and the =
second time to
> actually do it.
>=20
> In my opinion, perhaps we can just prevent "git log -p" from faulting =
in blobs
> and have it show a warning saying that it was performed only on a =
subset of
> all the blobs.
>=20

You might be surprised at how many other places end up faulting in =
blobs. :)  Rename detection is one we've recently been working on.

> [...]

