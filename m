Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EDCC433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 14:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242711AbiCBOII (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242799AbiCBOH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 09:07:58 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954B88CD84
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 06:06:57 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id o7-20020a056820040700b003205d5eae6eso1470268oou.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 06:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1FiTFW5iKrsSEEocS1tUG2Iv6toBTnhsNFQGkCHCbag=;
        b=CyNbv07gzzAvYDae/u89QYLcMP/Jf3bXhpSOsf3ws5dLgNtsgYoKZ7Y35nNNbbVUQv
         LhvznFq+HG+USR/9jJmJwhJbJIJvn+gJW8ApY4/EgQEmzz0sXzwNejifcAe0OTO4rsQa
         aDbtNU1H7FGQLCmbKQ9d4aqoXxEPcTr050CMknJELkqnILv7dKZ/gHr6fjDU3m6EORGB
         RvNJuEF6T9yIhsvvth1AtVGr4LMz8fL5UTtvfFCBbs9Qtpv8A7fNzwd/zdA9U1rSWqaU
         goPDIyr9NjIkppHRuQvvwJFV1gpLx/VT1aFbebf8SeHXMx7zY9DER6d65DEugUrdPXfS
         MHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1FiTFW5iKrsSEEocS1tUG2Iv6toBTnhsNFQGkCHCbag=;
        b=INF3fX7tpsEYkro5RGGI7NtjeJhE05JI4jWqRJRTfAuuClKsPGgpAAw5ACQLBQ4V6/
         0isf0TSUN8rh6DHcF1s9RrOQPP6WGYPE5DAQXY11/VholWdYtKjIiSjMK51VlhUHbn2X
         R/9DSx84cOIptVhQWKN0xFc/Yc7EZRsvBHbagO5oqBY2ByC/fI+o2ifvEF9FaZ/ETNJf
         32O/MH64ITkyIz/8Wet1KGu8cxn+BRlsmfGbViA1hirmr+XDpGZi/su1arzb6vIT4I+S
         WJVa7tRXj49KbXdwCv83WsBpUVCpQGvWhE7H3jCt4eDLAvVcNcBhGFA2UhSZ7b/9Z3MU
         SSHA==
X-Gm-Message-State: AOAM531SWQbhPrDGDLjYFWwRyfaclwTyZzHiFVrVbqQJVY6R+Qim2RPg
        rVwgpW2Sl72IFcVT7PmRfN1P
X-Google-Smtp-Source: ABdhPJxfkgnq+mYHFFAEBxBB2tVVaezVRCRPJjSrlsOk2PhDRe0hpNyPPUu+5td5mvJFW/xj9hgwTw==
X-Received: by 2002:a05:6870:1ca:b0:d6:d04a:5670 with SMTP id n10-20020a05687001ca00b000d6d04a5670mr15313722oad.47.1646230015508;
        Wed, 02 Mar 2022 06:06:55 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id e28-20020a0568301e5c00b005af640ec226sm7976972otj.56.2022.03.02.06.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 06:06:55 -0800 (PST)
Message-ID: <4f5f4751-c047-b9de-28a7-6ee3c31826f0@github.com>
Date:   Wed, 2 Mar 2022 09:06:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 01/25] docs: document bundle URI standard
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
 <0abec796b0089b84d23cb52bb127788fdd04961c.1645641063.git.gitgitgadget@gmail.com>
 <CABPp-BEXgmGW=Lk5-JE6bc1F8RbGidDVjALAZraeZ-2_u476gg@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BEXgmGW=Lk5-JE6bc1F8RbGidDVjALAZraeZ-2_u476gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2022 9:28 PM, Elijah Newren wrote:
