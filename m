Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6AC397942
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315522; cv=none; b=dqTnLOn0qKlenuV74SEQHdjDlFOt8eu/CAza/+BXq1U3boEmLywkehlu044hqsUYvj8eKXFCV24aXfZqaRpGzqWDGdLzflBSr5/3kCN5cVprI13fQs5b/GDCFHTk/Y5iAirHeI3adu8R9tLlQCpZ3ZpxqpJopsA/kpG1AopmhA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315522; c=relaxed/simple;
	bh=6pnQ/ddns4JNGaHpt3B0qX+AUbcIi7Jn0/0+JyDXJCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HPm0GvYJ9a++n+AJXUrJUq9YlrIzMO4h+rSxwDKzNP1edNNcz+HcBdabV99jaSDNXWVs8SEhPUsO6yfbk1BrDTHtbRYRpAugfDN5PL/N3LrejKgTbA2mEXv2Bs2LrJGUm8YMpZJRqxXwzWqmsl8G5RiR9gLY8WDdogaNm5Vqr5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gHOfkrd5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i3+MsGBN; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gHOfkrd5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i3+MsGBN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3EE827A00B1;
	Fri, 21 Aug 2026 08:32:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 21 Aug 2026 08:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787315520;
	 x=1787401920; bh=seCg6FNueoJfCm0MKsR/SHCNGQJB+LKjeGiYPT73rHA=; b=
	gHOfkrd5BWj1oOLFzXKnLE0LE7TvVw0PFS9MZp6BU4fB97xBhiy3Elr7l6K5TbRd
	GB2Dh84ikIyIHItvqIcAbGnu291tJgCoU2v8qqYTrHGcWQVCumjLeR73EWmX3X51
	lYvGivUR8KYF69uLgCxlC6tTknshRgM4daPYvBk55vpBR5UuznIyGS3+3GQDxq//
	qXlcwEdVIzyRp/8zEbrTgHaejqPxQUvLl8K/3H6NmY6ZBbBf4smglfhciQFz9914
	teQuSaqFUuEpp/XVdMO76pU/QGSJYuDa7zbbiSllZLg178gHrXd1nSUOX2CEu0Te
	RJJG46dyBXxA7SWp3/Ztgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787315520; x=
	1787401920; bh=seCg6FNueoJfCm0MKsR/SHCNGQJB+LKjeGiYPT73rHA=; b=i
	3+MsGBNLsWnKnwZOrGCcSSPflI3vGf0joeTG7un0bJ7n6aCjNioWwUvIUkwI/ggz
	X+I3NomLwD/RbEYWzKljtiZRNMGV9HcLy1Gvxd5SBInJil+rH0UDxNVpRrElX1FB
	0Wu0zRoL3OIsqUjzzy911mZcC9aD0cfxw308zd9lp9Q5fgxm3QvrMWgEo6BvJY+j
	hnaSb6qGE7EyPfICloFSHWv7npnbzvWRT0jib3c4LLSb4FFLyxUfha7sJH+Pl4jS
	Pnb2R4IS8Z5a//jFVg4ywdAPIbCVZP3ILlRM8+ECID8YnwG0/KjlGK9OCCG0yOOY
	rNxRFQfSQGIPx11CGFLIA==
X-ME-Sender: <xms:P0WIatmPzTjUblqevGyBxgn0riD-so2gKxUe25QRh2f_dZWXp_x4Mg>
    <xme:P0WIau3UYoGh_AvaPzHEnHhilJJLF9OfVq6VHfU2v_AVM6VJnimBeDQeLTK3MuNfr
    0E5YxYErejc9cGDXlB39YcMI9rkceT6vNbXKMeQS4-XRYdO2TMR7A>
