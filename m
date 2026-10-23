Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761124;
	b=GquJLwBMfntnkAOAb1PCGb+RVmWYV6yq2KeJZuhzZSAiu756fYitLhaI9qGyR48fsWZN
	 NJUYsXCnSrd4DWr+L4Xsa6lna8t4oKOjeaSGCnQIvdBWORjQq8MjaBzb9IG/2sh09qKSR
	 /R1Ao7VOt+xUB4Ksl/Qj0NH5Js6bB7HFHGYgUaFgEsF8YPhFVpPLFP0GOrgK1WGFEF8a0
	 QU56N+cbwZ1UkhQYQRyBnVY6wX5txBCLyzzDRZmWcCTzxiQVeIcygv0H6P8/HuP0W9aja
	 Rd+hJzP2D7PJvZOBKcIkv2A1R/ZMotsBwYp6NCJg2HsHRcA6gdnF6rvKKE2hfbezYeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=4IfS119Ck+vK2hgQMAw1dkOTERIuFBJV2Wof0vsKVSA=;
	b=Tyo+8/kVbMZuPHyX3EBIpchYOPySXXN2mKqALqk5sU9RsQDhj0LDdSaFqurFDTIMY/qH
	 ZQJCqa15NVvJa2hPUCR5qscNmt5AWbV1TNEhEA9mdzQL+VTZzLkRsvp9/o+OT0hBqlOYQ
	 k26g3hUjwzh1kqZjXuytYGQ4YmqvfbS35N6J+kUoxW389MI/k1HgdOH0VjCC/ZHsPXUM5
	 gPlVQVgS42p+t/bZZltBMnerqAc1n8xN81uO7T06boTEQ1yXqy90mthzDkJplFXVQgw/n
	 JLghJDTohFzYnyIJoYTKV/+avnVR9DnnKV89xeuxjbgfcpzl1Cy9HuzvSRqJ4kWtksA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OamfKK4a;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C03606A327
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63C03606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OamfKK4a
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b05bf699easo8369217b3.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792761123; x=1793365923; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4IfS119Ck+vK2hgQMAw1dkOTERIuFBJV2Wof0vsKVSA=;
        b=OamfKK4alf2JIVjTSm9P9wkWmUmq/BSANolp+nQg9gWYGUsmZG1j7VMyHv/yYvrJSt
         0YFfnsUOkkdkI5CBcQSZ+HzgUr/vr4stKwM47AZcuRFHdplsx4rm0phtPrfvZOwAA6Mo
         rl5O5XmBhsmHJwN5etXGIqnylW/yfz6Rl4Xwu3Ync+w/PauvWkat0HP/1fKYJACV0DJO
         JMwbiIdLCHSRA0oqzFK/atzgyqttIpA8Eqkrpu+ewqj+wL3kcVdfyC8VALUurJTws+ae
         7BMTp8LPMwEhXSe6yiqxHuuz01EKD/Gea6ZjmrjlKPd9EYZ2CvpZkz+LtpxTUodNTUVD
         hdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792761123; x=1793365923;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4IfS119Ck+vK2hgQMAw1dkOTERIuFBJV2Wof0vsKVSA=;
        b=ZqWyTTH7pW2acpQ9UtOw6f+BnmyWeTCLPMrK4kee7H+VuQ48adUzIMIllx107lucyE
         CByRuwldvQMKUViCRSh9pTM2yXeUfcjjZ8tWPmgk2VeKnzuB6Qk7Gv4dYw8fvqK7pGFt
         ar+Qy46xrf1tQSiGDzVFzfK7ASWSmWcsV2R+qy2NvqenmZ0enHDVQAtxZDlfNzMrZh3t
         JtBUk02G5IwSHUHIg8ULjEikMZvOrlKrVQGW3NU+wsTPyc/vSCbNH+vqun8OgIrxRIM8
         Wram46WgcQ/gabNl7/gELKelj7i2suY3byawsUt5MXDobLTb7Zghh6qwQuREcCyTznJq
         DTHQ==
X-Gm-Message-State: AFq9FYJka2jc66cji20w3k3uyPo+zhlMd3Yk1UQQB7bLd73HYQ1BQF3d
	VdZ21Twi1Rjpxx1GjY970jLwjCN2pKmPSYDhb+AlY/x2mQMj5hFZySVvTT+ShXcl
X-Gm-Gg: AYBFou2dSngKsBH1oXN26Ey7hWl7Ay1e4DahYA0DrUD0F4oLPDEz5yvQIVcxAvE16N3
	p9/nYS6yaulZPL58qIWE9AY0NVVF2/tFEyTkEbyeaGoRH7MoTPwKRyOdxl5Kq9Jrhre7UW7/oHn
	x9IdOe+TWDWS2+smfW+ZnQkioiyGsuPTkw60TPWNBRVfsoarDkuYxuIUisvWCGaVqI6Jb2uQiZp
	4+IEQ55sK0BLW+4sopW+Ibx0dWtZs5bxAEGfpWuDC2X+xXLxBvTah3KK5N3fLwvgOCkA8sQJjxM
	EFZcTTSjKNCD8Ba6gopEYSs4eg9Vwq+uAGJNNS8vMsu/n6uAeJG/zb86ldhPtCe5abIBom4oLuo
	PqvQotgMT+GNz9NnexUxV+EFxd4SLiBg17ACB58k7dNLz8C1D/JMSAOLSoH5Ccr7pO4kFihd2h1
	1Awc6EMe/SF/TY3Rjr4IiwabTuZazbZFrkyDBAWjwicj9bp7OYKDqWvUI08j10sVNRIQ/O3B+G3
	1CtgIOs7Dlq1OXAABc5y36/PaPKPMriijznwUpY3jwVHNjStJVmn1PJgPw=
X-Received: by 2002:a05:690c:f81:b0:897:697e:52a0 with SMTP id 00721157ae682-8b157e80a62mr18216467b3.55.1792761123145;
        Fri, 23 Oct 2026 06:12:03 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.86.148])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b156164114sm13114917b3.30.2026.10.23.06.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:12:02 -0700 (PDT)
Message-Id: <e25824c21d0dbc6161da81cae84cd755fc0e6fec.1792761119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v5.git.1792761119.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v5.git.1792761119.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 13:11:54 +0000
Subject: [PATCH v5 1/6] Documentation: describe connectivity checking
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

