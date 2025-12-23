Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3123254A2
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488301; cv=none; b=gK4FpwWNX5eJPOhC9FtxIutolAWYHnW7bw2FvTMNoYh5+yAxXZwMh/bgfNPPm3rZAKqXOkzB/zuZlJRDklx6mJSRs+VgKzmiUJoWKEhfJjAbwTngLd7hc/Ji546ZGijD2JdwqToH3yV69q0Vqq/m6LE4Ugn8GQNTYtfJYGuCrJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488301; c=relaxed/simple;
	bh=S7t4OIE/7mIbFBpIs5Lufc++h6LqeVIDALSfK06E3Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xfk43ayplMXuZvWNmrk741xC06A7hXllW+mmMWWXqgTbmRagkUQNurn5twVBkxeksxtb9RAa+IHXTvp5VCF0g9slyG7EsUo0vVdzRXXtNpZ4+r2JJBTQXf4rYt0IAmG0+hsLbLpTWVOgWObf2louRuSiaOoSMupDWIWXW3LQQEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxFTxMXW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxFTxMXW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso48428775e9.3
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 03:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766488296; x=1767093096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kstQLa7z6+9GsPcKk9eo0+iJ/ZOvZmL53Dbf+oC1/ps=;
        b=PxFTxMXWwFDSeNn/dwpbcShC2iYpXXckf0Yws6+FplEnowydcJgppHZgImoIMZk1J+
         8BnRWgXAirw8EgoVWC3N4wH6SkjhjvXJogrZdg7Dbh8zYuQfwf2VXu46A3KdU57spUB9
         kqfKVJDqtbDoxBeYeErcjqqTk+NkIw1BlLM3c9BYVuJmwa4MMqIPMB8CBFnJAL9aGR7H
         x9EboxsVfCcTk/s1jWMBvfCK4gqu2Q8Vf3XxFuVbGG4XpJwdQYnjCw9gcIYxgdibgDab
         zh0+R/Z6n4e3td5bylsx94nJTJFE/em6BoCwlryo30w3VsL6AHqTHVHpLrKGK6le50N+
         HuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766488296; x=1767093096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kstQLa7z6+9GsPcKk9eo0+iJ/ZOvZmL53Dbf+oC1/ps=;
        b=emFo9vjCrounBM5zZeKg9Femub+QfwZUp2/j90YN+bHIBb00GdGHh2i7kHl0VS5omS
         X49YC8d1DysiE/JmRV0O+Mbk1/Q6OBECx9eMGvKpM5ExvpLGePUbMz07a0SDdpzeBSy5
         T4ykaIVvQptPjHn6O64IG67EOmouLjtQa9byysekZIcVHe9/iuK2aobyvPeGDvLRBWls
         DH3cMaEx4pN+8C++bBjyhTQ2uHQpYDnnDfc4C9e8rgXL6o0WLH0yy8GrYSHBnCtGe/cK
         rY2Owgmarj3KcP6ZbCh2PGIKZPM2nJPGCfvrbwAaDnPRdllbJLwSELSGxMdEX3i4QFhs
         G4xg==
X-Gm-Message-State: AOJu0Yw+VqR0mbbPUz6EX4crKZLkc89Oe9XAtEkNJAHeGDZ9aYMGejf6
	ocSwYb/5uRoUu2Ejd8UggDROxaMLamaOmbBukioGs2sC6HkUPzoaswZMazYaOw==
X-Gm-Gg: AY/fxX6KygToTmYZpA5CG0EMooYYrjPC5Kw39DLBtA1YV8y+zHCFhuT2EXa9v9V3ohg
	QxBxoG1me9S0hI4Q/xc03P7Xh/8RDyfXXrmGljQ2GIA02EgY2DHMUELUmBtmtD9UOVGW7g2SOgp
	4fzF4wO8pUMUOzO6h/uEpD77NV6xS8C4d6kIj5yv4jw6HKlt+8PA2oZJK9NAGiIxZnJW2ILr/yQ
	h79tyr10Z53EGZQO/7o51obv4hrNekC5qbFTmDhCvDMMCfXJ0WYqwtliwL338FCay3xVzwe8ca0
	lsxPBcWelQSXCFtEPP/lZYhIzqhcq5GUzOoM0WY/ei9QcEbDe8XilXjDZsJMeMKC1/xCg+/1+qg
	kaPV3sP3LitikZQzcU4I0OER1nytaoYQVnxbvUrdwK9UMz9NmTq5P7qdo3JgaVGNeUrWgxOgxpD
	GUomHw69D5/CzptG95f8WHuHZ0tDPPSl416m73Nrb1G0BMEfIvijQUBjF6LtL0lJiZAFISHSAhx
	xGqb51BoEtP/200ouH8QVJxBdA=
