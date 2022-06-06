Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD12C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 19:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiFFTzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 15:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiFFTzc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 15:55:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CA729815
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 12:55:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h5so21283254wrb.0
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8NIPRl4i6HIsx2lAWw8AbAOtbptqiahyMLImaHqkIII=;
        b=p2vmKGb9mlvBtDGz5WzAwBLULt9gvcraZ4xUzVXWeqb82o2frWpt6GBTE4x1ozR3vx
         3VgOU/TySgms39NkAPMlX2lwpDOzvyGnK3wUGxg4fbIXGKkaj5eoFxPy1SEn8LDusX6n
         WB6J6eAWrklnQO1yp/+xm6stddbuhYoidw4OwLWcbxN74IJTmbCuNZikZNap3Whk8DS5
         MzxLSiR+flPOLHexlj8YoMyqldCtVHbnoef8A+UgKgPsifOf+OjK2ZmUHOOtrjVIFJhD
         wEpcqNtlVBySlvjDHF0yj9z/bok6lQtffEJCNqkI3uPjojDRzgXT75URW+c/vfbiA42L
         5uBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8NIPRl4i6HIsx2lAWw8AbAOtbptqiahyMLImaHqkIII=;
        b=5eO9VZ4uz9PtEwYkxwHJ6AH1KG6DTL6EqIzfyWmPxLJAqh2TdbmQC42obgeiMay3Zy
         R3xexB5yAgpDj4zaDf9xrjlPGO0mIaMlAYTtlLZaClhN+n9ATE2atUpj75etFcD8A4XE
         JNks7UHQAov23El6QOwgJ9p2XMEzn6AQNtgmKTb8TLR4fZtZu8/HBslhfwODwpLSHcKL
         j5Se0b4RtB7Nj06U4oIJ46cmXvLw1cskjmFI2PPst2DsJ9pzoC23DlWhNiLY/PP8KVsu
         DBd2s42kxPMY9FlHdqYardQZTOB4DRtnL5i7iMZjMo5ViRuNH/yLjVT+87ZXQhzpHLiy
         c9dQ==
X-Gm-Message-State: AOAM531RYNBDWWtCGTUe5vYwVIpWgRVvYsk6g2jq9d8V76si0/7S21d/
        wHh7WX7G+TFZG9ETPxADjOVzaNGcc4UeuV+b
X-Google-Smtp-Source: ABdhPJycBTNc9CXyXucbVeTobE9gz1l0AFFdY3W5vsPYZmdbOo7/DjBsFXtj/Fe6bM+Ml8zAfDY21Q==
X-Received: by 2002:a5d:59ad:0:b0:20f:e3bc:c719 with SMTP id p13-20020a5d59ad000000b0020fe3bcc719mr24185454wrr.562.1654545327785;
        Mon, 06 Jun 2022 12:55:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2-20020adfe942000000b0020fcaba73bcsm16274243wrn.104.2022.06.06.12.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:55:27 -0700 (PDT)
Message-Id: <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jun 2022 19:55:20 +0000
Subject: [PATCH 1/6] docs: document bundle URI standard
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Introduce the idea of bundle URIs to the Git codebase through an
aspirational design document. This document includes the full design
intended to include the feature in its fully-implemented form. This will
take several steps as detailed in the Implementation Plan section.

By committing this document now, it can be used to motivate changes
necessary to reach these final goals. The design can still be altered as
new information is discovered.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/technical/bundle-uri.txt | 475 +++++++++++++++++++++++++
 1 file changed, 475 insertions(+)
 create mode 100644 Documentation/technical/bundle-uri.txt

diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.txt
new file mode 100644
index 00000000000..6657ba079ab
--- /dev/null
+++ b/Documentation/technical/bundle-uri.txt
@@ -0,0 +1,475 @@
+Bundle URIs
+===========
+
+Bundle URIs are locations where Git can download one or more bundles in
+order to bootstrap the object database in advance of fetching the remaining
+objects from a remote.
+
+One goal is to speed up clones and fetches for users with poor network
+connectivity to the origin server. Another benefit is to allow heavy users,
+such as CI build farms, to use local resources for the majority of Git data
+and thereby reducing the load on the origin server.
+
+To enable the bundle URI feature, users can specify a bundle URI using
+command-line options or the origin server can advertise one or more URIs
+via a protocol v2 capability.
+
+Design Goals
+------------
+
+The bundle URI standard aims to be flexible enough to satisfy multiple
+workloads. The bundle provider and the Git client have several choices in
+how they create and consume bundle URIs.
+
+* Bundles can have whatever name the server desires. This name could refer
+  to immutable data by using a hash of the bundle contents. However, this
+  means that a new URI will be needed after every update of the content.
+  This might be acceptable if the server is advertising the URI (and the
+  server is aware of new bundles being generated) but would not be
+  ergonomic for users using the command line option.
+
+* The bundles could be organized specifically for bootstrapping full
+  clones, but could also be organized with the intention of bootstrapping
+  incremental fetches. The bundle provider must decide on one of several
+  organization schemes to minimize client downloads during incremental
+  fetches, but the Git client can also choose whether to use bundles for
+  either of these operations.
+
+* The bundle provider can choose to support full clones, partial clones,
+  or both. The client can detect which bundles are appropriate for the
+  repository's partial clone filter, if any.
+
+* The bundle provider can use a single bundle (for clones only), or a
+  list of bundles. When using a list of bundles, the provider can specify
+  whether or not the client needs _all_ of the bundle URIs for a full
+  clone, or if _any_ one of the bundle URIs is sufficient. This allows the
+  bundle provider to use different URIs for different geographies.
+
+* The bundle provider can organize the bundles using heuristics, such as
+  timestamps or tokens, to help the client prevent downloading bundles it
+  does not need. When the bundle provider does not provide these
+  heuristics, the client can use optimizations to minimize how much of the
+  data is downloaded.
+
+* The bundle provider does not need to be associated with the Git server.
+  The client can choose to use the bundle provider without it being
+  advertised by the Git server.
+
+* The client can choose to discover bundle providers that are advertised
+  by the Git server. This could happen during `git clone`, during
+  `git fetch`, both, or neither. The user can choose which combination
+  works best for them.
+
+* The client can choose to configure a bundle provider manually at any
+  time. The client can also choose to specify a bundle provider manually
+  as a command-line option to `git clone`.
+
+Each repository is different and every Git server has different needs.
+Hopefully the bundle URI feature is flexible enough to satisfy all needs.
+If not, then the feature can be extended through its versioning mechanism.
+
+Server requirements
+-------------------
+
+To provide a server-side implementation of bundle servers, no other parts
+of the Git protocol are required. This allows server maintainers to use
+static content solutions such as CDNs in order to serve the bundle files.
+
+At the current scope of the bundle URI feature, all URIs are expected to
+be HTTP(S) URLs where content is downloaded to a local file using a `GET`
+request to that URL. The server could include authentication requirements
+to those requests with the aim of triggering the configured credential
+helper for secure access. (Future extensions could use "file://" URIs or
+SSH URIs.)
+
+Assuming a `200 OK` response from the server, the content at the URL is
+expected to be of one of two forms:
+
+1. Bundle: A Git bundle file of version 2 or higher.
+
+2. Bundle List: A plain-text file that is parsable using Git's
+   config file parser. This file describes one or more bundles that are
+   accessible from other URIs.
+
+Any other data provided by the server is considered erroneous.
+
+Bundle Lists
+------------
+
+The Git server can advertise bundle URIs using a set of `key=value` pairs.
+A bundle URI can also serve a plain-text file in the Git config format
+containing these same `key=value` pairs. In both cases, we consider this
+to be a _bundle list_. The pairs specify information about the bundles
+that the client can use to make decisions for which bundles to download
+and which to ignore.
+
+A few keys focus on properties of the list itself.
+
+bundle.list.version::
+	(Required) This value provides a version number for the table of
+	contents. If a future Git change enables a feature that needs the Git
+	client to react to a new key in the bundle list file, then this version
+	will increment. The only current version number is 1, and if any other
+	value is specified then Git will fail to use this file.
+
+bundle.list.mode::
+	(Required) This value has one of two values: `all` and `any`. When `all`
+	is specified, then the client should expect to need all of the listed
+	bundle URIs that match their repository's requirements. When `any` is
+	specified, then the client should expect that any one of the bundle URIs
+	that match their repository's requirements will suffice. Typically, the
+	`any` option is used to list a number of different bundle servers
+	located in different geographies.
+
+bundle.list.heuristic::
+	If this string-valued key exists, then the bundle list is designed to
+  work well with incremental `git fetch` commands. The heuristic signals
+  that there are additional keys available for each bundle that help
+  determine which subset of bundles the client should download.
+
+The remaining keys include an `<id>` segment which is a server-designated
+name for each available bundle.
+
+bundle.<id>.uri::
+	(Required) This string value is the URI for downloading bundle `<id>`.
+	If the URI begins with a protocol (`http://` or `https://`) then the URI
+	is absolute. Otherwise, the URI is interpreted as relative to the URI
+	used for the bundle list. If the URI begins with `/`, then that relative
+	path is relative to the domain name used for the bundle list. (This use
+	of relative paths is intended to make it easier to distribute a set of
+	bundles across a large number of servers or CDNs with different domain
+	names.)
+
+bundle.<id>.list::
+	This boolean value indicates whether the client should expect the
+	content from this URI to be a list (if `true`) or a bundle (if `false`).
+	This is typically used when `bundle.list.mode` is `any`.
+
+bundle.<id>.filter::
+	This string value represents an object filter that should also appear in
+	the header of this bundle. The server uses this value to differentiate
+	different kinds of bundles from which the client can choose those that
+	match their object filters.
+
+bundle.<id>.timestamp::
+	This value is the number of seconds since Unix epoch (UTC) that this
+	bundle was created. This is used as an approximation of a point in time
+	that the bundle matches the data available at the origin server. This is
+	used when `bundle.list.heuristic=timestamp`.
+
+bundle.<id>.requires::
+	This string value represents the ID of another bundle. When present, the
+	server is indicating that this bundle contains a thin packfile. If the
+	client does not have all necessary objects to unbundle this packfile,
+	then the client can download the bundle with the `requires` ID and try
+	again. (Note: it may be beneficial to allow the server to specify
+	multiple `requires` bundles.) This is used when
+	`bundle.list.heuristic=timestamp`.
+
+bundle.<id>.location::
+	This string value advertises a real-world location from where the bundle
+	URI is served. This can be used to present the user with an option for
+	which bundle URI to use. This is only valuable when `bundle.list.mode`
+	is `any`.
+
+Here is an example bundle list using the Git config format:
+
+```
+[bundle "list"]
+	version = 1
+	mode = all
+	heuristic = timestamp
+
+[bundle "2022-02-09-1644442601-daily"]
+	uri = https://bundles.fake.com/git/git/2022-02-09-1644442601-daily.bundle
+	timestamp = 1644442601
+	requires = 2022-02-02-1643842562
+
+[bundle "2022-02-02-1643842562"]
+	uri = https://bundles.fake.com/git/git/2022-02-02-1643842562.bundle
+	timestamp = 1643842562
+
+[bundle "2022-02-09-1644442631-daily-blobless"]
+	uri = 2022-02-09-1644442631-daily-blobless.bundle
+	timestamp = 1644442631
+	requires = 2022-02-02-1643842568-blobless
+	filter = blob:none
+
+[bundle "2022-02-02-1643842568-blobless"]
+	uri = /git/git/2022-02-02-1643842568-blobless.bundle
+	timestamp = 1643842568
+	filter = blob:none
+```
+
+This example uses `bundle.list.mode=all` as well as the
+`bundle.<id>.timestamp` heuristic. It also uses the `bundle.<id>.filter`
+options to present two parallel sets of bundles: one for full clones and
+another for blobless partial clones.
+
+Suppose that this bundle list was found at the URI
+`https://bundles.fake.com/git/git/` and so the two blobless bundles have
+the following fully-expanded URIs:
+
+* `https://bundles.fake.com/git/git/2022-02-09-1644442631-daily-blobless.bundle`
+* `https://bundles.fake.com/git/git/2022-02-02-1643842568-blobless.bundle`
+
+Advertising Bundle URIs
+-----------------------
+
+If a user knows a bundle URI for the repository they are cloning, then
+they can specify that URI manually through a command-line option. However,
+a Git host may want to advertise bundle URIs during the clone operation,
+helping users unaware of the feature.
+
+The only thing required for this feature is that the server can advertise
+one or more bundle URIs. This advertisement takes the form of a new
+protocol v2 capability specifically for discovering bundle URIs.
+
+The client could choose an arbitrary bundle URI as an option _or_ select
+the URI with lowest latency by some exploratory checks. It is up to the
+bundle provider to decide if having multiple URIs is preferable to a
+single URI that is geodistributed through server-side infrastructure.
+
+Cloning with Bundle URIs
+------------------------
+
+The primary need for bundle URIs is to speed up clones. The Git client
+will interact with bundle URIs according to the following flow:
+
+1. The user specifies a bundle URI with the `--bundle-uri` command-line
+   option _or_ the client discovers a bundle list advertised by the
+   Git server.
+
+2. If the downloaded data from a bundle URI is a bundle, then the client
+   inspects the bundle headers to check that the negative commit OIDs are
+   present in the client repository. If some are missing, then the client
+   delays unbundling until other bundles have been unbundled, making those
+   OIDs present. When all required OIDs are present, the client unbundles
+   that data using a refspec. The default refspec is
+   `+refs/heads/*:refs/bundles/*`, but this can be configured.
+
+3. If the file is instead a bundle list, then the client inspects the
+   `bundle.list.mode` to see if the list is of the `all` or `any` form.
+
+   a. If `bundle.list.mode=all`, then the client considers all bundle
+      URIs. The list is reduced based on the `bundle.<id>.filter` options
+      matching the client repository's partial clone filter. Then, all
+      bundle URIs are requested. If the `bundle.<id>.timestamp` heuristic
+      is provided, then the bundles are downloaded in reverse-
+      chronological order, stopping when a bundle has all required OIDs.
+      The bundles can then be unbundled in chronological order. The client
+      stores the latest timestamp as a heuristic for avoiding future
+      downloads if the bundle list does not advertise newer bundles.
+
+   b. If `bundle.list.mode=any`, then the client can choose any one of the
+      bundle URIs to inspect. The client can use a variety of ways to
+      choose among these URIs. The client can also fallback to another URI
+      if the initial choice fails to return a result.
+
+Note that during a clone we expect that all bundles will be required, and
+heuristics such as `bundle.<uri>.timestamp` can be used to download bundles
+in chronological order or in parallel.
+
+If a given bundle URI is a bundle list with a `bundle.list.heuristic`
+value, then the client can choose to store that URI as its chosen bundle
+URI. The client can then navigate directly to that URI during later `git
+fetch` calls.
+
+When downloading bundle URIs, the client can choose to inspect the initial
+content before committing to downloading the entire content. This may
+provide enough information to determine if the URI is a bundle list or
+a bundle. In the case of a bundle, the client may inspect the bundle
+header to determine that all advertised tips are already in the client
+repository and cancel the remaining download.
+
+Fetching with Bundle URIs
+-------------------------
+
+When the client fetches new data, it can decide to fetch from bundle
+servers before fetching from the origin remote. This could be done via a
+command-line option, but it is more likely useful to use a config value
+such as the one specified during the clone.
+
+The fetch operation follows the same procedure to download bundles from a
+bundle list (although we do _not_ want to use parallel downloads here). We
+expect that the process will end when all negative commit OIDs in a thin
+bundle are already in the object database.
+
+When using the `timestamp` heuristic, the client can avoid downloading any
+bundles if their timestamps are not larger than the stored timestamp.
+After fetching new bundles, this local timestamp value is updated.
+
+If the bundle provider does not provide a heuristic, then the client
+should attempt to inspect the bundle headers before downloading the full
+bundle data in case the bundle tips already exist in the client
+repository.
+
+Error Conditions
+----------------
+
+If the Git client discovers something unexpected while downloading
+information according to a bundle URI or the bundle list found at that
+location, then Git can ignore that data and continue as if it was not
+given a bundle URI. The remote Git server is the ultimate source of truth,
+not the bundle URI.
+
+Here are a few example error conditions:
+
+* The client fails to connect with a server at the given URI or a connection
+  is lost without any chance to recover.
+
+* The client receives a response other than `200 OK` (such as `404 Not Found`,
+  `401 Not Authorized`, or `500 Internal Server Error`). The client should
+  use the `credential.helper` to attempt authentication after the first
+  `401 Not Authorized` response, but a second such response is a failure.
+
+* The client receives data that is not parsable as a bundle or table of
+  contents.
+
+* The bundle list describes a directed cycle in the
+  `bundle.<id>.requires` links.
+
+* A bundle includes a filter that does not match expectations.
+
+* The client cannot unbundle the bundles because the negative commit OIDs
+  are not in the object database and there are no more
+  `bundle.<id>.requires` links to follow.
+
+There are also situations that could be seen as wasteful, but are not
+error conditions:
+
+* The downloaded bundles contain more information than is requested by
+  the clone or fetch request. A primary example is if the user requests
+  a clone with `--single-branch` but downloads bundles that store every
+  reachable commit from all `refs/heads/*` references. This might be
+  initially wasteful, but perhaps these objects will become reachable by
+  a later ref update that the client cares about.
+
+* A bundle download during a `git fetch` contains objects already in the
+  object database. This is probably unavoidable if we are using bundles
+  for fetches, since the client will almost always be slightly ahead of
+  the bundle servers after performing its "catch-up" fetch to the remote
+  server. This extra work is most wasteful when the client is fetching
+  much more frequently than the server is computing bundles, such as if
+  the client is using hourly prefetches with background maintenance, but
+  the server is computing bundles weekly. For this reason, the client
+  should not use bundle URIs for fetch unless the server has explicitly
+  recommended it through the `bundle.list.forFetch = true` value.
+
+Implementation Plan
+-------------------
+
+This design document is being submitted on its own as an aspirational
+document, with the goal of implementing all of the mentioned client
+features over the course of several patch series. Here is a potential
+outline for submitting these features:
+
+1. Integrate bundle URIs into `git clone` with a `--bundle-uri` option.
+   This will include a new `git fetch --bundle-uri` mode for use as the
+   implementation underneath `git clone`. The initial version here will
+   expect a single bundle at the given URI.
+
+2. Implement the ability to parse a bundle list from a bundle URI and
+   update the `git fetch --bundle-uri` logic to properly distinguish
+   between `bundle.list.mode` options. Specifically design the feature so
+   that the config format parsing feeds a list of key-value pairs into the
+   bundle list logic.
+
+3. Create the `bundle-uri` protocol v2 verb so Git servers can advertise
+   bundle URIs using the key-value pairs. Plug into the existing key-value
+   input to the bundle list logic. Allow `git clone` to discover these
+   bundle URIs and bootstrap the client repository from the bundle data.
+   (This choice is an opt-in via a config option and a command-line
+   option.)
+
+4. Allow the client to understand the `bundle.list.forFetch` configuration
+   and the `bundle.<id>.timestamp` heuristic. When `git clone` discovers a
+   bundle URI with `bundle.list.forFetch=true`, it configures the client
+   repository to check that bundle URI during later `git fetch <remote>`
+   commands.
+
+5. Allow clients to discover bundle URIs during `git fetch` and configure
+   a bundle URI for later fetches if `bundle.list.forFetch=true`.
+
+6. Implement the "inspect headers" heuristic to reduce data downloads when
+   the `bundle.<id>.timestamp` heuristic is not available.
+
+As these features are reviewed, this plan might be updated. We also expect
+that new designs will be discovered and implemented as this feature
+matures and becomes used in real-world scenarios.
+
+Related Work: Packfile URIs
+---------------------------
+
+The Git protocol already has a capability where the Git server can list
+a set of URLs along with the packfile response when serving a client
+request. The client is then expected to download the packfiles at those
+locations in order to have a complete understanding of the response.
+
+This mechanism is used by the Gerrit server (implemented with JGit) and
+has been effective at reducing CPU load and improving user performance for
+clones.
+
+A major downside to this mechanism is that the origin server needs to know
+_exactly_ what is in those packfiles, and the packfiles need to be available
+to the user for some time after the server has responded. This coupling
+between the origin and the packfile data is difficult to manage.
+
+Further, this implementation is extremely hard to make work with fetches.
+
+Related Work: GVFS Cache Servers
+--------------------------------
+
+The GVFS Protocol [2] is a set of HTTP endpoints designed independently of
+the Git project before Git's partial clone was created. One feature of this
+protocol is the idea of a "cache server" which can be colocated with build
+machines or developer offices to transfer Git data without overloading the
+central server.
+
+The endpoint that VFS for Git is famous for is the `GET /gvfs/objects/{oid}`
+endpoint, which allows downloading an object on-demand. This is a critical
+piece of the filesystem virtualization of that product.
+
+However, a more subtle need is the `GET /gvfs/prefetch?lastPackTimestamp=<t>`
+endpoint. Given an optional timestamp, the cache server responds with a list
+of precomputed packfiles containing the commits and trees that were introduced
+in those time intervals.
+
+The cache server computes these "prefetch" packfiles using the following
+strategy:
+
+1. Every hour, an "hourly" pack is generated with a given timestamp.
+2. Nightly, the previous 24 hourly packs are rolled up into a "daily" pack.
+3. Nightly, all prefetch packs more than 30 days old are rolled up into
+   one pack.
+
+When a user runs `gvfs clone` or `scalar clone` against a repo with cache
+servers, the client requests all prefetch packfiles, which is at most
+`24 + 30 + 1` packfiles downloading only commits and trees. The client
+then follows with a request to the origin server for the references, and
+attempts to checkout that tip reference. (There is an extra endpoint that
+helps get all reachable trees from a given commit, in case that commit
+was not already in a prefetch packfile.)
+
+During a `git fetch`, a hook requests the prefetch endpoint using the
+most-recent timestamp from a previously-downloaded prefetch packfile.
+Only the list of packfiles with later timestamps are downloaded. Most
+users fetch hourly, so they get at most one hourly prefetch pack. Users
+whose machines have been off or otherwise have not fetched in over 30 days
+might redownload all prefetch packfiles. This is rare.
+
+It is important to note that the clients always contact the origin server
+for the refs advertisement, so the refs are frequently "ahead" of the
+prefetched pack data. The missing objects are downloaded on-demand using
+the `GET gvfs/objects/{oid}` requests, when needed by a command such as
+`git checkout` or `git log`. Some Git optimizations disable checks that
+would cause these on-demand downloads to be too aggressive.
+
+See Also
+--------
+
+[1] https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
+    An earlier RFC for a bundle URI feature.
+
+[2] https://github.com/microsoft/VFSForGit/blob/master/Protocol.md
+    The GVFS Protocol
-- 
gitgitgadget

