Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE253343D86
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195529; cv=none; b=V0AGd+ckkGr+j+glwob1PRUOUEwBlxq+MhavVSM0nDDLtu3lcOqvVFeRbk795czlk3CcyiFVmAyQPtGMRElzSqsia5i5Xq/vOlWMNWDrGnQQvdvKFPPaEqwe04IOcnmAO/P4Aux5qAmfmyWewr+s7esspxH2FLRft4/34gRbBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195529; c=relaxed/simple;
	bh=cMw5YRU8/wpNZePtA4H2Qwb8avKuz7F46loCgHGT3z8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eqF1U+a9JljPDtpP+t9OgAIgvQBhulCd7J8QBsCC83buTxzYDMg5YD1YjEFqw8DvAetSuzSPyx4RtfPI7MY7drYohcjIKALPT06rQy+rhOTXu5zEt5rVV4dKDWa7ozzVEPtfKaglQg2iL3n8MQ2Dauct72gOrKzozX0wgTfM4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTE9SADU; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTE9SADU"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-882399d60baso1928476d6.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 14:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764195526; x=1764800326; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/Gyk1aI8bDpsLxLGEAORUB0we2oIcN7twMnOglf+8c=;
        b=aTE9SADUb0yFkz5ZebbHHs06dJ37z1zuuWAmafYXMFJl1K9QS0D8OMO4j14IAXgXxm
         gBiRFq+p/AOcKui5EdUZhyGRZvQD/H1FQg0AIGqyyj0fF6wFg07XOWVcDELnTabpBNIu
         f1spCQHjWBfGaINpeTdSbscqm9O8eaEmML7emFNbK9SPBYhmhd75hD+AZILsJZVGcoWb
         9BRa1S3De2XMGZIc5uGkBQ7cNeV7Z6TVnNpEueVQSUlPxV8yVBHE9OBrSc+RsOWD4nZw
         JZq3RcpPMWqpSHPDDwIscCFZCSvCTGSfslKpxHJxzYhh/57MclGr1w9PkysJM32RT6Zt
         0C7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764195526; x=1764800326;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4/Gyk1aI8bDpsLxLGEAORUB0we2oIcN7twMnOglf+8c=;
        b=dFLoMeRJwoTBC2CKhbJvJczbA1oDIXj6Y+zTlwmj0BSKTp4P5/13d7HDSk3C8eis/j
         H/pIHBpd6S91M2OHCVVOyU3hUfejIYHX3wjS2xvWKO0pNUYR1rLv9BV7qN9C6xgLGYGb
         N7bMHLgyP8MsaXdIiABiZmPMjpRiBIaMUULxIrHnbjwAbfUS7G2nROPRVh1UiwvgRP7Y
         HQR9FMIHndXCNZTfSm3y6BrFTTzGnE1kfSQ/khYarKV7jFad+zVy/rTp0wmGKKXVpU+R
         yHvEh62ljsd9FguikUaZKdfUGuFHOa76/CZsnVyxY0+u/5BL6PfbkLaKHCW84Y6Ku7TD
         frBA==
X-Gm-Message-State: AOJu0YywjbNZOv7GXbqkfFpLlej+2NnaX4OXnINxXg/Y07+HGzAV9QsA
	TFmewtyNurHxp275fqnRJbjM4DkMn/1pWcKLM2Bd0+i6Cs91MG0xhuNiIZOG1mWf
X-Gm-Gg: ASbGncsQ96G4N2CYbOveN2lXuFmUG2Q+cDVNinmsDD9Kp0LysvZ3hhJ0/Vpctd9UPH1
	G/GBzCI1u51zlXKiAepLa1NLA0OZnH4IzGPgRsJJkXdiaDBi0iBvQPTYZ3ObuBuThSPiUC1d5R8
	cRrd/T9JN4uWKD0jhx5sVhCN/S1gppXG6GZte91NvpjjMv0CGG+nGp2W47Hr9wiVZL1s5+6dlHM
	CrLRAjo6dl66zkM5wTTSTLFy2zlWeAHtBbd37babN50xr2eAaKus6V1FU/xfe6Ec+RX89NKvA/o
	6LUqtG2t205qx+iwv94z8LvjypM9hQEhvO3XEORnBRFKcGzc2fcQ7N8Cf6sz4O+TT8iV9yJKduS
	otBc57RiiOQvFyrT2wsmoxqBcT4GIEF7u0N4OTj9hQYKksMBw18llb1k1nnZqXgl3cl71oyHB/A
	3pcEDmqbeJgkU=
