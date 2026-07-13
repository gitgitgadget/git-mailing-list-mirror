Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD693002D1
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961516; cv=none; b=dYm2ZHNqfJWQO2llBguFxe48Q2EoCdrraKbUXxiSznrFImx3tPE6ysiAXJjTtwnECdDrF2rsHAOhUcK2mtjnOwJVzF8gCJLIGDfsag0qg8DHxWfwyBTdiMzz5dAupXltpt2GAunO+w32+kP2ZX7qYOvuVJAhQwhU/nWY29U5St8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961516; c=relaxed/simple;
	bh=PhiU46Geifi0LRurLsSNjlRFVjqXKGywQ2U/K3DuUNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NcjehgWApPDeZN5l2vQdBmvwwxqFzNymrXb2yqn9/6vcqW9//scXoB44rYWk0l/awRM37iXjlKuw8Es3W2Pmjp1LEyQ+OmZM2tk45GU7eZcmaseL6V2wBptgTTZ/1tEEOyDEwtgMDs9eooVxZs/LueC/McjkKYjp4vnf+vgqPMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssGm9YTg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssGm9YTg"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso70170a12.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783961514; x=1784566314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8BXZoQh7HH//4xljc8lXIVvGC/y+JHO0SlRmZlZ8oUw=;
        b=ssGm9YTgPRvr4gZFcsO1zWPalb8juKzHPtKf1/jGSlr5PUwh5Eieeszyrw9KVB+jn+
         51hxg6Qe9MTC6YQYNSeZSvI5Ks35TlgneVH98D+tSkN6G3pO+jNhJGrwUOUoJbI/KCCP
         UhBUWr2hj9SHdchHfDOrwrf99bMWQAE1pq7WkwzNBak/Bp43sPNAr5yFZ/J9c9N+NPq7
         DaP0Es2ZrRB0H/CkFmzENfzcTSWxfux0nqo3uJGSPdoRYja1U2fLqF/8Oh7CBevXdxLl
         R4p0LicWu/aXAkPmrDz1apTvhIqE0Zxq3YnwWsrKa7bwNIyj/GE9VZ9UrxK/x1fAI/bP
         q2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961514; x=1784566314;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8BXZoQh7HH//4xljc8lXIVvGC/y+JHO0SlRmZlZ8oUw=;
        b=aBTn35lON/dyWL+Tvf99qv1O316UIu7rCUJ0gP2Z3yhwOFKpa+yBhsLoKMYdFRvg73
         7OfNtkAP4Cw5+L4NpS9bxxEj9659KWyPe9wvLb5pMfAgnDjKD6zt+SnK3hZm9qzsoF+M
         GXYoB+u4Td2sTmNnXhGJIgRsj4owkJYksQSUvcIths0+Zv0Q336DeP4qHex0cTHJnreq
         sqElTZFWOlCofB8aQa4wGDWByHrY0DpqvSBWnsAIeOIj39DbKUWChlAUJAhwE4boxTqq
         jSLnp55TWatFKt2yTOCHl/qSqu4xD/McBnvJBbi8faRRqa8sy6TClFWkrc4wi14IZd0K
         O/6g==
X-Gm-Message-State: AOJu0YwAp2EYvDEAzacIDZwcMz49xUa3R231XeJ6lk1Fogb41MGhXNQH
	JV4tvA3gWrE98mE4qVQTnDhpi8ETKIMeiCWuCAHiNa62HPG7so4creQWgtxQZBJb
X-Gm-Gg: AfdE7ck6yCUGQ5m08CmIiVQh8JOdFGKU/464inI3tVBx0aQN4bNLW9oXFYzYAo3IAxl
	pZvYYJubBohjBmiFq2jdrRBjJno8k4m4Jaw3pbwGf4/+DUoUfK6yykVG9ge4nQegRdDQvD6wz+s
	6jpGqdSazEkITWffckn8RJ5K8k703wk0eeqqQnAK/cto9j4jiXQuAB9NW8HJGz0f48ECwNXEkpy
	D11xhwqSQeXZKmzfoGRpMMXdnldqVFKaR06hejSdSdp6vO/sxWDn8PNCyZPQUBGIRj9KiCZWy3T
	Fw50jzyYoFvEnl0lyM1f30Ay7ahUM0r2C3YwqKkbvr04tK/6Z/97WhsTIKwbInGJR00G2zz8lHH
	6by//n1KLeJMtIKQ2jMZkVAe3TFKCKUrID5WGjxkdeq+032NpIWbW2S3xDZ9hTN8m13z7bj+ifo
	YiUW1QGSM5vyWQbzZhr4smQ8CB2YCnTRmLlyD9v/10GG/R5rRXjbksYdS5x3cH3oX0F+U7JXHDU
	G7Thg81gjT0gL8yDGRSAtm+hIKnDR7Uss1SrwGqi+geXtb/LS7vk0Nw1huEUyENCqWVAEn7vlXz
	EuIf60+MWqIO1qmSY8af4h5cOLCswHFQ+v+WRZSl6TJh5l9uGNe/Cb8NB6xCnyvP/IiDNAAO1/n
	wBopd271iEg==
