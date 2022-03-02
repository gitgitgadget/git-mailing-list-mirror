Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BFDC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 02:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbiCBC3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 21:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbiCBC3w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 21:29:52 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155503E5F0
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 18:29:09 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s1so289489edd.13
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 18:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c26QsvVJyJvZGyaq2q5MuIaLKCTDlm0cyrds6CIPGsg=;
        b=AyN9CvrEwf0HSVDwDOYR+79EuSwbgLDpkl8BHnUtP2/7/0ZyCpKZEgcqWCZKO28lVB
         XyjAFCLpbzcCTkSscyW68A+7N+xMFqvMZ7t1Z1ste1m3e7GW2WLoX7Ilf03/DrIC/g/q
         sU3YlkB47pAm9lFi/i4pWunFOGQ25hfC8yKTMAXcUpbZvlYRwSn9+iTL9ycTEi0KK5kt
         5mWBvKvp2bSTS5NIi1ylyzPNiBYRflO1ZUYDjBMCEaJG3tFyS4jtoFoCqr1suPgi30Md
         4NlwIII1i8rB0K9RSWWwblMldoyC3a13pSk4djyZKSYR73sescwC1ehWTpBHKUI/Ma7l
         hdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c26QsvVJyJvZGyaq2q5MuIaLKCTDlm0cyrds6CIPGsg=;
        b=CqxC67G1/m1qiWKOCPU/DkpsdPrRIPQMf8kRd5iohs0N+a/9QQ5N3VeAP4lUZS+7lt
         yNUDQHVXx7wwFzgkAiceDLCJ6SKJF2gSGviHvtX6glYQk5Gfwr1r7rkxHsAlorkRk5Ia
         JZZB6swAA7FAVdCHcNPJNo0yMrOg5i/qrFbL7g596D8QB04qCq0qTfuHL1Vji8s9RldE
         ImU3FsbPdKju93keFUIkjgjpkOPNKlKGOLGPZPCgB9h+6mq5xt4z3AjaIQ5O16yJd9vD
         KBwlvVLVceL1ldxaDIOoOX1PtoBBsJ+SsirbxhJzQ4OKccfNASWlPM0FcmDFLUNujH7I
         GR+w==
X-Gm-Message-State: AOAM531xYUifgy8IygMLVO11IMZuszES4aHbxcY2f1h53F+dL0O982Kg
        yX1IwFJ51QCsJaMwUrsdazffu01Z99QDZsiCR3U=
X-Google-Smtp-Source: ABdhPJymf44VRUjdBMX9l62b7iEdrwckjD1QDuQwlQkqNtrVH1ZDnaYFtQ5b00kwtUHFD0nIYiIapgfe/PeW67SLqio=
X-Received: by 2002:a05:6402:40d4:b0:415:b355:a72a with SMTP id
 z20-20020a05640240d400b00415b355a72amr1638947edb.153.1646188147243; Tue, 01
 Mar 2022 18:29:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com> <0abec796b0089b84d23cb52bb127788fdd04961c.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <0abec796b0089b84d23cb52bb127788fdd04961c.1645641063.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 1 Mar 2022 18:28:55 -0800
