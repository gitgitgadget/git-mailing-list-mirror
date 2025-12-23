Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A2E330B1C
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488310; cv=none; b=JZdP4x8uVVK0Qswn3nLHHLJll1Tb2RKNb1ZNk1FkBuAbbYGeF6oN9kNRo0xyMSDwF0U+MfXDtUJEic6bSObmV2eTxWgOO4zHumijW8vB9/3PufrAId8MFOT5BpOlUbW5Ljg5SiOBgeMsy4hzZQlvNfEbK+yBrY59ttUmisiyVdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488310; c=relaxed/simple;
	bh=7mkHVxcbp5pB4WElT6/eLhnYfXhJqjZJb1Ls1s355EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VT3z+8N8XuQW0zR5gYr6u0mN09SWS4NyfNClZrdOzR3OAI2K8IpjJJ9sfEIMLFMDHAP27v9+rvOzCfF/73QOj4NSCKYcNu5SNpXqQDqsVuQ0c45DEb1itpIsCXIZS6zqBNzyOcgSULw8DmUVgsssQ11toseZOQo3WzHwlMhohfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeUpzcR6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeUpzcR6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47755de027eso28492155e9.0
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 03:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766488305; x=1767093105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8a3pRCY7nQhi8Fj6iVjQFxKGMADf7QrArXjHRvAzMA=;
        b=YeUpzcR6xq5tf3Bi+MoJn7ueT6e+cskamqZkZQU6LWXm6bspSfCVpinvpcd/JmNtvG
         /GPdyZJPNSahI1eJHFC3FL0l5HOShljbcQQIaVO71rUqj1Gu824NTqPGYNZ1h057gCjq
         A8sv8TXqU4WXrce7/WKS6DXXzichZsdxc/jGnRhT4qUDpAR24Rg5Hn9Lcyu5uNyW/WT7
         UrzBq8YF8XbZQTsfesoqpdIUf1Ey9e3lt1hxPPhCI26DzQnEf4QBCE4pwdW10ftNiQM4
         xXQpahvpuNsSCcBTVE8GH96rseET3jotdJwLEuVV+oUzZCRMNCuKVKw4jBKY/D4cIkyl
         r0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766488305; x=1767093105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S8a3pRCY7nQhi8Fj6iVjQFxKGMADf7QrArXjHRvAzMA=;
        b=cmm2QcAUh5SRbEOcOzDfuqBVXeGqpWiz0KsAcEj1O/tU5PaRikD7rTfErnLHiIanBc
         CCYFSr2/cFQtwUbXhSffeI1JWzrj6MZk8srAMRyP5/vTypeOJf8goQn9F10Aj4mI1hZP
         ZAHoCBm8Ll7RVPVnFiVjca9fsLX6R54FXo1HDSkk0q98PqtX+zNNGCOUOoKYJkJ6rSUv
         xttzOYlxg5wGRHN6enkdZGMScY7b5Kc9m/MhpTHvZ7Lp366by3novn6lvk1XJOXfgdZQ
         Uw3wq5mwVrwSUy0HVsKSlMBzQXhXhxnkzBwTnBq0ShEed8aRXGLaaCFi8SRQvjkpXAXA
         d3Ow==
X-Gm-Message-State: AOJu0YwC2jTzl/q0dd/N4rzGOWz9rs+V4jiIGDNavhF3pBbw49+2l3jI
	UBqByuWZIyp63X7+vYrNYJ6nV4U1jiPuuHzQx5dzCGMy4E18D1LmbOwmSE/PiA==
