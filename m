Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168D24B29
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754558408; cv=none; b=lvX1bjD3XBTiGQoOGGSVvQDhBvbfx2ZPvpTxzgVgvWGNOso1GMEdhv0Q7Q4wjYYxV5PfNmRLnXTOIQTiPwElXRsGvcGE/fDyLk4MP96YIcsuK3wFxoQjdjCZaZXGVDM4dOX3d9gYvCmZdEe33nD860KMEiFjp/arK/7MoTgFSew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754558408; c=relaxed/simple;
	bh=pAhJe+FlPsCzWVf8CBWWz7zOYN8EHdOch0++brVvlqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKrumrtvMO7k5whq4SuzfQdi9VUjjYQczIvNtHgVBEV6QT0aCfzfvzzlbEIoLhwIMYEZjdykoK6+jo7fYu+gK66+HqNC5BVANyNCmGBo4lJ8iz3SDX+EB+31usSnEnPZ0bzCWKbvs+PA2/nlt2ZgrzsSxqTNkHz1qXQsZj/Gi1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rj1cn9rr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rj1cn9rr"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76c406941b5so2360b3a.3
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754558406; x=1755163206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r3DcKct724FqqWJHEdkYcR7fyJ+fw5Sf1nZYB25GkTc=;
        b=Rj1cn9rrj8MTA0SsmD9LUtQ1TR9bOtUR3gm07WuSLMraF8wbxjqK9sG0DHBYxWMjt0
         uPf3Tvj4oLTATH4MI+zYMV12hmITc4hGmiVu7d16yepkf3q+JE2tpQ7/zsnu/lUI4KUo
         XfDHoiDui4R/CQpjGHvX1tLZQpp6X3UjahBz4GVLt0rR5rSykYTQlNBfkcPedLTA7R8s
         rENJk41hTAhMzfoSFyGeL6ePV8ktiOkbR2kN2XqRX+L2wMmHgelt/lO0GpbxgQ5z2MYs
         WNnB8XPiWDQgqbcccJCM8svSufFe8R8Dj+pDns1caP0eIVyBrZltJANzB5WTw8WjeyEG
         iQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754558406; x=1755163206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3DcKct724FqqWJHEdkYcR7fyJ+fw5Sf1nZYB25GkTc=;
        b=cwLf7fAGmeFQc2ZKvV60vA4aFNeBDCjERGIy51osKvF6PfFLRrgErLFrYduLh2J7kg
         Cg17zrhAFHSeZLjsUspKmS0oPtGpw5LvC5VYZ89gtXHod4lKnoJxg05n8xJYfIh6qQYz
         Ug0SxEprSflxn0zA6hPxbxYv/aJC52cW2lK9BQmUM5cB6Tv+4k+tyb2NBSSnwWsuoklK
         Tmo5c4sQOwlE5W+htKHsJugw3eDLBMWFRtcutfNY1ObuYIqe3s5c/uZ1Dtd0YsHid5PI
         vaCDR+I/KszSv2ti7buVeIKA+1GB4X3Z8bFBTUMYs7lOsv5rHEbP0oQOYvb/hwPWwkhn
         FtSA==
X-Gm-Message-State: AOJu0Yy+YNDbSRv2eVw9GVUMXPp+lPGIey4JDGdLrhBiRK4dJMDp62O+
	zYu06tDzDdKq5l9lpxgfuelGSZh7zi6njvWQTvR6dvqr8rhGa4x0DizvRqi57Q==
X-Gm-Gg: ASbGncuXpUAd50FXf46YUaEro9i8KhvV+LY+7raCGLREyVRJDsJdNwhk43hC/uQHKmU
	Y5kPu0UHvYsSVPNSJi17JDr6Yg5ENCPcDLvLFFH0/+b2SuAh1iUaRsVi78Zdgc0RU233dua7IN3
	0JmQJhhXOk1ZIOP/fXTHeb07xAQ55i/iRVLRLvbnCeHZvWLdYeyCKEMN/sCLLwnW4IZFIzocHfT
	IBaiHh/46WwmdFVl0E0PnohN5MtrDL/ro0ewtWsS0k3IRr0tYir7ZIwPA2EqRUgy/3Dv0zYo9xR
	TceH1EcTdSDDoqd6xLkfL8GGC67lAzl/1UxwOoLN1ggu8tWAd5EbMdYfrHhj7Sk2YMGYcg9x51c
	4WFxlakhNjwnJuH/DamkChl8E8T/HAqz0WzCJ6ecE
X-Google-Smtp-Source: AGHT+IHU6qb4jup4xPoDd5i7jrt+9aVKx80NcjHKpi/YsidIejnxFmDg/E/qL5XiVe/iOnPWKQObFw==
X-Received: by 2002:a05:6a00:2d22:b0:76b:cdf5:f4ba with SMTP id d2e1a72fcca58-76c2a820e76mr3736262b3a.4.1754558406330;
        Thu, 07 Aug 2025 02:20:06 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f48fsm17584160b3a.40.2025.08.07.02.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 02:20:05 -0700 (PDT)
Date: Thu, 7 Aug 2025 02:20:03 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] remote.c: convert if-else tower to switch
Message-ID: <54a16614e2a38117f533ede3321b4d8ee2eabe8c.1754558302.git.liu.denton@gmail.com>
References: <5866818859be97c091c40602974629eb7e463623.1754540903.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5866818859be97c091c40602974629eb7e463623.1754540903.git.liu.denton@gmail.com>

For better readability, convert the if-else tower into a switch
statement.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index 465e0ea0eb..029b1fa93b 100644
--- a/remote.c
+++ b/remote.c
@@ -1171,7 +1171,6 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 						 const char *matched_src_name)
 {
 	struct object_id oid;
-	enum object_type type;
 
 	/*
 	 * TRANSLATORS: "matches '%s'%" is the <dst> part of "git push
@@ -1196,30 +1195,36 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
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
 		advise(_("The <src> part of the refspec ('%s') is an object ID that doesn't exist.\n"),
 		       matched_src_name);
+		break;
 	}
 }
 

Range-diff against v1:
1:  5866818859 ! 1:  54a16614e2 remote.c: convert if-else tower to switch
    @@ Commit message
     
      ## remote.c ##
     @@ remote.c: static void show_push_unqualified_ref_name_error(const char *dst_value,
    + 						 const char *matched_src_name)
    + {
    + 	struct object_id oid;
    +-	enum object_type type;
    + 
    + 	/*
    + 	 * TRANSLATORS: "matches '%s'%" is the <dst> part of "git push
    +@@ remote.c: static void show_push_unqualified_ref_name_error(const char *dst_value,
    + 		BUG("'%s' is not a valid object, "
      		    "match_explicit_lhs() should catch this!",
      		    matched_src_name);
    - 	type = odb_read_object_info(the_repository->objects, &oid, NULL);
    +-	type = odb_read_object_info(the_repository->objects, &oid, NULL);
     -	if (type == OBJ_COMMIT) {
    -+	switch (type) {
    ++
    ++	switch (odb_read_object_info(the_repository->objects, &oid, NULL)) {
     +	case OBJ_COMMIT:
      		advise(_("The <src> part of the refspec is a commit object.\n"
      			 "Did you mean to create a new branch by pushing to\n"
-- 
2.50.1

