Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9722D9EF2
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645207; cv=none; b=R2Df2q5wWunEsI4Ch2TZxT3HiWgPwjr6s9UormGO3hMZ95wOhEPTp3HkJRH/1at2W8GVg4TCvHRUZF2sowMTLH0lSFkNC6nzqsuO+VqNsuV+/CU4eViFflrkGlvC5ORGUNWEvXl/LUjnZYJcrRH5NUFJdiCUFHeTxUdVLINSsiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645207; c=relaxed/simple;
	bh=UUFschPxvQLSoCeTfJfml5AKf5DeToZBbIFy+CewxVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzOQJtWqGzFbvrRI+lCh5sKgN9yr2/H6lWOi7vDxNv/LQ9sbGtgWQTceVbHMJbbkFp2WG9N8h56fsgJIuES7hs5SYaR1/xqYhLSJScChdIC4dgBfjtVNueNWPPofUlqQ7QlUhYHN6NK1bvIJcOqrTxaAibqDzo8Q7hWQjhXNdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=K+BaOtpJ; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="K+BaOtpJ"
Received: from inspiron-LM22 ([80.189.83.109])
	by smtp with ESMTPA
	id 9UBovzPFx9u4D9UCOvvPcS; Thu, 16 Oct 2025 21:03:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1760645025; bh=FD195vG2229K+IOE/fvpFyaxZF8xKExiDZU2vnw1578=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K+BaOtpJM2/NKLVCS2Jlk/5BaDd08Swk7cBp9HRpI8W+YlZkoznxgEMuwEYsuJDdw
	 6cJpMClPVj27QAwKWgnoGAvXX6yh9V03Z5oaVqZ4bd5ZBX6Qhy4//GqBurFpdKQ1/J
	 /i4zU5xYx4SSrFbA9+6HLl0LdRWBSarDYMtHwHSk3MrGkGFOcxSPm5JFOaGU6zFT//
	 MUavjD4rJXdnSkWCqTFK2YKhkqz5MSh4nj4NB4XJwT1jcxiPFivL6ZCR1+lTcbrmvp
	 D0NdKPen7DYp4HqNv7R+yW954/WNiLeYQQ3WFaHuwJ0mVKo7gnopaANdfMgjit5hsz
	 Ad4gX1EVbIJUA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UKJ+Hzfy c=1 sm=1 tr=0 ts=68f14fa1
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=QyRJ8Xq4AAAA:8
 a=VwQbUJbxAAAA:8 a=EBOSESyhAAAA:8 a=gf2t_CT67q65dDXztV0A:9
 a=bU4N5Dn6QmUNwQ-LvVBy:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 4/4] doc: add large-object-promisors.adoc to the docs build
Date: Thu, 16 Oct 2025 21:03:01 +0100
Message-ID: <20251016200301.1595204-5-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016200301.1595204-1-ramsay@ramsayjones.plus.com>
References: <1a72434f-7935-4d0c-868f-03bd24601d4d@ramsayjones.plus.com>
 <20251016200301.1595204-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOnBy2GpXOOsFOnFSHsEYPzu4NoxeM6YJWeJ59c7tk4Ja3QwqkWMdgpM9PgV74GUFbfFxOst2ewYiHWtgnKKNSAThXNI6rvQFQGmtV1Y7+LrOLjMQecj
 nuMw4aguCT78CrleQBVp+9N2+q9Tcz07OS7FS5qdClf3qAK+oOXmYZveYg/pLa0dnJbFQW4Gv1P8FTlKAWORuGragaCMMQ4zhiY=