X-Gm-Gg: AY/fxX741YesqpR+SRXiRSDrJRGHurT3R23KewrBlsBOObjK/CIo6v1jBT4tqas7q9F
	/ER5mFmsLwIOmx54FrbPDVlCVb0CjE9MGtkxVaGquIOnY4sFb65FVUuLYp69LIt1V15Ln6TTY3d
	vsNpRGfcygiHp0+QPorGlhN8MZijKFTcI5yuttYdZWxRpYZQKMdUa/d48hgJV0etOE/kf5mJA2p
	XXqvRpQ6+a7EbYfaqFJyHd5Hl8uJhw3Q9rQTzcyrc1dqFhf+VV5lEckWjfPxkq5WzKKteLq0Gdo
	NlFpkOyJaYFfEYeJLsoebO2/KnVUNct0acjSaQI7FQbQu0ad7tMkY0AX3xdz64MrmHCzhT+WIU9
	0R5anpZlvf3jpw8cs+YU9VO6vJGMX4dwv2Y4L+1/41m6Sdn5qWFWfcmHOsPXc2gk4tRAaT/pjva
	/f9PDDgFp7O3XY8/pmsbIyeoeBbX47RL0iYL5GDONwloVZbLgObcu9yUhQgoOSQ8USKz5ewy3jl
	ISqLUywPeiavqjFQcftwZb9Cuo=
X-Google-Smtp-Source: AGHT+IFDdy39fM3Jibw2IgpzDoVLds+8W0/OEEZMARNxYwSLGeVCStqTMZDj6m4Z3+OznpD/yLBjLQ==
X-Received: by 2002:a05:600c:444b:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47d1953b77fmr124546285e9.5.1766488305292;
        Tue, 23 Dec 2025 03:11:45 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227e0sm27932795f8f.17.2025.12.23.03.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 03:11:44 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 9/9] fetch-pack: wire up and enable auto filter logic
Date: Tue, 23 Dec 2025 12:11:13 +0100
Message-ID: <20251223111113.47473-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.319.gfcaffa7898
In-Reply-To: <20251223111113.47473-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous commits have set up an infrastructure for `--filter=auto` to
automatically prepare a partial clone filter based on what the server
advertised and the client accepted.

Using that infrastructure, let's now enable the `--filter=auto` option
in `git clone` and `git fetch` by setting `allow_auto_filter` to 1.

Note that these small changes mean that when `git clone --filter=auto`
or `git fetch --filter=auto` are used, "auto" is automatically saved
as the partial clone filter for the server on the client. Therefore
subsequent calls to `git fetch` on the client will automatically use
this "auto" mode even without `--filter=auto`.

Let's also set `allow_auto_filter` to 1 in `transport.c`, as the
transport layer must be able to accept the "auto" filter spec even if
the invoking command hasn't fully parsed it yet.

When an "auto" filter is requested, let's have the "fetch-pack.c" code
in `do_fetch_pack_v2()` compute a filter and send it to the server.

In `do_fetch_pack_v2()` the logic also needs to check for the
"promisor-remote" capability and call `promisor_remote_reply()` to
parse advertised remotes and populate the list of those accepted (and
their filters).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/fetch-options.adoc      | 19 ++++++---
 Documentation/git-clone.adoc          | 25 ++++++++---
 Documentation/gitprotocol-v2.adoc     | 16 ++++---
 builtin/clone.c                       |  2 +
 builtin/fetch.c                       |  2 +
 fetch-pack.c                          | 20 +++++++++
 t/t5710-promisor-remote-capability.sh | 60 +++++++++++++++++++++++++++
 transport.c                           |  1 +
 8 files changed, 130 insertions(+), 15 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 70a9818331..f7432d4b29 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -92,11 +92,20 @@ precedence over the `fetch.output` config option.
 	Use the partial clone feature and request that the server sends
 	a subset of reachable objects according to a given object filter.
 	When using `--filter`, the supplied _<filter-spec>_ is used for
-	the partial fetch. For example, `--filter=blob:none` will filter
-	out all blobs (file contents) until needed by Git. Also,
-	`--filter=blob:limit=<size>` will filter out all blobs of size
-	at least _<size>_. For more details on filter specifications, see
-	the `--filter` option in linkgit:git-rev-list[1].
+	the partial fetch.
++
+If `--filter=auto` is used, the filter specification is determined
+automatically by combining the filter specifications advertised by
+the server for the promisor remotes that the client accepts (see
+linkgit:gitprotocol-v2[5] and the `promisor.acceptFromServer`
+configuration option in linkgit:git-config[1]).
++
+For details on all other available filter specifications, see the
+`--filter=<filter-spec>` option in linkgit:git-rev-list[1].
++
+For example, `--filter=blob:none` will filter out all blobs (file
+contents) until needed by Git. Also, `--filter=blob:limit=<size>` will
+filter out all blobs of size at least _<size>_.
 
 ifndef::git-pull[]
 `--write-fetch-head`::
diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index 57cdfb7620..0db2d1e5f0 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -187,11 +187,26 @@ objects from the source repository into a pack in the cloned repository.
 	Use the partial clone feature and request that the server sends
 	a subset of reachable objects according to a given object filter.
 	When using `--filter`, the supplied _<filter-spec>_ is used for
-	the partial clone filter. For example, `--filter=blob:none` will
-	filter out all blobs (file contents) until needed by Git. Also,
-	`--filter=blob:limit=<size>` will filter out all blobs of size
-	at least _<size>_. For more details on filter specifications, see
-	the `--filter` option in linkgit:git-rev-list[1].
+	the partial clone filter.
++
+If `--filter=auto` is used the filter specification is determined
+automatically through the 'promisor-remote' protocol (see
+linkgit:gitprotocol-v2[5]) by combining the filter specifications
+advertised by the server for the promisor remotes that the client
+accepts (see the `promisor.acceptFromServer` configuration option in
+linkgit:git-config[1]). This allows the server to suggest the optimal
+filter for the available promisor remotes.
++
+As with other filter specifications, the "auto" value is persisted in
+the configuration. This ensures that future fetches will continue to
+adapt to the server's current recommendation.
++
+For details on all other available filter specifications, see the
+`--filter=<filter-spec>` option in linkgit:git-rev-list[1].
++
+For example, `--filter=blob:none` will filter out all blobs (file
+contents) until needed by Git. Also, `--filter=blob:limit=<size>` will
+filter out all blobs of size at least _<size>_.
 
 `--also-filter-submodules`::
 	Also apply the partial clone filter to any submodules in the repository.
diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index d93dd279ea..f985cb4c47 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -812,10 +812,15 @@ MUST appear first in each pr-fields, in that order.
 After these mandatory fields, the server MAY advertise the following
 optional fields in any order:
 
-`partialCloneFilter`:: The filter specification used by the remote.
+`partialCloneFilter`:: The filter specification for the remote. It
+corresponds to the "remote.<name>.partialCloneFilter" config setting.
 Clients can use this to determine if the remote's filtering strategy
-is compatible with their needs (e.g., checking if both use "blob:none").
-It corresponds to the "remote.<name>.partialCloneFilter" config setting.
+is compatible with their needs (e.g., checking if both use
+"blob:none"). Additionally they can use this through the
+`--filter=auto` option in linkgit:git-clone[1]. With that option, the
+filter specification of the clone will be automatically computed by
+combining the filter specifications of the promisor remotes the client
+accepts.
 
 `token`:: An authentication token that clients can use when
 connecting to the remote. It corresponds to the "remote.<name>.token"
@@ -828,8 +833,9 @@ future protocol extensions.
 
 The client can use information transmitted through these fields to
 decide if it accepts the advertised promisor remote. Also, the client
-can be configured to store the values of these fields (see
-"promisor.storeFields" in linkgit:git-config[1]).
+can be configured to store the values of these fields or use them
+to automatically configure the repository (see "promisor.storeFields"
+in linkgit:git-config[1] and `--filter=auto` in linkgit:git-clone[1]).
 
 Field values MUST be urlencoded.
 
diff --git a/builtin/clone.c b/builtin/clone.c
index 186e5498d4..41bbaea72a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1001,6 +1001,8 @@ int cmd_clone(int argc,
 		NULL
 	};
 
+	filter_options.allow_auto_filter = 1;
+
 	packet_trace_identity("clone");
 
 	repo_config(the_repository, git_clone_config, NULL);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b984173447..ddc30a0d30 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2439,6 +2439,8 @@ int cmd_fetch(int argc,
 		OPT_END()
 	};
 
