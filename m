Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F23618A954
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250734; cv=none; b=bBX6nNAHcRnHsZKt2gwAoOB4iZ5WOQPaZXXGheZAEJ7MUtH+v1OgKLGFiMGeudfUSTyvW6DzPdEhtIyGh73PuzcTJdDxszBHEuBZBc1CqyjfAIVFVWoQzmave3t5Gr8Ye8uqBLjswig0OYSuQVlAY/pXNmts82CGyTcHb3Eg+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250734; c=relaxed/simple;
	bh=SjLa5uDw7SiFV6E/t2nSyHC/4Amwc5dkMGt89V1lAz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU85aa3Gec2W+v8R+sELmr+G1gCsM/mCkG/6JmsbDBtvKFbzMpbrOPMTa419+cjwRIspjy5RVwd3OEE+s6R9y0nag2ktIbVNlV96RXDGxU6Xy5CsYN5iB2BEtvkpwytrPVH/8oQtVxLOpBpjkJhHQ35N2usgQ7OjziJtNU56zXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=V0Wju0c1; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="V0Wju0c1"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-66498fd4f91so627317b3.3
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250732; x=1721855532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lnzc86+9vzF4QY7wCGj2g/lNYiSAAm9TogHZViVdr8Y=;
        b=V0Wju0c1VvNaZrAs2+oB9kdt1ZVECMdcOuMFT2pGBkbFQ1xIRoHZaJ2enx55kZZ8O1
         Nnfy6zwrZS80VDsRy4zV41ldPPRAYyK9/Xrsk8yGSiq5exqZTT+b8elqFql1ZtwD5fc7
         IWqs8xaMA7b6ZMuAXNOACyO8h0i1WopEyHf2vQnhX31TeaBBy1srmlQSfrRLWUPjwtvP
         kHHeGEo5RHC675K8Guv0LtAXodfIJS/npuNhusLrW1apaCft+8U4DMi5KdoUHlGVmokF
         fl74cD2fqNuOE5siV6eQsefg0DgL1RoxyriWpiXIaaZdmLrvc02/9dKAt9JsQUUWi6j2
         qkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250732; x=1721855532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lnzc86+9vzF4QY7wCGj2g/lNYiSAAm9TogHZViVdr8Y=;
        b=Ajbakx37btgBqJIZ+vq7nR0EjPBKrQF+2BIcc7LtmKcxC5ACTL9UhHqIf6Man4erj1
         F3eKgtWx/KxA/FpNIuYckL9voQMX2rb3D9iPA7EeVk6gQa59gV7FKhty8GLL8NwV+2pg
         QAxEErWOhMcF6eFlH6joUjhg9WTqdHPiEIYBmfhQA0O5l9bzhO892haTKOWSqRBTxgjv
         FkoojJ9GRCygddOnIKXH3l1fl5BgMTFcwebhNkG9jk+4DhcqKNxudbgxdaqD8XFVpA5O
         8P5VV1Xh6R1/mS0GGFNRJ/BuGCscBQIqM5jnFYlrxpxUTuGBaZklcHzUjZ0Kg7u7SOfc
         mZYg==
X-Gm-Message-State: AOJu0Yx44i6G3hmrX4Av7W2MRG8YeYn85DNih8uLk8YrZM+DQzNkTn2Y
	jB+aFqkMJOAq3bAKCg86pteEHwqYk7S0pLYIRA4smeWLeHfKoS35XNm1NLGXvIP3IsvHsmkz942
	v
X-Google-Smtp-Source: AGHT+IFaxWaCSIjydCmcFedj32qWzi1028TX5CQ+Hflbv9Dkzg4h8AiaVpHWxpI1fAeSQBEcuiVy1w==
X-Received: by 2002:a81:9c0c:0:b0:64a:7040:2d8a with SMTP id 00721157ae682-664fe25ff8fmr33280707b3.23.1721250731956;
        Wed, 17 Jul 2024 14:12:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66603ed5624sm748267b3.127.2024.07.17.14.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:11 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/19] midx: teach `nth_midxed_object_oid()` about
 incremental MIDXs
Message-ID: <ec57ff434900f2b95e31fbdf854b5ebbf46b5c78.1721250704.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721250704.git.me@ttaylorr.com>

The function `nth_midxed_object_oid()` returns the object ID for a given
object position in the MIDX lexicographic order.

Teach this function to instead operate over the concatenated
lexicographic order defined in an earlier step so that it is able to be
used with incremental MIDXs.

To do this, we need to both (a) adjust the bounds check for the given
'n', as well as record the MIDX-local position after chasing the
`->base_midx` pointer to find the MIDX which contains that object.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index da5e0bb940..d470a88755 100644
--- a/midx.c
+++ b/midx.c
@@ -337,9 +337,11 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
 					uint32_t n)
 {
-	if (n >= m->num_objects)
+	if (n >= m->num_objects + m->num_objects_in_base)
 		return NULL;
 
+	n = midx_for_object(&m, n);
+
 	oidread(oid, m->chunk_oid_lookup + st_mult(m->hash_len, n),
 		the_repository->hash_algo);
 	return oid;
-- 
2.46.0.rc0.94.g9b2aff57b3