> On Wed, Feb 23, 2022 at 10:31 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> Introduce the idea of bundle URIs to the Git codebase through an
>> aspirational design document. This document includes the full design
>> intended to include the feature in its fully-implemented form. This will
>> take several steps as detailed in the Implementation Plan section.
>>
>> By committing this document now, it can be used to motivate changes
>> necessary to reach these final goals. The design can still be altered as
>> new information is discovered.
>>
>> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>> ---
>>  Documentation/technical/bundle-uri.txt | 404 +++++++++++++++++++++++++
>>  1 file changed, 404 insertions(+)
>>  create mode 100644 Documentation/technical/bundle-uri.txt
>>
>> diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.txt
>> new file mode 100644
>> index 00000000000..5c0b9e8e3ef
>> --- /dev/null
>> +++ b/Documentation/technical/bundle-uri.txt
>> @@ -0,0 +1,404 @@
>> +Bundle URIs
>> +===========
>> +
>> +Bundle URIs are locations where Git can download one or more bundles in
>> +order to bootstrap the object database in advance of fetching the remaining
>> +objects from a remote.
>> +
>> +One goal is to speed up clones and fetches for users with poor network
>> +connectivity to the origin server. Another benefit is to allow heavy users,
>> +such as CI build farms, to use local resources for the majority of Git data
>> +and thereby reducing the load on the origin server.
>> +
>> +To enable the bundle URI feature, users can specify a bundle URI using
>> +command-line options or the origin server can advertise one or more URIs
>> +via a protocol v2 capability.
>> +
>> +Server requirements
>> +-------------------
>> +
>> +To provide a server-side implementation of bundle servers, no other parts
>> +of the Git protocol are required. This allows server maintainers to use
>> +static content solutions such as CDNs in order to serve the bundle files.
>> +
>> +At the current scope of the bundle URI feature, all URIs are expected to
>> +be HTTP(S) URLs where content is downloaded to a local file using a `GET`
>> +request to that URL. The server could include authentication requirements
>> +to those requests with the aim of triggering the configured credential
>> +helper for secure access.
> 
> So folks using ssh to clone, who have never configured a credential
> helper before, might need to start doing so.  This makes sense and I
> don't think I see a way around it, but we might want to call it out a
> bit more prominently.  Cloning over https seems to be rare in the
> various setups I've seen (I know there are others where it's common,
> just noting that many users may never have had to use https for
> cloning before), so this is a potentially big point for users to be
> aware of in terms of setup.

We could even go so far as to skip the credential manager if the
Git remote is SSH, requiring the bundle URIs to work only if
unauthenticated. Likely, we will want clear knobs that the user
can toggle for how to behave when a bundle URI is advertised with
modes such as

* always attempt with authentication
* always attempt, but skip authentication when Git remote is not HTTP(S)
* attempt only when Git remote is HTTP(S)
* never attempt

These are all things that are separate from the bundle URI standard
being documented here, but instead would be saved for the last set of
patches that allow a server to advertise a bundle URI at clone time.

>> +bundle.tableOfContents.version::
>> +       This value provides a version number for the table of contents. If
>> +       a future Git change enables a feature that needs the Git client to
>> +       react to a new key in the table of contents file, then this version
>> +       will increment. The only current version number is 1, and if any
>> +       other value is specified then Git will fail to use this file.
> 
> What does "Git will fail to use this file" mean?  Does it mean Git
> will throw an error?  clone/fetch without the aid of bundle uris but
> show a warning?  something else?

I mean "Git will continue as if the bundle URI was not specified". It would
show a warning, probably. This could be converted into a failure if valuable
for the user, but I don't expect that will be the default behavior.

>> +bundle.<id>.timestamp::
>> +       (Optional) This value is the number of seconds since Unix epoch
>> +       (UTC) that this bundle was created. This is used as an approximation
>> +       of a point in time that the bundle matches the data available at
>> +       the origin server.
> 
> As an approximation, is there a risk of drift where the user has
> timetamp A which is very close to B and makes decisions based upon it
> which results in their not getting dependent objects they need?  Or is
> it just an optimization for them to only download certain bundles and
> look at them, and then they'll iteratively go back and download more
> (as per the 'requires' field below) if they don't have enough objects
> to unbundle what they previously downloaded?

The user doesn't ever generate the timestamp. It saves the timestamp
from the most-recent bundle it downloaded. The only risk of timestamp
drift is if the server has multiple machines generating different sets
of bundles, and places those machines behind a load balancer.

This is something the server can control, likely by having one job
generate the bundle set and then distributing them to various storage
locations.

