Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348648;
	b=Jp5qyo/riQ27NtphDFs5ubfXHgwrinzcXdlHihusgwCMfOp9WW11rqJt+eXTraNQF/a3
	 9K1XMlAMah4fcH9BhugKSD3QmLTdK4JZOFHCgJMbC+26KfwyB4gK8ESiadaNvNc8K07+W
	 Com7/3gquW/DcBxbrIrVPxYn+bDZb0wUYZyvDt7Nf2ZJFtrmsjDgfi5ycIqfZTuzBzkbV
	 3hbEgmGe9a716IE20la7UvXSvxiy+watIRhXNt0LE6383BdR9pB7txFTDs9wboiMJD9x0
	 p6issWPH3Aeuv20A/6WjwxPv+OD85P6gYqh/+gVu/eiO5AEwj6sLEJ1KWxVhau0/PkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Ln4wJUY6q9GxGl6mKJV5laBPV9BANBTQVevXpjKWVIE=;
	b=M4t6k2Ih3hl5+QVPbPvhN1UZ1fiMTT2o4kki+zeMwDHrvPEXJsaye7Op+9AaN4NLwq39
	 uI+qJroYmaEXFhUalqGA+vQHGN2F90AJs+ttSepbdzvOErtuKwy1el2FQJtS4YaZ9MWof
	 Vw6oKD8QRY5668x+nTmQrJ54LSaJl4mlQ5gFDKRd3livC13IEm4Eida00YphgucLWg149
	 J/2571rQAEkPEnkuAi+x/C3ZvPCI8Prnsi0mwqunXxnThTTRwqCEdq3ixZADqUdu3QW3r
	 9SwdRFQ+0Krj4dmelrQL474xEO8fFmS1lDr5vgO5j6KbALfaNZWLWbuHTIsHNgaRH0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hpD/WBpx";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7089E606A32A
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 11:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7089E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hpD/WBpx
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36a315ed211so3002325eec.0
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 03:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795348647; x=1795953447; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ln4wJUY6q9GxGl6mKJV5laBPV9BANBTQVevXpjKWVIE=;
        b=hpD/WBpxccTOqCAP0Xa/L0lCfpMtyqEzl7kdiJauVoNjfe2d6qLZihMA5dWs/qPdJv
         I6aTg7g+Ah45PbCCTw63c/e1mjKhF6DmVqA6SPpxUQcAlzwlRVAcc1JlR7WtEwSZpSTn
         tfZJcjZXEEs9XnZPweOpTDyD4JLlY49/eb1ytYv5gmsR3ueYUcJAsvDjE82/lS/JcjJU
         suOOcOiFklZY5OovWLpf8Zs1vVBmMlEbNuZ/VH+/Oq+mbVVVpIW0nMW6iBXKz/TWcuWi
         RLja921ksgYx9X8v6SUYRydyQz3VnjFjmD529YHqE7HVNfuZ5kdnIC31+rFbbXkhoPEB
         E6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348647; x=1795953447;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ln4wJUY6q9GxGl6mKJV5laBPV9BANBTQVevXpjKWVIE=;
        b=fHRu2Mseq/k8LwpuRpwIZh8cSIqmp+WiYF2ryq9bpZqrfWlxbMaHKga2XSUp9IsDIm
         1r0SG2dRVnk6tCB5gisVkrtYNh9wIKLHiLXVan6Exrvxy6ked+OFdlzCtEvKNG8XRVQc
         3WsVx/cS+RdiP19XQWBOL5WsTazJBLyuddemHQLfFoeH0I8j5rxY93pMD/B1/aUK3Kzd
         MIMWpn7B6R533rWvn61hhvbx3zOhR7fSsYxekcr7dMch2qM/2LOX2/QPLJ2+3/bpbeUp
         NEXmv9PCsYYKF7+JLiquxWEQ+QAaL9D9FlJhTEQNomC+PAIKFz7Fy3mG4aJL8G+X2Kn5
         4MEA==
X-Gm-Message-State: APuU4Z+M56m1BCFQ2q9m45OH02n2Q6q4RnjyqY04Yu89YyxsC8bp1E52
	3AoFm1M+zCFv4ud6i5G21TmUWBhylorXU0ewdP08pJw4YfbNDvF0eqidXgG6HA==
X-Gm-Gg: AZFdTZc1uv4/RbsZWMVmAFpqIyIy82KsMrAOPK6MzP1v4V+gh/16xnXgzKiXtsiY5hd
	cqSdkAbZ0FX/QdFNFtAQEUgItRYgnBrERIo3SWZMz0+CZbK3S6JYken1mmWPbCvcayYSJX75F35
	etFvGrJxtboK2IoCSTC7zzywx/ihr56oID7pgofnTg6XTCf9D9tMvOF+l232ibo6oWpVZAyKbnH
	pseGxHlvJh/VyTwr7/RQJkqCBPFHvQthaw8fQLshCde/88GEXTzkOzgavUExquCHhqWTph4j5RB
	gHcwnbWdJ+M5u/babP1Y2zpOYNp2LMFcedLSAIOQzeS+uRAzIw5h+4CDYuzuATEZOSQmHCjYf7j
	VJUmFdzZBX1o3M0i/UYZaC9i2toEp2xsW1kofq6snKXxA7D449ai5piz5+zsJBMYQ6N39ktwTAt
	TNQEt2eg+9CCw5FLxLE/FrBlCHXQFXOl41smjd/JottbjTFDxp398608bpTyL1OSDGt68eFhjq3
	sq9vF2S8q13oxbJSzWoaT8J6Wp83Z5Lq5cYghTzsoja/Z3UWGOjOq3UXIJIG7F2WIAzEV9f6505
	MXtUv8Rj+57ThPcRUnwvS+Tdi6T68czOmA==
