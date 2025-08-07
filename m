Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B191DB125
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754541025; cv=none; b=TYDmg2zeoUE40xaP93XPaW6FF01hgvuAfBuRN1TTNNWE6bU0I6TqI8gCUM3O5UvhqMoqM5P3/NJvZLg/tf1YuRC1J5sUyKBNuAo/INvASm5Js3GBDNSkI8Q9K12ckL+72OUEZjjrPDtPAOUtyxv2Mi6w4kQk2/ejIpFwENz7vuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754541025; c=relaxed/simple;
	bh=n03DZB3Ag02rhyiJn4tkLX3lKGVLIlVxJiUOQX2gigk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c62nYRi0FvdB0zXpDuNefvSquSezxOTxlkvtsxFHEcXH2N3KKZ5meEaYs5rvWgY27iWaG90yceras6fHHnMbFcT5YnW1asXdVpbMn/4psoiaNlsWT8ziMCoUJaitD73PcSbqWDu9oW0Af1XlnRbclXtaWnAUby2V308h06vq+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YifX8Nh5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YifX8Nh5"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31ec2ac984eso110782a91.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 21:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754541023; x=1755145823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wA4zTR3eStySvek1IOEZ9H5Wricp7pAQR3stJxSsbNw=;
        b=YifX8Nh57S3YakBHLgjFWus4j8SucpFpU75BSNzBYWhPMAChbbdozcile1liE4YY3s
         XHBuo0mvMoQ0NOGqaFPuJORWmmVr3hhPLjFAutFQQMG1mjyf4RdUHNKXNvpANFicrsIJ
         dIioDb7jljeCAWmE7W9W7xllNhUDdpiu+vBJ4psudKizNjGOktlCrDVmVAWHRfEkJt6m
         MJdSPQJfvmupfBZtbEYM37zZeOxHWTwQjEp5Z5CH++xr2jg9UStigOLiTv71cRl1wrab
         8i5DiFpRi3qOYcpTuL8x9Rj+UckZZ4W6fWsg14ZRV0a43kI0kUAH+FC/VMqymB63+O1z
         01Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754541023; x=1755145823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA4zTR3eStySvek1IOEZ9H5Wricp7pAQR3stJxSsbNw=;
        b=t5t/4koHx8rcmzNViLeycva1W4u9U/HtXl4j8PTd7+gchKgHYdxB8GE63+s95rDaNl
         GGsQvhxH/sZLwaCMqE4lN3Ng+hRPHaY0TGiXnmmZBfJqeyqEQKsu3t0gD+Kgx4MxMFx0
         0oqECiKs/9W7ZmDBgi/W8pa4Qr4FV7WdUeOgG5TXHcZopidPkOiAvGV9niN4K5DVi4go
         Cv9gj4DR/XPekNZPaFbQD7StlpUtKeh50OLC51p06N2Ic23FzharF33m6IooCdciIk8G
         sBu1jp/ad+zTQkydpby9U06rl0PnP4YZG7ErzDj++LkrJOmCASNK8Ma3G8g2GuYlGzfI
         9UQg==
X-Gm-Message-State: AOJu0YxGIIlnfuDkKFq7fZiVR8WAMA6zhz2LnQWYJLMvkEuf3aetph4D
	fEXPPppuUCjyugVuKdNa5repexNaPbxGcmwljzPUV1iCYL1mZ2XoxKSSC+2xOA==
X-Gm-Gg: ASbGnctAL5gpdgdllWyKo+39GOhNJzLuZgLcnTLQ9jSBkE4149ENoQo8Oxb2A7ULTVH
	H5PRA59Sx8fAdClKlB+oNtlh0+B0lUPCESNXvuozP+bz95ZrefD8bR/rRHJIdlCvRzajzosQKx7
	veTVz+xxtL0tsx7gN+UbEDH8M5JjFbm0mQ6Icl2aLs/7DjcCZZ4ivCz6jySA/fL/iiR6IlwbTNG
	YV0In9FIyewhQwyi+E41RFDHPR8/XDV4utBaiLjPQ0vrtz4iboNvhwEKeHuqQzxYSDA/V38AVxb
	HCsfXHX/QdLAlb58eZTSAo3WoeH6SmDtrs1VEIWbJ15pKu23OYzL7mSo5w3BxPZv8pB4qIv83vT
	ssVwXjuNlgRa+bJ0Sm5UfzufbODVCLvg=
X-Google-Smtp-Source: AGHT+IErxGLSi61XxSVXdgSlfNkf6dRG69RAEGUCBVN7bapUIKfYWi5HnohzqY1Pzxu2AsvXigGrFQ==
X-Received: by 2002:a17:90b:1c91:b0:31f:11d6:ce9c with SMTP id 98e67ed59e1d1-32166cfe229mr3097904a91.7.1754541022947;
        Wed, 06 Aug 2025 21:30:22 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:7ec2:c6ff:fe46:ef9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da5719sm21133124a91.6.2025.08.06.21.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 21:30:22 -0700 (PDT)
Date: Wed, 6 Aug 2025 21:30:20 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] remote.c: convert if-else tower to switch
Message-ID: <5866818859be97c091c40602974629eb7e463623.1754540903.git.liu.denton@gmail.com>
References: <xmqqv7n0wkbv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7n0wkbv.fsf@gitster.g>

For better readability, convert the if-else tower into a switch
statement.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Thanks for the suggestion, both. Please queue this patch wherever it
makes the most sense to do so (either with the existing series or on its
own separate branch).

 remote.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 465e0ea0eb..c7ae18fcfa 100644
--- a/remote.c
+++ b/remote.c
@@ -1197,29 +1197,35 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 		    "match_explicit_lhs() should catch this!",
 		    matched_src_name);
 	type = odb_read_object_info(the_repository->objects, &oid, NULL);
-	if (type == OBJ_COMMIT) {
+	switch (type) {
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
 
-- 
2.50.1

