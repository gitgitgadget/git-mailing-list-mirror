Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747524;
	b=ExpiUUDy+LIjNDgkLOdjKgP+/kkaCLRb8THZWN39oh5xWrPcPMJF7XvdQlCxT/qk6kiQ
	 /VmXJqhQVW/vJVi9bIJztVYILHGOk3NlbssuoHbndLFvg3ZwrGRcl8xKya+LTOKZPMO+h
	 QLOBhNM6nAe1rVlexWWpZk5DGMhT+QF1eaN8GNAjSeF0/C5quyRP94I1yd9glShuRPawf
	 j5GPFf005kjBlY6YgvkxUqxf2s/o7+lGmQ0rj/Z/ThIzyfHqqwQ2pZ2jN/wBuNiGKE0TD
	 7SFkOoxCafJ7r+J7H1ocjdGJfm89mmCqqfM66StRHnr6k1C27KB3pwJD7l8wo/xWgIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KIUf8k1/UJuvhkldYefB8C6xRY/ivTOoegS6+hsbCSw=;
	b=nd7vSXAFQNdPBWyrYqrdRCyCeVQJoPVCs428kozGQrIdBAPkUQwRk6bGYk2ZjPyGXI/W
	 xPX8W4fFU7jqonmCvn0dPzrIe89hY/zvZ6IWbjz/2erL4z3qxyTclv9JcBfa2x1aDfoow
	 3D5NSOi19mHfjBg/ZImBqeiN1CluHafW72dv4oLEQ7KYzPzDWiHzL3USUhUCDWOdwnx2F
	 Nr+2wiuAOrbD/41iTQVmvcXUOQMgCnlCeWd0u7xkMj4uwHk+ZXionCM+/WpiYvcNM0xeB
	 lmHXPxLaQ2QYsUWq9YmNxYBRNxuTnGW8P1VAitr4Q/JFAkDKPSgwjXIDbTzLp1OC9SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xr5tc6X6;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B243B606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 23:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B243B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xr5tc6X6
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso557735e9.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 15:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793747522; x=1794352322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KIUf8k1/UJuvhkldYefB8C6xRY/ivTOoegS6+hsbCSw=;
        b=xr5tc6X6KrgXPFQpZMjNMax72vFJ4QjSjnt0/ZByTwt+Nn3/nIORI2MMA6f5kjzr7O
         5+Ly8bzT/EoSY+vn3EzGaCwsSUtsV9DaptEqODtNtx70ygAAUow8UTEXY+l/drofucMs
         IjptO6F6uotoaimblpR7g6v3NVUaYTzuzURJxLBdxDcQCoUXGglBLAQguwEOXDqnzw2j
         eeGf+hGWxsfD3N2WZ3T9+RCtd9zU6BCDYStSij/FGQAYqYJouiH3ALu1hhyzxbV0z+VI
         69cv+fwPE+OfDCHYVw8JUyW7gvVJuGtYYELcxolXLMO0sJSYGITq+rHHyB0oT5unzima
         BKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793747522; x=1794352322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KIUf8k1/UJuvhkldYefB8C6xRY/ivTOoegS6+hsbCSw=;
        b=AcU8tGUNRVwJHDPeIBXvicO9OnP0Zmf/lZP2s6qUjmbn2dfsJ+o5TWrpMxEVUDrwyI
         RnaaFcRUbgMmbycH7H72sOm0cTsTiRz94zmK3xX6aJmCJMOCopLrWflxtKUfM9Hb4n63
         lyW5m8JyxrhP0U8KPRtz92O9TOeeCSWWETeHw5APp7sbhroh8ST+lArih9pubK/oxk0C
         X5DFz/kocvBb4gD9Q4Fms4W2+EmfUuP0dsICWYjnaZzwgc52m8kaizK5X2x3D4zHufJb
         sy2IoiZG3Iea4+eW+IajzT5qnOFE6txdvw/aqOSHQMHRRu3KM+MRydyTVJd2USsYV8Xj
         HuXg==
X-Gm-Message-State: APuU4Z+QY53TOc88n26xtddfEAezwzquzmoVx1/H2hFqXK3jh1f91YA5
	lJmVjrV3sRAzIhwFe1OtGnCQag38INUPRFoU1uHv5bLvKaShEnc+IEg8DW8E0CQd
X-Gm-Gg: AYBFou2T7681QjnEQABIuST+esRlkGt2XnkOrqAfl/sdgGMORSgRVpuVuxm+53612h4
	f79V040BPGGzuR37lfKvP1aPlnPQot15q0acY2Pwso2pEwTLIK2T0gphKpOLu2Vi7c8d8j+shX3
	EZMHQ6nKZm03pUSJUdpHC8VYRgKS7wHJbzpDTFnDr0WBvJV17+2audL58A0Z6q+wOwyFQZwVX3t
	Amhx1AGmYCfH6E+5Zs53svcI59UurBB8LTo9p2wveVCjxq/PX9TRHd+LcOIdb8u4Aip1J7D7G1p
	qirryK76xIviVK2xmk2yUpfXPvo8bcX/mB14iFHUx6HT4YHnrXh8Zb8iQ8Be0/NV3vcTWQzGCtS
	UoyIGibVVCj4JY335CCdVejVx55l+ygbo/K6RZhXGKW3kJqiuq9/eGW9ZITXfSig62eQl9aMz8M
	P06L53JljVnstEfkhqw1QJznYUcYD+3/Rg/R1cMhVSCTVTgPwc5Yx8XkkfY7hU+8JdCFOfD20i+
	xsovCxt43FIkJmglVoIriwLWYzx4tzCoWzKH5qJfqR+rh7TQZaJeQOnQoeIrcxZ4Q77sYray2fJ
	gTqLdtoY9vjHXGy1THa1elMAeciHCweWJFKzM73DszaiTUK3AgyO117tXvQY0/af6C4GTqLEM5E
	OeSg8UoH9VXh+WymPvMXdgEjtFfxDyQ==
