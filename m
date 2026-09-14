Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A524248C9
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379284; cv=none; b=SVvot7kUjknbabUVYEj5AMcAED9X8OUHWoG45US9DEesS4FvPcq0QnDNGAbDgl/XLof9N5/PJ43VoQiX6pBkY7lRgyvSRoRol960h8VZEQlmW/yiucNfSL9p+6opKvLK4WiUEolxu6YDmYtjACs4gMZKHKMXlUF2veLNiJOY/gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379284; c=relaxed/simple;
	bh=gAQJ4Xqp8l+T3L7N+40TPwrGWe3oiPAAJHIVXemm9m4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rMwQGRAbxPFRdp9bC+A2F/9MQWvtslfkq3SdTqYad2Vd4F5YxwVri258SFxCLO+YRLC9bFO0lt/pU9KYpWGCUqvMxtgcqcTbLrdDIX5OhN4arf22CW7ZVUTwM/2wwwhcXvT0Z/2tvzWFkHvYaw4Usnd8vzYwpDQux36Co4mEunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXm091CP; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXm091CP"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24afso1313388a91.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 02:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789379280; x=1789984080; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q+O6PK2EUa17RHITADJNUCSmA7pnZCYmr4Mln7xMYXg=;
        b=EXm091CPdaJMjHZwqvFKSGqBOWGBclGQQ3/gXHmA1xZDdwpFclf3Eb+QIXSW7rc70X
         ooQYNmiFshZoZyXOeZ+hY+loIDICBbz7qygLgimNQ2O1T3LYqPtbdba5EVgaCmZg+XCr
         E6hgbMO12TgS0f52q/WxfxdsC6JvrW9ZYgVeENVhPQ1CvCh2MjtkSEE83bZRZDFZyr35
         Wbz2GZC4AHOXUY2ZR4Z6Yps1wxnjBwfhs1pg3iEWNnEFkZsSSZUPcPNk+bm9Nmt0Ysk7
         eaLGCBO8WkDtc+V8Rz55RPvDOc/GpkU5Lv3SatO5yLg7WPxD5aEdH1KMr1XbywzDmfee
         4y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789379280; x=1789984080;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+O6PK2EUa17RHITADJNUCSmA7pnZCYmr4Mln7xMYXg=;
        b=Y4shCovI95mbi29JXEgnrA0EDpUT2uRxXO+kQgm4T1L48L9220/vT9tvP0Pitn9jWQ
         R59U+7Ivrd3c3yC1eMZRLjIMAnFnC0Sww1YBUhyYCWlnPNYLBuqqu7qMr673eqxPvTDf
         u/BD3nUNRF4OU3yMrABMTu+ahwEPJSkxvHa/6agqvDgX455zKiq+F1dFm0n5d+TTc1ey
         BlVcq3TEx0DGYscvkr/pha6eK9/sCmNQoUWcYr4QqSEzbkt1jadQaawAcqcqUrT/aEaP
         AsmASaTer3UjpnDu8cE9Y0ATvmwfsE4hUHly5hH9FCPxV9KLeTVHQuPAseW1l3gmT6G3
         kqfA==
X-Gm-Message-State: AFuF++m0UVjlEM+dneozOFJOMUf09noB0rouRFHyvT73RwDUARYW6NyT
	aS9H9yCFLQl16wa8T4Wu4+cgIK/EAz40fCByiGX8cPRXYOGUcZ3vd2sqByQ7gw==
X-Gm-Gg: AYBFou02kehWxBDn3PcmBYqBvs05cWZW26kUx/8KPUUXbmgb29PTfoZSF7M+qGB74Fj
	HoQnNCeX8LqvXeuPpDurVX6Qr/d7Ibs35i7Ulkh3P7E6jfnhv3eWCkLCWtZ82omBcaS2YOeVddc
	OE4wQnP6PCZt83RCOFg7qEM+MkIX0HyXKIW+dxaXfT3paD4l/VOMf19atamp0PyBS73y77iWRBb
	88TkMI8WIiunKLyCEUZGA1TteXFgVinsXegEaRksRTCroxmG5wPO2NVqtRQBSkNucRZrokSxwgh
	cDFvJA5yb1TVIU4oAW+jClDv2Ke2PpMskf3zEi/JyA4UdnCKWjg5DyrpRFhWJ9JZrVuWz351n23
	bhb4f16wSy3J8Z/krD6WP7ePsRD2tPIdImhmb4RKfClEo6A3mMEW1I1FwYukWkOm1SP7Rz7YAOu
	d/ZIL/CYg6lfAtjCWuoH3NwGH9QBXYWociBgwmpFWSRqvonFVb4umwIMP5hstOUuMSBXwDUMci/
	Kr79w==
X-Received: by 2002:a17:90b:2885:b0:39d:f15b:589f with SMTP id 98e67ed59e1d1-39df15b5965mr2013682a91.5.1789379280060;
        Mon, 14 Sep 2026 02:48:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b759d0sm26006747c88.7.2026.09.14.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:47:59 -0700 (PDT)
Message-Id: <e55c5452db0b7cb683d4e2ad51cd8f44046c23bd.1789379276.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 09:47:55 +0000
Subject: [PATCH 1/2] Documentation: describe connectivity checking
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add Documentation/technical/connectivity-check.adoc describing
the connectivity invariant and the full connectivity check.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/connectivity-check.adoc         | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/technical/connectivity-check.adoc

diff --git a/Documentation/technical/connectivity-check.adoc b/Documentation/technical/connectivity-check.adoc
new file mode 100644
index 0000000000..d20bff6af6
--- /dev/null
+++ b/Documentation/technical/connectivity-check.adoc
@@ -0,0 +1,109 @@
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
+
+The connectivity check maintains this invariant when references
+are updated.  It trusts the existing connected state and verifies
+that the new reference tips do not introduce references to
+unavailable objects.  Verification is permitted to stop when it
+reaches objects already reachable from trusted existing
+references, since their closure is already connected.  These
+trusted references include local references and references from
+alternate object stores.
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
+`check_connected()` (see `connected.c`) normally performs the
+connectivity check using a `rev-list` subprocess, feeding the
+new reference tips via stdin.  A normal invocation is roughly:
+
+    git rev-list --objects --stdin --not --all --quiet
+        --alternate-refs [--exclude-promisor-objects]
+
+When promisor remotes are configured, `check_connected()` first
+attempts a fast path based on promisor packfiles.  If it falls
+back to the `rev-list` check, `--exclude-promisor-objects` is
+added so that the traversal does not trigger on-demand fetches.
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
+The check proceeds in three phases:
+
+1. Walk from the incoming tips (T1, T2) against the trusted
+   refs (L1, L2) to find the incoming set ({N1, N2, N3, T1, T2}).
+
+2. Walk the trees of the boundary commits (B1, B2) and mark
+   those objects uninteresting.  These trees are already trusted
+   because their commits are on the already-connected side.
+
+3. Walk the trees of each incoming commit and verify that every
+   referenced object is connected, stopping at objects already
+   marked uninteresting in phase 2.
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
+These non-commit tips are handled by the subsequent object
+traversal.
-- 
gitgitgadget

