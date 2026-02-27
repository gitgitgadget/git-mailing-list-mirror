Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF474611D1
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220654; cv=none; b=sQRawcgmZljx6hieiF1n01PWIdPrAtnKkIa8rYcLFRe4nbtmGT3d69oAtmj32vQUZ/lXxrRJboAk10r6xgbQ5dX6gVjdMPy6ixsAcmpEsKvXwotJUnQyKT/LyV1+wOF5JwKgdq53mkNb98L2a1f1fMP/E6fPZ5p7hOM9LCCSnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220654; c=relaxed/simple;
	bh=oiXpF0oxkOeOXKH6gQ/+Yg9fbS5qQDDRxFxeA/8XdKI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rh9Y5nUS24ziQZlvvcxi0YkK1jNvLAQ+c51LYFvexH9Uthh7mLCxiUX1BRcsSgKXz+yfNGQlNAQ9BUIUHZpjDdnnk19gFNzcnBe6f2z+FLgNAl8BQWvZXwasxXg+BX7EsrP5kqNX19LRq8KWmHOhx4HmnRVvKtTzWStfr2COuQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9rsW3RI; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9rsW3RI"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1275910b930so1482964c88.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772220651; x=1772825451; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZgU/MahiXqxFGpQQqToNR0ngzTRutVNuYDENpThLSs=;
        b=f9rsW3RI/5if48TfYp7wYORUBlOAOpnworI9JYkIrz28W61Xk5aSSMelUtrUoeZHH8
         bwNQnMwtOnoytFcc08F6oDKyDi07G/vci6sMcoaDklrGhpMnpEUQrajARNuLlw77IYAD
         YNGzTGmpyvdZJk/I40TL0pfOyy7EsMeYk6Sbs3iNUlMqdN/7wq8w5i+SvbWoIaiWLQHL
         24M8+ENLcX3iWDVoC+97dJb10KmvMMZaYNjmX+IjAlNWUlIjB8qAxEgz6EYUQxVu2+1G
         EQt5E7V6xZEaRDh+0llNOktYBhYNiHTH2HPyuZnZdYfPpiE/Pun3QxoFd+9NbFp2b3ls
         ypew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220651; x=1772825451;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZgU/MahiXqxFGpQQqToNR0ngzTRutVNuYDENpThLSs=;
        b=kTXOgFoQ2UNjSasswugV4jufASBHh4X0GYrrjh/xaSbCLFZQH2891uNym3Fu5WQjQF
         a6Iapds5sKQMaJWBWfiTyeF6MjZMNaA89K3/NcWVFl4637K9OMBNSXJgmZUq5RIlsGnv
         8JXJ2aHQYPxFo1/l4uxC9sRNX7EpEPci/xVMDT5DURDgcOoKntsT03qcCr3K+ezKF6N2
         wyX2Ykl+LflTMLrMxy94uPnBecGytEAwlKQnnr4lXDH+k3J489rE++gUjnxw+apSlbh/
         q7OViToL3kzk0EQtI3QhLWDmu1/K2HGO7rrAI9vvM9U1F7o2EN/1u5cQ3aiQJ2OumEcL
         a8nQ==
X-Gm-Message-State: AOJu0YxVcdjubVZrXqOtDj3OfBrzakczO24Ix1M8QN8gQfQ4D9OLeRRU
	POW1za5SHf2yusASYsiZpdrT/ABbtzeg5P7aQ69KMhTw7TQlg5nMvehSAMazhg==
X-Gm-Gg: ATEYQzyt8mpBFNKf1zQl0rE5UA1HCNhtBSLXbvEeXHEsKMoKi+bqoRYJpx+6qvF3bJU
	AJsQ+eUhA7O3GWKi/fLHbponxS9+Z12gLsG9zB/cgslGPE62nc8OkSv1lRdzBrKMpmdnbEQrTgt
	Rqk+iqaELtBF4joOnQIoLNegTlF9++YbpGZcOvo8l7qcx15tow3UHXI3s9pBd2KvmYpbxIMw7C/
	K2X1pdH1KbNC2997XZXg6Wl2BWQb6snUwecv2Uor+1eNd1AmkPyqXR6Ae17MdQ8XFMw4xG6+uRw
	JD2GNii6C3EfyERM2psxb/3XXZBd0+0M8E7iqdHt+bSwzTVZQk5copMAfg+0nOr7VNgQRzr7Vsm
	li66WbJu68PUUTCea5Hc1WDBCKi+OfaVKTqPs0ez8PsYjwZ6i+XpdbHuJARrK7K2bnWmsLL40Ic
	07OqNggSCpk8XNY/jFhPfAPmM7xb8=
X-Received: by 2002:a05:7022:618e:b0:127:fa:7758 with SMTP id a92af1059eb24-1278906e079mr3529519c88.9.1772220650679;
        Fri, 27 Feb 2026 11:30:50 -0800 (PST)
Received: from [127.0.0.1] ([172.184.191.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f81be1sm4239330eec.33.2026.02.27.11.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:30:50 -0800 (PST)
Message-Id: <1751181950734d2571ef85a419ef62000458bd39.1772220640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
References: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
	<pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 19:30:35 +0000
Subject: [PATCH v5 06/11] repo: add aggregate structure totals to keyvalue
 output
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Expose aggregate totals alongside per-type values in structure
keyvalue/nul output: total references, total objects, total
inflated size, and total disk size.

These totals remove the need for callers to recompute sums
externally.

Keeping aggregate and per-type values in the same output format
improves script ergonomics.

It also keeps machine-readable output aligned with what table mode
summarizes for humans.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/builtin/repo.c b/builtin/repo.c
index f92c209469..cb70171412 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -824,9 +824,16 @@ static void stats_table_clear(struct stats_table *table)
 static void structure_keyvalue_print(struct repo_structure *stats,
 				     char key_delim, char value_delim)
 {
+	size_t references_count_total = get_total_reference_count(&stats->refs);
+	size_t object_count_total = get_total_object_values(&stats->objects.type_counts);
+	size_t inflated_size_total = get_total_object_values(&stats->objects.inflated_sizes);
+	size_t disk_size_total = get_total_object_values(&stats->objects.disk_sizes);
 	size_t max_inflated_size = get_max_object_value(&stats->objects.max_inflated_sizes);
 	size_t max_disk_size = get_max_object_value(&stats->objects.max_disk_sizes);
 
+	printf("references.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)references_count_total, value_delim);
+
 	printf("references.branches.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->refs.branches, value_delim);
 	printf("references.tags.count%c%" PRIuMAX "%c", key_delim,
@@ -836,6 +843,9 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("references.others.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->refs.others, value_delim);
 
+	printf("objects.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)object_count_total, value_delim);
+
 	printf("objects.commits.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.type_counts.commits, value_delim);
 	printf("objects.trees.count%c%" PRIuMAX "%c", key_delim,
@@ -845,6 +855,9 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.type_counts.tags, value_delim);
 
+	printf("objects.inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)inflated_size_total, value_delim);
+
 	printf("objects.commits.inflated_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.inflated_sizes.commits, value_delim);
 	printf("objects.trees.inflated_size%c%" PRIuMAX "%c", key_delim,
@@ -865,6 +878,9 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.max_inflated_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.max_inflated_sizes.tags, value_delim);
 
+	printf("objects.disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)disk_size_total, value_delim);
+
 	printf("objects.max_disk_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)max_disk_size, value_delim);
 	printf("objects.commits.max_disk_size%c%" PRIuMAX "%c", key_delim,
-- 
gitgitgadget