Message-ID: <CABPp-BEXgmGW=Lk5-JE6bc1F8RbGidDVjALAZraeZ-2_u476gg@mail.gmail.com>
Subject: Re: [PATCH 01/25] docs: document bundle URI standard
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, aevar@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 10:31 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <derrickstolee@github.com>
>
> Introduce the idea of bundle URIs to the Git codebase through an
> aspirational design document. This document includes the full design
> intended to include the feature in its fully-implemented form. This will
> take several steps as detailed in the Implementation Plan section.
>
> By committing this document now, it can be used to motivate changes
> necessary to reach these final goals. The design can still be altered as
> new information is discovered.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/technical/bundle-uri.txt | 404 +++++++++++++++++++++++++
>  1 file changed, 404 insertions(+)
>  create mode 100644 Documentation/technical/bundle-uri.txt
>
> diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.txt
> new file mode 100644
> index 00000000000..5c0b9e8e3ef
> --- /dev/null
> +++ b/Documentation/technical/bundle-uri.txt
> @@ -0,0 +1,404 @@
> +Bundle URIs
> +===========
> +
> +Bundle URIs are locations where Git can download one or more bundles in
> +order to bootstrap the object database in advance of fetching the remaining
> +objects from a remote.
> +
> +One goal is to speed up clones and fetches for users with poor network
> +connectivity to the origin server. Another benefit is to allow heavy users,
> +such as CI build farms, to use local resources for the majority of Git data
> +and thereby reducing the load on the origin server.
> +
> +To enable the bundle URI feature, users can specify a bundle URI using
> +command-line options or the origin server can advertise one or more URIs
> +via a protocol v2 capability.
> +
> +Server requirements
> +-------------------
> +
> +To provide a server-side implementation of bundle servers, no other parts
> +of the Git protocol are required. This allows server maintainers to use
> +static content solutions such as CDNs in order to serve the bundle files.
> +
> +At the current scope of the bundle URI feature, all URIs are expected to
> +be HTTP(S) URLs where content is downloaded to a local file using a `GET`
> +request to that URL. The server could include authentication requirements
> +to those requests with the aim of triggering the configured credential
> +helper for secure access.

So folks using ssh to clone, who have never configured a credential
helper before, might need to start doing so.  This makes sense and I
don't think I see a way around it, but we might want to call it out a
bit more prominently.  Cloning over https seems to be rare in the
various setups I've seen (I know there are others where it's common,
just noting that many users may never have had to use https for
cloning before), so this is a potentially big point for users to be
aware of in terms of setup.

> +
> +Assuming a `200 OK` response from the server, the content at the URL is
> +expected to be of one of two forms:
> +
> +1. Bundle: A Git bundle file of version 2 or higher.
> +
> +2. Table of Contents: A plain-text file that is parsable using Git's
> +   config file parser. This file describes one or more bundles that are
> +   accessible from other URIs.
> +
> +Any other data provided by the server is considered erroneous.
> +
> +Table of Contents Format
> +------------------------
> +
> +If the content at a bundle URI is not a bundle, then it is expected to be
> +a plaintext file that is parseable using Git's config parser. This file
> +can contain any list of key/value pairs, but only a fixed set will be
> +considered by Git.
> +
> +bundle.tableOfContents.version::
> +       This value provides a version number for the table of contents. If
> +       a future Git change enables a feature that needs the Git client to
> +       react to a new key in the table of contents file, then this version
> +       will increment. The only current version number is 1, and if any
> +       other value is specified then Git will fail to use this file.

What does "Git will fail to use this file" mean?  Does it mean Git
will throw an error?  clone/fetch without the aid of bundle uris but
show a warning?  something else?

> +
> +bundle.tableOfContents.forFetch::
> +       This boolean value is a signal to the Git client that the bundle
> +       server has designed its bundle organization to assist `git fetch`
> +       commands in addition to `git clone` commands. If this is missing,
> +       Git should not use this table of contents for `git fetch` as it
> +       may lead to excess data downloads.
> +
> +The remaining keys include an `<id>` segment which is a server-designated
> +name for each available bundle.
> +
> +bundle.<id>.uri::
> +       This string value is the URI for downloading bundle `<id>`. If
> +       the URI begins with a protocol (`http://` or `https://`) then the
> +       URI is absolute. Otherwise, the URI is interpreted as relative to
> +       the URI used for the table of contents. If the URI begins with `/`,
> +       then that relative path is relative to the domain name used for
> +       the table of contents. (This use of relative paths is intended to
> +       make it easier to distribute a set of bundles across a large
> +       number of servers or CDNs with different domain names.)
> +
> +bundle.<id>.timestamp::
> +       (Optional) This value is the number of seconds since Unix epoch
> +       (UTC) that this bundle was created. This is used as an approximation
> +       of a point in time that the bundle matches the data available at
> +       the origin server.

As an approximation, is there a risk of drift where the user has
timetamp A which is very close to B and makes decisions based upon it
which results in their not getting dependent objects they need?  Or is
it just an optimization for them to only download certain bundles and
look at them, and then they'll iteratively go back and download more
(as per the 'requires' field below) if they don't have enough objects
to unbundle what they previously downloaded?

