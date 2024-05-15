Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943D86130
	for <git@vger.kernel.org>; Wed, 15 May 2024 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779564; cv=none; b=HVEJjtozo8rKWML7ZtvRo3lz9nfCA9GQuVw3OyYGed+1X4gKbc2QGdLRCBNdu1Khw2iVCpixVHwinlMuQQ82O49OOcKad9kBUUcEmvOtAA/RGywrW+Ofh6tn0K4VTDgctqJSy3vQl1CcIk//LankS74oIjN/k3FHXYEjH2I9hUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779564; c=relaxed/simple;
	bh=REoIPoe24jdwxjxkeG2CYZAOTqz3du3DXTf4krpNuZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfNtTIaUjm6x2zLXZHQET9o0yj2pRKKKoGKtM6+MWcjmKfov/gN7fw2/0uAtVIIdKUKStU10nnmpIksataSASXrLD2R4KtJfKnODVHFghemJLTpOFNGBdafkgLfHThWHfs4xEfpgwgR+7jFav1vk+4/S9kCxVG1V6SwQd77rznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWj92axW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWj92axW"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-420180b5838so22215535e9.2
        for <git@vger.kernel.org>; Wed, 15 May 2024 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715779560; x=1716384360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K++TS67hHUmVSqDEzgjYWpQZqD4sAfrDB03HxcdpZiY=;
        b=AWj92axWXaNbC4i5S+qi4CjULLpP6xlzlZG4VbzoEU1SGdhl11BlnHQynV3LK/FTMk
         e9U347zI40meOVFFwu2f/sDAiZv46i6IrNvQ2W8RuwRKxYOFeBi6PNJQ8sj+vMs+P5f2
         YUzY6GnmGQiG2XEZTmKZGPjKMaZTFXogVAOtjbjjymlxBU2fUYylTWqHV6t11KWFORqZ
         P2G5aHPEg24Om5+mjxXgf2wwCByHAF513Nh3o5UCykNDanf70QuQROBnVJMATKG96uYG
         FU5Lb4rYSFiq8cSolhItD4nMHgrNZ+uCfDKxtwfzuH9l17ftxTdDlqGC7LZpCdi4LDRB
         Djkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715779560; x=1716384360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K++TS67hHUmVSqDEzgjYWpQZqD4sAfrDB03HxcdpZiY=;
        b=P/RvtEXRAPd17udoWhluGuDbU/t5T57SGToAoy2+eIJLG7Mab9mv/uURFX4gnmX8Y/
         wGNGGq8PPVncTj8DtA9/FgcFXRK776bG1miPOsyrJ5XaC3Ti0M4aozImpf08hiEry8kq
         jx+PlHwfXlDDfh4misT5oV1yYh/5Svv4tcNjHaAjzP3YhoO0OvFO8XiJofD+hQyjXSgj
         SNuHSGAlzaDLfHYZGVs6b9ZK3Mul16O9JD3CumywuU+wSr4WoZ8Ps0ZIflORy4L+HnUN
         yjjLtk/YCOIv7nOs5Q6xTTb61ygn4zM9Xu5wiz7tcEzYy6miVa/FVJWiVp/tH5SwxcZO
         VI1A==
X-Gm-Message-State: AOJu0YwJr60nugArwRroMEnojrKS+VFzrWfGBGGZU0AA08SHt4ti4S6i
	16LNDi18xLChYRQT3+fP4uzraCTW9URxQnMVtz0+LO3xNVrVRY+rLiM75A==
X-Google-Smtp-Source: AGHT+IHjPP8+Tc2BbatE5Mwvm31E60267vdBcaFGZrEg0bgOLaHHx9b14bvL0gxFZQYvV0U/IKrhGg==
X-Received: by 2002:a05:600c:45c5:b0:41b:935:2492 with SMTP id 5b1f17b1804b1-41fead6443fmr185200685e9.36.1715779560162;
        Wed, 15 May 2024 06:26:00 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4201592e5f3sm117171695e9.43.2024.05.15.06.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 06:25:59 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/3] upload-pack: allow configuring a missing-action
Date: Wed, 15 May 2024 15:25:43 +0200
Message-ID: <20240515132543.851987-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.45.1.148.g0f5efb064b
In-Reply-To: <20240515132543.851987-1-christian.couder@gmail.com>
References: <20221012135114.294680-1-christian.couder@gmail.com>
 <20240515132543.851987-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Couder <chriscool@tuxfamily.org>

In case some objects are missing from a server, it might still be
useful to be able to fetch or clone from it if the client already has
the missing objects or can get them in some way.

For example, in case both the server and the client are using a
separate promisor remote that contain some objects, it can be better
if the server doesn't try to send such objects back to the client, but
instead let the client get those objects separately from the promisor
remote. (The client needs to have the separate promisor remote
configured, for that to work.)

