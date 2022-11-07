Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E426C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiKGSg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiKGSgM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:12 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70930209B5
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:11 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z14so17564971wrn.7
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqzRpn/q6peZiy2Tiiqul2t5ioB1w1wUwPSftwG+4Y8=;
        b=S/kAtHIierTE22qAQ1IG5QM8b9OJDYOKr4HLJ7Fgg0Pme0M6a7TTh/qhRFvlHa+UZh
         U2ynZNc5thlnGoQKpjPW2diIqCe8jQl106QfG+QHl6fIAOb5uUDfWS8D0denGbCR+z6d
         g6v9SXpFJNFIS0iN2AqeIXDq2YOEPkUvvAtj6JLSC1DQ3PPwUVuM9+3i4eslXNC1b/M5
         v1dxPsQWRlNVkXVSPBnIltwUUJBUzNMnWmGMsVSf9o7Vxm7MvMYJUNYupGZ0sH7HSxtc
         7DJwQZsxC8PuzHyAeHSoR+v4Z0D0Frpi0Em1Fb3gwlj47JjgR30WaiRbPO309emJQcIC
         M+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqzRpn/q6peZiy2Tiiqul2t5ioB1w1wUwPSftwG+4Y8=;
        b=lhrMH8Lq+RRAhHfjKeyz4uaFOBlFesokRoQl06hmGbhLqgJXGWxgxoxwyu26zShkO4
         kXOW0XfRyRvt7QH9j03On1cyAU2mZeDo/5U9HWxSOCx1P7/8L0x8yaK+7zjYm2B/+0SF
         zynOyytSUfkTAL8iLgVjRc4QT5KEDNFmTHgpUMo6Y0lPPht+7ms1p3+cQ3hPqtvuAUm8
         dRErC64xFGFShRxpxVrVtwsb43QNYXRfklepZnRry6ysjOsGOBG82sYdcQHViQF6Ppz5
         zGLMEdKPHY3o3aZ6NQD7RKpAyiaQ1B71TFM7v6cCkjo254DC183u94JhpSjxgSmbrQ6V
         JNTQ==
X-Gm-Message-State: ACrzQf0dhG/Rq2G63gCuyFfdsglZFhHjIbLIf0AT29qHuB59y5aPq6ez
        NJMCcumil7QjEdS39IxA5IOPE+a/ixM=
X-Google-Smtp-Source: AMsMyM6vrfsgRWTyNStuUzyl51zzqj2wx3R9GPWoGZIu/lre1gA0tW1/RqgH9xZaDtO2u3mGtcTxiw==
X-Received: by 2002:a05:6000:1042:b0:236:f509:1dc3 with SMTP id c2-20020a056000104200b00236f5091dc3mr18555041wrx.313.1667846169632;
        Mon, 07 Nov 2022 10:36:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18-20020a056000125200b0023677fd2657sm7826542wrx.52.2022.11.07.10.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:09 -0800 (PST)
Message-Id: <4013f992d15aab69346bf6f8eafe38511b923595.1667846164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:37 +0000
Subject: [PATCH 03/30] extensions: add refFormat extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Git's reference storage is critical to its function. Creating new
storage formats for references requires adding an extension. This
prevents third-party tools that do not understand that format from
operating incorrectly on the repository. This makes updating ref formats
more difficult than other optional indexes, such as the commit-graph or
multi-pack-index.

However, there are a number of potential ref storage enhancements that
are underway or could be created. Git needs an established mechanism for
coordinating between these different options.

The first obvious format update is the reftable format as documented in
Documentation/technical/reftable.txt. This format has much of its
implementation already in Git, but its connection as a ref backend is
not complete. This change is similar to some changes within one of the
patches intended for the reftable effort [1].

[1] https://lore.kernel.org/git/pull.1215.git.git.1644351400761.gitgitgadget@gmail.com/

However, this change makes a distinct strategy change from the one
recommended by reftable. Here, the extensions.refFormat extension is
provided as a multi-valued list. In the reftable RFC, the extension has
a single value, "files" or "reftable" and explicitly states that this
should not change after 'git init' or 'git clone'.

The single-valued approach has some major drawbacks, including the idea
that the "files" backend cannot coexist with the "reftable" backend at
the same time. In this way, it would not be possible to create a
repository that can write loose references and combine them into a
reftable in the background. With the multi-valued approach, we could
integrate reftable as a drop-in replacement for the packed-refs file and
allow that to be a faster way to do the integration since the test suite
would only need updates when the test is explicitly testing packed-refs.

When upgrading a repository from the "files" backend to the "reftable"
backend, it can help to have a transition period where both are present,
then finally removing the "files" backend after all loose refs are
collected into the reftable.

But the reftable is not the only approach available.

One obvious improvement could be a new file format version for the
packed-refs file. Its current plaintext-based format is inefficient due
to storing object IDs as hexadecimal representations instead of in
their raw format. This extra cost will get worse with SHA-256. In
addition, binary searches need to guess a position and scan to find
newlines for a refname entry. A structured binary format could allow for
more compact representation and faster access. Adding such a format
could be seen as "files-v2", but it is really "packed-v2".

The reftable approach has a concept of a "stack" of reftable files. This
idea would also work for a stack of packed-refs files (in v1 or v2
format). It would be helpful to describe that the refs could be stored
in a stack of packed-ref files independently of whether that is in file
format v1 or v2.