> +
> +bundle.<id>.requires::
> +       (Optional) This string value represents the ID of another bundle.
> +       When present, the server is indicating that this bundle contains a
> +       thin packfile. If the client does not have all necessary objects
> +       to unbundle this packfile, then the client can download the bundle
> +       with the `requires` ID and try again. (Note: it may be beneficial
> +       to allow the server to specify multiple `requires` bundles.)
> +
> +bundle.<id>.filter::
> +       (Optional) This string value represents an object filter that
> +       should also appear in the header of this bundle. The server uses
> +       this value to differentiate different kinds of bundles from which
> +       the client can choose those that match their object filters.
> +
> +Here is an example table of contents:
> +
> +```
> +[bundle "tableofcontents"]
> +       version = 1
> +       forFetch = true
> +
> +[bundle "2022-02-09-1644442601-daily"]
> +       uri = https://gitbundleserver.z13.web.core.windows.net/git/git/2022-02-09-1644442601-daily.bundle
> +       timestamp = 1644442601
> +       requires = 2022-02-02-1643842562
> +
> +[bundle "2022-02-02-1643842562"]
> +       uri = https://gitbundleserver.z13.web.core.windows.net/git/git/2022-02-02-1643842562.bundle
> +       timestamp = 1643842562
> +
> +[bundle "2022-02-09-1644442631-daily-blobless"]
> +       uri = 2022-02-09-1644442631-daily-blobless.bundle
> +       timestamp = 1644442631
> +       requires = 2022-02-02-1643842568-blobless
> +       filter = blob:none
> +
> +[bundle "2022-02-02-1643842568-blobless"]
> +       uri = /git/git/2022-02-02-1643842568-blobless.bundle
> +       timestamp = 1643842568
> +       filter = blob:none
> +```
> +
> +This example uses all of the keys in the specification. Suppose that the
> +table of contents was found at the URI
> +`https://gitbundleserver.z13.web.core.windows.net/git/git/` and so the
> +two blobless bundles have the following fully-expanded URIs:
> +
> +* `https://gitbundleserver.z13.web.core.windows.net/git/git/2022-02-09-1644442631-daily-blobless.bundle`
> +* `https://gitbundleserver.z13.web.core.windows.net/git/git/2022-02-02-1643842568-blobless.bundle`
> +
> +Advertising Bundle URIs
> +-----------------------
> +
> +If a user knows a bundle URI for the repository they are cloning, then they
> +can specify that URI manually through a command-line option. However, a
> +Git host may want to advertise bundle URIs during the clone operation,
> +helping users unaware of the feature.
> +
> +Note: The exact details of this section are not final. This is a possible
> +way that Git could auto-discover bundle URIs, but is not a committed
> +direction until that feature is implemented.
> +
> +The only thing required for this feature is that the server can advertise
> +one or more bundle URIs. One way to implement this is to create a new
> +protocol v2 capability that advertises recommended features, including
> +bundle URIs.
> +
> +The client could choose an arbitrary bundle URI as an option _or_ select
> +the URI with lowest latency by some exploratory checks. It is up to the
> +server operator to decide if having multiple URIs is preferable to a
> +single URI that is geodistributed through server-side infrastructure.
> +
> +Cloning with Bundle URIs
> +------------------------
> +
> +The primary need for bundle URIs is to speed up clones. The Git client
> +will interact with bundle URIs according to the following flow:
> +
> +1. The user specifies a bundle URI with the `--bundle-uri` command-line
> +   option _or_ the client discovers a bundle URI that was advertised by
> +   the remote server.
> +
> +2. The client downloads the file at the bundle URI. If it is a bundle, then
> +   it is unbundled with the refs being stored in `refs/bundle/*`.
> +
> +3. If the file is instead a table of contents, then the bundles with
> +   matching `filter` settings are sorted by `timestamp` (if present),
> +   and the most-recent bundle is downloaded.
> +
> +4. If the current bundle header mentions negative commid OIDs that are not
> +   in the object database, then download the `requires` bundle and try
> +   again.
> +
> +5. After inspecting a bundle with no negative commit OIDs (or all OIDs are
> +   already in the object database somehow), then unbundle all of the
> +   bundles in reverse order, placing references within `refs/bundle/*`.
> +
> +6. The client performs a fetch negotiation with the origin server, using
> +   the `refs/bundle/*` references as `have`s and the server's ref
> +   advertisement as `want`s. This results in a pack-file containing the
> +   remaining objects requested by the clone but not in the bundles.