Commit 5040f9f164 ("doc: add technical design doc for large object
promisors", 2025-02-18) added the large object promisors document
as a technical document (with a '.txt' extension). The merge commit
2c6fd30198 ("Merge branch 'cc/lop-remote'", 2025-03-05) seems to
have renamed the file with an '.adoc' extension.

Despite the '.adoc' extension, this document was not being formatted
by asciidoc(tor) as part of the docs build. In order to do so, add
the document to the make and meson build files.

Having added the document to the build, asciidoc and asciidoctor find
(slightly different) problems with the syntax of the input document.

The first set of warnings (only issued by asciidoc) relate to some
'section title out of sequence: expected level 3, got level 4'. This
document uses 'setext' style of section headers, using a series of
underline characters, where the character used denotes the level of
the title. From document title to level 5 (see [1]), these characters
are =, -, ~, ^, +. This does not seem to fit the error message, which
implies that those characters denote levels 0 -> 4. Replacing the headings
underlined with '+' by the '^' character eliminates these warnings.

The second set of warnings (only issued by asciidoctor) relate to some
headings which seem to use both arabic and roman numerals as part of
a single 'list' sequence. This elicited either 'unterminated listing
block' or (for example) 'list item index: expected I, got II' warnings.
In order not to mix arabic and roman numerals, remove the numeral from
the '0) Non goals' heading.  Similarly, the remaining roman numeral
entries had the ')' removed and turned into regular headings with I, II,
III ... at the beginning.

[1] https://asciidoctor.org/docs/asciidoc-recommended-practices/

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Documentation/Makefile                        |  1 +
 .../technical/large-object-promisors.adoc     | 64 +++++++++----------
 Documentation/technical/meson.build           |  1 +
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a3fbd29744..a3ba25e659 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -122,6 +122,7 @@ TECH_DOCS += technical/bundle-uri
 TECH_DOCS += technical/commit-graph
 TECH_DOCS += technical/directory-rename-detection
 TECH_DOCS += technical/hash-function-transition
+TECH_DOCS += technical/large-object-promisors
 TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/multi-pack-index
 TECH_DOCS += technical/packfile-uri
diff --git a/Documentation/technical/large-object-promisors.adoc b/Documentation/technical/large-object-promisors.adoc
index dea8dafa66..2aa815e023 100644
--- a/Documentation/technical/large-object-promisors.adoc
+++ b/Documentation/technical/large-object-promisors.adoc
@@ -34,8 +34,8 @@ a new object representation for large blobs as discussed in:
 
 https://lore.kernel.org/git/xmqqbkdometi.fsf@gitster.g/
 
-0) Non goals
-------------
+Non goals
+---------
 
 - We will not discuss those client side improvements here, as they
   would require changes in different parts of Git than this effort.
@@ -90,8 +90,8 @@ later in this document:
     even more to host content with larger blobs or more large blobs
     than currently.
 
-I) Issues with the current situation
-------------------------------------
+I Issues with the current situation
+-----------------------------------
 
 - Some statistics made on GitLab repos have shown that more than 75%
   of the disk space is used by blobs that are larger than 1MB and
@@ -138,8 +138,8 @@ I) Issues with the current situation
   complaining that these tools require significant effort to set up,
   learn and use correctly.
 
-II) Main features of the "Large Object Promisors" solution
-----------------------------------------------------------
+II Main features of the "Large Object Promisors" solution
+---------------------------------------------------------
 
 The main features below should give a rough overview of how the
 solution may work. Details about needed elements can be found in
@@ -166,7 +166,7 @@ format. They should be used along with main remotes that contain the
 other objects.
 
 Note 1
-++++++
+^^^^^^
 
 To clarify, a LOP is a normal promisor remote, except that:
 
@@ -178,7 +178,7 @@ To clarify, a LOP is a normal promisor remote, except that:
   itself.
 
 Note 2
-++++++
+^^^^^^
 
 Git already makes it possible for a main remote to also be a promisor
 remote storing both regular objects and large blobs for a client that
@@ -186,13 +186,13 @@ clones from it with a filter on blob size. But here we explicitly want
 to avoid that.
 
 Rationale
-+++++++++
+^^^^^^^^^
 
 LOPs aim to be good at handling large blobs while main remotes are
 already good at handling other objects.
 
 Implementation
-++++++++++++++
+^^^^^^^^^^^^^^
 
 Git already has support for multiple promisor remotes, see
 link:partial-clone.html#using-many-promisor-remotes[the partial clone documentation].
@@ -213,19 +213,19 @@ remote helper (see linkgit:gitremote-helpers[7]) which makes the
 underlying object storage appear like a remote to Git.
 
 Note
-++++
+^^^^
 
 A LOP can be a promisor remote accessed using a remote helper by
 both some clients and the main remote.
 
 Rationale
-+++++++++
+^^^^^^^^^
 
 This looks like the simplest way to create LOPs that can cheaply
 handle many large blobs.
 
 Implementation
-++++++++++++++
+^^^^^^^^^^^^^^
 
 Remote helpers are quite easy to write as shell scripts, but it might
 be more efficient and maintainable to write them using other languages
@@ -247,7 +247,7 @@ The underlying object storage that a LOP uses could also serve as
 storage for large files handled by Git LFS.
 
 Rationale
-+++++++++
+^^^^^^^^^
 
 This would simplify the server side if it wants to both use a LOP and
 act as a Git LFS server.
@@ -259,7 +259,7 @@ On the server side, a main remote should have a way to offload to a
 LOP all its blobs with a size over a configurable threshold.
 
 Rationale