+	filter_options.allow_auto_filter = 1;
+
 	packet_trace_identity("fetch");
 
 	/* Record the command line for the reflog */
diff --git a/fetch-pack.c b/fetch-pack.c
index 40316c9a34..12ccea0dab 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -35,6 +35,7 @@
 #include "sigchain.h"
 #include "mergesort.h"
 #include "prio-queue.h"
+#include "promisor-remote.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -1661,6 +1662,25 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
 	int i;
 	struct strvec index_pack_args = STRVEC_INIT;
+	const char *promisor_remote_config;
+
+	if (server_feature_v2("promisor-remote", &promisor_remote_config)) {
+		char *remote_name = promisor_remote_reply(promisor_remote_config);
+		free(remote_name);
+	}
+
+	if (args->filter_options.choice == LOFC_AUTO) {
+		struct strbuf errbuf = STRBUF_INIT;
+		char *constructed_filter = promisor_remote_construct_filter(r);
+
+		list_objects_filter_resolve_auto(&args->filter_options,
+						 constructed_filter, &errbuf);
+		if (errbuf.len > 0)
+			die(_("couldn't resolve 'auto' filter: %s"), errbuf.buf);
+
+		free(constructed_filter);
+		strbuf_release(&errbuf);
+	}
 
 	negotiator = &negotiator_alloc;
 	if (args->refetch)
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index a726af214a..21543bce20 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -409,6 +409,66 @@ test_expect_success "clone with promisor.storeFields=partialCloneFilter" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone and fetch with --filter=auto" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client trace" &&
+
+	git -C server config remote.lop.partialCloneFilter "blob:limit=9500" &&
+	test_config -C server promisor.sendFields "partialCloneFilter" &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
+		-c remote.lop.promisor=true \
+		-c remote.lop.url="file://$(pwd)/lop" \
+		-c promisor.acceptfromserver=All \
+		--no-local --filter=auto server client 2>err &&
+
+	test_grep "filter blob:limit=9500" trace &&
+	test_grep ! "filter auto" trace &&
+
+	# Verify "auto" is persisted in config
+	echo auto >expected &&
+	git -C client config remote.origin.partialCloneFilter >actual &&
+	test_cmp expected actual &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid" &&
+
+	# Now change the filter on the server
+	git -C server config remote.lop.partialCloneFilter "blob:limit=5678" &&
+
+	# Get a new commit on the server to ensure "git fetch" actually runs fetch-pack
+	test_commit -C template new-commit &&
+	git -C template push --all "$(pwd)/server" &&
+
+	# Perform a fetch WITH --filter=auto
+	rm -rf trace &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch --filter=auto &&
+
+	# Verify that the new filter was used
+	test_grep "filter blob:limit=5678" trace &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid" &&
+
+	# Change the filter on the server again
+	git -C server config remote.lop.partialCloneFilter "blob:limit=5432" &&
+
+	# Get yet a new commit on the server to ensure fetch-pack runs
+	test_commit -C template yet-a-new-commit &&
+	git -C template push --all "$(pwd)/server" &&
+
+	# Perform a fetch WITHOUT --filter=auto
+	# Relies on "auto" being persisted in the client config
+	rm -rf trace &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch &&
+
+	# Verify that the new filter was used
+	test_grep "filter blob:limit=5432" trace &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
 	git -C server config promisor.advertise true &&
 
diff --git a/transport.c b/transport.c
index c7f06a7382..cde8d83a57 100644
--- a/transport.c
+++ b/transport.c
@@ -1219,6 +1219,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		 */
 		struct git_transport_data *data = xcalloc(1, sizeof(*data));
 		list_objects_filter_init(&data->options.filter_options);
+		data->options.filter_options.allow_auto_filter = 1;
 		ret->data = data;
 		ret->vtable = &builtin_smart_vtable;
 		ret->smart_options = &(data->options);
-- 
2.52.0.319.gfcaffa7898