Does step 6 potentially involve a new, second connection to the origin
server?  I'm wondering about timeouts closing the original connection
while the client is downloading the bundle uris.  Will the client
handle that automatically, or will they potentially be forced to
re-issue the clone/fetch command?  I'm also wondering if we want to be
"nice" and pre-emptively close the original connection to the server
while we fetch the bundles -- for example, some servers have a
threadpool for processing fetch/clone requests and will only serve a
limited number; IIRC Gerrit operates this way.  I have no idea if
that's a good idea or a horrible one.  If a second connection is tried
automatically, will the user potentially be forced to re-enter
connection credentials again?  And is there a risk that after the
second connection, there are new bundle uris for the client to go
fetch (and/or a removal of the original ones, e.g. replacing the old
"daily" bundle with a new one)?  Does this possibly cause us some
timestamp confusion as I noted earlier?

> +Note that during a clone we expect that all bundles will be required. The
> +client could be extended to download all bundles in parallel, though they
> +need to be unbundled in the correct order.

What does required mean?  That the origin server can refuse to service
requests if the client does not have commits found in said bundles?
That new enough Git clients are expected to download all the bundles
(and no config option will be provided to users to just do traditional
negotation without first downloading them)?  Something else?

If users are doing a single-branch clone or a shallow clone, will the
requirements still hold?  (I'm not a fan of shallow clones, but they
are sadly used in a number of places and I'm curious how the features
interact or conflict.)

> +
> +If a table of contents is used and it contains
> +`bundle.tableOfContents.forFetch = true`, then the client can store a
> +config value indicating to reuse this URI for later `git fetch` commands.
> +In this case, the client will also want to store the maximum timestamp of
> +a downloaded bundle.
> +
> +Fetching with Bundle URIs
> +-------------------------
> +
> +When the client fetches new data, it can decide to fetch from bundle
> +servers before fetching from the origin remote. This could be done via
> +a command-line option, but it is more likely useful to use a config value
> +such as the one specified during the clone.
> +
> +The fetch operation follows the same procedure to download bundles from a
> +table of contents (although we do _not_ want to use parallel downloads
> +here). We expect that the process will end because all negative commit
> +OIDs in a thin bundle are already in the object database.
> +
> +A further optimization is that the client can avoid downloading any
> +bundles if their timestamps are not larger than the stored timestamp.
> +After fetching new bundles, this local timestamp value is updated.

What about the transition period where repositories were cloned before
bundle URIs became a thing (or were turned on within an organization),
and the user then goes to fetch?  Will git go and download a bunch of
useless large bundles (and maybe one small useful one) the day this
feature is turned on, making users think this is a bad feature?

Should git perhaps treat the already-cloned case without a stored
timestamp as a request to store a timestamp of "now", making it ignore
the current bundles?  (If so, are there races where it later goes to
grab a bundle slightly newer than "now" but which depends on an older
bundle that has some objects we are missing?)

