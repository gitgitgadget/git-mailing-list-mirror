Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBF41537C6
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731240563; cv=none; b=KC9rzFVcf0wzgMeksNenJkC2Hc2PN2qx6/NUJG9u3aHXRlq216lmteADkSfvvqD9lsNvHMdRjPW/2Xix8JhUbCEPUq1AH3m2aZ5GI9lK0Datbxh9J204T/YR9eWlp+uWZLPvwhXrLy9DVjz1sRb5t0rjGrDln0zsRXU0xvVlYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731240563; c=relaxed/simple;
	bh=Iq240slf6F8USCuNlFVvJmIT6fjkny4AKF4dW34UQj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgbqi3T78en7Gz6JJdUQBxh8hJlEIqV4Z8RN0H/UnqiRxmqon9DbHDY/+Hq2+tywcxyy/rR1Zs475TzGjY+w8crlhCBixebNrICsuiXztDgtkkWhFLBNEqSlA+yJsHJGoPNlfJDZQBWJba9619a/A0GnVNsQ4+9zAM6Qm4rKxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlFDep5j; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlFDep5j"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cb7139d9dso33934385ad.1
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 04:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731240560; x=1731845360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc/fmkvpcUY3It7x/Wyto6u14vgd1/H96CWyWXBd6jA=;
        b=AlFDep5jmRVjFipsOxRTZlY724iMsVWrT8GBCZVO/L2W2IeS4S5G97l16pFQHJoYKf
         dAW310+F1n18a2a4xC71OvNtyt8teYvBP6jei8bm+3lcqtWO2OYkT5dEHsGrXlMf2PLY
         ixFZfVtHq2+akJxDtNz1dQTXOqRYNswhiAYZ1AJfDvGba4cdDYdCXcjHW56hg8oTVJss
         3sYC1lYA2DcMUn0r0BNgo+LQEOYGXs6pjU9HkgiUHmoCAwlT11SaCvy2iICS9VhcFYRW
         eQTftvViVpjOcaKNqYvpBamrrhbAX/QKVOrWa7cz6Rlip/N+9bmSk2ms4N88iCcVIC9y
         XLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731240560; x=1731845360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc/fmkvpcUY3It7x/Wyto6u14vgd1/H96CWyWXBd6jA=;
        b=V9j2pJZ9S1liGNsX3SdImyRQUEMXPjmga96Aosk9FN1z0mHVoE+0iGztjVirgEJ28z
         dHeUH4TXtklW0FZAGffvzzwZGwQirG/Q1JGjNWxytLSJlb5DxzsK842ClEXmTOkI7Aiy
         /L+M9H9ykSNl4aJ2Xpt6jptDOiZs5/Da9avQUWXFBOcyVBHuUw9GUSIWgMhneq+zUlvd
         bl/IIS2uIHKvuDmN8NpptSqNtdfiK2ReZUY31V3NkComNRD5qAz75et739Bdg4xpVNAY
         aIZZCG70fO9WPDMgZh44F2m2dsRIrhmqMTk+RI65AMKx/BfkRL6+QuC7BE+1c36fF04X
         CY2Q==
X-Gm-Message-State: AOJu0YyogV9TcjIlFdQ3S3hI5wRtUomZCcRIfurqPVcu0rTztIntdasu
	vboP1FwZh/mCv9+oSrzEfGcqPF6nwz+yx6pBVx8oIu3Hk0CvA7q9ssQ9UqHKunI=
X-Google-Smtp-Source: AGHT+IGixWoTKRDkboKsmpoh02lykIpgtdNTwU1tx5wz/mx/NZJKGzCU4h1WNk0AkjF5qqE8IGjvVg==
X-Received: by 2002:a17:902:f685:b0:20b:951f:6dff with SMTP id d9443c01a7336-21183b91f73mr132594575ad.0.1731240560561;
        Sun, 10 Nov 2024 04:09:20 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e41902sm56953275ad.121.2024.11.10.04.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 04:09:20 -0800 (PST)
Date: Sun, 10 Nov 2024 20:09:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 1/9] ref: initialize "fsck_ref_report" with zero
Message-ID: <ZzCibqcJzTkXLBap@ArchLinux>
References: <ZzCiCGxL4Adnd_eq@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzCiCGxL4Adnd_eq@ArchLinux>

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