X-ME-Received: <xmr:P0WIahSNJufI41MiQMgjiySfB_TG0HxIBa0gI48qEvpcXvLMxG0qeAQ5O1kPX8U9-6sTgAivc6c09YKW3nFqSM_iccpTRGsyC-K_0fFvzL_t>
X-ME-Proxy-Cause: dmFkZTEutFYURr53osgEdpGE2CY+NSFU+Cb83xojaSOXH6aiNmm46iCT87DE1W/nJWsq8Y
    viTJTwQRzGeBwT+VUiH0nWn5S0TdkZg5Wdyzs5B9QJUnX3E08i6LorZxz7DWdoNZ//jmnl
    CsnJGpTaxOzX/kLwDqoebtFLZrBqCAAdrjRagwizseKPvxLfAjFq7e2pfRyXy7WY9DB0hJ
    LNq3eZSatGJYggsUdyx5fQ4plE6+6/y7F9o/jngRpt9buPyo3rOqTjh2XxM69OxCBm+5c2
    abOCC+SO+XAZ5mSB3exCljhAFLroGSWZPJ+iiphpjJGz9YLXsmAhUKUl6orMr4V4z6SDUK
    OJw2UkV0SurSwfdjH/GeKCOPCghJJ4QRbmbvwhSj5J0fvUOQ0krz9K2kX8Rtd5nKYReAMP
    3MHEhxFgCk37V33fAgZpO5lpp0HBr6PEToQKfC7iy2WsxUv8qZWgmiM+VRLov0Z2RdUK89
    sGC2l3gvCgs4PPflBMV1HFc/O+hkvEwKjUvTVY6/rlMwSK9SlC0DVZXzyK08puRZGKt3dY
    POUrqkPPITo0GMTqTKNEjOr/P6xAQKrid4Eb7YOA8YwqWRT8f0ywvT1AH/e7szoKk5O+dz
    0CrJIkMvuOqhqORbreiMEM+jqdMC1+czByGx5TMdEPy4OGg84KTyrW68cSUw
X-ME-Proxy: <xmx:P0WIaotSdJxniToBjY4hxLjgwnsAiba9YAgSCPd22Xwb2YjgXSn6nQ>
    <xmx:QEWIauaEmqtI1AudYiHf-A2hGrH8F8O-ZuCS2ZrRyii64FUF6dlAgQ>
    <xmx:QEWIalsl0XkqHwKDdBWb1WblaX5aXX4XF-SGL1E6ARfZVAYnjczWiw>
    <xmx:QEWIaoFcFfuFLOjWAfcZuZn_QWng1SDavDxX67qlDEsq3s4Ne8_ebw>
    <xmx:QEWIamUgeKXmZlCXuY58hFaqYtgAEUQVKbN3e6sFjQJgt7sEgZeE2bzN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 08:31:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id efa03274 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 12:31:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Aug 2026 14:31:45 +0200
Subject: [PATCH 2/2] fetch-pack: allow parallelizing packfile URI fetches
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260821-pks-parallelize-fetching-packfile-uris-v1-2-0df52d9427ce@pks.im>
References: <20260821-pks-parallelize-fetching-packfile-uris-v1-0-0df52d9427ce@pks.im>
In-Reply-To: <20260821-pks-parallelize-fetching-packfile-uris-v1-0-0df52d9427ce@pks.im>
To: git@vger.kernel.org
Cc: Ted Nyman <tnyman@openai.com>
X-Mailer: b4 0.15.2

When cloning from a server that supports packfile URIs we may see
multiple URIs being announced by the server. If so, the expectation is
that the client will download all of those packfiles. This is being done
sequentially, where we fetch one packfile after the other.

In many cases this should be fine, but there are scenarios where it's
not. When packfiles are for example hosted by object storage (think AWS
S3 or GCS) then the way to achieve high performance is typically to
parallelize downloading the data as a single connection is often capped
at a certain bandwidth. Furthermore, when the server announces a bunch
of smaller packfiles, then the overhead of establishing the connection
may eventually add up.

