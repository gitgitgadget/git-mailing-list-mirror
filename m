Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000874;
	b=FmXJKKTj9YTXcVS+SkJxPG4narFdJBhEUVzueg4Jy0ib8kF87JYJZdML65hpwSZ6o7r6
	 Y2orBp56pj5ZvDZORp9nLvPvbz3YWnBwnSkRiEdqNfTRIJu6PV4epITqEzwVAyuGLAtIu
	 V762Djg7WVX3nIuAnVSzuZ44/cSHUeqAGvjlTjeu9sIECcEc5q5+2mDuWNq4ftCP1i38M
	 6hLi26BPTRby/kh4sM2hn3+yj6In5dNynzXn0T+aYsFd3ycA4PmVNgstTxdxiMWNzVvtP
	 Rd8Rm+ts9+GuuPh0OW3TcHtpL1ZfevfERmcPw4W3cJ1H3s7UmStioFeDeHKqBteXOqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YWxU8Q5vMgwRIlwzG0fW+iDKky41CAdCWDS5L9Xi528=;
	b=zWsI5se4cJVCTP0npWsf7m24/mMuZPsyI0+v4YScCVaSIily624S/ECQCyOxL5IjKN5y
	 YGPjXDK+tiVLl87OOyHVLMxG+BpWmt/pDZczPwYLTj3JpwZcYHkP1i9PhnwjrasrXzZ2g
	 fANzaDgZwByw7SzHurS7EeG7muzUqarQHw3rGf5xbH4CnjaR29P1LKX+QfiJ8bEYT9isM
	 AKv6ShgUMZWwYRXfFOxZeWWs+NJ8HSe5FWbJ0t26blKIEQ/LoOcQ/0eD9eRUDydJ1euH1
	 WSXxOmk4WX7zmeh/v2CdGWv+Bu21z56xroXTj7YBGjhC0/sY27DeY46eYz24UBn2HtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oZq0pwUW;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA283606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 21:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA283606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oZq0pwUW
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so7629415e9.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 13:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794000872; x=1794605672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YWxU8Q5vMgwRIlwzG0fW+iDKky41CAdCWDS5L9Xi528=;
        b=oZq0pwUWosVZcWeDt16ZX9ylg1M0gdQ5wdVTWaG4WdWS20+QmDNVuKhqRFt4/BtIoa
         tBGvH5ZPTwXSCWw01V1/CcUuqF3PwKOuMj3AkZ8a0clU6f6JR89rDLrpf5XcQ32QaBhJ
         Z8sDqtuLd+xP/zEtG90/rtSPn6a0Ksfj4cF6wDKDbcYqWKpc75kL0blASz2dSOH7qtW5
         c+tNRoV1RcfHbXJ1xE8CR+OcXjl3HDpOoc9ET96+VWsHWHSsKUsdbZG3QxstNR22u/3b
         kOJeIvh+4rkBgVPCbzPZPORvxmDeQZW6CrXVsEUanJ/efxbqjO6nTKeV2BCD4l7kTUAk
         ks0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794000872; x=1794605672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YWxU8Q5vMgwRIlwzG0fW+iDKky41CAdCWDS5L9Xi528=;
        b=npqC5VnmX6LVnb6ZirRPpWhW0WC20YxnZzZjIfZBlkLMF3v9ByZrdxY8yZXzZntar5
         e4c1ciFPyu5dkk3V7dmaDxTauPw2rI+zkEdrreObpNnwVND1EwJX/WsFiLGZ5CCevoU+
         LW5IPQY35Kv6dU4Y2IKogjnEmkFcJMSVOYhLVKDTzHN+ImE51WwkN/7g0ICjKwQxq7X1
         mXj+GPUNSxg3WFaEZfaVXfHSQoG44dC7c92CYngeGhT5dOkTTBFmZ9l+yj7I23B17pYB
         gAK1q+dMtNr4grNy8+OiqLPz1hCNMynEkZzBhLbhLicpWoj7azL1tZ9M75iLyFuQMpvg
         GM5A==
X-Gm-Message-State: APuU4Z/K7klC4lQWRhyf7tmE9+HlmWSJdgxLcAkWxtuRm3/B2W36dMdF
	GdN/wE0BUgJNvCrUnh+So15jdZlzeVj6EYbAiVSbg8Ga3275v/xg+22Y1G5TU20x
