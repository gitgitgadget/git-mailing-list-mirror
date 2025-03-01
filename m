Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FB2179BC
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740863248; cv=none; b=Rc41olE3iYrkjQjTHm+XlEv1y5GyyKXgGzFmotIrAoM2OWvgp+pATYUKDnnApaXge/2vfJ5l77HtUKU65Ww8tCBSci0KdsH63qkpZHseDurTeufFHd7uNVj50iqvkWQmJqy3P7U5GTpsYAiNY6IAxUOUt2hoVjH1TIicMF+6AIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740863248; c=relaxed/simple;
	bh=WsdD/eR1gsTyd4Svbz4kMRitk98bs39S7UPO/e/b5qQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=HDl3+T7jEsnf7g7GroP+hkAbqlo/RK4Odz+LrG6zS9nYqXkehfmgmgXpJ5dJBjIawJ3QoCf5y5A4POP8Za1oVBzxNBI0hkUKRbi40zRRXF/ISKGRYKSIS2eM3M4fMMFwU2Ddkg3S2ZzQ9MzTQwnon13E3z7dhzs7AWrWfbfzIfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpYKRdh3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpYKRdh3"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43998deed24so30645255e9.2
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 13:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740863244; x=1741468044; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dhObuEOqjXRsjNiTqSOcuNxXT4A5U/drG784mWBnAaA=;
        b=ZpYKRdh3Qz4eVctjEYlnUoVlXdV3eaYFGywbWZjRA7ZlpBZtpt+XK9Qa6HGmrLdkgG
         LEDStLbPYhjEPQVosV36FMG+FmOmfxK//M9cEoU8mQnnMGA1AknmBDTtjp0Ed8eY9F18
         A9pP4EcDkcSEuACKQp1XaAoHembM63lTSH/E5VHgiuy/msecCWCjoc1m1ZaXD6qyP64T
         TfqO8vB/YsvdVbtEGcfdCBNEETrP/rtPDOgCsDYsL4Eh34ZXzLWMTmhXW7RUm12DSrgu
         KWKdWDw33E39L61uWdmyYEbg32qhlaKQ27bg3iNaSgcfhQaw5kK79wOjN49YxqYhxYxK
         BnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740863244; x=1741468044;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dhObuEOqjXRsjNiTqSOcuNxXT4A5U/drG784mWBnAaA=;
        b=K9ouB7MgQ7FM5JXv4FqsDhKeTuyunynvEPuNhHBaFxuZiFoitOiiYXViIMqXA9R7b1
         57Ia9lc3jqCKreBJQpGMl2bjeuImUAeBv6GAPX+Vi9DMBB6O2xL6hKsOH3iHReYOfa5R
         rLSbCXnPw632K4xnRFoezHFCOXCqUzImliNM6DHH0JUdNcRN2+lUyvFP7kjmT9LmyufA
         TP5Ajx+GMh4n0tOqTxUKNdrV9B3JZoYvuEwMTj3QDrLgQK0eBiH07zGtPaez6NNCAEJE
         knBjnYeN2Ep2OVMq4/vbGkf0fCld75FnUXfj3q+xbAQbAVN3pmOxOo3PrTrjgPDCu8C6
         +DfA==
X-Gm-Message-State: AOJu0Yzys//5IteI5cHQrGWlhS4CJiJL2iLOErXHfl9MFPH/Scxl5ZkR
	/1Vz2nhKk/x4cFb06eA4+S1q+2DEEskZ9l5BFYIu25IVsFb/WZOi2Twi6w==
X-Gm-Gg: ASbGncvZSsQ3nwEbCnEN+t+591+clejJ61XW6ZDfwWy9cMGmumWqCKDhFwl7XeYFZgl
	YCxflqLxJ0+9TM05HAvEnDqrIhES0kJRZlT9DxVdc6j1p+Ucfz7f3CGLLkIRvSHbmK7XmLv0b7g
	zvwOIyWDozeKkVYy1qz0exRdOuWvbrge4FZm316tLaQYxFefd5+ozRzzlibUJbrkvs4KXMxyFf6
	2K81cTLWi29fEYTwhLDdv5kB5T4g2W/wdaEZoxME8bBvOsXUITTiEGA3lZMO3Xo8kofc+FuRw7s
	mXr+/Cl+DOy4ffdsrhMDQLfxaDsSDsOPfDOI4Zv9Zl4aew==
