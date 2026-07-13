Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D72EB856
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939506; cv=none; b=ZNKr2B7UJ2gTYdQpLw6EV4nuUMPI+PUbYblXsPpcQywyooSd22csPZYnw3Q327Y2rx/5rD9Y3GMnsqdvqzBkGkeqSDogHBKHBKjphiYYngfJoB7viASixZ8cwNeiBbezapqNEnzB2NDTfn9bldAJdnUQswpnWaH/b8Zf99Uv9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939506; c=relaxed/simple;
	bh=PhiU46Geifi0LRurLsSNjlRFVjqXKGywQ2U/K3DuUNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5cmiOAewcBONkJnNlmBiIyPkjM3owefx5OMraJSVjD+vhO8SjaQe3GkCeiyG8ldoCweRX8y12O1EJG+0f6L/CYrs0v0Ho3QUlroZ9jCV/hCxJfB6LZunGJWW04njvnUg2oyTH3i8wAY/xOcEAisiXNoJKIARzPxF1fyOJ/FbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi74bfp0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi74bfp0"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b77b150aso25052435e9.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783939503; x=1784544303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8BXZoQh7HH//4xljc8lXIVvGC/y+JHO0SlRmZlZ8oUw=;
        b=Qi74bfp02XszZyrIMN3MB+2TwM7NIKt1uQrVSqQTZf439BaTTgXAfqYOqndimcF7vo
         Ku4hu+3WPTC41Ft4UA8zEJi9rXMl8nQz5XG8cbYYV6rIvovyOaqquA9PgGXRdb07yZMX
         7Jsmgydj7f0HaHDSn3eKiE8sotwqjWKIMMqUo5QjjjMiyk1lDjUPjhphh73Y9qXnMoYP
         iezeTPCbgIi1HWlSra2hbOE8Anonwy3RBzeztVsrfIexz783Hz208JnyKTrnoBDaSfPg
         exw0ZasNSf0BvaxJmkUB2FrP32zYkaoWfwuG/9zGJfvHo8Kobs+o03vq5YoNG9EM0Xn6
         N2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783939503; x=1784544303;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8BXZoQh7HH//4xljc8lXIVvGC/y+JHO0SlRmZlZ8oUw=;
        b=LHtnDaW7WNAqY+XAkLZKJNuRZ7Jk5nRADUJmU/IHWb2hBQjWgWkJ4l5NGe/X5FZM9+
         q4cUpVlxrO3+M24zPEEq5KNv/rpMyCOVFqPLul3M6BRBNp4B8SmDfBmu3E+ApIw9Bs2m
         G9WnDV12lh0CHHQUxlMBWpVoKh0bYEi1Q0TaY5kH2A8EwtZiRJadGRCS/G5aApXut1SY
         LumIZaKK3qkhjsQGUayYAOFLci423fy5sUlcOKvNIgsbNA8naUphPtF4G6DsVVBgS3Fr
         0q8Ynv1dLrPoLFU+XmQmazpm49jsZ5o8h8EvJFYv/NG6V77PQ3QBxEGnPlRvr2LPICRM
         X0CQ==
X-Gm-Message-State: AOJu0Yytx6U31PtwXFOQQSePvZpkasVfT28fiyf+cxUPTWJkZ97RsQfZ
	znGKza4A1/kXSc+Y2mz8R1ToFGrgZoWQe+CPFWTS2VjF3GcmniNQWLlvTKa0QSeo
X-Gm-Gg: AfdE7cme8JWUinpd4AGnHNmtFDklwNFRl0y/6BSrke4K718o6dKwvZIEla55z+bXGx2
	jQ360kRAeMNe0y4hUDAJ3m9tokKmYXpqh4kjNbq1eUGkuDxAfER2x7dzgpUfw1eDjuLQQOKnrj0
	jQMaSnQFebuSgSOuRd4K1JaC4o9dsNhPYCKhwZx7iKcMFrJ43Ic2WJYg37wk6eKDvM5cNYRGLNm
	6PfDav4XSX/AN34HzdnTpNVRCGXyJrzhyNIjM7eYIRUljKLS4jSS7v7Wg1UNWMREbBkBOwIybvN
	2eIlXQH6bIOa1UknJ5+RQH/SKGtJmqTIemjFRbBCZ1m4M8RTi1aoh/dbcZdXzzsSFuwOws6mOmf
	xpvPrpboAUa08KK3DvdL46aqKsgBXD0YM2ITEY19b4L+1aozEaHqoFIZUuWdS8bzsUtTaw8yimg
	RYv7BHHbH0wt02IcKp7rXwf0vkqmeVRcYhRP/Zg+9Tb4ji0CcMjLauQC+umfo/2E69b6k0XNQcB
	O3LbHCCW66Tza5i6epFDhNwKMvX8AHDtVwsJvlkOP4YqX4CMlIqoNtWXK4EKE/o6E1SkUAXb3b9
	2xU4Sbh2JCZXma5NaBGZICeWS+S0w6JYh0nRr7ML86bhYnAicR+Yw7usGOx0CWH2W3gZ5ODQrtD
	gXfLK/jWvhGBsV3o/lOcxYAWjSCEMz6k=
X-Received: by 2002:a05:600c:3e88:b0:493:915b:dc4a with SMTP id 5b1f17b1804b1-493f87d8a97mr80070175e9.8.1783939502663;
        Mon, 13 Jul 2026 03:45:02 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73b161sm318564645e9.9.2026.07.13.03.45.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 03:45:02 -0700 (PDT)
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
Subject: [PATCH v10 5/7] graph: wrap cascading commits after 4 columns
Date: Mon, 13 Jul 2026 12:44:40 +0200
Message-ID: <20260713-ps-pre-commit-indent-v10-5-82ddab26bc96@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
References: <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
 <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
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