> +
> +Choices for Bundle Server Organization
> +--------------------------------------
> +
> +With this standard, there are many options available to the bundle server
> +in how it organizes Git data into bundles.
> +
> +* Bundles can have whatever name the server desires. This name could refer
> +  to immutable data by using a hash of the bundle contents. However, this
> +  means that a new URI will be needed after every update of the content.
> +  This might be acceptable if the server is advertising the URI (and the
> +  server is aware of new bundles being generated) but would not be
> +  ergonomic for users using the command line option.
> +
> +* If the server intends to only serve full clones, then the advertised URI
> +  could be a bundle file without a filter that is updated at some cadence.
> +
> +* If the server intends to serve clones, but wants clients to choose full
> +  or blobless partial clones, then the server can use a table of contents
> +  that lists two non-thin bundles and the client chooses between them only
> +  by the `bundle.<id>.filter` values.
> +
> +* If the server intends to improve clones with parallel downloads, then it
> +  can use a table of contents and split the repository into time intervals
> +  of approximately similar-sized bundles. Using `bundle.<id>.timestamp`
> +  and `bundle.<id>.requires` values helps the client decide the order to
> +  unbundle the bundles.
> +
> +* If the server intends to serve fetches, then it can use a table of
> +  contents to advertise a list of bundles that are updated regularly. The
> +  most recent bundles could be generated on short intervals, such as hourly.
> +  These small bundles could be merged together at some rate, such as 24
> +  hourly bundles merging into a single daily bundle. At some point, it may
> +  be beneficial to create a bundle that stores the majority of the history,
> +  such as all data older than 30 days.
> +
> +These recommendations are intended only as suggestions. Each repository is
> +different and every Git server has different needs. Hopefully the bundle
> +URI feature and its table of contents is flexible enough to satisfy all
> +needs. If not, then the format can be extended.
> +
> +Error Conditions
> +----------------
> +
> +If the Git client discovers something unexpected while downloading
> +information according to a bundle URI or the table of contents found at
> +that location, then Git can ignore that data and continue as if it was not
> +given a bundle URI. The remote Git server is the ultimate source of truth,
> +not the bundle URI.

This seems to contradict the earlier statement that for clones all
bundle URIs would be "required".  I like the idea of bundle URIs only
being an optimization that can be ignored, just noting the potential
confusion.

> +
> +Here are a few example error conditions:
> +
> +* The client fails to connect with a server at the given URI or a connection
> +  is lost without any chance to recover.
> +
> +* The client receives a response other than `200 OK` (such as `404 Not Found`,
> +  `401 Not Authorized`, or `500 Internal Server Error`).
> +
> +* The client receives data that is not parsable as a bundle or table of
> +  contents.
> +
> +* The table of contents describes a directed cycle in the
> +  `bundle.<id>.requires` links.
> +
> +* A bundle includes a filter that does not match expectations.
> +
> +* The client cannot unbundle the bundles because the negative commit OIDs
> +  are not in the object database and there are no more
> +  `bundle.<id>.requires` links to follow.

Should these result in warnings so that folks can diagnose slower
connections, or should they be squelched?  (I'm thinking particularly
of the `401 Not Authorized` case in combination with users never
having had to use a credential helper before.)

> +
> +There are also situations that could be seen as wasteful, but are not
> +error conditions:
> +
> +* The downloaded bundles contain more information than is requested by
> +  the clone or fetch request. A primary example is if the user requests
> +  a clone with `--single-branch` but downloads bundles that store every
> +  reachable commit from all `refs/heads/*` references. This might be
> +  initially wasteful, but perhaps these objects will become reachable by
> +  a later ref update that the client cares about.