X-Google-Smtp-Source: AGHT+IHy0qUztePWZ+FhAeJxub2aSGA1e5TJRCWiA7wPr7qVqE3Co40QPfpgawa8VMRxKLCiksJfqw==
X-Received: by 2002:a05:600c:3b08:b0:439:94ef:3780 with SMTP id 5b1f17b1804b1-43ba6766e7amr75693385e9.30.1740863244046;
        Sat, 01 Mar 2025 13:07:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab2c4051bsm120859315e9.0.2025.03.01.13.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 13:07:23 -0800 (PST)
Message-Id: <pull.1869.git.1740863242815.gitgitgadget@gmail.com>
From: "John Giorshev via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 01 Mar 2025 21:07:22 +0000
Subject: [PATCH] add --must-filter option for fetch and clone
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    John Giorshev <john.giorshev1@gmail.com>,
    John Giorshev <john.giorshev1@gmail.com>

From: John Giorshev <john.giorshev1@gmail.com>

Signed-off-by: John Giorshev <john.giorshev1@gmail.com>
---
    add --must-filter, give error on filter not supported instead of warn
    
    from:
    https://public-inbox.org/git/20250225013227.GB752084@coredump.intra.peff.net/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1869%2Fjagprog5%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1869/jagprog5/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1869

 builtin/clone.c          |  6 ++++++
 builtin/fetch.c          |  7 ++++++-
 fetch-pack.c             |  8 ++++++--
 fetch-pack.h             |  1 +
 t/t0410-partial-clone.sh | 17 +++++++++++++++++
 transport.c              |  1 +
 transport.h              |  1 +
 7 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f9a2ecbe9cc..7000b0ecd36 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -887,6 +887,7 @@ int cmd_clone(int argc,
 	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
 	const int do_not_override_repo_unix_permissions = -1;
 	int option_reject_shallow = -1; /* unspecified */
+	int must_filter = 0;
 	int deepen = 0;
 	char *option_template = NULL, *option_depth = NULL, *option_since = NULL;
 	char *option_origin = NULL;
@@ -915,6 +916,8 @@ int cmd_clone(int argc,
 			 N_("force progress reporting")),
 		OPT_BOOL(0, "reject-shallow", &option_reject_shallow,
 			 N_("don't clone shallow repository")),
+		OPT_BOOL(0, "must-filter", &must_filter,
+			 N_("error on filter not supported by server")),
 		OPT_BOOL('n', "no-checkout", &option_no_checkout,
 			 N_("don't create a checkout")),
 		OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
@@ -1333,6 +1336,9 @@ int cmd_clone(int argc,
 	transport_set_verbosity(transport, option_verbosity, option_progress);
 	transport->family = family;
 	transport->cloning = 1;
+	if (transport->smart_options) {
+		transport->smart_options->must_filter = must_filter;
+	}
 
 	if (is_bundle) {
 		struct bundle_header header = BUNDLE_HEADER_INIT;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1c740d5aac3..1f3cdf53148 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -84,7 +84,7 @@ static int prune_tags = -1; /* unspecified */
 
 static int append, dry_run, force, keep, update_head_ok;
 static int write_fetch_head = 1;
-static int verbosity, deepen_relative, set_upstream, refetch;
+static int verbosity, deepen_relative, set_upstream, refetch, must_filter;
 static int progress = -1;
 static int tags = TAGS_DEFAULT, update_shallow, deepen;
 static int atomic_fetch;
@@ -1508,6 +1508,9 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 	transport = transport_get(remote, NULL);
 	transport_set_verbosity(transport, verbosity, progress);
 	transport->family = family;
+	if (transport->smart_options) {
+		transport->smart_options->must_filter = must_filter;
+	}
 	if (upload_pack)
 		set_option(transport, TRANS_OPT_UPLOADPACK, upload_pack);
 	if (keep)
@@ -2322,6 +2325,8 @@ int cmd_fetch(int argc,
 			 N_("append to .git/FETCH_HEAD instead of overwriting")),
 		OPT_BOOL(0, "atomic", &atomic_fetch,
 			 N_("use atomic transaction to update references")),
+		OPT_BOOL(0, "must-filter", &must_filter,
+			 N_("error on filter not supported by server")),
 		OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
 			   N_("path to upload pack on remote end")),
 		OPT__FORCE(&force, N_("force overwrite of local reference"), 0),
diff --git a/fetch-pack.c b/fetch-pack.c
index 1ed5e11dd56..0cf59c1bc82 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -319,9 +319,13 @@ static void send_filter(struct fetch_pack_args *args,
 			trace2_data_string("fetch", the_repository,
 					   "filter/effective", spec);
 		} else {
-			warning("filtering not recognized by server, ignoring");
-			trace2_data_string("fetch", the_repository,
+			if (args->must_filter) {
+				die("filtering not recognized by server");
+			} else {
+				warning("filtering not recognized by server, ignoring");
+				trace2_data_string("fetch", the_repository,
 					   "filter/unsupported", spec);
+			}
 		}
 	} else {
 		trace2_data_string("fetch", the_repository,
diff --git a/fetch-pack.h b/fetch-pack.h
index 9d3470366f8..01ab94fc24b 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -40,6 +40,7 @@ struct fetch_pack_args {
 	unsigned cloning:1;
 	unsigned update_shallow:1;
 	unsigned reject_shallow_remote:1;
+	unsigned must_filter:1;
 	unsigned deepen:1;
 	unsigned refetch:1;
 
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 2a5bdbeeb87..0166c491ca5 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -48,6 +48,23 @@ test_expect_success 'convert shallow clone to partial clone' '
 	test_cmp_config -C client 1 core.repositoryformatversion
 '
 
+test_expect_failure 'must filter clone' '
+	rm -fr server client &&
+	test_create_repo server &&
+	test_commit -C server my_commit 1 &&
+	test_commit -C server my_commit2 1 &&
+	git clone --filter="blob:none" --must-filter "file://$(pwd)/server" client
+'
+
+test_expect_failure 'must filter fetch' '
+	rm -fr server client &&
+	test_create_repo server &&
+	test_commit -C server my_commit 1 &&
+	test_commit -C server my_commit2 1 &&
+	git clone --depth=1 "file://$(pwd)/server" client &&
+	git -C client fetch --unshallow --filter="blob:none" --must-filter
+'
+
 test_expect_success DEFAULT_REPO_FORMAT 'convert to partial clone with noop extension' '
 	rm -fr server client &&
 	test_create_repo server &&
diff --git a/transport.c b/transport.c
index 6c2801bcbd9..0543821399d 100644
--- a/transport.c
+++ b/transport.c
@@ -450,6 +450,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.quiet = (transport->verbose < 0);
 	args.no_progress = !transport->progress;
 	args.depth = data->options.depth;
+	args.must_filter = data->options.must_filter;
 	args.deepen_since = data->options.deepen_since;
 	args.deepen_not = data->options.deepen_not;
 	args.deepen_relative = data->options.deepen_relative;
diff --git a/transport.h b/transport.h
index 44100fa9b7f..0ffc8d273ab 100644
--- a/transport.h
+++ b/transport.h
@@ -16,6 +16,7 @@ struct git_transport_options {
 	unsigned reject_shallow : 1;
 	unsigned deepen_relative : 1;
 	unsigned refetch : 1;
+	unsigned must_filter : 1;
 
 	/* see documentation of corresponding flag in fetch-pack.h */
 	unsigned from_promisor : 1;

base-commit: a554262210b4a2ee6fa2d594e1f09f5830888c56
-- 
gitgitgadget