Even in these two options, it might be helpful to indicate whether or
not loose ref files are present. That is one reason to not make them
appear as "files-v2" or "files-v3" options in a single-valued extension.
Even as "packed-v2" or "packed-v3" options, this approach would require
third-party tools to understand the "v2" version if they want to support
the "v3" options. Instead, by splitting the format from the layout, we
can allow third-party tools to integrate only with the most-desired
format options.

For these reasons, this change is defining the extensions.refFormat
extension as well as how the two existing values interact. By default,
Git will assume "files" and "packed" in the list. If any other value
is provided, then the extension is marked as unrecognized.

Add tests that check the behavior of extensions.refFormat, both in that
it requires core.repositoryFormatVersion=1, and Git will refuse to work
with an unknown value of the extension.

There is a gap in the current implementation, though. What happens if
exactly one of "files" or "packed" is provided? The presence of only one
would imply that the other is not available. A later change can
communicate the list contents to the repository struct and then the
reference backend could ignore one of these two layers.

Specifically, having only "files" would mean that Git should not read or
write the packed-refs file and instead only read and write loose ref
files. By contrast, having only "packed" would mean that Git should not
read or write loose ref files and instead always update the packed-refs
file on every ref update.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/extensions.txt | 41 +++++++++++++++++++++++++++++
 setup.c                             |  5 ++++
 t/t3212-ref-formats.sh              | 27 +++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100755 t/t3212-ref-formats.sh

diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
index bccaec7a963..ce8185adf53 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -7,6 +7,47 @@ Note that this setting should only be set by linkgit:git-init[1] or
 linkgit:git-clone[1].  Trying to change it after initialization will not
 work and will produce hard-to-diagnose issues.
 
+extensions.refFormat::
+	Specify the reference storage mechanisms used by the repoitory as a
+	multi-valued list. The acceptable values are `files` and `packed`.
+	If not specified, the list of `files` and `packed` is assumed. It
+	is an error to specify this key unless `core.repositoryFormatVersion`
+	is 1.
++
+As new ref formats are added, Git commands may modify this list before and
+after upgrading the on-disk reference storage files. The specific values
+indicate the existence of different layers:
++
+--
+`files`;;
+	When present, references may be stored as "loose" reference files
+	in the `$GIT_DIR/refs/` directory. The name of the reference
+	corresponds to the filename after `$GIT_DIR` and the file contains
+	an object ID as a hexadecimal string. If a loose reference file
+	exists, then its value takes precedence over all other formats.
+
+`packed`;;
+	When present, references may be stored as a group in a
+	`packed-refs` file in its version 1 format. When grouped with
+	`"files"` or provided on its own, this file is located at
+	`$GIT_DIR/packed-refs`. This file contains a list of distinct
+	reference names, paired with their object IDs. When combined with
+	`files`, the `packed` format will only be used to group multiple
+	loose object files upon request via the `git pack-refs` command or
+	via the `pack-refs` maintenance task.
+--
++
+The following combinations are supported by this version of Git:
++
+--
+`files` and `packed`;;
+	This set of values indicates that references are stored both as
+	loose reference files and in the `packed-refs` file in its v1
+	format. Loose references are preferred, and the `packed-refs` file
+	is updated only when deleting a reference that is stored in the
+	`packed-refs` file or during a `git pack-refs` command.
+--
+
 extensions.worktreeConfig::
 	If enabled, then worktrees will load config settings from the
 	`$GIT_DIR/config.worktree` file in addition to the
diff --git a/setup.c b/setup.c
index cefd5f63c46..f5eb50c969a 100644
--- a/setup.c
+++ b/setup.c
@@ -577,6 +577,11 @@ static enum extension_result handle_extension(const char *var,
 				     "extensions.objectformat", value);
 		data->hash_algo = format;
 		return EXTENSION_OK;
+	} else if (!strcmp(ext, "refformat")) {
+		if (strcmp(value, "files") && strcmp(value, "packed"))
+			return error(_("invalid value for '%s': '%s'"),
+				     "extensions.refFormat", value);
+		return EXTENSION_OK;
 	}
 	return EXTENSION_UNKNOWN;
 }
diff --git a/t/t3212-ref-formats.sh b/t/t3212-ref-formats.sh
new file mode 100755
index 00000000000..bc554e7c701
--- /dev/null
+++ b/t/t3212-ref-formats.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='test across ref formats'
+
+. ./test-lib.sh
+
+test_expect_success 'extensions.refFormat requires core.repositoryFormatVersion=1' '
+	test_when_finished rm -rf broken &&
+
+	# Force sha1 to ensure GIT_TEST_DEFAULT_HASH does
+	# not imply a value of core.repositoryFormatVersion.
+	git init --object-format=sha1 broken &&
+	git -C broken config extensions.refFormat files &&
+	test_must_fail git -C broken status 2>err &&
+	grep "repo version is 0, but v1-only extension found" err
+'
+
+test_expect_success 'invalid extensions.refFormat' '
+	test_when_finished rm -rf broken &&
+	git init broken &&
+	git -C broken config core.repositoryFormatVersion 1 &&
+	git -C broken config extensions.refFormat bogus &&
+	test_must_fail git -C broken status 2>err &&
+	grep "invalid value for '\''extensions.refFormat'\'': '\''bogus'\''" err
+'
+
+test_done
-- 
gitgitgadget