>> +Cloning with Bundle URIs
>> +------------------------
>> +
>> +The primary need for bundle URIs is to speed up clones. The Git client
>> +will interact with bundle URIs according to the following flow:
>> +
>> +1. The user specifies a bundle URI with the `--bundle-uri` command-line
>> +   option _or_ the client discovers a bundle URI that was advertised by
>> +   the remote server.
>> +
>> +2. The client downloads the file at the bundle URI. If it is a bundle, then
>> +   it is unbundled with the refs being stored in `refs/bundle/*`.
>> +
>> +3. If the file is instead a table of contents, then the bundles with
>> +   matching `filter` settings are sorted by `timestamp` (if present),
>> +   and the most-recent bundle is downloaded.
>> +
>> +4. If the current bundle header mentions negative commid OIDs that are not
>> +   in the object database, then download the `requires` bundle and try
>> +   again.
>> +
>> +5. After inspecting a bundle with no negative commit OIDs (or all OIDs are
>> +   already in the object database somehow), then unbundle all of the
>> +   bundles in reverse order, placing references within `refs/bundle/*`.
>> +
>> +6. The client performs a fetch negotiation with the origin server, using
>> +   the `refs/bundle/*` references as `have`s and the server's ref
>> +   advertisement as `want`s. This results in a pack-file containing the
>> +   remaining objects requested by the clone but not in the bundles.
> 
> Does step 6 potentially involve a new, second connection to the origin
> server?  I'm wondering about timeouts closing the original connection
> while the client is downloading the bundle uris.  Will the client
> handle that automatically, or will they potentially be forced to
> re-issue the clone/fetch command?  I'm also wondering if we want to be
> "nice" and pre-emptively close the original connection to the server
> while we fetch the bundles -- for example, some servers have a
> threadpool for processing fetch/clone requests and will only serve a
> limited number; IIRC Gerrit operates this way.  I have no idea if
> that's a good idea or a horrible one.  If a second connection is tried
> automatically, will the user potentially be forced to re-enter
> connection credentials again?  And is there a risk that after the
> second connection, there are new bundle uris for the client to go
> fetch (and/or a removal of the original ones, e.g. replacing the old
> "daily" bundle with a new one)?  Does this possibly cause us some
> timestamp confusion as I noted earlier?

If the user is cloning over HTTPS, then the connections are stateless
and this is not any different than how it works today.

When using SSH, we will probably want to close the SSH connection on
the client and then reopen it to avoid keeping that connection open
during the download. The implementation in this RFC does _not_ do this,
but I think it would be valuable to do.

>> +Note that during a clone we expect that all bundles will be required. The
>> +client could be extended to download all bundles in parallel, though they
>> +need to be unbundled in the correct order.
> 
> What does required mean?  That the origin server can refuse to service
> requests if the client does not have commits found in said bundles?
> That new enough Git clients are expected to download all the bundles
> (and no config option will be provided to users to just do traditional
> negotation without first downloading them)?  Something else?

The assumption I'm making here is that all but on bundle in the table
of contents contains a thin pack, depending on an "earlier" bundle.
The client would be unsuccessful unbundling any single bundle except
the earliest one first.

The benefit of this assumption is that we could also implement parallel
downloads of all bundles in the future.

This assumes that there is no way to organize the bundles to communicate
that a user might want only the objects reachable from the default branch,
but also some users want every reachable object. Such an organization
would require extra information to describe two "parallel" lists of
bundles that could be selected for each of those categories. If such an
organization is valuable, then the table of contents can be extended with
information to communicate such an organization. The downside is that
clients with this "v1" version would download extra data based on this
assumption.

> If users are doing a single-branch clone or a shallow clone, will the
> requirements still hold?  (I'm not a fan of shallow clones, but they
> are sadly used in a number of places and I'm curious how the features
> interact or conflict.)

The current specification does not focus on shallow clones. The TOC
could be extended to say "this bundle is for a shallow clone of 
commit <X>" if that was valuable.

For single-branch clones, my expectation is that the bundles will
give the user more information than they need for that clone. The
negotiation will find out what they need from that branch that was
not in the bundles, but the bundles will also contain a lot of
objects that are not reachable from that ref. (This is also up to
the discretion of the bundle server operator, since they could
focus on only objects reachable from a subset of refs, minimizing
the bundle data while increasing the potential size of that
follow-up fetch.)

>> +If a table of contents is used and it contains
>> +`bundle.tableOfContents.forFetch = true`, then the client can store a
>> +config value indicating to reuse this URI for later `git fetch` commands.
>> +In this case, the client will also want to store the maximum timestamp of
>> +a downloaded bundle.
>> +
>> +Fetching with Bundle URIs
>> +-------------------------
>> +
>> +When the client fetches new data, it can decide to fetch from bundle
>> +servers before fetching from the origin remote. This could be done via
>> +a command-line option, but it is more likely useful to use a config value
>> +such as the one specified during the clone.
>> +
>> +The fetch operation follows the same procedure to download bundles from a
>> +table of contents (although we do _not_ want to use parallel downloads
>> +here). We expect that the process will end because all negative commit
>> +OIDs in a thin bundle are already in the object database.
>> +
>> +A further optimization is that the client can avoid downloading any
>> +bundles if their timestamps are not larger than the stored timestamp.
>> +After fetching new bundles, this local timestamp value is updated.
> 
> What about the transition period where repositories were cloned before
> bundle URIs became a thing (or were turned on within an organization),
> and the user then goes to fetch?  Will git go and download a bunch of
> useless large bundles (and maybe one small useful one) the day this
> feature is turned on, making users think this is a bad feature?
> 
> Should git perhaps treat the already-cloned case without a stored
> timestamp as a request to store a timestamp of "now", making it ignore
> the current bundles?  (If so, are there races where it later goes to
> grab a bundle slightly newer than "now" but which depends on an older
> bundle that has some objects we are missing?)

