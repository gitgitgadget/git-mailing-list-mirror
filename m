Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72931DE8AE
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 04:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754628076; cv=none; b=QbKuTWIvoMGD73N8ZSWv22+JOo6DpqjjVYGdLem7ueyq0WlMCtROu/8ZD1H3727MzdJW+0tUOXvZhPrAHK7yu1RUrPSyT6o64mTLoWLnqfpAUP+CCXE0IC/bXhEII+UN02sAbijbNaBkpM0gUmVH5T1/e6G3EbXeijO/oHhoEhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754628076; c=relaxed/simple;
	bh=JYOs0PwuRKj7DV625MZwsH0tLPl8shcixxWdgCiIp24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OK6ai/wpMw3KWlqjpe427oZY/LYXBIShTU57FFRtF75cBQ1fiay53hLoIbz0H21PGBHHKJ7rpN1LdXR/Q8mWtGnaBXZqjGhA4dqXREoTIs3sFxyeNNMvBmR9V6v9iwqDzy9PlhqY+t5MSXJAIt1hZl/x4LLW6fByFdgl6dZVDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImQuIGQv; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImQuIGQv"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b3510c22173so239018a12.0
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 21:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754628074; x=1755232874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ddzbjpuw714LkBS4h8wNcv5NVsS/nu+u/gc+SYmAbcM=;
        b=ImQuIGQvSADLuCjFX81m0+HSi09jU9wiu1BveN5NmNIsZgQoU/bQdTeaAkGThOkSuR
         iTFZhuiZX7IL5dd7Z+/4lxQfS217OnpzCA8j9VwTO9r/LcZK/bpk0AXCOr0m7pZB9bqF
         TDp85l73nGOwDkpJU7+5bLAuGnS8iJ9RF1gw0bamCOWjdevoQOmT4fofAKZbMiJMnM5X
         6LIGx6/N/IO5210sjyCVsyeYhR+XiqrkcY928ERz5HHm1L8X+bI6KpnhRWoMfq5Ea/Ep
         GIoYxRFlowyQMYEKXfATJr6d3cjjPPifTQUl9+LSwsKcJGCG9sr1OmcgOl/Ro1urcFKI
         tZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754628074; x=1755232874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ddzbjpuw714LkBS4h8wNcv5NVsS/nu+u/gc+SYmAbcM=;
        b=gy1KnhfIAFNavv7l+YbcAmP6wFXSF+FIzZ20YyEMH8dFnm6zU8IGg/3TEGCl43q2cP
         JnSmnuL6Ky9tELZ0+rwdaE4jEXe3tVoh4YyseJzKQIWWQ2a6Z83WSJ8yEEKmO0Pq1zc9
         JYAlv6hs1zVViLqu0uCLjYrkXQ/TvAOhOr/3gnzk5sStNDOBx8fvYNMNCh0zaE3SKncA
         e3tLsH1kz0MryYZ0xfsPTX+9JL51bGCGTl4SNYLfxFapzpgBUYjfoYlxuA8p7Ddr1qqK
         lMKsopYP8IKOCnhPABcpkdU599a97cGkLz0l9mOKVYRb6WAQ3ALWrXmfotivFQnEgwyn
         u6SQ==
X-Gm-Message-State: AOJu0YwfEzk1WbOp0p5meLeONq72miVl8j9pyiFpXGIS6ivBVitnP9qt
	jfQL/jcyTyOwltv5rbJd0U8xwms911mIAIOdlp8x+coaixw3qttMew2ON3MbAQ==
X-Gm-Gg: ASbGncsconJdF6HthVJoEzomGhyyMDZDf6XQ1Mz01Valn6xXGcy3m/iRKQjx1dV5jir
	wIuH1xWaY+vdsXJI3uTiKxve1fvPks1IsHrqfJmsyKHM2QX+iZg7kKfCGWtp6LUcv6vv73sJ/k/
	9WRe1jy124FL7FjRtiIR1tSlPnBrhS95YEbooq8v2PulOPtK85EhZ7Wj/1u0/fv/1v5puK5TwdJ
	WHRTmxlek7A7wwrmEyy9y5+Va6wK+tGV/UqHI+pRwi8Judhxru/NhAxuGGjlsP3+nU2uPtzSQBf
	gOLtZlfGfMAn956Gx1tc4zU3hjbK2dG0cYYiQ+Lqhs3C4xzCeg9FWi3bfMiiZEJyGnwjM5KOUtz
	8DA6PNe67x6hlyg+kiNwJqL2U8chE+Q==
X-Google-Smtp-Source: AGHT+IEhVsWy3YQL5CMi5RMeVs0j/KkDuJPdJno6Kv0jHGQGTIPW3j0IddnqY55MazCMhbA1WDB4AA==
X-Received: by 2002:a05:6a20:e617:b0:1ee:cb87:79f0 with SMTP id adf61e73a8af0-240551e2b26mr1150413637.4.1754628073854;
        Thu, 07 Aug 2025 21:41:13 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf067e310sm14399409b3a.25.2025.08.07.21.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 21:41:13 -0700 (PDT)
Date: Thu, 7 Aug 2025 21:41:11 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 2/3] remote.c: convert if-else ladder to switch
Message-ID: <ee6d69bcafeda9d8a2cdfd1f8bb62c28c13941f9.1754627874.git.liu.denton@gmail.com>
References: <cover.1754455931.git.liu.denton@gmail.com>
 <cover.1754627874.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754627874.git.liu.denton@gmail.com>

For better readability, convert the if-else ladder into a switch
statement.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index 88f991795b..61e2c9951a 100644
--- a/remote.c
+++ b/remote.c
@@ -1171,7 +1171,6 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 						 const char *matched_src_name)
 {
 	struct object_id oid;
-	enum object_type type;
 
 	/*
 	 * TRANSLATORS: "matches '%s'%" is the <dst> part of "git push
@@ -1196,28 +1195,33 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 		BUG("'%s' is not a valid object, "
 		    "match_explicit_lhs() should catch this!",
 		    matched_src_name);
-	type = odb_read_object_info(the_repository->objects, &oid, NULL);
-	if (type == OBJ_COMMIT) {
+
+	switch (odb_read_object_info(the_repository->objects, &oid, NULL)) {
+	case OBJ_COMMIT:
 		advise(_("The <src> part of the refspec is a commit object.\n"
 			 "Did you mean to create a new branch by pushing to\n"
 			 "'%s:refs/heads/%s'?"),
 		       matched_src_name, dst_value);
-	} else if (type == OBJ_TAG) {
+		break;
+	case OBJ_TAG:
 		advise(_("The <src> part of the refspec is a tag object.\n"
 			 "Did you mean to create a new tag by pushing to\n"
 			 "'%s:refs/tags/%s'?"),
 		       matched_src_name, dst_value);
-	} else if (type == OBJ_TREE) {
+		break;
+	case OBJ_TREE:
 		advise(_("The <src> part of the refspec is a tree object.\n"
 			 "Did you mean to tag a new tree by pushing to\n"
 			 "'%s:refs/tags/%s'?"),
 		       matched_src_name, dst_value);
-	} else if (type == OBJ_BLOB) {
+		break;
+	case OBJ_BLOB:
 		advise(_("The <src> part of the refspec is a blob object.\n"
 			 "Did you mean to tag a new blob by pushing to\n"
 			 "'%s:refs/tags/%s'?"),
 		       matched_src_name, dst_value);
-	} else {
+		break;
+	default:
 		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
 		    matched_src_name, type);
 	}
-- 
2.50.1

