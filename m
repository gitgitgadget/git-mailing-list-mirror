Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348650;
	b=LKgi7Rzr2kEHzpQffBpn1EbCoXrORtlfSNkRBEsQ2dmbjDWHMeMcKwepiay0SLp3FnyT
	 7r/Xu2a+AAiHspfns/gf0cJF9j67MH7SmzC43nj+aOMUvtIOXiYyr/gpSo3Aw2jMhs5LG
	 wXuEdbYGYloErEZIP1pdah1FqnIigDjCkdp+5zR2MUMQYJUhlLmuTTfayhi6IXl4T3ki4
	 eM33nrZLdQeFY8dVqYBYha4Xk+yOu0ERz0U12ufcffITsqykinBlWrjVh9bN086uaJVgZ
	 kB2yn1HmGZ5FL3kajS+RAFu4/RnZWtcFpkn+gsiTYokv6f9ZTD3lAorPO+d85UsNd2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=LEX3C3763seSlfqL4OjNA6bBzNjpiaYd6OBbyTKWBYU=;
	b=S612UwxaXFUY3l5ubm/zRJf0OSj2VHbHvlNpbmXpvUqOmAI9jO66LFht8xLY0bwWJXuR
	 NEVdoY1+Nf/ly+f/9KCy4N9GFGkBywBm3das/bVUXEhDmxiW1an+Fg8j4Eils+lEKAyPF
	 W7vyM79fkxANBXJh3/3foht5eGY33/JpRn/xJA+Nfs9t7gOiYeSwI3kBHXD1/YisT2nli
	 R1bRI1hmcmCi1DN4gdmmazPowNlNIB+YEI7BykIGijY5cbgqGhglx5bhaIpBAbqd5B03B
	 1D7QCtQziAaeY6DYUeFjehXKVzGZ4BrJQFq8/a4GcmMxaa+l3dO7LBBUZ2TfvwHM6DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="QYar4/MM";
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3BA606A33F
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 11:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF3BA606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QYar4/MM
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b244fb7fffso2256922c88.1
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 03:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795348649; x=1795953449; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LEX3C3763seSlfqL4OjNA6bBzNjpiaYd6OBbyTKWBYU=;
        b=QYar4/MMTcS2YimTNLq4Ffa//DKqk8sdF6QsAcQ+UY36a9gS2p43H6eGIHYdSmV034
         j2dkdSCe+5TAVIC3IQ149DlYTZBZp1QAPgzs4H4ro1BWKZxTHNVe2arGiuyvZlKZHs23
         e9tnLN+53E82GC/e78mX0+O7QmhXdpw1/hqaGY++d8Sf6lk9uqejk/dchfTBfGLX5pdd
         2o2lciD1azMcmZNBI6Uwq5V0UPmk5L+xRwoU0hMyj9rkO0GimVfuWS2bvlBPNVfTPMUI
         Ba6vyBasQT5eexZaSedCVEJa0JllKUgrQGuQEkagj8LATwnsNAN/No0i26i2ve5ZmvlT
         09cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348649; x=1795953449;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LEX3C3763seSlfqL4OjNA6bBzNjpiaYd6OBbyTKWBYU=;
        b=cQHPW2UOxhsIUpNVYvuv7f6eG9lgBwQumITcPhmIzVyLkvJs5M+LqGdlGF5KZ9l4iL
         Bco85TXV4pqAYQw0ME7eBvBn4jkT7/zXCPKmFvNb8lInkWZVpcQuxlkgzeU+HudUsUiB
         FbKPYy4cmvn9hwgaYAkULKZsIEvU9FVAsq4cLKcDz5tLv5lgbvJijdEzOgLOzU3NJ3cQ
         m623HiJpiAh5s6etEQvJNxB3+VZIh0ElKrNnQTsz1F/UaXoC2jbMITw1JV877clZRuHe
         wEHhrFyxJfddcYKMJ4fMHYq7YB3uUY28iv3mJA39+9b2cx8HXcf+Fluy6SRCmGtzPUvv
         eIJg==
X-Gm-Message-State: APuU4Z8j2YJxJdICYZ2keJ1Gjv6fKTG4EXcNzKFe96AkDSg4X4UaXPfT
	NJCsVVM2pSaClHpu45yUbUNysInywDkaEkVxsjg6SoUNH9CaAbnknR+0K9uAkA==
X-Gm-Gg: AZFdTZfzd5x8+uSIOmwvPCbzuClsIwdnBv1oHA2aeKcqTHnrUEdqEFHmWH7dGCph3yh
	CSuEt3YlMQ4pTMPp9RnS1IcCvrFdfZCM7WjgoYXKYcEHmD23kuGLISuM6N9Az6YpEG5wRd5UOMi
	7kzhWPJ4i7k7FkbXXv88Gd1eRtS3Mxyyypvd5jXtAmhB2PiYQazNTXNZ9EBNhfBxDkp58fmn7dI
	CVbMROCwhgqf/npTT4kNd/sBgAyVbQWMrUnCJX4VHCV2pEz8ZbCB45qqjQhxLD2g4uqKkoo7J3m
	xm3fpHW8aRqZvEauHHBBRR/1nVDdQhyJXBK0DhFN7WIIZ8R0hquOHJzdnqRC687JG0vF02tzlrX
	N1XJTdKXD0x8VYehzonwTALOBCfPh7fVDDP1vvNYwADRRtZGC3nxi7g6211tElqwJOT99y96+1y
	Zhxvdgpczakha8Y4zECkjZDQATqnMbi+M6949s90cjUx9pUjlUb4puG4nCa22eRL+agfdL2zBPN
	JP2TBPX/ebdo1RDFY2a8a4epvChvImNCZWX/05hbFn3vlCPVRVhsL9Kt2yCBrqs5mYT9ZOhVJv/
	/j1BdiRdwkGzFT0CzE+OOiB/kqX8WoQ6Gw==