X-Gm-Gg: AYBFou2i13nBwxEInvUeAh8HEL3mfEI/AGbBMerh+W8lIszMCZR+168me8N6fPzJA1P
	Tqu8/ddULOL0wDkAE0CgBemVKnU0vjOgJXtplAMUx5mcWB2Jl7cVB2AK44LlW6BJSppbThMueLg
	iHLAT/W//S7ked8TS46/eEv8z6Jo6KH590ymAP1kR6GB2nt6S7FrEN//s+zbWOg4gVg1KDJn0Ep
	JhP0Tz8z4dJx6nAeC+zgKB4bPel+Ytds1khMSOY63R1m6MLKxU6TXk72CCtU6jrEKe9P3z6bK26
	3MTtSMkoYo9qlolTsK+RJr8Skjxe0pefTgssOWcan/ANSJW/t2EZDrlwP02HvsVx1Z/q4X/aOpv
	Sg/9c83sE+U7rjEHdHBt2sFKpAoqqYMkC7tNnU91XQt2i74991OSMJgS8o7Bk6n/9pGd2QZanD7
	jDMsIireC3vwo02RJa1I1PzZQyb2/lNpEGBYwZdyWROJHLJwbqyi74RA30yxyvkjZjaFSyRDkB0
	imfH2RPMAoK6al5uHNpjeyc5mk8Cg+/25mejXg26pB1GvTPBd/V5hjW0R5gWHJqY2bkPVafxe3n
	Vstp5gzer6mqTJOQDVShOWJSAZoZZvB2qyGR+qKj05gWKqVBlBfDXpsz3Ur+jja4FRCoDgRBKgS
	TXdP+xfygAuN25CIeF7I0+A==
X-Received: by 2002:a05:600c:621b:b0:4a2:190f:cf6a with SMTP id 5b1f17b1804b1-4b6dfbab213mr61343975e9.35.1794000872318;
        Fri, 06 Nov 2026 13:34:32 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3271867sm9994385e9.6.2026.11.06.13.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:34:31 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v3 2/5] doc: glossary: update per-worktree refs
Date: Fri,  6 Nov 2026 21:31:05 +0000
Message-ID: <0bc902f13d89e2b6c692ae35ddfcf209b088ea0e.1794000450.git.andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794000450.git.andy.koppe@gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com> <cover.1794000450.git.andy.koppe@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "per-worktree ref" entry says that only HEAD and refs under
"refs/bisect/" are per-worktree, but that has been out of date since
a9be29c981 (sequencer: make refs generated by the `label` command
worktree-local, 2018-04-25). All root refs are per-worktree, as are refs
under "refs/worktree/" and "refs/rewritten/". Pseudorefs are specific to
each worktree too.

Bring the list up to date, and refer to git-worktree(1) for how to
access per-worktree refs of other worktrees. In the "worktree" entry,
link to "per-worktree ref" instead of listing HEAD and MERGE_HEAD.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/glossary-content.adoc | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index 668f309a6f..c7ab1c981f 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -494,10 +494,23 @@ exclude;;
 	interface than the <<def_plumbing,plumbing>>.
 
 [[def_per_worktree_ref]]per-worktree ref::
-	Refs that are per-<<def_worktree,worktree>>, rather than
-	global.  This is presently only <<def_HEAD,HEAD>> and any refs
-	that start with `refs/bisect/`, but might later include other
-	unusual refs.
+	A <<def_ref,ref>> that is specific to a <<def_worktree,worktree>>,
+	rather than shared between all worktrees. All <<def_root_ref,root refs>>,
+	for example <<def_HEAD,HEAD>> and `ORIG_HEAD`, are per-worktree, as are
+	refs with the following prefixes:
++
+--
+ - `refs/bisect/`
+
+ - `refs/rewritten/`
+
+ - `refs/worktree/`
+--
++
+<<def_pseudoref,Pseudorefs>> are also specific to each worktree.
++
+See "REFS" in linkgit:git-worktree[1] for how to access the
+per-worktree refs of other worktrees.
 
 [[def_pseudoref]]pseudoref::
 	A name that can be used like a <<def_ref,ref>> to refer to an
@@ -792,5 +805,5 @@ and pseudorefs.
 	"working tree" and repository metadata, most of which are
 	shared among other worktrees of a single repository, and
 	some of which are maintained separately per worktree
-	(e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
-	per-worktree refs and per-worktree configuration file).
+	(e.g. the index, <<def_per_worktree_ref,per-worktree refs>>, and the
+	per-worktree configuration file).
-- 
2.56.0

