Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46C1922FB
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758505164; cv=none; b=j7kPSvBTvGMC+mujt5b/5ADOecWOXUS3zgtB0zGN9Oc6HSkUAPYyKZ6Xkn0SW/aDkfmYSvVRxJCaxczaLLixi6SfO5kkuUn6rda/9jkFFjIR+8P6YD9MkF8DQ9mwBZJji3a6fb37KJInk5RuYMWpLY7n7HFWyo0nkFVp0ijp1sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758505164; c=relaxed/simple;
	bh=234h0ekugCcjHqY/oFb94Mj5SDWh5XuDMorwRd9Guv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acRnaHSXBBQkd7FJAGyEImurlfMNuqpJ7KQWj39Yj76YFU2rUrPN40KQYU6eevJeoZO1Q13LfVOCVrfcuKm/LSvnRbi9VBQe58bnSBMcivYnGv3AIVS8Nxli/nihmEM37kWmZ8AbxQClQkiW0KetMf/0tZ05FBYVZPrcx/iKkYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SW5o6n1w; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW5o6n1w"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-73f20120601so13331927b3.2
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 18:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758505162; x=1759109962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cs5ZJvGcBUz2B0iF/IXbnMLMofxHS4FPokW5oz8j9gk=;
        b=SW5o6n1wr0i14JQFDEgJG6faGJ9PbY3NbiIapXgBHfOqJqGVI+3ar3et8+/Se473jx
         FjNd4+4ES1DHzJBDl0Ayh6BB5mcw3Sz6eA+MpV59OnEf4CXn12lu/O8C6cBVgR4MzLod
         Kg3r6cQDVX4207A29kP/vX120AbSg2CnyuqZkPhZVXCckvhjLSSGr6/wmKYHtUtsntdu
         0jHTfDz2vKeVEfkYLlp6egdCcq+d5ZrikGWfXi9f/poh91C7eKsu5+gaMQkpiGw4giAA
         td0RIQiArt+YJnMoPwajQpQnW3jjAUNbpLR0XmR0D2AXg7qJUJxTzJg0QUDHgddp9HY8
         3+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758505162; x=1759109962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cs5ZJvGcBUz2B0iF/IXbnMLMofxHS4FPokW5oz8j9gk=;
        b=hc4N28avLsgBxbgvmk5GPAesXTygoZcGbsMH2BlwxoGeP7w6/30IaEP4mbv7I9pPsb
         yFZPQxIFrifCUrcU1adIqyn5KXJLS01A0UaK3FhaG4wxoMliUoJbSqKpctQn0o82gOWn
         bQ4XfkvcSBeP6ht9PMRosendNpX2MyXJR5FHKDg9zLsYdIwxR3ME2NXk8XV2tLiNOwq+
         HnwOgsyXmIucETg8TWsZr2rgGdG3DT/D+xxSCKYxI5IJmvJ1EsWpQ+B+31h9CEsWeGE4
         CDWUDI6VbXS+uIorv6vygr1TiVQDmfeb6p12cSR6eeo2tRbsBHldKXYaA3050bM441N4
         RP2A==
X-Gm-Message-State: AOJu0Yx9iTuaGpE/Ru009sAyghTrgES+5iZpGHgorSeW8mttRkKaVTDt
	nexxmJZW2806CSeDIXXzi603GFurEQxONMQ+CRU6gk9Y6LOcQzVmfidrubmMD/pa
X-Gm-Gg: ASbGncslOV8ZabB1z+8JcheUQeJll8r1aMIPiZ0fEAy2Xmk8ciyip9it9d4oFIaHP27
	KIuabGfJDwoA9FV4q5FYmJgIazCIkpSQSwVn8C/NAS7CIhqex+mDXrTD0wv7oFqY8R/Qe067fES
	lF00K2wlolawWsFJzCNqaQ8Gcr6HQPVskbeN6i+fSkNeOx0ai96TbYalxl1hg6Wq1p4YOk40i3X
	U0izb/8thiMPYSFW9NV8qxrAkMDKsMktz1/9LorFWWF+XKnDnXguH3oLmZAu6dqoISQYY2pvEor
	+iQT1X/9ZIkWvfZ4vUYsFYpL2k7LbfQwDKSVUya4QChAwxnsKSj//7OSUGGqqX6fZKPdSHvLKxp
	4ED+MPL4ENtsKEj3pmRbBHG9MJvuywOjKp5YRk957qCkpVY24Wfu6B0WhaJvSbrv9oFt9PK3spF
	ej2g==
X-Google-Smtp-Source: AGHT+IEH2G4kClh4elgA8nhwRTUz1CsCCkEX/OgAKITJu8OStvgm/OXNrlraSwUWwtnpI+MLJMMGXQ==
X-Received: by 2002:a05:690c:6c07:b0:74d:b56e:77fe with SMTP id 00721157ae682-74db56e961amr22562287b3.18.1758505162021;
        Sun, 21 Sep 2025 18:39:22 -0700 (PDT)
Received: from localhost.localdomain (69-77-149-20.skybest.com. [69.77.149.20])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-633bcd05dd7sm3942069d50.7.2025.09.21.18.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 18:39:21 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Glen Choo <glencbz@gmail.com>
Subject: [PATCH v3 3/4] stash: refactor private config globals
Date: Sun, 21 Sep 2025 21:39:05 -0400
Message-ID: <bf0a561ce36afe14b6bc03bf851d19b30ef491ad.1758505011.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1758505011.git.ben.knoble+github@gmail.com>
References: <cover.1757982870.git.ben.knoble+github@gmail.com> <cover.1758505011.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A subsequent commit will access a new config variable in the stash
subcommand implementations, which requires the variables to be declared
before the relevant functions. Prep with a pure refactoring change to
consolidate config-related globals with the rest of the globals.

Best-viewed-with: --color-moved
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 builtin/stash.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index cfbd92852a..d9b478d1d1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -127,6 +127,10 @@ static const char * const git_stash_save_usage[] = {
 static const char ref_stash[] = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
+static int show_stat = 1;
+static int show_patch;
+static int show_include_untracked;
+
 /*
  * w_commit is set to the commit containing the working tree
  * b_commit is set to the base commit
@@ -845,10 +849,6 @@ static int list_stash(int argc, const char **argv, const char *prefix,
 	return run_command(&cp);
 }
 
-static int show_stat = 1;
-static int show_patch;
-static int show_include_untracked;
-
 static int git_stash_config(const char *var, const char *value,
 			    const struct config_context *ctx, void *cb)
 {
-- 
2.48.1

