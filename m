Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581749;
	b=WuZdjAzGKehvz4nfNXE4cTn12kgvLaNyCbU+ZMthBrvdlzbHK0tLiHRl5LA8uQSybPtu
	 wARdK2wbghbuuIW8telsTPx77yBygOVrNo+ypqWcNV5LWyOR2ngcED56Uf/ojFNVkB+Fh
	 53MI3Iic0Om9jVhinxSbpbZcuOvg+VWp4I1Xcl5gs2SHfexXPXwrp+NbFXt7aaKTo2Jqs
	 2tvdk81H4PFNuI4Qpf24GTt0SbYBNR6P+NqW28x9qREELuamGtd1o5QvKQUlekWpKhv+P
	 h4GUGV8IlNhPqZ2LL4Io80aRRgiAWYO6z1tRnW6PrlIyY3m5NG0OAQBNW3j6g0ETENw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=4IfS119Ck+vK2hgQMAw1dkOTERIuFBJV2Wof0vsKVSA=;
	b=jaXzCtzCC1HAKirRJSZhSeyto3qdcqsRvcPXBS22+82sDtZ6tzf+0kPDW/z/Tq17mv5T
	 D78MEzVVezqdAoyL32oEH/PQYdkcuaWrFEXdPoWSXPxdqozLBRPzZ04Iseo1MARCM8ZYr
	 VZ3plX1wU8o/tQIlodQIOMUqdRnaM5M1pkwwtn5swYdbfGZNzogbMSUNlV6WOAeCiLrq2
	 LXAcMZ3/XP8FuUYdWLHD5qXW+eyUllPNkpq8W2B8xn2hqLUHeyRrC8tGBTyPRRyKd7Qiq
	 6m+i+LtcylcvauBh/zg5VOWUxul59dMYUKbUre7UkVfCwY/KulAeBSHTidT7bqHSvLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NgjhviK9;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EB9606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13EB9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NgjhviK9
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso375955a91.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 04:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792581748; x=1793186548; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4IfS119Ck+vK2hgQMAw1dkOTERIuFBJV2Wof0vsKVSA=;
        b=NgjhviK9DyboWsAFQLo5fyfUzCdCCRyx8YhYwqqif/oD93wveqkgly1a7PSiSUIL95
         TQp/YArjsKNi8N4F/94rljwaZwKAa8EA14y4SWZaxm1/pdMbBuUtX8m8ruIphbOrloRa
         9i7YW9zLQCeoGnrALtN4YBH5MyhQ5hPIAufL4Q/Q4FH3CFf+ROvlqRzMND6UNvurquf8
         Nso70kdoUJ/Q7ZoPvry3BnSSkkn/pKcV7xRZSp9YumDENGgfjvG5sZHuqGK70al3/BEA
         Wp4dkJRCxjsGJmdHjXLuWJ6fbbJsyMijCurVt9zA7C5vp7ynA81zXGz9Ka9g4SbjoPw0
         4aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792581748; x=1793186548;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4IfS119Ck+vK2hgQMAw1dkOTERIuFBJV2Wof0vsKVSA=;
        b=mWAWv660ZlkU/WGOvWoUzNkPqNLlBO37zfeHUh8PWq2AhUQiKB/CYlD4YFy6KXMFO+
         WCs7cyT5Ml/pTG5ynR6KSrWDz2nVT2WwCWUNt78ETAU3h2NugxQKA4jd1oaEwM5o4oJU
         s3bXzRVwxEi/v6pZ6cfTEdauuSAn3E4hrj0FFqKkI1S2bck1YvCYI6astp9MLhynnXVS
         piarNqSEWvSYLfxHylrakTfJKr28AVbyPtuNAnOqpdcYEW2XWOiUw7g9U042rSJ7y9es
         xpbQB5Lx3SARgApr0YJtYzijmECT99zGT2Yi6zfycj+0slQtraoDZcedpPYsKLwmeUMD
         TkQg==
