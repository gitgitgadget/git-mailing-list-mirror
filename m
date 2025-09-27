Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD76A28371
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759002663; cv=none; b=RpITZGQ6pYYyIC7i+ESuu/duFfn2LV5H5vP3sNSnky9LeT4/ZJhyTzovXxR8Jj0BOCLFM2onatShSMN6WovzEY/+bq/YpKoOq8wiBdG6BttIsnhLXuqStIku1Enf1Y1yWMfbE7Id+9JwOQOKCu9eA8xzzFUN1zjNsgdNFaoyae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759002663; c=relaxed/simple;
	bh=NYkGhvAJBH55MMJ1ggvLu+hYitZjkplN3cgyd6fYYY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ccys3Y41lAsoxx6v7UgMZ6YXTCOBFUdFm7+YQO45PCp2Yu5Nph4IDb1S6qQPJUTkm6aiWLo0HbNZEc32Dck5DNUta89QcfVCESG5kFrEcDSi1PkNwmmodwuFu+h5elHTXwLTWShnHCTRC8Bnxi9e/xFivfZNaPSqscCWw/5Ct6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from cayenne (unknown [IPv6:2a01:e0a:d1:f360:ce52:66bd:aa03:6fc7])
	by smtp2-g21.free.fr (Postfix) with ESMTP id EE9A92003C3;
	Sat, 27 Sep 2025 21:50:48 +0200 (CEST)
From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v2] doc: change the markup of paragraphs following a nested list item
Date: Sat, 27 Sep 2025 21:39:45 +0200
Message-ID: <20250927195032.37223-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <xmqq5xd5aqa5.fsf@gitster.g>
References: <xmqq5xd5aqa5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Asciidoctor and asciidoc.py have different behaviors when a paragraph
follows a nested list item. Asciidoctor has a bug[1] that makes it keep a
plus sign (+) used to attached paragraphs at the beginning of the paragraph.

This commit uses workarounds to avoid this problem by using second level
definition lists and open blocks.

[1]:https://github.com/asciidoctor/asciidoctor/issues/4704

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---

Sorry for the straight/stray confusion. It is saner to remove it.

The first occurrence of the described issue is a few lines below where you
looked at:

https://git.github.io/htmldocs/git-config.html#:~:text=+%20For%20historical

also see the second one:

https://git.github.io/htmldocs/git-log.html#:~:text=%2B%20%25(decorate

And big thank you to peff for teaching doc-diff.

 Documentation/config/extensions.adoc | 23 +++++++++++------------
 Documentation/pretty-formats.adoc    |  6 ++++--
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 829f2523fc..556eda5d12 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -3,8 +3,7 @@ extensions.*::
 	`core.repositoryFormatVersion` is not `1`. See
 	linkgit:gitrepository-layout[5].
 +
---
-compatObjectFormat::
+compatObjectFormat:::
 	Specify a compatibility hash algorithm to use.  The acceptable values
 	are `sha1` and `sha256`.  The value specified must be different from the
 	value of `extensions.objectFormat`.  This allows client level
@@ -19,18 +18,18 @@ Note that the functionality enabled by this extension is incomplete and subject
 to change.  It currently exists only to allow development and testing of
 the underlying feature and is not designed to be enabled by end users.
 
-noop::
+noop:::
 	This extension does not change git's behavior at all. It is useful only
 	for testing format-1 compatibility.
 +
 For historical reasons, this extension is respected regardless of the
 `core.repositoryFormatVersion` setting.
 
-noop-v1::
+noop-v1:::
 	This extension does not change git's behavior at all. It is useful only
 	for testing format-1 compatibility.
 
-objectFormat::
+objectFormat:::
 	Specify the hash algorithm to use.  The acceptable values are `sha1` and
 	`sha256`.  If not specified, `sha1` is assumed.
 +