X-Received: by 2002:a05:6000:26c2:b0:47e:4379:a4f1 with SMTP id ffacd0b85a97d-47f2dcb5be3mr11611156f8f.6.1783961053044;
        Mon, 13 Jul 2026 09:44:13 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a96fdsm653768f8f.24.2026.07.13.09.44.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 09:44:12 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v11 5/7] graph: wrap cascading commits after 4 columns
Date: Mon, 13 Jul 2026 18:44:02 +0200
Message-ID: <20260713-ps-pre-commit-indent-v11-5-dcb65bc4ba99@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
References: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
 <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the visual root commits in a graph cascade indefinitely until
a commit which is not a visual root or the last commit appears.
On filters like --author where one author might contribute mostly on
single patches this can become a visual issue.

Make the cascading wrap after 4 columns.

There are two possible cases of the wrap:

1. No ambiguity:

* A
  * B
    * C
      * D
* E
  * F

2. Ambiguous conflict:

If F happens to not be a visual root and E gets wrapped back to the
initial column then E and F would be vertically adjacent. The solution
is to forcefully indent E one level:

* A
  * B
    * C
      * D
  * E
* F
* F

The magic number 4 comes as the minimum number of columns to wrap where
the output shows clearly the commits are unrelated and doesn't cause too
much "pyramid" effects

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c                          | 22 +++++++++++++++++++++-
 t/t4218-log-graph-indentation.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/graph.c b/graph.c
index 087094189f..e3e206170c 100644
--- a/graph.c
+++ b/graph.c
@@ -1042,6 +1042,23 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 		 */
 		if (!graph->visual_root_depth && flags.is_next_visual_root)
 			graph->visual_root_cascade = 1;
+
+		/*
+		 * We wrap the cascading at a max of four columns at most, after
+		 * that we wrap it back to the initial column.
+		 *
+		 * This could cause ambiguity in case of the next commit not
+		 * being a visual root and be at the initial column after the
+		 * first wrap.
+		 *
+		 * In case of being a non-visual-root the next, stop the
+		 * cascading to get the commit indented.
+		 */
+		if (!flags.is_next_visual_root &&
+		    graph->visual_root_depth &&
+		    !(graph->visual_root_depth % 4))
+			graph->visual_root_cascade = 0;
+
 		graph->visual_root_depth++;
 	} else {
 		graph->visual_root_depth = 0;
@@ -1328,8 +1345,11 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 				 * Each visual column is 2 characters wide.
 				 * Omit the indentation for the first visual
 				 * root in cascade mode.
+				 *
+				 * Have a max of 4 columns when cascading, after
+				 * that wrap it and repeat.
 				 */
-				int padding = (depth - graph->visual_root_cascade) * 2;
+				int padding = ((depth - graph->visual_root_cascade) % 4) * 2;
 				graph_line_addchars(line, ' ', padding);
 				graph->width += padding;
 			}
diff --git a/t/t4218-log-graph-indentation.sh b/t/t4218-log-graph-indentation.sh
index 60c7d84af7..d4c850c0d4 100755
--- a/t/t4218-log-graph-indentation.sh
+++ b/t/t4218-log-graph-indentation.sh
@@ -511,4 +511,33 @@ test_expect_success '--grep skipped parent makes a visual root' '
 	EOF
 '
 
+# The cascading wraps after 4 columns and when wraping (column % 4 == 0) if the
+# next is a non visual-root, force indentation to avoid an ambiguous graph
+# (commit 59_A is forcefully indented)
+test_expect_success 'visual root cascading gets wrapped after 4 columns' '
+	create_orphan _58 && test_commit 58_A && test_commit 58_B &&
+	create_orphan _59 && test_commit 59_A &&
+	create_orphan _60 && test_commit 60_A &&
+	create_orphan _61 && test_commit 61_A &&
+	create_orphan _62 && test_commit 62_A &&
+	create_orphan _63 && test_commit 63_A &&
+	create_orphan _64 && test_commit 64_A &&
+	create_orphan _65 && test_commit 65_A &&
+	create_orphan _66 && test_commit 66_A &&
+	create_orphan _67 && test_commit 67_A &&
+	lib_test_check_graph _58 _59 _60 _61 _62 _63 _64 _65 _66 _67 <<-\EOF
+	* 67_A
+	  * 66_A
+	    * 65_A
+	      * 64_A
+	* 63_A
+	  * 62_A
+	    * 61_A
+	      * 60_A
+	  * 59_A
+	* 58_B
+	* 58_A
+	EOF
+'
+
 test_done

-- 
2.54.0