Despite the limitations caused by the network bandwidth and latency, Git
also runs git-index-pack(1) on all of the fetched packfiles. This is
another task that can be easily parallelized for another speedup.

All of these limitations can be addressed by parallelizing the fetch.
Introduce a new configuration option that allows the user to ask for
this: by default we continue to not parallelize the fetch to retain the
status quo. But when configured to 0 (where we auto-detect the number of
cores) or a value larger than 1 we perform the fetches concurrently.

With this infrastructure in place we can significantly speed up such
fetches. Using a local HTTP server demonstrates the speedup when using a
throttled connection of 2MB/s and downloading 8x1MB packfiles:

    Benchmark 1: 2MB/s, 8x1MB packfiles, 1 threads
      Time (mean ± σ):      4.321 s ±  0.003 s    [User: 0.195 s, System: 0.113 s]
      Range (min … max):    4.318 s …  4.325 s    5 runs

    Benchmark 2: 2MB/s, 8x1MB packfiles, 2 threads
      Time (mean ± σ):      2.284 s ±  0.241 s    [User: 0.191 s, System: 0.114 s]
      Range (min … max):    2.173 s …  2.714 s    5 runs

    Benchmark 3: 2MB/s, 8x1MB packfiles, 4 threads
      Time (mean ± σ):      1.212 s ±  0.238 s    [User: 0.192 s, System: 0.105 s]
      Range (min … max):    1.102 s …  1.638 s    5 runs

    Benchmark 4: 2MB/s, 8x1MB packfiles, 8 threads
      Time (mean ± σ):     569.9 ms ±   2.5 ms    [User: 183.4 ms, System: 116.0 ms]
      Range (min … max):   566.5 ms … 573.4 ms    5 runs

    Summary
      2MB/s, 8x1MB packfiles, 8 threads ran
        2.13 ± 0.42 times faster than 2MB/s, 8x1MB packfiles, 4 threads
        4.01 ± 0.42 times faster than 2MB/s, 8x1MB packfiles, 2 threads
        7.58 ± 0.03 times faster than 2MB/s, 8x1MB packfiles, 1 threads

Quite unsurprisingly, we scale almost linearly with the number of
threads in this case as we're limited by the bandwidth of a single
connection. But we can also demonstrate a speedup on an unthrottled
connection when downloading slightly larger packfiles:

    Benchmark 1: unthrottled, 8x16MB packfiles, 1 threads
      Time (mean ± σ):      2.434 s ±  0.031 s    [User: 2.067 s, System: 0.329 s]
      Range (min … max):    2.381 s …  2.460 s    5 runs

    Benchmark 2: unthrottled, 8x16MB packfiles, 2 threads
      Time (mean ± σ):      1.353 s ±  0.129 s    [User: 2.025 s, System: 0.328 s]
      Range (min … max):    1.288 s …  1.583 s    5 runs

    Benchmark 3: unthrottled, 8x16MB packfiles, 4 threads
      Time (mean ± σ):     702.9 ms ±  23.9 ms    [User: 1732.5 ms, System: 313.9 ms]
      Range (min … max):   660.7 ms … 718.5 ms    5 runs

    Benchmark 4: unthrottled, 8x16MB packfiles, 8 threads
      Time (mean ± σ):     455.1 ms ±   7.7 ms    [User: 1730.0 ms, System: 372.3 ms]
      Range (min … max):   442.8 ms … 462.8 ms    5 runs

    Summary
      unthrottled, 8x16MB packfiles, 8 threads ran
        1.54 ± 0.06 times faster than unthrottled, 8x16MB packfiles, 4 threads
        2.97 ± 0.29 times faster than unthrottled, 8x16MB packfiles, 2 threads
        5.35 ± 0.11 times faster than unthrottled, 8x16MB packfiles, 1 threads

