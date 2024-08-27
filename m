Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E3A64A
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774821; cv=none; b=TjIGbQsWvUQ7dMvMe6WQRFAKmUXovzaFeEN1Fx6kcfox1FtMqVmoAzpufdpl30bME07Sh5ax/73wB+FhNnxqf3cEXSuE+E1rU0uqaY/7XQj4o6/TcT01KlkSlLDWqDYyJDmatjA7FN3SR/0Q6VzZeBAGpX0FJWeVP0AgDCpMAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774821; c=relaxed/simple;
	bh=V4DDs/hClwAYYIhD/5WHCWPBJlyb6/CZ1ijOn8MqQ6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEaKdoCF2BUVTwEB7omBWkllFLZzP5/8jvpgBGAszyrtxi5evLrhapUZF3Itk8LEgUH6hEtg8GzyA9WEtDXZrrjU0iLGJhZzVtwG0n3RqqEY4ins66LPZbXEq/lDNT3c5DIZSw9epWqpzlRANTN6X217Xgyo3J8bEo63KjyHVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUW3tvpv; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUW3tvpv"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3eda6603cso4547919a91.3
        for <git@vger.kernel.org>; Tue, 27 Aug 2024 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724774819; x=1725379619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i8uyMImbvTYD4N/MAG3h6aPl+rkH5Fvu9BeFpyy8WmA=;
        b=TUW3tvpvX/HXx7avQ7vYBI6QQpCcx0u4RoZWaN090vbWwkrxB7SiSdNR2WkAB1X9Zd
         BeQj2PX6b8wDcVxsS9xDvnC/gK5h1docTwnIGpBIC/g6ETwFJhErnjgM2kVchbLFrwfA
         Kip10g0ybYN/O8rTlSvd/RC5+NkHgqmOl44e1BDBQYDoAC/hdj3SVpZWBIu8mxKN5ZxX
         lN9c4qXCp0Onbsm4jfUwMcDbqE07TEoJnSO97aN4HlEjhr7+W0up3f49hk5xrxPvfUjt
         JJr0/hU8I8KPs8AbS/NIft+xP+CiQRGIaW9wtnDIPDV+H+AQ6sLVkzt5EOXP0NDrvY8z
         gKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724774819; x=1725379619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8uyMImbvTYD4N/MAG3h6aPl+rkH5Fvu9BeFpyy8WmA=;
        b=X4l2wsDNOY8zxmaHRZ50eP1v5j2W5VfWZKKVCjaqDpdBKGzANvSl8zHvaP5SjbVVZy
         ap+WwvqXW3oiEBgt0sUL7Knv6R3FctLSBMOqCgbAn2HW75a7XpS9UOkehVQPsmj3hnF6
         TWnyHmIlwiWSyFZr8IOwdjeXq5hwckUP68TE4EHtw1xFPYg2OR3Eg/CmU6/sGMzS664G
         OcSKWnXaLnRkzrfz8U6+SZPjmiJE81bQXkDCLSWD/t7RfnPZVqxO3j52gi8Tca/nxNUn
         3OuYn3KrZc1s0tPQ2egMO6b7/F90fhXiGRi5uWsLSljRIHSjJCv4Vw2rWdbbLHs7fZiF
         pR/g==
X-Gm-Message-State: AOJu0YwhfEay+xaMehbRNbdLkggepL9NjcgMsQkHavQtwd1NVUYOHxzc
	zfDLAC1QhklyPiR910cv+oI+0ktgKl+HeBYEkYJ4RiVJGsh8WjDWy10Skw==
X-Google-Smtp-Source: AGHT+IEP9kI3iJoyiSc5v/D4987kKR5ts31vPi1aszBQe90dF1rXLNilduKBqubjD7fLm3iZaSFG2g==
X-Received: by 2002:a17:90a:2c49:b0:2c9:cbdd:acd with SMTP id 98e67ed59e1d1-2d8259ea0f2mr3774267a91.35.1724774819114;
        Tue, 27 Aug 2024 09:06:59 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbef1edsm14680598a91.47.2024.08.27.09.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:06:58 -0700 (PDT)
Date: Wed, 28 Aug 2024 00:07:50 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] ref: initialize "fsck_ref_report" with zero
Message-ID: <Zs351iV2HbdhNvEz@ArchLinux>
References: <Zs348uXMBdCuwF-2@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs348uXMBdCuwF-2@ArchLinux>

In "fsck.c::fsck_refs_error_function", we need to tell whether "oid" and
"referent" is NULL. So, we need to always initialize these parameters to
NULL instead of letting them point to anywhere when creating a new
"fsck_ref_report" structure.

The original code explicitly specifies the ".path" field to initialize
the "fsck_ref_report" structure. However, it introduces confusion how we
initialize the other fields. In order to avoid this, initialize the
"fsck_ref_report" with zero to make clear that everything in
"fsck_ref_report" is zero initialized.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8d6ec9458d..d6fc3bd67c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3446,7 +3446,7 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 		goto cleanup;
 
 	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
-		struct fsck_ref_report report = { .path = NULL };
+		struct fsck_ref_report report = {0};
 
 		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
 		report.path = sb.buf;
-- 
2.46.0

