Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF42039B947
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030991; cv=none; b=uKvz14M+cF7HD4Pc8d3wMVzHjnrUO+a3D4p8F3rTevN5y1DG3QS64DpNLI6p9HIGaMzVC5JESQIgoNJh/rqxaGVnB82NgUyUP/Oc0opOADrP5lBLbOs9lOvYATxORXcE9CAseZxKLucIZ9nSRkTMFkzdNgzYSmQ5e/5eaEmCWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030991; c=relaxed/simple;
	bh=PhiU46Geifi0LRurLsSNjlRFVjqXKGywQ2U/K3DuUNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stwKBuZru89mtAfjkeaoF3DnzS7XYDaQ5cGL5vRNn3A0s5DbXTgnKUV0S7vF30MvRy5T+PUIJiAFjUMaK7hYtXYoVZihVxwQsX2seBQd9Gnv2nPEgOcUuaqjkPfIyy/xvLMAqIikk+Eas8rs6IQpGAnS4xohK28W4vp9EUh2OaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6dX41gn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6dX41gn"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so30056325e9.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 05:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030988; x=1784635788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8BXZoQh7HH//4xljc8lXIVvGC/y+JHO0SlRmZlZ8oUw=;
        b=G6dX41gnLAFj0myxjoISCcbcO76TG7x2HKRG5+chxS0lLiH3ac538K7uPKWqps73R3
         vBDijVH21KhzRYiunNRnnR6YL2rtZJ0YJUGBIJDKPYfcJ+h0o5AdLDTRTaXDRcwFcXT0
         T5SBOa2gddJQH82RdpY/APQT3W7O8P4609vIN3AinVK0N8ACegOHMo0f4XKP3SAZ+O5x
         +m2Y9x7OStbVuIqJEI24dnv8PkZgURzwdAIH3f3hEr8l9UPOjZ7GCTGXCoFqXFbdKOBK
         lah1exdAuftMFMUv8svtXXYWQ4suuMBYWyQfJinrFXlxeVDH4LNhlqcR9Y8AjlpF8CDI
         J52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030988; x=1784635788;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8BXZoQh7HH//4xljc8lXIVvGC/y+JHO0SlRmZlZ8oUw=;
        b=eiT4dO+si2B/mqMS8y/7NHxO1TMLaeIyYL0cPDX1AcyFh86zvWqNCzqDIEX449ZVwT
         EbzPqUiOXOc7Z1WrrvMthkSyaBZcndf1+h8Uxjszu5DeOoGKG1tEyOPpqVjPBbvmCXfc
         OV8cE5V5IoO0+AzKOxDZkY2qMoMKjEX4JjLOCbPjAPZOzsWAa3gvXmWRYVP/7kAFlBYN
         Eym4lgHBNe9WH/ZudT3gQH7Hhrc3FXn2XY1Z1VCs2fTYb/xR1VQFKM1+M4ArmXqartUQ
         pgkq8pafbwCCjGfCK7FNR3zxnzhmQnSdmozd610cZDJ/UONIuq9Evpb3jGBPuGBJuFxw
         8jNQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/dvzADNb8tcOyP7sqd3r0ELQmlM5tbppKFNpKZXT+Tf4IhBauB02BLVzVBva1g2n8O0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAbBvwIhybEWDXa/zpFthtS5YyXuC4s6NKeSJZpgioh8Fyv1CX
	OdsygJfJozafwiFUB7dV8uBuEMqlytkGmxqgooUaWLEcgm/8iMI6pIby
X-Gm-Gg: AfdE7cl2DMGFBinQ8VlA7m4c8jO1ChXAm2TiZ/lnJaXQfKTX33KtxWQALmz0Ke/qZHU
	t9NEimPxYVxuMYrWQX3Qs/0ltvvoxwMGAWjOcz9vXcdkxNKy8i7W/Ot2DwfZj6ybUayxDnpaXNW
	my2buDVfuyMd4auH/I4BSY2aQ3IQWT1+lce8WhTUeqeqvDQ/XAuEvt0km/5TPWYigivkrPOYQUg
	IYQdWiB6CgaBaGZ3fUfidxy1D9p14fEHejDQZ8B4h3xFXapS8UQL6R1Mhf9CfRrORO4HSnAEA5W
	JDj2pnFCxTnSV6FAJGyUdDtyyfqTrwOpakm7CXvegUNx4SbxFOj4fxnc96tX99OKb/iFmCZlwA7
	ThoAbG8na0jyMZrfwC4qhwHaO6zNzNOKTt4PziZ8VOushzdW2Oa5+/2PCxpLEYgOCA964OJPkns
	vxEZLn0qg0hkeD9Mb/CscMGt4HzHTvy52jJWXwtS4uxLG2O7CZgWuEMMLf/DJr2R6IZ8o9ZOc2s
	bmoG1wujWMn6S/5qxvxWw9HtGM1JrygymaOwC7NMWVjj/KN9OViNbq6smp50nfSo71xu84zHyJq
	1EBxEX0fGpXCQIwbyUIiPOFX5x8GUW883Fu/b/lrH65MEE/vYyEezp3R+YLV2lhhv/G0BJsjHwA
	Bc4+mo/n+Pw==
X-Received: by 2002:a05:600c:354e:b0:493:c194:4e7a with SMTP id 5b1f17b1804b1-49538992ceamr22148985e9.3.1784030987825;
        Tue, 14 Jul 2026 05:09:47 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c89e5sm7749939f8f.34.2026.07.14.05.09.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 05:09:47 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v12 5/7] graph: wrap cascading commits after 4 columns
Date: Tue, 14 Jul 2026 14:09:36 +0200
Message-ID: <20260714-ps-pre-commit-indent-v12-5-d50938e006df@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-pre-commit-indent-v12-0-d50938e006df@gmail.com>
References: <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
 <20260714-ps-pre-commit-indent-v12-0-d50938e006df@gmail.com>
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