Ah, this answers my --single-branch question.  Still curious about the
--shallow misfeature (yeah, I'm a bit opinionated) and how it
interacts, though.

> +* A bundle download during a `git fetch` contains objects already in the
> +  object database. This is probably unavoidable if we are using bundles
> +  for fetches, since the client will almost always be slightly ahead of
> +  the bundle servers after performing its "catch-up" fetch to the remote
> +  server. This extra work is most wasteful when the client is fetching
> +  much more frequently than the server is computing bundles, such as if
> +  the client is using hourly prefetches with background maintenance, but
> +  the server is computing bundles weekly. For this reason, the client
> +  should not use bundle URIs for fetch unless the server has explicitly
> +  recommended it through the `bundle.tableOfContents.forFetch = true`
> +  value.

Makes sense, and certainly reduces my worry about the "transition
period" where users have existing clones that pre-dated the
introduction of the bundle URI feature.  But I'm still kind of curious
about how we handle that transition for folks that have recommended
their bundleUris for fetches.


> +
> +Implementation Plan
> +-------------------
> +
> +This design document is being submitted on its own as an aspirational
> +document, with the goal of implementing all of the mentioned client
> +features over the course of several patch series. Here is a potential
> +outline for submitting these features for full review:
> +
> +1. Update the `git bundle create` command to take a `--filter` option,
> +   allowing bundles to store packfiles restricted to an object filter.
> +   This is necessary for using bundle URIs to benefit partial clones.
> +
> +2. Integrate bundle URIs into `git clone` with a `--bundle-uri` option.
> +   This will include the full understanding of a table of contents, but
> +   will not integrate with `git fetch` or allow the server to advertise
> +   URIs.
> +
> +3. Integrate bundle URIs into `git fetch`, triggered by config values that
> +   are set during `git clone` if the server indicates that the bundle
> +   strategy works for fetches.
> +
> +4. Create a new "recommended features" capability in protocol v2 where the
> +   server can recommend features such as bundle URIs, partial clone, and
> +   sparse-checkout. These features will be extremely limited in scope and
> +   blocked by opt-in config options. The design for this portion could be
> +   replaced by a "bundle-uri" capability that only advertises bundle URIs
> +   and no other information.
> +
> +Related Work: Packfile URIs
> +---------------------------
> +
> +The Git protocol already has a capability where the Git server can list
> +a set of URLs along with the packfile response when serving a client
> +request. The client is then expected to download the packfiles at those
> +locations in order to have a complete understanding of the response.
> +
> +This mechanism is used by the Gerrit server (implemented with JGit) and
> +has been effective at reducing CPU load and improving user performance for
> +clones.
> +
> +A major downside to this mechanism is that the origin server needs to know
> +_exactly_ what is in those packfiles, and the packfiles need to be available
> +to the user for some time after the server has responded. This coupling
> +between the origin and the packfile data is difficult to manage.
> +
> +Further, this implementation is extremely hard to make work with fetches.
> +
> +Related Work: GVFS Cache Servers
> +--------------------------------
> +
> +The GVFS Protocol [2] is a set of HTTP endpoints designed independently of
> +the Git project before Git's partial clone was created. One feature of this
> +protocol is the idea of a "cache server" which can be colocated with build
> +machines or developer offices to transfer Git data without overloading the
> +central server.
> +
> +The endpoint that VFS for Git is famous for is the `GET /gvfs/objects/{oid}`
> +endpoint, which allows downloading an object on-demand. This is a critical
> +piece of the filesystem virtualization of that product.
> +
> +However, a more subtle need is the `GET /gvfs/prefetch?lastPackTimestamp=<t>`
> +endpoint. Given an optional timestamp, the cache server responds with a list
> +of precomputed packfiles containing the commits and trees that were introduced
> +in those time intervals.
> +
> +The cache server computes these "prefetch" packfiles using the following
> +strategy:
> +
> +1. Every hour, an "hourly" pack is generated with a given timestamp.
> +2. Nightly, the previous 24 hourly packs are rolled up into a "daily" pack.
> +3. Nightly, all prefetch packs more than 30 days old are rolled up into
> +   one pack.
> +
> +When a user runs `gvfs clone` or `scalar clone` against a repo with cache
> +servers, the client requests all prefetch packfiles, which is at most
> +`24 + 30 + 1` packfiles downloading only commits and trees. The client
> +then follows with a request to the origin server for the references, and
> +attempts to checkout that tip reference. (There is an extra endpoint that
> +helps get all reachable trees from a given commit, in case that commit
> +was not already in a prefetch packfile.)
> +
> +During a `git fetch`, a hook requests the prefetch endpoint using the
> +most-recent timestamp from a previously-downloaded prefetch packfile.
> +Only the list of packfiles with later timestamps are downloaded. Most
> +users fetch hourly, so they get at most one hourly prefetch pack. Users
> +whose machines have been off or otherwise have not fetched in over 30 days
> +might redownload all prefetch packfiles. This is rare.
> +
> +It is important to note that the clients always contact the origin server
> +for the refs advertisement, so the refs are frequently "ahead" of the
> +prefetched pack data. The missing objects are downloaded on-demand using
> +the `GET gvfs/objects/{oid}` requests, when needed by a command such as
> +`git checkout` or `git log`. Some Git optimizations disable checks that
> +would cause these on-demand downloads to be too aggressive.
> +
> +See Also
> +--------
> +
> +[1] https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
> +    An earlier RFC for a bundle URI feature.
> +
> +[2] https://github.com/microsoft/VFSForGit/blob/master/Protocol.md
> +    The GVFS Protocol
> \ No newline at end of file
> --
> gitgitgadget
>