In this case, the speedup is caused by us running git-index-pack(1) in
parallel. The improvement isn't linear, but still quite significant.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/fetch.adoc |  9 +++++
 fetch-pack.c                    | 86 +++++++++++++++++++++++++++++++++++++++--
 t/t5702-protocol-v2.sh          | 44 +++++++++++++++++++++
 3 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/fetch.adoc b/Documentation/config/fetch.adoc
index 00435e9a16..7afe8d7d5c 100644
--- a/Documentation/config/fetch.adoc
+++ b/Documentation/config/fetch.adoc
@@ -94,6 +94,15 @@ A value of 0 will give some reasonable default. If unset, it defaults to 1.
 For submodules, this setting can be overridden using the `submodule.fetchJobs`
 config setting.
 
+`fetch.packfileURIThreads`::
+	Specifies the number of threads used to download packfiles
+	advertised by the server via the `packfile-uris` capability in
+	parallel. Each packfile is downloaded via a separate
+	linkgit:git-http-fetch[1] process.
++
+A value of 0 will use a reasonable default based on the number of available
+CPUs. If unset, it defaults to 1, downloading packfiles sequentially.
+
 `fetch.writeCommitGraph`::
 	Set to true to write a commit-graph after every `git fetch` command
 	that downloads a pack-file from a remote. Using the `--split` option,
diff --git a/fetch-pack.c b/fetch-pack.c
index 6aca0b2588..b9dca9e07f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -37,6 +37,7 @@
 #include "mergesort.h"
 #include "prio-queue.h"
 #include "promisor-remote.h"
+#include "thread-utils.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -53,6 +54,7 @@ static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
 static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
+static unsigned int packfile_uri_threads = 1;
 
 /* Remember to update object flag allocation in object.h */
 #define COMPLETE	(1U << 0)
@@ -1692,6 +1694,13 @@ static void fetch_packfile_uri(const char *uri_with_hash,
 	cmd.git_cmd = 1;
 	cmd.no_stdin = 1;
 	cmd.out = -1;
+
+	/*
+	 * Multiple threads may spawn and reap children concurrently in here.
+	 * This is safe because the child-cleanup bookkeeping in run-command.c,
+	 * which is not thread-safe, is only ever used when `clean_on_exit` is
+	 * set.
+	 */
 	if (start_command(&cmd))
 		die("fetch-pack: unable to spawn http-fetch");
 
@@ -1720,22 +1729,84 @@ static void fetch_packfile_uri(const char *uri_with_hash,
 		    uri_with_hash);
 }
 
