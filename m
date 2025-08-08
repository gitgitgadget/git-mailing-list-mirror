Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE826FD88
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637893; cv=none; b=t3QuiL0p4eduQwrfQuC6exHjB+mOgpy7ZPdxjG4be5MfWPmyQk/AR9LAL7dttgf14A1f/XBPjTh/RPLqpBs7jOFWHha1WsUKshPNYhsLcfMG55CdkAOk8IQjLryHMYgTo5ycXZxE1514l+R20Ds+9w6I1hoc1Ucdw/a0nklcLk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637893; c=relaxed/simple;
	bh=W8T8e1MNax9rk+TYOoC3IFlJa97wxurK56/lOePHTvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg7uWNN7rFruiHqKHd9PorXNWxG8Cu1rP3ZfaGaAMNTKh2KEvdEIn4LoxMJ5PVSaRVmm+zkiG1AYkFCAgCqH06j2XO42DjazxU3wICZxBQpwXiuNzfQk++ky7ZfXtQOZJZMIbh1N3WaV12ltLqsHj4kindsxKIHjUUVdO1Vp7zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeRKUW8N; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeRKUW8N"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b422499c9deso88033a12.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 00:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754637891; x=1755242691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIL2zHZOcEOqx6jwc1sYAA/GvOLPMiR+SeGZXKoQeFw=;
        b=CeRKUW8NMh+IvQDUndOMbhHY7HC2q+yxApC1bkmPGbxQYbzKas889rwQMgmIYIoBNK
         /LajhS2hxKAt3135MJmAIOAQhb3cM+EsDQ1Fu5U4zVOxD650lgeV/79x7RcI3iEp/GQg
         GUErNoVZRhdVVnotR1LpZGZZ8lx1EaxLBhYDv3TaRsmjWb9hdVCGZuYj6x2ckg+kE9gt
         +zY2HLGUx2i0mPbK/6wrwivmdObnRMQeI27js7UBZmXJMTD3qxJJCE77OfSSkDj2KDyR
         wNvsb5bPXzN6yC+DqxSs/7VXudXxnX1thucSqY5KnyPwzq5VTtQgrzVhiAjbAlI+LEVh
         kf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754637891; x=1755242691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIL2zHZOcEOqx6jwc1sYAA/GvOLPMiR+SeGZXKoQeFw=;
        b=tMRrzHmDSKebDa5Mkmcvt15MIbmZNWOMvgowJSQkKS7/loMSy5WQOyaMvm+MTd3Sfx
         zOP36VoEcwcH0ts4zJaRvPmW4NrUMHzL2A4wIh8VeCQFsPI5nfQW/vRdzaCEE3jwBVvx
         K4EHFLgl0v/2J373QxOhWZGoUxx9gDTeANPVrkdzqGncnyR+WZZR4AKwn7roJjlmsbAV
         TrFurfcIupT77xZSjVzp7Sg5aedQXr4556oHwvqn1jnjfM/VVzjhtHBvmP9DZs/0tVC4
         g/aaNTqigdm2tNKuAhg/A+5tO1mgkABctYOLpSAQFhK4ikKB8NY/UX4cxE4pvKHDcOc5
         yfjg==
X-Gm-Message-State: AOJu0YxTrH+pqWKNj6HXc9gRM4jv9XCcddwEOd1BqhEu7CY9CGh3TV7M
	O1EcLXaw2NbEAa7OW1QGkGFQNyimQwvCp/HcHCWg49W4IQaOAJsdQCoK+gtpEA==
X-Gm-Gg: ASbGncssHa4AoTLh4ezu9jI/jKZRT3fLcjtH1r1ARCHEsh5T6gUj276SdPpzmO3Wg35
	rJ6sgfjAMn5WWGYiRF14WvPIWXLUagaGTIQ/ueicsRITLDllM6Df52SlsEcnQ+GGGVda3wAqLhX
	Et1vdeeXoVDTxvE0xK/mXSao0yX0HQIEHtOoEKQ5+r9vsfcbWVfha9b9SELbnse5qo0jQO27SSg
	UmC4+tUR6tWpDzKKjgS319QgMmCZta8a09BvvHZBs3ENHG4nrOjZlUY8B3n8+Wx61jm24Xu5uX0
	kbXr4prJHxWIJVQM2Zi1Q+C3Lq4W7YVyXzS6g7mC8mhnzVUV8Y9rjtuLAQenrNcqknVsB5o/Pwr
	Wi0OKwDsbqJ9Hf0zrYlQPjAROFkbF6A==
X-Google-Smtp-Source: AGHT+IGpldJu/YvxoBdNrM+NG/wt4OVLwBBuDGV4fHg/wH6/yo7Znl/ihodRB3r00+RdMRltBPuIYw==
X-Received: by 2002:a05:6a00:811:b0:76b:cb84:36a5 with SMTP id d2e1a72fcca58-76c46134da7mr1406576b3a.3.1754637891337;
        Fri, 08 Aug 2025 00:24:51 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f48fsm19742760b3a.40.2025.08.08.00.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 00:24:50 -0700 (PDT)
Date: Fri, 8 Aug 2025 00:24:48 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 3/3] remote.c: convert if-else ladder to switch
Message-ID: <cbda61af5c33a5ca4e7dcf2cfa5a2068e9483a6c.1754637850.git.liu.denton@gmail.com>
References: <cover.1754627874.git.liu.denton@gmail.com>
 <cover.1754637849.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754637849.git.liu.denton@gmail.com>

For better readability, convert the if-else ladder into a switch
statement.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index 00761604a8..df88914716 100644
--- a/remote.c
+++ b/remote.c
@@ -1171,7 +1171,6 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 						 const char *matched_src_name)
 {
 	struct object_id oid;
-	enum object_type type;
 
 	/*
 	 * TRANSLATORS: "matches '%s'%" is the <dst> part of "git push
@@ -1196,31 +1195,37 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
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
 		advise(_("The <src> part of the refspec ('%s') "
 			 "is an object ID that doesn't exist.\n"),
 		       matched_src_name);
+		break;
 	}
 }
 
-- 
2.50.1