X-Received: by 2002:a05:7301:dd8e:b0:386:6c8e:b4f7 with SMTP id 5a478bee46e88-3866c8ebd4bmr7276153eec.12.1795348647429;
        Sun, 22 Nov 2026 03:57:27 -0800 (PST)
Received: from [127.0.0.1] ([20.184.150.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm21814068eec.25.2026.11.22.03.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:57:26 -0800 (PST)
Message-Id: <02bffb6b357264afd84ea32ee2717fab8f7ac363.1795348644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Nov 2026 11:57:18 +0000
Subject: [PATCH v15 1/7] fetch: do not apply --refmap to a refspec with a
 destination
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git fetch --refmap=<map> <remote> <src>:<dst>" stores the fetched
ref twice, once at <dst> and once where <map> sends <src>. That is
harmless while --refmap has to be typed on the same command line,
but the next commit lets a remote configure a default for --refmap,
and then a refspec that names its own destination would have no way
to say "store it only here".

Apply --refmap only to refspecs that have no destination of their
own. A refspec with a destination is stored there and nowhere else.

The opportunistic update of remote-tracking branches through
remote.<name>.fetch is left alone, so "git fetch origin main:tmp"
still updates origin/main.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/fetch-options.adoc |  4 +++-
 builtin/fetch.c                  | 31 ++++++++++++++++++++++++-------
 t/t5510-fetch.sh                 | 12 ++++++++++++
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 47dea1de8e..327169cee7 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -239,7 +239,9 @@ endif::git-pull[]
 	specified refspec (can be given more than once) to map the
 	refs to remote-tracking branches, instead of the values of
 	`remote.<name>.fetch` configuration variables for the remote
-	repository.  Providing an empty _<refspec>_ to the
+	repository.  A ref fetched with a destination of its own
+	(`<src>:<dst>`) is stored only there and is not mapped.
+	Providing an empty _<refspec>_ to the
 	`--refmap` option causes Git to ignore the configured
 	refspecs and rely entirely on the refspecs supplied as
 	command-line arguments. See section on "Configured Remote-tracking
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c646bc6698..0ee252e353 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -274,6 +274,23 @@ static void add_merge_config(struct ref **head,
 	}
 }
 
+static void map_refs_without_dst(const struct ref *ref_map,
+				 const struct refspec *refmap,
+				 struct ref ***tail)
+{
+	struct ref *unmapped = NULL, **unmapped_tail = &unmapped;
+
+	for (const struct ref *rm = ref_map; rm; rm = rm->next) {
+		if (rm->peer_ref)
+			continue;
+		*unmapped_tail = copy_ref(rm);
+		unmapped_tail = &(*unmapped_tail)->next;
+	}
+	for (int i = 0; i < refmap->nr; i++)
+		get_fetch_map(unmapped, &refmap->items[i], tail, 1);
+	free_refs(unmapped);
+}
+
 static void create_fetch_oidset(struct ref **head, struct oidset *out)
 {
 	struct ref *rm = *head;
@@ -530,8 +547,6 @@ static struct ref *get_ref_map(struct remote *remote,
 		filter_prefetch_refspec(&remote->fetch);
 
 	if (rs->nr) {
-		struct refspec *fetch_refspec;
-
 		for (i = 0; i < rs->nr; i++) {
 			get_fetch_map(remote_refs, &rs->items[i], &tail, 0);
 			if (rs->items[i].dst && rs->items[i].dst[0])
@@ -560,14 +575,16 @@ static struct ref *get_ref_map(struct remote *remote,
 		 * which has FETCH_HEAD_NOT_FOR_MERGE, is not removed
 		 * by ref_remove_duplicates() in favor of one of these
 		 * opportunistic entries with FETCH_HEAD_IGNORE.
+		 *
+		 * A refspec that names its own destination is not
+		 * mapped through --refmap.
 		 */
 		if (refmap.nr)
-			fetch_refspec = &refmap;
+			map_refs_without_dst(ref_map, &refmap, &oref_tail);
 		else
-			fetch_refspec = &remote->fetch;
-
-		for (i = 0; i < fetch_refspec->nr; i++)
-			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
+			for (i = 0; i < remote->fetch.nr; i++)
+				get_fetch_map(ref_map, &remote->fetch.items[i],
+					      &oref_tail, 1);
 	} else if (refmap.nr) {
 		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5b27f1d5bb..4b40ec965a 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -927,6 +927,18 @@ test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
 	)
 '
 
+test_expect_success '--refmap is not applied to a refspec with a destination' '
+	git branch -f side &&
+	(
+		cd three &&
+		git fetch --refmap="refs/heads/*:refs/remotes/mapped/*" origin \
+			main:refs/remotes/custom/main side &&
+		git rev-parse --verify refs/remotes/custom/main &&
+		test_must_fail git rev-parse --verify refs/remotes/mapped/main &&
+		git rev-parse --verify refs/remotes/mapped/side
+	)
+'
+
 test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
 	git branch -f side &&
 	(
-- 
gitgitgadget