+struct fetch_packfile_uris_state {
+	const struct string_list *packfile_uris;
+	const struct strvec *index_pack_args;
+	struct fetch_packfile_uri_result *results;
+	size_t next;
+	pthread_mutex_t lock;
+};
+
+static void *fetch_packfile_uris_thread(void *data)
+{
+	struct fetch_packfile_uris_state *state = data;
+
+	trace2_thread_start("fetch_packfile_uri");
+
+	for (;;) {
+		size_t i;
+
+		pthread_mutex_lock(&state->lock);
+		i = state->next++;
+		pthread_mutex_unlock(&state->lock);
+		if (i >= state->packfile_uris->nr)
+			break;
+
+		fetch_packfile_uri(state->packfile_uris->items[i].string,
+				   state->index_pack_args,
+				   &state->results[i]);
+	}
+
+	trace2_thread_exit();
+
+	return NULL;
+}
+
 static void fetch_packfile_uris(const struct string_list *packfile_uris,
 				const struct strvec *index_pack_args,
 				struct oidset *gitmodules_found,
 				struct string_list *pack_lockfiles)
 {
+	unsigned int nr_threads = packfile_uri_threads;
 	struct fetch_packfile_uri_result *results;
 
+	if (!nr_threads)
+		nr_threads = online_cpus();
+	if (nr_threads > packfile_uris->nr)
+		nr_threads = packfile_uris->nr;
+
 	/* Initialize the data. */
 	CALLOC_ARRAY(results, packfile_uris->nr);
 	for (size_t i = 0; i < packfile_uris->nr; i++)
 		oidset_init(&results[i].gitmodules_found, 0);
 
 	/* Perform the fetches. */
-	for (size_t i = 0; i < packfile_uris->nr; i++)
-		fetch_packfile_uri(packfile_uris->items[i].string,
-				   index_pack_args, &results[i]);
+	if (nr_threads > 1) {
+		struct fetch_packfile_uris_state state = {
+			.packfile_uris = packfile_uris,
+			.index_pack_args = index_pack_args,
+			.results = results,
+		};
+		pthread_t *threads;
+
+		pthread_mutex_init(&state.lock, NULL);
+		ALLOC_ARRAY(threads, nr_threads);
+
+		for (size_t i = 0; i < nr_threads; i++)
+			if (pthread_create(&threads[i], NULL,
+					   fetch_packfile_uris_thread, &state))
+				die(_("failed to create thread"));
+		for (size_t i = 0; i < nr_threads; i++)
+			if (pthread_join(threads[i], NULL))
+				die(_("failed to join thread"));
+
+		pthread_mutex_destroy(&state.lock);
+		free(threads);
+	} else {
+		for (size_t i = 0; i < packfile_uris->nr; i++)
+			fetch_packfile_uri(packfile_uris->items[i].string,
+					   index_pack_args, &results[i]);
+	}
 
 	/* Aggregate results. */
 	for (size_t i = 0; i < packfile_uris->nr; i++) {
@@ -2018,6 +2089,15 @@ static void fetch_pack_config(void)
 		}
 	}
 
+	if (!repo_config_get_uint(the_repository, "fetch.packfileurithreads",
+				  &packfile_uri_threads)) {
+		if (!HAVE_THREADS && packfile_uri_threads != 1) {
+			warning(_("no threads support, ignoring %s"),
+				"fetch.packfileURIThreads");
+			packfile_uri_threads = 1;
+		}
+	}
+
 	repo_config(the_repository, fetch_pack_config_cb, NULL);
 }
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 0f05286de8..a43d64ac95 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -1270,6 +1270,50 @@ test_expect_success 'part of packfile response provided as URI' '
 	test_line_count = 6 filelist
 '
 
+test_expect_success 'packfile URIs are downloaded in parallel' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log trace2.txt &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	for i in one two three
+	do
+		echo blob-$i >"$P"/blob-$i &&
+		git -C "$P" add blob-$i &&
+		configure_exclusion "$P" blob-$i >h-$i || return 1
+	done &&
+	git -C "$P" commit -m message &&
+
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TEST_SIDEBAND_ALL=1 git \
+		-c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		-c fetch.packfileurithreads=2 \
+		clone --quiet "$HTTPD_URL/smart/http_parent" http_child 2>err &&
+
+	# Ensure that all objects were found.
+	for i in one two three
+	do
+		git -C http_child cat-file -e "$(cat h-$i)" || return 1
+	done &&
+
+	# Ensure that there are exactly 4 packfiles with associated .idx.
+	ls http_child/.git/objects/pack/*.pack \
+	    http_child/.git/objects/pack/*.idx >filelist &&
+	test_line_count = 8 filelist &&
+
+	if test_have_prereq PTHREADS
+	then
+		# Ensure that exactly two worker threads were spawned.
+		git grep --no-index --only-matching "\"thread\":\"th[0-9]*:fetch_packfile_uri\"" trace2.txt >threads &&
+		sort -u <threads >threads.unique &&
+		test_line_count = 2 threads.unique &&
+		test_grep ! "warning: no threads support, ignoring fetch.packfileURIThreads" err
+	else
+		test_grep "warning: no threads support, ignoring fetch.packfileURIThreads" err
+	fi
+'
+
 test_expect_success 'packfile URIs with fetch instead of clone' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	rm -rf "$P" http_child log &&

-- 
2.55.0.822.g20453c30eb.dirty