X-Gm-Message-State: AFq9FYLeS/mEP0xUN+BxkWEHxRQeHd8H5IqaNVhlBuBftJuEcnP7uE20
	Sx2pTDWbA++JtCKnu64PXEuP5Sda6SdVc0NeKLvZRYArXXmN6ubjROadZ7Jx2Q==
X-Gm-Gg: AYBFou2+ShWmjpqBLVdW/Dq0Mqr9m2GP5XSg7JueIO0YT5GQ952HO747UnezrcZV3CK
	iX5Mf795MudSPZjE4nioo+b6fpXxgMLb4riftIgr+DuOXyT+KMcI1KesfEHtlfXr0hiHNW54U2a
	bFpob7TMAI+xJmCld1C1rDQH2dnHhkJau0qztQReUq/JpDkBlCeV3XorHVmxf2ruBHOmqDDkG+1
	Hu1rnoal1ytgDaoCeO+NuDw0AtyM9HF56my+8KrdTRGellJ8z9GOl9um0uT94s3KaqgoQYTVxH5
	sVIWXXrM19A+ztnE8lhLWVcmN7xMP41WGP1uAD+iIwjHIeahAdbcNWyulEcpBZvaa1YY+SMVGCB
	fGJrJAs4nmBofgboZGLFfRvgrruotZKwTpgucNyUQzhleq5CsgyCdD0H8R1uMFuIeB2OoS4AXm+
	AgCVv+FSylTxxH9tTAcOEEfubJJTuciJnvzTUvbBkPyvmrYCb57yU0/D0HhXxmh8PKEfG+0zVVq
	gjvNSyAedRT69FZ5bVbn3V9iQGfpm9fzuR9npa/S8ny+hRar9w7umO0Ng==
X-Received: by 2002:a17:90a:d883:b0:3ac:17c:6e74 with SMTP id 98e67ed59e1d1-3ad86cc2074mr1325505a91.53.1792581748252;
        Wed, 21 Oct 2026 04:22:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.42.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad85f56b03sm1697162a91.3.2026.10.21.04.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 04:22:27 -0700 (PDT)
Message-Id: <e25824c21d0dbc6161da81cae84cd755fc0e6fec.1792581744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v4.git.1792581744.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v4.git.1792581744.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 11:22:19 +0000
Subject: [PATCH v4 1/6] Documentation: describe connectivity checking
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add Documentation/technical/connectivity-check.adoc describing
the connectivity invariant and the full connectivity check.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 Documentation/Makefile                        |   1 +
 .../technical/connectivity-check.adoc         | 112 ++++++++++++++++++
 Documentation/technical/meson.build           |   1 +
 3 files changed, 114 insertions(+)
 create mode 100644 Documentation/technical/connectivity-check.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f8dea4b395..1747f4a00b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -122,6 +122,7 @@ TECH_DOCS += technical/bitmap-format
 TECH_DOCS += technical/build-systems
 TECH_DOCS += technical/bundle-uri
 TECH_DOCS += technical/commit-graph