Another example could be a server where some objects have been
corrupted or deleted. It could still be useful for clients who could
get those objects from another source, like perhaps a different
client, to be able to fetch or clone from the server.

To configure what a server should do if there are such missing
objects, let's teach `git upload-pack` a new
`uploadpack.missingAction` configuration variable.

This new missing-action works in a similar way as what `git rev-list`
and `git pack-objects` already support with their
`--missing=<missing-action>` command line options. In fact when
`uploadpack.missingAction` is set to something different than "error",
`git upload-pack` will just pass the corresponding
`--missing=<missing-action>` to `git pack-objects`.

So this new missing-action has the same limitations as
`git pack-objects --missing=<missing-action>`. Especially when not
using promisor remotes, 'allow-any' works only for blobs.

Another limitation comes from `git upload-pack` itself which requires
setting `GIT_NO_LAZY_FETCH` to 0 since 7b70e9efb1 (upload-pack:
disable lazy-fetching by default, 2024-04-16) for lazy fetching from
a promisor remote to work on the server side.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/uploadpack.txt |   9 ++
 missing.c                           |  16 ++++
 missing.h                           |   2 +
 t/t5706-upload-pack-missing.sh      | 125 ++++++++++++++++++++++++++++
 upload-pack.c                       |  19 +++++
 5 files changed, 171 insertions(+)
 create mode 100755 t/t5706-upload-pack-missing.sh

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
index 16264d82a7..cd70e853b3 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -82,3 +82,12 @@ uploadpack.allowRefInWant::
 	is intended for the benefit of load-balanced servers which may
 	not have the same view of what OIDs their refs point to due to
 	replication delay.
+
+uploadpack.missingAction::
+	If this option is set, `upload-pack` will call
+	linkgit:git-pack-objects[1] passing it the corresponding
+	`--missing=<missing-action>` command line option. See the
+	documentation for that option, to see the valid values and
+	their meaning. This could be useful if some objects are
+	missing on a server, but a client already has them or could
+	still get them from somewhere else.
diff --git a/missing.c b/missing.c
index ce3cf734a8..75036d2089 100644
--- a/missing.c
+++ b/missing.c
@@ -18,3 +18,19 @@ int parse_missing_action_value(const char *value)
 
 	return -1;
 }