I expect that users who already cloned will never configure their
repositories to include a bundle server.

That said, if you run 'git bundle fetch <uri>' in an existing
repository, then it will fetch only the newest bundle and see if you
already have all of its negative refs. If so, then it stops and that
is the only bundle that is downloaded. Its timestamp is stored for
the next 'git bundle fetch'.

In the case where the server starts advertising a bundle URI, a
'git fetch' will not start using that URI. That check only happens
during 'git clone' (as currently designed).

>> +Error Conditions
>> +----------------
>> +
>> +If the Git client discovers something unexpected while downloading
>> +information according to a bundle URI or the table of contents found at
>> +that location, then Git can ignore that data and continue as if it was not
>> +given a bundle URI. The remote Git server is the ultimate source of truth,
>> +not the bundle URI.
> 
> This seems to contradict the earlier statement that for clones all
> bundle URIs would be "required".  I like the idea of bundle URIs only
> being an optimization that can be ignored, just noting the potential
> confusion.

Perhaps I misnamed this section. These are things that could go wrong with
a bundle server connection, and in such a case Git should recover by
transitioning to the normal Git protocol to fetch the objects.

>> +
>> +Here are a few example error conditions:
>> +
>> +* The client fails to connect with a server at the given URI or a connection
>> +  is lost without any chance to recover.
>> +
>> +* The client receives a response other than `200 OK` (such as `404 Not Found`,
>> +  `401 Not Authorized`, or `500 Internal Server Error`).
>> +
>> +* The client receives data that is not parsable as a bundle or table of
>> +  contents.
>> +
>> +* The table of contents describes a directed cycle in the
>> +  `bundle.<id>.requires` links.
>> +
>> +* A bundle includes a filter that does not match expectations.
>> +
>> +* The client cannot unbundle the bundles because the negative commit OIDs
>> +  are not in the object database and there are no more
>> +  `bundle.<id>.requires` links to follow.
> 
> Should these result in warnings so that folks can diagnose slower
> connections, or should they be squelched?  (I'm thinking particularly
> of the `401 Not Authorized` case in combination with users never
> having had to use a credential helper before.)

There is a lot of work to be done around polishing the user ergonomics
here, and that is an interesting thing to consider for a second round
after the basic standard is established. I appreciate that you are
already thinking about the user experience in these corner cases.

>> +
>> +There are also situations that could be seen as wasteful, but are not
>> +error conditions:
>> +
>> +* The downloaded bundles contain more information than is requested by
>> +  the clone or fetch request. A primary example is if the user requests
>> +  a clone with `--single-branch` but downloads bundles that store every
>> +  reachable commit from all `refs/heads/*` references. This might be
>> +  initially wasteful, but perhaps these objects will become reachable by
>> +  a later ref update that the client cares about.
> 
> Ah, this answers my --single-branch question.  Still curious about the
> --shallow misfeature (yeah, I'm a bit opinionated) and how it
> interacts, though.

(Hopefully my previous reply to this topic is helpful.)

>> +* A bundle download during a `git fetch` contains objects already in the
>> +  object database. This is probably unavoidable if we are using bundles
>> +  for fetches, since the client will almost always be slightly ahead of
>> +  the bundle servers after performing its "catch-up" fetch to the remote
>> +  server. This extra work is most wasteful when the client is fetching
>> +  much more frequently than the server is computing bundles, such as if
>> +  the client is using hourly prefetches with background maintenance, but
>> +  the server is computing bundles weekly. For this reason, the client
>> +  should not use bundle URIs for fetch unless the server has explicitly
>> +  recommended it through the `bundle.tableOfContents.forFetch = true`
>> +  value.
> 
> Makes sense, and certainly reduces my worry about the "transition
> period" where users have existing clones that pre-dated the
> introduction of the bundle URI feature.  But I'm still kind of curious
> about how we handle that transition for folks that have recommended
> their bundleUris for fetches.

By "that transition" I believe you are talking about configuring bundle
URIs on an existing repository. My earlier reply on that hopefully
eases your concerns somewhat. Ævar also has some ideas about downloading
only the header of a bundle and examining it to see if we need the rest
of it, which would further reduce the amount of data necessary to do an
initial first fetch from a bundle URI.

Thanks for taking the time to read and give detailed thoughts on this
proposal!

Thanks,
-Stolee

