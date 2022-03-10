Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0523C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 22:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbiCJWol (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344396AbiCJWoe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 17:44:34 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6173A4
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:43:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so4348783wmq.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5NNW0FbavEj2yXOFUjt6PGyxIlD+hPEoObXt6SjaOHs=;
        b=Ml08Yf04ONKK+I2psy53oOMFl3pz64zoQxQ8P+JZy0x8k13jN0PmpB4+6txW6zJOWQ
         lP8obkBwlsWc/RtiEt6RuS7dlETGNc8aVYlDviwi3uIQDu7k+30q8Apuy/iQjlKlfOcZ
         LCkgH2N0F6wz8jUD2FDNP7XcgDmb9U/ymULnjkndtzlKl97WvUL+GORUd/km1UYhZVIe
         9KX5RfzkYQvKrXyKWAObm0p5mD2JyiZPVRjLxUfygTGHr9b0wE3l60SgbAS1BQ5Xzitn
         RNEJfeaU9Lf4uMZMaDGeTGBakyrEUf3v6iyozQYRpqNB2i3Co+VgVDfDIMK9Z1BEbK8Z
         Wdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5NNW0FbavEj2yXOFUjt6PGyxIlD+hPEoObXt6SjaOHs=;
        b=5D9O/kHWaGOY5aPkZIc6qcvbMatBDg9PhweK7knMfilvknQ1/I7QYvQ7cB54mgRgtF
         0wJkGZYCXlzV+ZYS6nPjQh6SOOJN5/sOEVzSN81GQw4St7tReXttdUsCMDkj7go+G11+
         DH3cJ0yMMzztMy6UJyeUlHWBmS6Hfzg8YiDVTfbMmoN4taWdu2vELRW175iczcjpt/2Q
         q/tuPczPH8BxdsJw5G3sup5caTjcam8h8NbYQM0F9Q6g+VVw87ealjGB0bz1w+k8b4yF
         lDisrCev45sYXdedA36vBwJleEX9cJefoV9UUMJgHiUaUx9niur1wSw9otR5p2A4koEK
         6vUw==
X-Gm-Message-State: AOAM531XjOdN8kykbbCGTI+VyLG2K51lFa0QHCXalZFsQJdvUTlNNccq
        JfqFbz9gut+xxbV3DvZoMguLJ4Ez/sw=
X-Google-Smtp-Source: ABdhPJxzb/oWOO3ccIkbStURt5SaI4ymaET5dS4ynjSw8IF9fm6BvBRYOGDg0iMNmx3LtXWynxpcJA==
X-Received: by 2002:a05:600c:4a12:b0:389:9c7d:5917 with SMTP id c18-20020a05600c4a1200b003899c7d5917mr5273008wmp.0.1646952211014;
        Thu, 10 Mar 2022 14:43:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8-20020a056000114800b001f045f3435asm7180570wrx.108.2022.03.10.14.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:43:30 -0800 (PST)
Message-Id: <6adc8dc13852c219763a9830f848fbc8663f2fa9.1646952205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 22:43:22 +0000
Subject: [PATCH v6 4/6] core.fsync: add configuration parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

This change introduces code to parse the core.fsync setting and
configure the fsync_components variable.

core.fsync is configured as a comma-separated list of component names to
sync. Each time a core.fsync variable is encountered in the
configuration heirarchy, we start off with a clean state with the
platform default value. Passing 'none' resets the value to indicate
nothing will be synced. We gather all negative and positive entries from
the comma separated list and then compute the new value by removing all
the negative entries and adding all of the positive entries.

We issue a warning for components that are not recognized so that the
configuration code is compatible with configs from future versions of
Git with more repo components.

Complete documentation for the new setting is included in a later patch
in the series so that it can be reviewed once in final form.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 Documentation/config/core.txt |  9 +++--
 config.c                      | 76 +++++++++++++++++++++++++++++++++++
 environment.c                 |  2 +-
 3 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index dbb134f7136..ab911d6e269 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -558,11 +558,12 @@ core.fsyncMethod::
 
 core.fsyncObjectFiles::
 	This boolean will enable 'fsync()' when writing object files.
+	This setting is deprecated. Use core.fsync instead.
 +
-This is a total waste of time and effort on a filesystem that orders
-data writes properly, but can be useful for filesystems that do not use
-journalling (traditional UNIX filesystems) or that only journal metadata
-and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
+This setting affects data added to the Git repository in loose-object
+form. When set to true, Git will issue an fsync or similar system call
+to flush caches so that loose-objects remain consistent in the face
+of a unclean system shutdown.
 
 core.preloadIndex::
 	Enable parallel index preload for operations like 'git diff'
diff --git a/config.c b/config.c
index f3ff80b01c9..94a4598b5fc 100644
--- a/config.c
+++ b/config.c
@@ -1323,6 +1323,73 @@ static int git_parse_maybe_bool_text(const char *value)
 	return -1;
 }
 
+static const struct fsync_component_name {
+	const char *name;
+	enum fsync_component component_bits;
+} fsync_component_names[] = {
+	{ "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
+	{ "pack", FSYNC_COMPONENT_PACK },
+	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
+	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
+};
+
+static enum fsync_component parse_fsync_components(const char *var, const char *string)
+{
+	enum fsync_component current = FSYNC_COMPONENTS_DEFAULT;
+	enum fsync_component positive = 0, negative = 0;
+
+	while (string) {
+		int i;
+		size_t len;
+		const char *ep;
+		int negated = 0;
+		int found = 0;
+
+		string = string + strspn(string, ", \t\n\r");
+		ep = strchrnul(string, ',');
+		len = ep - string;
+		if (!strcmp(string, "none")) {
+			current = FSYNC_COMPONENT_NONE;
+			goto next_name;
+		}
+
+		if (*string == '-') {
+			negated = 1;
+			string++;
+			len--;
+			if (!len)
+				warning(_("invalid value for variable %s"), var);
+		}
+
+		if (!len)
+			break;
+
+		for (i = 0; i < ARRAY_SIZE(fsync_component_names); ++i) {
+			const struct fsync_component_name *n = &fsync_component_names[i];
+
+			if (strncmp(n->name, string, len))
+				continue;
+
+			found = 1;
+			if (negated)
+				negative |= n->component_bits;
+			else
+				positive |= n->component_bits;
+		}
+
+		if (!found) {
+			char *component = xstrndup(string, len);
+			warning(_("ignoring unknown core.fsync component '%s'"), component);
+			free(component);
+		}
+
+next_name:
+		string = ep;
+	}
+
+	return (current & ~negative) | positive;
+}
+
 int git_parse_maybe_bool(const char *value)
 {
 	int v = git_parse_maybe_bool_text(value);
@@ -1600,6 +1667,13 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.fsync")) {
+		if (!value)
+			return config_error_nonbool(var);
+		fsync_components = parse_fsync_components(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.fsyncmethod")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -1613,6 +1687,8 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "core.fsyncobjectfiles")) {
+		if (fsync_object_files < 0)
+			warning(_("core.fsyncobjectfiles is deprecated; use core.fsync instead"));
 		fsync_object_files = git_config_bool(var, value);
 		return 0;
 	}
diff --git a/environment.c b/environment.c
index 36ca5fb2e77..698f03a2f47 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,7 @@ const char *git_attributes_file;
 const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
-int fsync_object_files;
+int fsync_object_files = -1;
 int use_fsync = -1;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
-- 
gitgitgadget