X-Received: by 2002:a05:600c:1987:b0:4a1:6517:ccf1 with SMTP id 5b1f17b1804b1-4ac16fa2edbmr334840085e9.9.1793747521842;
        Tue, 03 Nov 2026 15:12:01 -0800 (PST)
Received: from KURSA (ipservice-092-208-105-158.092.208.pools.vodafone-ip.de. [92.208.105.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4104d600fsm14452415e9.0.2026.11.03.15.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:12:01 -0800 (PST)
From: Caspar Duregger <caspar.duregger@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	gitster@pobox.com,
	krka@spotify.com,
	karthik.188@gmail.com,
	chandrapratap3519@gmail.com,
	Caspar Duregger <caspar.duregger@gmail.com>
Subject: [PATCH] graph: do not indent visual roots with columns to their right
Date: Wed,  4 Nov 2026 00:11:53 +0100
Message-ID: <20261103231153.289762-1-caspar.duregger@gmail.com>
X-Mailer: git-send-email 2.56.0.windows.3
In-Reply-To: <CAFzd1+4Jx_sWvMrV10gi9400BBNJOUXW0WwsypiM7yCh5x8fow@mail.gmail.com>
References: <CAFzd1+4Jx_sWvMrV10gi9400BBNJOUXW0WwsypiM7yCh5x8fow@mail.gmail.com>
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

Since a34c00d96 (graph: indent visual root in graph, 2026-07-14), a
visual root that has a child is drawn indented, connected to its child
by an extra GRAPH_PRE_ROOT line.  When there are columns to the right
of the root, this breaks the graph:

	*   M
	|\
	 \ |
	  * | R
	 /
	| * T
	|/
	* B

graph_output_pre_root_line() writes the extra " " for the root column
without shifting the columns to its right, so they are drawn between
two columns.  graph_output_commit_line() then pushes them one column
to the right, but the following GRAPH_COLLAPSING line is computed from
the mapping, which knows nothing about that offset.  The column next
to R does not continue into the next line, and with more columns to
the right of R one of them goes nowhere.

But in this situation the indentation is not needed in the first
place.  The columns to the right of the root collapse into its column
once it is rendered, so the collapsing line always leaves a blank
right below the root, and the next commit cannot end up vertically
adjacent to it.

Do not consider a commit a visual root when there are columns to its
right, which gives:

	*   M
	|\
	* | R
	 /
	| * T
	|/
	* B

Signed-off-by: Caspar Duregger <caspar.duregger@gmail.com>
---
 graph.c                          | 12 ++++++++++++
 t/t4218-log-graph-indentation.sh | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/graph.c b/graph.c
index 28bef1b88..95eef3a95 100644
--- a/graph.c
+++ b/graph.c
@@ -969,10 +969,22 @@ static int graph_is_visual_root(struct git_graph *graph,
 	 * already a column, so it will not be rendered below, the
 	 * current commit has to act as the last commit and omit
 	 * indentation.
+	 *
+	 * If there are columns to the right of the commit, they collapse
+	 * into its column once it is rendered, so nothing can be rendered
+	 * right below it and there is no need to indent it.
+	 *
+	 *   * | <- visual root with a column to its right
+	 *    /
+	 *   | *
+	 *
+	 * Indenting it would also push these columns to the right, but
+	 * the collapsing code does not know about that offset.
 	 */
 	return graph_is_visual_root_candidate(graph->commit, graph) &&
 	       !(graph->commit_in_columns &&
 		 graph->columns[graph->commit_index].is_merge_parent) &&
+	       graph->commit_index + 1 >= graph->num_columns &&
 	       flags->is_next_visible &&
 	       (!flags->next_has_column || graph->visual_root_depth > 0);
 }
diff --git a/t/t4218-log-graph-indentation.sh b/t/t4218-log-graph-indentation.sh
index 24dc9b497..b3b9f7c14 100755
--- a/t/t4218-log-graph-indentation.sh
+++ b/t/t4218-log-graph-indentation.sh
@@ -449,6 +449,24 @@ test_expect_success 'two unrelated merges' '
 	EOF
 '
 
+test_expect_success 'visual root with columns to its right is not indented' '
+	create_orphan _70 && test_commit 70_A &&
+	git checkout -b _71 && test_commit 71_A &&
+	create_orphan _72 && test_commit 72_A &&
+	TREE=$(git write-tree) &&
+	MERGE=$(git commit-tree $TREE -p _72 -p _70 -m 72_merge) &&
+	git reset --hard $MERGE &&
+	lib_test_check_graph _72 _71 <<-\EOF
+	*   72_merge
+	|\
+	* | 72_A
+	 /
+	| * 71_A
+	|/
+	* 70_A
+	EOF
+'
+
 test_expect_success '--max-count treats the last visible commit as the last commit' '
 	lib_test_check_graph --max-count=2 _8 _9 _10 <<-\EOF
 	  * 10_A
-- 
2.56.0.windows.3

