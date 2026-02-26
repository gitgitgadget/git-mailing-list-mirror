Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E71A477E2E
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140500; cv=none; b=MWmg8zeBqCGvQBKlMZEyDb19eyHkMiIbtq3pDPbHfXzcF31e2fi0LzS4vOJGk2lzOVAD8dafFjzX5oB00C4Ah8f0F7pF+x+f8vjU+3idyVoUWVkh+JUPeuKa0/wVGVcb4e+0ssGnWD5n8CiemuFYeKq0hq4zjsQo1mbEjnVOLmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140500; c=relaxed/simple;
	bh=oiXpF0oxkOeOXKH6gQ/+Yg9fbS5qQDDRxFxeA/8XdKI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LMqUwLX7MOqMyPqhnlT12sF4oxzZiS48QCRf36ZkO/i6gX90Mq9w6ssRPrLhhHlSGERBvRz4knf09RSc1EI+jh3xpIFwhb4RDxuCC3g3Yve8WOsrJw43+yXcEpbKeafWUY4FJGpfVL50JGBskHH++dIsuJj9/3KlfDitTcP0hbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlZZyHea; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlZZyHea"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-897023602b1so18978726d6.0
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 13:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772140496; x=1772745296; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZgU/MahiXqxFGpQQqToNR0ngzTRutVNuYDENpThLSs=;
        b=HlZZyHeaPLvMxaDdU8SP+qeNJvqiKpcue+g5C2HTL+K56brIdNl3aQw8U4Q3Dfy7sT
         6aXqKSzPRn3TIlcZONWtUhezCOPe378RDxgOLFe0XiJH3ySmsGRBpOBor4e/fKnE676n
         0rhqInY0LlOM1UPL6sLUJ9kmqI9iUlEbnQiIjQI0bkaRpNCr9O2MO8ZeOUTcMxCcKy09
         k8RXpk35x5Uyvd4d/pX+DwT1oiutnAVIF5hSYi2gD7VSxDx7EYz435WPwtppRglemfsw
         lNEkjFe9mJdL54PyG16rcf5to52Oe55vh5r8G20be+aA2GfXM90WX0ThxUx0RzVk4076
         lS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140496; x=1772745296;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZgU/MahiXqxFGpQQqToNR0ngzTRutVNuYDENpThLSs=;
        b=SsJQWx5UX9z1k+D1L7J9AJ+XEK85YnIl2HPHttkor6xgCsg6RcCPE3YIkMyyMq7CfS
         Jl7LP/KbrZSF5RJtysRoUwn/rkyz7PE7YfBFfRUvL6w/Lt3g3K5hWJ1j6Vw3LxTs6pVs
         jV/1lI5RkX3bYUhfa//QOvKS8BM2h4ZjtdonmiFPcc9aKRdDRhJo7FMY3Befp3OG/zAP
         XoMZmZGItp5yFAKYnIV91SKtfSZF1mYAhGofRvZPCXOcElt6eLPMo7qkbzKGAJNB9Wi5
         C5IY5r1NXGiszledUXD2wSktU6LqwGGcRkLupXPSa+YxB+8mx/V6JeDr6HS4pmVDgWEC
         wg0A==
X-Gm-Message-State: AOJu0YznRJJfDRhVZKgdBtV0bElePjwXlczG5Ul/p3RyBuHMZ8GDq+4A
	YG1js1vzcDiN9P1qCs348xxrI1+8GDoUjGz6sPDu2ZJrMNbwsheQpt0sRuCiLg==
X-Gm-Gg: ATEYQzwVWefFdjQx9avYh/zK5XH/+0bMj/LeS86k0LuUoZBNwJ80SI4wJoS/XX6gQue
	3bxHbL1/FJllXaFS6/y9YNVgcexYakjUcJyS8OWVwXeTkMskKbxSxeaGKR9XBKPZ3Lhf5v+trhw
	krUI+sJRhWBEaYTT3ZTVUENpAayxfrhRr4KNbSrLYNd3kxWIc8zt6TIWm2H5krHRKpQiqDgQI4y
	j0d312H80rZUaiXetdR/rU1IRad0CvsOeD49ixIQ4liEYUFj0vaUDzL+lJIMbhdMDVKyCKevFLl
	sed/ACAKXy0GUektOhVxQOz4lMAL1KRnDbCZyv24eJAazIAf6g0EqVvlFn6mbZjk6PDfl1Ex9ka
	NJSSxonfC6TETx/HfPrUgOcKYsHO5pf5cIDtk8HSCQts0zYen3taiwVWufjYawvFVa6zk3TFucj
	kkn0rs5L9zX5wW4lq6HR+pZYTHiw==
X-Received: by 2002:a05:6214:1d0b:b0:895:35ea:8bc6 with SMTP id 6a1803df08f44-899d1e7530amr7537456d6.67.1772140495780;
        Thu, 26 Feb 2026 13:14:55 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf66c515sm296657785a.11.2026.02.26.13.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:14:55 -0800 (PST)
Message-Id: <1751181950734d2571ef85a419ef62000458bd39.1772140487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
	<pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 21:14:43 +0000
Subject: [PATCH v4 06/10] repo: add aggregate structure totals to keyvalue
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
Cc: eslam reda <eslam.reda.div@gmail.com>,
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