@@ -38,7 +37,7 @@ Note that this setting should only be set by linkgit:git-init[1] or
 linkgit:git-clone[1].  Trying to change it after initialization will not
 work and will produce hard-to-diagnose issues.
 
-partialClone::
+partialClone:::
 	When enabled, indicates that the repo was created with a partial clone
 	(or later performed a partial fetch) and that the remote may have
 	omitted sending certain unwanted objects.  Such a remote is called a
@@ -50,14 +49,14 @@ The value of this key is the name of the promisor remote.
 For historical reasons, this extension is respected regardless of the
 `core.repositoryFormatVersion` setting.
 
-preciousObjects::
+preciousObjects:::
 	If enabled, indicates that objects in the repository MUST NOT be deleted
 	(e.g., by `git-prune` or `git repack -d`).
 +
 For historical reasons, this extension is respected regardless of the
 `core.repositoryFormatVersion` setting.
 
-refStorage::
+refStorage:::
 	Specify the ref storage format to use. The acceptable values are:
 +
 include::../ref-storage-format.adoc[]
@@ -67,13 +66,13 @@ Note that this setting should only be set by linkgit:git-init[1] or
 linkgit:git-clone[1]. Trying to change it after initialization will not
 work and will produce hard-to-diagnose issues.
 
-relativeWorktrees::
+relativeWorktrees:::
 	If enabled, indicates at least one worktree has been linked with
 	relative paths. Automatically set if a worktree has been created or
 	repaired with either the `--relative-paths` option or with the
 	`worktree.useRelativePaths` config set to `true`.
 
-worktreeConfig::
+worktreeConfig:::
 	If enabled, then worktrees will load config settings from the
 	`$GIT_DIR/config.worktree` file in addition to the
 	`$GIT_COMMON_DIR/config` file. Note that `$GIT_COMMON_DIR` and
@@ -87,11 +86,12 @@ When enabling this extension, you must be careful to move
 certain values from the common config file to the main working tree's
 `config.worktree` file, if present:
 +
+--
 * `core.worktree` must be moved from `$GIT_COMMON_DIR/config` to
   `$GIT_COMMON_DIR/config.worktree`.
 * If `core.bare` is true, then it must be moved from `$GIT_COMMON_DIR/config`
   to `$GIT_COMMON_DIR/config.worktree`.
-
+--
 +
 It may also be beneficial to adjust the locations of `core.sparseCheckout`
 and `core.sparseCheckoutCone` depending on your desire for customizable
@@ -104,4 +104,3 @@ details.
 +
 For historical reasons, this extension is respected regardless of the
 `core.repositoryFormatVersion` setting.
---
diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
index 618ddc4a0c..2121e8e1df 100644
--- a/Documentation/pretty-formats.adoc
+++ b/Documentation/pretty-formats.adoc
@@ -232,7 +232,7 @@ ref names with custom decorations. The `decorate` string may be followed by a
 colon and zero or more comma-separated options. Option values may contain
 literal formatting codes. These must be used for commas (`%x2C`) and closing
 parentheses (`%x29`), due to their role in the option syntax.
-+
+
 ** `prefix=<value>`: Shown before the list of ref names.  Defaults to "{nbsp}++(++".
 ** `suffix=<value>`: Shown after the list of ref names.  Defaults to "+)+".
 ** `separator=<value>`: Shown between ref names.  Defaults to "+,+{nbsp}".
@@ -241,10 +241,12 @@ parentheses (`%x29`), due to their role in the option syntax.
 ** `tag=<value>`: Shown before tag names. Defaults to "`tag:`{nbsp}".
 
 +
+--
 For example, to produce decorations with no wrapping
 or tag annotations, and spaces as separators:
-+
+
 ++%(decorate:prefix=,suffix=,tag=,separator= )++
+--
 
 ++%(describe++`[:<option>,...]`++)++::
 human-readable name, like linkgit:git-describe[1]; empty string for
-- 
2.51.0