+
+const char *missing_action_to_string(enum missing_action action)
+{
+	switch (action) {
+	case MA_ERROR:
+		return "error";
+	case MA_ALLOW_ANY:
+		return "allow-any";
+	case MA_PRINT:
+		return "print";
+	case MA_ALLOW_PROMISOR:
+		return "allow-promisor";
+	default:
+		BUG("invalid missing action %d", action);
+	}
+}
diff --git a/missing.h b/missing.h
index 1e378d6215..74753d7887 100644
--- a/missing.h
+++ b/missing.h
@@ -14,4 +14,6 @@ enum missing_action {
 */
 int parse_missing_action_value(const char *value);
 
+const char *missing_action_to_string(enum missing_action action);
+
 #endif /* MISSING_H */
diff --git a/t/t5706-upload-pack-missing.sh b/t/t5706-upload-pack-missing.sh
new file mode 100755
index 0000000000..0f39c0ddd0
--- /dev/null
+++ b/t/t5706-upload-pack-missing.sh
@@ -0,0 +1,125 @@
+#!/bin/sh
+
+test_description='handling of missing objects in upload-pack'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+# Setup the repository with three commits, this way HEAD is always
+# available and we can hide commit 1 or 2.
+test_expect_success 'setup: create "template" repository' '
+	git init template &&
+	test_commit -C template 1 &&
+	test_commit -C template 2 &&
+	test_commit -C template 3 &&
+	test-tool genrandom foo 10240 >template/foo &&
+	git -C template add foo &&
+	git -C template commit -m foo
+'
+
+# A bare repo will act as a server repo with unpacked objects.
+test_expect_success 'setup: create bare "server" repository' '
+	git clone --bare --no-local template server &&
+	mv server/objects/pack/pack-* . &&
+	packfile=$(ls pack-*.pack) &&
+	git -C server unpack-objects --strict <"$packfile"
+'
+
+# Fetching with 'uploadpack.missingAction=allow-any' only works with
+# blobs, as `git pack-objects --missing=allow-any` fails if a missing
+# object is not a blob.
+test_expect_success "fetch with uploadpack.missingAction=allow-any" '
+	oid="$(git -C server rev-parse HEAD:1.t)" &&
+	oid_path="$(test_oid_to_path $oid)" &&
+	path="server/objects/$oid_path" &&
+
+	mv "$path" "$path.hidden" &&
+	test_when_finished "mv $path.hidden $path" &&
+
+	git init client &&
+	test_when_finished "rm -rf client" &&
+
+	# Client needs the missing objects to be available somehow
+	client_path="client/.git/objects/$oid_path" &&
+	mkdir -p $(dirname "$client_path") &&
+	cp "$path.hidden" "$client_path" &&
+
+	test_must_fail git -C client fetch ../server &&
+	git -C server config uploadpack.missingAction error &&
+	test_must_fail git -C client fetch ../server &&
+	git -C server config uploadpack.missingAction allow-any &&
+	git -C client fetch ../server &&
+	git -C server config --unset uploadpack.missingAction
+'
+
+check_missing_objects () {
+	git -C "$1" rev-list --objects --all --missing=print > all.txt &&
+	sed -n "s/^\?\(.*\)/\1/p" <all.txt >missing.txt &&
+	test_line_count = "$2" missing.txt &&
+	test "$3" = "$(cat missing.txt)"
+}
+
+test_expect_success "setup for testing uploadpack.missingAction=allow-promisor" '
+	# Create another bare repo called "server2"
+	git init --bare server2 &&
+
+	# Copy the largest object from server to server2
+	obj="HEAD:foo" &&
+	oid="$(git -C server rev-parse $obj)" &&
+	oid_path="$(test_oid_to_path $oid)" &&
+	path="server/objects/$oid_path" &&
+	path2="server2/objects/$oid_path" &&
+	mkdir -p $(dirname "$path2") &&
+	cp "$path" "$path2" &&
+
+	# Repack everything first
+	git -C server -c repack.writebitmaps=false repack -a -d &&
+
+	# Repack without the largest object and create a promisor pack on server
+	git -C server -c repack.writebitmaps=false repack -a -d \
+	    --filter=blob:limit=5k --filter-to="$(pwd)" &&
+	promisor_file=$(ls server/objects/pack/*.pack | sed "s/\.pack/.promisor/") &&
+	> "$promisor_file" &&
+
+	# Check that only one object is missing on the server
+	check_missing_objects server 1 "$oid" &&
+
+	# Configure server2 as promisor remote for server
+	git -C server remote add server2 "file://$(pwd)/server2" &&
+	git -C server config remote.server2.promisor true &&
+
+	git -C server2 config uploadpack.allowFilter true &&
+	git -C server2 config uploadpack.allowAnySHA1InWant true &&
+	git -C server config uploadpack.allowFilter true &&
+	git -C server config uploadpack.allowAnySHA1InWant true
+'
+
+test_expect_success "fetch with uploadpack.missingAction=allow-promisor" '
+	git -C server config uploadpack.missingAction allow-promisor &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
+		-c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
+		-c remote.server2.url="file://$(pwd)/server2" \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "fetch without uploadpack.missingAction=allow-promisor" '
+	git -C server config --unset uploadpack.missingAction &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
+		-c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
+		-c remote.server2.url="file://$(pwd)/server2" \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is not missing on the server anymore
+	check_missing_objects server 0 ""
+'
+
+test_done
diff --git a/upload-pack.c b/upload-pack.c
index 902144b9d3..f114f92197 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -29,6 +29,8 @@
 #include "write-or-die.h"
 #include "json-writer.h"
 #include "strmap.h"
+#include "missing.h"
+#include "object-file.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -96,6 +98,8 @@ struct upload_pack_data {
 
 	const char *pack_objects_hook;
 
+	enum missing_action missing_action;
+
 	unsigned stateless_rpc : 1;				/* v0 only */
 	unsigned no_done : 1;					/* v0 only */
 	unsigned daemon_mode : 1;				/* v0 only */
@@ -315,6 +319,9 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		strvec_push(&pack_objects.args, "--delta-base-offset");
 	if (pack_data->use_include_tag)
 		strvec_push(&pack_objects.args, "--include-tag");
+	if (pack_data->missing_action)
+		strvec_pushf(&pack_objects.args, "--missing=%s",
+			     missing_action_to_string(pack_data->missing_action));
 	if (pack_data->filter_options.choice) {
 		const char *spec =
 			expand_list_objects_filter_spec(&pack_data->filter_options);
@@ -1371,6 +1378,18 @@ static int upload_pack_config(const char *var, const char *value,
 		precomposed_unicode = git_config_bool(var, value);
 	} else if (!strcmp("transfer.advertisesid", var)) {
 		data->advertise_sid = git_config_bool(var, value);
+	} else if (!strcmp("uploadpack.missingaction", var)) {
+		int res = parse_missing_action_value(value);
+		if (res < 0 || (res != MA_ERROR &&
+				res != MA_ALLOW_ANY &&
+				res != MA_ALLOW_PROMISOR))
+			die(_("invalid value for '%s': '%s'"), var, value);
+		/* Allow fetching only from promisor remotes */
+		if (res == MA_ALLOW_PROMISOR)
+			fetch_if_missing = 1;
+		if (res == MA_ALLOW_ANY)
+			fetch_if_missing = 0;
+		data->missing_action = res;
 	}
 
 	if (parse_object_filter_config(var, value, ctx->kvi, data) < 0)
-- 
2.45.1.148.g0f5efb064b