X-Google-Smtp-Source: AGHT+IEpZ/bvY7y08thejEfqnLF3uPXwtHiEyUyf+uh21B5YJHR3jczbp0FWTF2jxtRpsNH5HIVNkA==
X-Received: by 2002:a5d:5f54:0:b0:431:abb:942f with SMTP id ffacd0b85a97d-4324e708ed8mr17383025f8f.54.1766488296330;
        Tue, 23 Dec 2025 03:11:36 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227e0sm27932795f8f.17.2025.12.23.03.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 03:11:35 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/9] clone: make filter_options local to cmd_clone()
Date: Tue, 23 Dec 2025 12:11:07 +0100
Message-ID: <20251223111113.47473-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.319.gfcaffa7898
In-Reply-To: <20251223111113.47473-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `struct list_objects_filter_options filter_options` variable used
in "builtin/clone.c" to store the parsed filters specified by
`--filter=<filterspec>` is currently a static variable global to the
file.

As we are going to use it more in a following commit, it could become
a bit less easy to understand how it's managed.

To avoid that, let's make it clear that it's owned by cmd_clone() by
moving its definition into that function and making it non-static.

The only additional change to make this work is to pass it as an
argument to checkout(). So it's a small quite cheap cleanup anyway.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b19b302b06..186e5498d4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -77,7 +77,6 @@ static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
-static struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
 static int config_filter_submodules = -1;    /* unspecified */
 static int option_remote_submodules;
 
@@ -634,7 +633,9 @@ static int git_sparse_checkout_init(const char *repo)
 	return result;
 }
 
-static int checkout(int submodule_progress, int filter_submodules,
+static int checkout(int submodule_progress,
+		    struct list_objects_filter_options *filter_options,
+		    int filter_submodules,
 		    enum ref_storage_format ref_storage_format)
 {
 	struct object_id oid;
@@ -723,9 +724,9 @@ static int checkout(int submodule_progress, int filter_submodules,
 			strvec_pushf(&cmd.args, "--ref-format=%s",
 				     ref_storage_format_to_name(ref_storage_format));
 
-		if (filter_submodules && filter_options.choice)
+		if (filter_submodules && filter_options->choice)
 			strvec_pushf(&cmd.args, "--filter=%s",
-				     expand_list_objects_filter_spec(&filter_options));
+				     expand_list_objects_filter_spec(filter_options));
 
 		if (option_single_branch >= 0)
 			strvec_push(&cmd.args, option_single_branch ?
@@ -903,6 +904,7 @@ int cmd_clone(int argc,
 	enum transport_family family = TRANSPORT_FAMILY_ALL;
 	struct string_list option_config = STRING_LIST_INIT_DUP;
 	int option_dissociate = 0;
+	struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
 	int option_filter_submodules = -1; /* unspecified */
 	struct string_list server_options = STRING_LIST_INIT_NODUP;
 	const char *bundle_uri = NULL;
@@ -1625,9 +1627,13 @@ int cmd_clone(int argc,
 		return 1;
 
 	junk_mode = JUNK_LEAVE_REPO;
-	err = checkout(submodule_progress, filter_submodules,
+	err = checkout(submodule_progress,
+		       &filter_options,
+		       filter_submodules,
 		       ref_storage_format);
 
+	list_objects_filter_release(&filter_options);
+
 	string_list_clear(&option_not, 0);
 	string_list_clear(&option_config, 0);
 	string_list_clear(&server_options, 0);
-- 
2.52.0.319.gfcaffa7898

