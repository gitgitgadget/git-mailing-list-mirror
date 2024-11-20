Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29A1A4E77
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103464; cv=none; b=GaMe2iw8zhvzpMgNeNp8ci2XoVYMQ1zX+e6BjaGhbUZGH5O4fsfoTMzM4ls+rSXvUjfNa5zsdUeksw9I3IlsCuipQcnXbwjvYIM9ljEGb8PQ5ZEuiWGoOWwOrPipBLoZvBjPbgxNH3k8m1vdUaE97HCBcFc3n/BF86SXPkFWiq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103464; c=relaxed/simple;
	bh=Iq240slf6F8USCuNlFVvJmIT6fjkny4AKF4dW34UQj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9HqiqEJ0XKZiMC62iRLHIh9qtoPlfx7ubcakhT2wivgPtl/Dm77vufhLqKGdydp3ohrVJjan0YcdzTCizn/zuiqwMQZ8GtUdrPvbckiPGjOr8QWb5z+aaCgmBOXjMbodrQUSpHWzMiDFztgN3emDBDUhhhWo1S6IFLbKCRrxR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DamvhaKt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DamvhaKt"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cdda5cfb6so49301685ad.3
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 03:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103459; x=1732708259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc/fmkvpcUY3It7x/Wyto6u14vgd1/H96CWyWXBd6jA=;
        b=DamvhaKta1lzHkwd0+o0HizNc+0xh0evt++KgRaE8rO9QnKGSvY7B1ogiE0PB6tdwi
         4u9tV3sdLpMTMdD6qhZ/3bxdO8OLVMySud8vVBFeM030M/E+BQPNdKx8HsqxRg2u6xER
         7BJFOp5UVcw0Ulckltz2XJpqc4a5GAaZy4gyIoYh3PZD2s+WLZ/A+7xwXnPciTLFgEPM
         gX1Vqb5JQi9vBxDyetY1irc7oOoXXHVB9ShLDRSTEDEAAHWW/s6bt9LE1JPsQcIUU3n1
         wiXpEWTrabE6NC5li2cd/FEZFpFX3JKJIWtuGNJpbLQbhtZuvhYcX8r1KFRQG/oKgAjD
         4Tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103459; x=1732708259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc/fmkvpcUY3It7x/Wyto6u14vgd1/H96CWyWXBd6jA=;
        b=nOmmcllDvmQ0fZtPM7qv+Xp5qbxe1MTLjlRrH+6L3Aae+KQmpnjewACAO5v9KAEUuR
         epGzDeNUPp35zHWiyvWihsyem9ZaCwn4hIyAMHRZSg/usmFZ2QIrSKOLi/RJZ2NexkRZ
         8hzZxuIaZ3++Rk/RvqY0EoYClQ2acRUfafgzO+xRY2BixBJMuPD9q//zhq0ImBOfOuv2
         cfNO4Ou1DHOmTRB9PA4vjCN9vOTuiEdrcc5Qu2cYogYQZFFCho+Jz4756pwVYzTVlKp3
         Ywg5pYlBIV3YcxvCKwxEjMPCs+pYXH9K+UMy2UoiRpuP9Ngc+1ong7Bf6bQBoUdraM/R
         pRMg==
X-Gm-Message-State: AOJu0YzshhvTzf9DVD+SSJrerDQfKF1d8Dck3EW5FTauQrrf7PbHn4df
	b6GhrDBMNt2icW3gLV9iObPVavcNknIxV7rXaFABgNwNe4vFfWl1oKUWpg==
X-Google-Smtp-Source: AGHT+IGl96+Ct34Xuh8LCOUCj2OHCp3AwDonmcetHr0YFIgqTxNYuN00QeyLFdWVsjvUfUMk8vc9rA==
X-Received: by 2002:a17:902:e80c:b0:20c:a44b:3221 with SMTP id d9443c01a7336-2126b06938amr24864335ad.15.1732103459510;
        Wed, 20 Nov 2024 03:50:59 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f34903sm90350615ad.158.2024.11.20.03.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:50:58 -0800 (PST)
Date: Wed, 20 Nov 2024 19:51:08 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v9 1/9] ref: initialize "fsck_ref_report" with zero
Message-ID: <Zz3NLB_Y-9ct9Kad@ArchLinux>
References: <Zz3MON9_9DGD6nsy@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz3MON9_9DGD6nsy@ArchLinux>

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