X-Google-Smtp-Source: AGHT+IEln7wVTioub5oOEK8HmJJyQazOKkYqZnGiN9+quRIB+JW3d94dSMUf6BK8T33ahQXGw5LBcw==
X-Received: by 2002:ad4:5e8e:0:b0:882:5e6e:b94d with SMTP id 6a1803df08f44-8863af6dc87mr127719566d6.39.1764195526396;
        Wed, 26 Nov 2025 14:18:46 -0800 (PST)
Received: from [127.0.0.1] ([20.161.78.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54c9d0sm151914126d6.26.2025.11.26.14.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 14:18:45 -0800 (PST)
Message-Id: <18580f020d149eaa8271542d7e629ef10fd8c9a0.1764195516.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 22:18:36 +0000
Subject: [PATCH 5/5] scalar: document config settings
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
Cc: gitster@pobox.com,
    ps@pks.im,
    atthewhughes934@gmail.com,
    johannes.schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add user-facing documentation that justifies the values being set by
'scalar clone', 'scalar register', and 'scalar reconfigure'.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/scalar.adoc | 158 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
index f81b2832f8..b34af225e6 100644
--- a/Documentation/scalar.adoc
+++ b/Documentation/scalar.adoc
@@ -197,6 +197,164 @@ delete <enlistment>::
 	This subcommand lets you delete an existing Scalar enlistment from your
 	local file system, unregistering the repository.
 
+REQUIRED AND RECOMMENDED CONFIG
+-------------------------------
+
+As part of both `scalar clone` and `scalar register`, certain Git config
+values are set to optimize for large repositories or cross-platform support.
+These options are updated in new Git versions according to the best known
+advice for large repositories, and users can get the latest recommendations
+by running `scalar reconfigure [--all]`.
+
+This section lists justifications for the config values that are set in the
+latest version.
+
+am.keepCR=true::
+	This setting is important for cross-platform development across Windows
+	and non-Windows platforms and keeping carriage return (`\r`) characters
+	in certain workflows.
+
+commitGraph.changedPaths=true::
+	This setting helps the background maintenance steps that compute the
+	serialized commit-graph to also store changed-path Bloom filters. This
+	accelerates file history commands and allows users to automatically
+	benefit without running a foreground command.
+
+commitGraph.generationVersion=1::
+	While the preferred version is 2 for performance reasons, existing users
+	that had version 1 by default will need special care in upgrading to
+	version 2. This is likely to change in the future as the upgrade story
+	is solidifies.
+
+core.autoCRLF=false::
+	This removes the transformation of worktree files to add CRLF line
+	endings when only LF line endings exist. This is removed for performance
+	reasons. Repositories that use tools that care about CRLF line endings
+	should commit the necessary files with those line endings instead.
+
+core.logAllRefUpdates=true::
+	This enables the reflog on all branches. While this is a performance
+	cost for large repositories, it is frequently an important data source
+	for users to get out of bad situations or to seek support from experts.
+
+core.safeCRLF=false::
+	Similar to `core.autoCRLF=false`, this disables checks around whether
+	the CRLF conversion is reversible. This is a performance improvement,
+	but can be dangerous if `core.autoCRLF` is reenabled by the user.
+
+credential.https://dev.azure.com.useHttpPath=true::
+	This setting enables the `credential.useHttpPath` feature only for web
+	URLs for Azure DevOps. This is important for users interacting with that
+	service using multiple organizations and thus multiple credential
+	tokens.
+
+feature.experimental=false::
+	This disables the "experimental" optimizations grouped under this
+	feature config. The expectation is that all valuable optimizations are
+	also set explicitly by Scalar config, and any differences are
+	intentional. Notable differences include several bitmap-related config
+	options which are disabled for client-focused Scalar repos.
+
+feature.manyFiles=false::
+	This disables the "many files" optimizations grouped under this feature
+	config. The expectation is that all valuable optimizations are also set
+	explicitly by Scalar config, and any differences are intentional.
+
+fetch.showForcedUpdates=false::
+	This disables the check at the end of `git fetch` that notifies the user
+	if the ref update was a forced update (one where the previous position
+	is not reachable from the latest position). This check can be very
+	expensive in large repositories, so is disabled and replaced with an
+	advice message. Set `advice.fetchShowForcedUpdates=false` to disable
+	this advice message.
+
+fetch.unpackLimit=1::
+	This setting prevents Git from unpacking packfiles into loose objects
+	as they are downloaded from the server. This feature was intended as a
+	way to prevent performance issues from too many packfiles, but Scalar
+	uses background maintenance to group packfiles and cover them with a
+	multi-pack-index, removing this issue.
+
+fetch.writeCommitGraph=false::
+	This config setting was created to help users automatically udpate their
+	commit-graph files as they perform fetches. However, this takes time
+	from foreground fetches and pulls and Scalar uses background maintenance
+	for this function instead.
+
+gc.auto=0::
+	This disables automatic garbage collection, since Scalar uses background
+	maintenance to keep the repository data in good shape.
+
+gui.GCWarning=false::
+	Since Scalar disables garbage collection by setting `gc.auto=0`, the
+	`git-gui` tool may start to warn about this setting. Disable this
+	warning as Scalar's background maintenance configuration makes the
+	warning irrelevant.
+
+index.skipHash=true::
+	Disable computing the hash of the index contents as it is being written.
+	This assists with performance, especially for large index files.
+
+index.threads=true::
+	This tells Git to automatically detect how many threads it should use
+	when reading the index in parallel due to the `core.preloadIndex=true`
+	setting.
+
+index.version=4::
+	This index version adds compression to the path names, reducing the size
+	of the index in a significant way for large repos. This is an important
+	performance boost.
+
+merge.renames=true::
+	When computing merges in large repos, it is particularly important to
+	detect renames to maximize the potential for a result that will validate
+	correctly. Users performing merges locally are more likely to be doing
+	so because a server-side merge (via pull request or similar) resulted in
+	conflicts. While this is the default setting, it is set specifically to
+	override a potential change to `diff.renames` which a user may set for
+	performance reasons.
+
+merge.stat=false::
+	This disables a diff output after computing a merge. This improves
+	performance of `git merge` for large repos while reducing noisy output.
+
+pack.useBitmaps=false::
+	This disables the use of `.bitmap` files attached to packfiles. Bitmap
+	files are optimized for server-side use, not client-side use. Scalar
+	disables this to avoid some performance issues that can occur if a user
+	accidentally creates `.bitmap` files.
+
+pack.usePathWalk=true::
+	This enables the `--path-walk` option to `git pack-objects` by default.
+	This can accelerate the computation and compression of packfiles created
+	by `git push` and other repack operations.
+
+receive.autoGC=false::
+	Similar to `gc.auto`, this setting is disabled in preference of
+	background maintenance.
+
+status.aheadBehind=false::
+	This disables the ahead/behind calculation that would normally happen
+	during a `git status` command. This information is frequently ignored by
+	users but can be expensive to calculate in large repos that receive
+	thousands of commits per day. The calculation is replaced with an advice
+	message that can be disabled by disabling the `advice.statusAheadBehind`
+	config.
+
+The following settings are different based on which platform is in use:
+
+core.untrackedCache=(true|false)::
+	The untracked cache feature is important for performance benefits on
+	large repositories, but has demonstrated some bugs on Windows
+	filesystems. Thus, this is set for other platforms but disabled on
+	Windows.
+
+http.sslBackend=schannel::
+	On Windows, the `openssl` backend has some issues with certain types of
+	remote providers and certificate types. Override the default setting to
+	avoid these common problems.
+
+
 SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
-- 
gitgitgadget