+TECH_DOCS += technical/connectivity-check
 TECH_DOCS += technical/directory-rename-detection
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/large-object-promisors
diff --git a/Documentation/technical/connectivity-check.adoc b/Documentation/technical/connectivity-check.adoc
new file mode 100644
index 0000000000..a112d5be3e
--- /dev/null
+++ b/Documentation/technical/connectivity-check.adoc
@@ -0,0 +1,112 @@
+Connectivity checking
+=====================
+
+After receiving new objects via fetch, push (receive-pack), clone,
+or bundle, Git verifies that the new reference tips do not leave
+the repository in a state where reachable objects are missing.
+This verification is called the connectivity check.
+
+Connectivity invariant
+----------------------
+
+A repository is connected when every object reachable from its
+references is available locally (with exceptions noted below).
+The reverse does not hold: objects that exist in the object
+database but are not reachable from any reference may be
+incomplete or lack a connected closure.
+
+The connectivity check maintains this invariant when references
+are updated.  It trusts that all objects reachable from existing
+reference tips are already fully connected and verifies that the
+new reference tips do not introduce references to unavailable
+objects.  Verification is permitted to stop when it reaches
+objects already reachable from existing references, since their
+closure is already connected.  These trusted references include
+local references and references from alternate object stores.
+
+Without this check, a truncated or corrupted transfer could leave
+a repository in a state where later history walks encounter
+missing objects.
+
+Exceptions
+~~~~~~~~~~
+
+Gitlink entries (submodule references) are excluded from
+connectivity checking.  Their target objects belong to a separate
+repository.
+
+In partial clones, objects promised by a promisor remote are
+accepted as connected without requiring local existence.  The
+check excludes promisor objects from traversal so that it does
+not trigger on-demand fetches for them.
+
+Full connectivity check
+-----------------------
+
+The full connectivity check runs a `rev-list` subprocess, feeding
+the new reference tips via stdin.  A normal invocation is roughly:
+
+    git rev-list --objects --stdin --not --all --quiet
+        --alternate-refs [--exclude-promisor-objects]
+
+In a partial clone, objects received from a promisor remote do
+not need to be checked: anything they reference is promised by
+that remote and can be fetched on demand.  So if every new tip is
+found in a promisor packfile, `rev-list` is not run at all.
+Otherwise it runs with `--exclude-promisor-objects`, so that the
+traversal stops at promisor objects instead of fetching them.
+
+Consider the following graph after a fetch, where all reference
+tips point directly to commits.  For simplicity, only local
+references appear on the already-connected side; alternate refs
+play the same role.  N3 is a merge commit:
+
+            /-------------L2
+           /
+    C1---B1---C2---B2-----L1
+          \         \
+           N1        N3---T2
+            \       /
+             N2-----------T1
+
+    L1, L2:         local refs
+    T1, T2:         incoming tips (new refs)
+    N1, N2, N3:     incoming commits (N3 is a merge)
+    B1, B2:         boundary commits (already connected)
+    C1, C2:         already connected (but not boundary)
+
+The incoming set is the commits reachable from the incoming
+tips but not from the already-connected side.  Boundary commits
+are the already-connected commits at the edge of that set.  Here
+B1 is an ancestor of B2, which happens when incoming branches
+fork at different depths in the existing history.
+
+The `--not --all` arguments establish the trust boundary: the
+incoming set is the commits reachable from the new tips but not
+from any existing reference.
+
+The traversal then walks the trees of the boundary commits and
+marks those objects uninteresting.  Trees of incoming commits
+are then walked, stopping at objects already marked as
+uninteresting.  The cost of marking boundary trees uninteresting
+dominates when the boundary commits have large trees, even when
+the incoming changes are small.
+
+Deepening fetches
+~~~~~~~~~~~~~~~~~
+
+For deepening fetches (where the shallow boundary moves), the
+full check omits `--not --all`.  There is no existing-reference
+boundary at which the walk can stop.  Instead, traversal follows
+the effective shallow boundary supplied for the deepened
+repository.  The new content may be below the old shallow
+boundary even when the tips themselves have not changed.
+
+Non-commit tips
+~~~~~~~~~~~~~~~
+
+When a new reference points to a non-commit object, such as a
+tag, tree, or blob, that object is not part of the commit walk.
+These non-commit tips are verified during the tree and blob
+traversal that follows the commit walk within the same rev-list
+invocation.
diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
index 9ce11d5e48..c439a7a072 100644
--- a/Documentation/technical/meson.build
+++ b/Documentation/technical/meson.build
@@ -11,6 +11,7 @@ articles = [
   'build-systems.adoc',
   'bundle-uri.adoc',
   'commit-graph.adoc',
+  'connectivity-check.adoc',
   'directory-rename-detection.adoc',
   'hash-function-transition.adoc',
   'large-object-promisors.adoc',
-- 
gitgitgadget