X-Received: by 2002:a05:701b:4281:20b0:14d:c7ae:85dd with SMTP id a92af1059eb24-1b55686523bmr9107418c88.7.1795348648823;
        Sun, 22 Nov 2026 03:57:28 -0800 (PST)
Received: from [127.0.0.1] ([20.184.150.246])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm29252283c88.14.2026.11.22.03.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:57:28 -0800 (PST)
Message-Id: <f848c9b0a889f32f2bbe54fca4b45d2cad5d7ccd.1795348644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Nov 2026 11:57:19 +0000
Subject: [PATCH v15 2/7] fetch: let --refmap apply to configured refspecs
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

"git fetch --refmap=<map> <remote>" without refspecs on the command
line dies with "--refmap option is only meaningful with command-line
refspec(s)". So there is no way to fetch what remote.<name>.fetch
normally fetches and store it somewhere else for one invocation.

Let the option apply there as well. The configured refspecs still
decide what is fetched, and the refs are stored through <map> instead
of at the destinations configured in remote.<name>.fetch. The command
line overrides the configuration, the same way refspecs given on the
command line override remote.<name>.fetch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/fetch-options.adoc |  8 ++++++--
 builtin/fetch.c                  | 15 +++++++++++++--
 t/t5510-fetch.sh                 |  9 +++++++--
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 327169cee7..27f2ac6dc7 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -239,8 +239,12 @@ endif::git-pull[]
 	specified refspec (can be given more than once) to map the
 	refs to remote-tracking branches, instead of the values of
 	`remote.<name>.fetch` configuration variables for the remote
-	repository.  A ref fetched with a destination of its own
-	(`<src>:<dst>`) is stored only there and is not mapped.
+	repository.  A refspec on the command line with a destination
+	of its own (`<src>:<dst>`) is stored only there and is not
+	mapped.  Without refspecs on the command line, the
+	`remote.<name>.fetch` values still decide what is fetched, and
+	the refs are stored through the specified refspec instead of
+	at the destinations configured there.
 	Providing an empty _<refspec>_ to the
 	`--refmap` option causes Git to ignore the configured
 	refspecs and rely entirely on the refspecs supplied as
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0ee252e353..ccff0075c9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -291,6 +291,14 @@ static void map_refs_without_dst(const struct ref *ref_map,
 	free_refs(unmapped);
 }
 
+static void drop_destinations(struct ref *ref_map)
+{
+	for (struct ref *rm = ref_map; rm; rm = rm->next) {
+		free_one_ref(rm->peer_ref);
+		rm->peer_ref = NULL;
+	}
+}
+
 static void create_fetch_oidset(struct ref **head, struct oidset *out)
 {
 	struct ref *rm = *head;
@@ -585,8 +593,6 @@ static struct ref *get_ref_map(struct remote *remote,
 			for (i = 0; i < remote->fetch.nr; i++)
 				get_fetch_map(ref_map, &remote->fetch.items[i],
 					      &oref_tail, 1);
-	} else if (refmap.nr) {
-		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
 		/* Use the defaults */
 		struct branch *branch = branch_get(NULL);
@@ -621,6 +627,11 @@ static struct ref *get_ref_map(struct remote *remote,
 			ref_map->fetch_head_status = FETCH_HEAD_MERGE;
 			tail = &ref_map->next;
 		}
+
+		if (refmap.nr) {
+			drop_destinations(ref_map);
+			map_refs_without_dst(ref_map, &refmap, &oref_tail);
+		}
 	}
 
 	if (tags == TAGS_SET) {
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4b40ec965a..412a5401a8 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -906,10 +906,15 @@ test_expect_success 'explicit pull should update tracking' '
 	)
 '
 
-test_expect_success 'explicit --refmap is allowed only with command-line refspec' '
+test_expect_success '--refmap without command-line refspec replaces where remote.*.fetch stores' '
 	(
 		cd three &&
-		test_must_fail git fetch --refmap="*:refs/remotes/none/*"
+		git update-ref refs/remotes/origin/main base-origin-main &&
+		o=$(git rev-parse --verify refs/remotes/origin/main) &&
+		git fetch --refmap="refs/heads/*:refs/remotes/none/*" origin &&
+		n=$(git rev-parse --verify refs/remotes/origin/main) &&
+		test "$o" = "$n" &&
+		git rev-parse --verify refs/remotes/none/main
 	)
 '
 
-- 
gitgitgadget