-+++++++++
+^^^^^^^^^
 
 This makes it easy to set things up and to clean things up. For
 example, an admin could use this to manually convert a repo not using
@@ -268,7 +268,7 @@ some users would sometimes push large blobs, a cron job could use this
 to regularly make sure the large blobs are moved to the LOP.
 
 Implementation
-++++++++++++++
+^^^^^^^^^^^^^^
 
 Using something based on `git repack --filter=...` to separate the
 blobs we want to offload from the other Git objects could be a good
@@ -284,13 +284,13 @@ should have ways to prevent oversize blobs to be fetched, and also
 perhaps pushed, into it.
 
 Rationale
-+++++++++
+^^^^^^^^^
 
 A main remote containing many oversize blobs would defeat the purpose
 of LOPs.
 
 Implementation
-++++++++++++++
+^^^^^^^^^^^^^^
 
 The way to offload to a LOP discussed in 4) above can be used to
 regularly offload oversize blobs. About preventing oversize blobs from
@@ -326,18 +326,18 @@ large blobs directly from the LOP and the server would not need to
 fetch those blobs from the LOP to be able to serve the client.
 
 Note
-++++
+^^^^
 
 For fetches instead of clones, a protocol negotiation might not always
 happen, see the "What about fetches?" FAQ entry below for details.
 
 Rationale
-+++++++++
+^^^^^^^^^
 
 Security, configurability and efficiency of setting things up.
 
 Implementation
-++++++++++++++
+^^^^^^^^^^^^^^
 
 A "promisor-remote" protocol v2 capability looks like a good way to
 implement this. The way the client and server use this capability
@@ -356,7 +356,7 @@ the client should be able to offload some large blobs it has fetched,
 but might not need anymore, to the LOP.
 
 Note
-++++
+^^^^
 
 It might depend on the context if it should be OK or not for clients
 to offload large blobs they have created, instead of fetched, directly
@@ -367,13 +367,13 @@ This should be discussed and refined when we get closer to
 implementing this feature.
 
 Rationale
-+++++++++
+^^^^^^^^^
 
 On the client, the easiest way to deal with unneeded large blobs is to
 offload them.
 
 Implementation
-++++++++++++++
+^^^^^^^^^^^^^^
 
 This is very similar to what 4) above is about, except on the client
 side instead of the server side. So a good solution to 4) could likely
@@ -385,8 +385,8 @@ when cloning (see 6) above). Also if the large blobs were fetched from
 a LOP, it is likely, and can easily be confirmed, that the LOP still
 has them, so that they can just be removed from the client.
 
-III) Benefits of using LOPs
----------------------------
+III Benefits of using LOPs
+--------------------------
 
 Many benefits are related to the issues discussed in "I) Issues with
 the current situation" above:
@@ -406,8 +406,8 @@ the current situation" above:
 
 - Reduced storage needs on the client side.
 
-IV) FAQ
--------
+IV FAQ
+------
 
 What about using multiple LOPs on the server and client side?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -533,7 +533,7 @@ some objects it already knows about but doesn't have because they are
 on a promisor remote.
 
 Regular fetch
-+++++++++++++
+^^^^^^^^^^^^^
 
 In a regular fetch, the client will contact the main remote and a
 protocol negotiation will happen between them. It's a good thing that
@@ -551,7 +551,7 @@ new fetch will happen in the same way as the previous clone or fetch,
 using, or not using, the same LOP(s) as last time.
 
 "Backfill" or "lazy" fetch
-++++++++++++++++++++++++++
+^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 When there is a backfill fetch, the client doesn't necessarily contact
 the main remote first. It will try to fetch from its promisor remotes
@@ -576,8 +576,8 @@ from the client when it fetches from them. The client could get the
 token when performing a protocol negotiation with the main remote (see
 section II.6 above).
 
-V) Future improvements
-----------------------
+V Future improvements
+---------------------
 
 It is expected that at the beginning using LOPs will be mostly worth
 it either in a corporate context where the Git version that clients
diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
index a13aafcfbb..34b5ebe5c3 100644
--- a/Documentation/technical/meson.build
+++ b/Documentation/technical/meson.build
@@ -13,6 +13,7 @@ articles = [
   'commit-graph.adoc',
   'directory-rename-detection.adoc',
   'hash-function-transition.adoc',
+  'large-object-promisors.adoc',
   'long-running-process-protocol.adoc',
   'multi-pack-index.adoc',
   'packfile-uri.adoc',
-- 
2.51.0

