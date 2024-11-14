Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B95674E
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603237; cv=none; b=bs/TSz7fPfSpXtYBj5jj9llHMTe6ep+yCnLJkdE/M3LvMXDOgRoI6CpdOUFvbGLUiJc73SB8juzHxB/kP8xHOSjLL+4lNohmQlKLGgyCIUj7hJvAYLce5qecutDXhHTE0EXTOo8jb4yF/cmkh2rENc8PeZ8K687XRAT7dm7oj+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603237; c=relaxed/simple;
	bh=Iq240slf6F8USCuNlFVvJmIT6fjkny4AKF4dW34UQj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+031ehSA+AvJn2yfvHMxLELOlhgMHfWSUEYhYTthzUw8l1LcJ1s4B9WfJF8f4abuIIM9EzsUPTK2hyBfjeJnOIxgVP1/jK94YwD3h3ohOweSSKYrbebmMB5836mpi7Q18IXKvK65/PIaJo0YA3mT6SCo/GWhzTxczVIxX6UptY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvciWNdz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvciWNdz"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2114214c63eso8056915ad.3
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 08:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731603235; x=1732208035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc/fmkvpcUY3It7x/Wyto6u14vgd1/H96CWyWXBd6jA=;
        b=TvciWNdzMI93G9NEp7K850X42wKpXLnC/UoNxP/s4LP4a1wsfvzqY/rejJ5t/PqO0M
         yIL0NtPIzk7wOW59gW9pSJTibW5ely3IH5lLh7fdQM8sb9uRWeP1ubt09NyPexW5WuTq
         cMiUCV4yEKK3H4PmWUg68Vp/6w5xwboZ3F0STqaZF5tyY3uAZnrTdizeOEgpdfH9KN93
         bawQyepn6btyyyWLYEQjr8lGRBhngsOT2o38QusaylDgnLT8kk8jkTFCvgu83JtD2SZn
         j5JEG874i5incUEDBA6jPFYLng2nDFnlrfhXH9EZn2TU37Nl+0+QPlT6OGF+CTo/s1zZ
         GQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731603235; x=1732208035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc/fmkvpcUY3It7x/Wyto6u14vgd1/H96CWyWXBd6jA=;
        b=j2HicQEzYCAG7P8lHG/rRhnJBzhB7vRLLTP7Ol6mhLiHnJm6x3mPMPMw+tDQyhFVBi
         jYcuy5HViSA2uFn7mBoPncngvksPEV/ltMqTtznIh+Wc19OX9N4VvWo39fsuzd3IsE31
         NoB/ygXLm3lpqEyuAHaUidt7yUBerLuSrLgIDmGoEaCnmfy8ezoJ6of54DxBj30ekNOK
         Ycrr2G2eXdAJPvfrwwyOcxSkjg485eJLLngBEyakwUARNmV430Bn0BdraYqumqxtNK8I
         hdjtY+MWyQTjQdhLVn5fXrKNyfAbWWQ3PwyFLVEnwwxutTpGvOukTMsbfdtvHGvAD7s7
         CLeQ==
X-Gm-Message-State: AOJu0Yyq41Cld8LUmiYuJNyay85IgjMYEG31UPPsqwNHQwwuHKHfCTtW
	sXwJowHlEvk5VEhIsgMIXzehoZK0pSqd0nxNjtcb/9W0C94hB9oD8cFq6Q==
X-Google-Smtp-Source: AGHT+IEwUfqeaAh78+RrcTqjauTvkOhEPLpr+T91XDeKBO8t3SQ5f8haQB4fWdm1yculQYfBUwoscw==
X-Received: by 2002:a17:902:fc85:b0:203:a0ea:63c5 with SMTP id d9443c01a7336-211833296ffmr352317945ad.0.1731603234611;
        Thu, 14 Nov 2024 08:53:54 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c28ee3sm12975555ad.47.2024.11.14.08.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:53:54 -0800 (PST)
Date: Fri, 15 Nov 2024 00:53:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v8 1/9] ref: initialize "fsck_ref_report" with zero
Message-ID: <ZzYrJT58VlU7slBo@ArchLinux>
References: <ZzYqoai8X_Wdtbmt@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzYqoai8X_Wdtbmt@ArchLinux>

In "fsck.c::fsck_refs_error_function", we need to tell whether "oid" and
"referent" is NULL. So, we need to always initialize these parameters to
NULL instead of letting them point to anywhere when creating a new
"fsck_ref_report" structure.

The original code explicitly initializes the "path" member in the
"struct fsck_ref_report" to NULL (which implicitly 0-initializes other
members in the struct). It is more customary to use "{ 0 }" to express
that we are 0-initializing everything. In order to align with the
codebase, initialize "fsck_ref_report" with zero.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0824c0b8a9..03d2503276 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3520,7 +3520,7 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 		goto cleanup;
 
 	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
-		struct fsck_ref_report report = { .path = NULL };
+		struct fsck_ref_report report = { 0 };
 
 		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
 		report.path = sb.buf;
-- 
2.47.0

