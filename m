Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897DE2E62C
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775501; cv=none; b=keEwjUeCpQ/3Qjm5dTwNjvCTky73FbbdP6TNd34EbguzIGXNSaCSpTFWaVkWMxE/PemkbJ6BtX6no2x7JVobElIMF0Fkiyh3DXu1F5lSgCNiQ0BYQA4hiqB7D5k1B/DO+Kbe0NM34AoGVqe7p5JwY7jgoI/9bvEwAPNMtxYuz1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775501; c=relaxed/simple;
	bh=Yskx60mtTMtZm0T/b83vIaVPaZVXXXbWMot0hrErCZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOdBX5NUOqjkWuGM/iZVnpQopBHHM0HLMNILhKeBiudgl1oxY4s3R5A7jBzN9zaMUJnYXVXIyy+pmMZzt7GKqm2JwRHqu3uKVZm8cKQ5h9LqVIKwqnbH/CpIMWLamcRjtH6ZJz/3Ul23no0oeClc/6xHov9hXxnEBsQVng8Bc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+Q1zDtS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+Q1zDtS"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2021c08b95cso50562465ad.0
        for <git@vger.kernel.org>; Tue, 27 Aug 2024 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724775499; x=1725380299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HOhxBsKUFIDmJNhTpFufRBEpgeTUQARAVWMaF5nOBgM=;
        b=T+Q1zDtSrTOvCZ7ysmu8eM5otgmsn69cAXLd4VRfdv0NjaDB3qMDUYZ38+KtaX58Io
         4coUiZFhyWOAN+qsuybrl1Rbr0OtTDITYrbgdi2vICUQfFhecVnqAQbkNbj0Jk3Se4dN
         Flhs14zxS30oTA+/LM7X398Hb5L2m+wD9A2GgcCFEzcP9ZUkWRUi5LIv9jLPyqE4Q1Ey
         OWfckyMWgsUhFxjaUQRsnOe9re1Jc/+JS3SPJ/AZSqStEuyQwKMSY7/kfq5v2Cv0wSBo
         fZEpCCNBtiDZqGOCI+eEXL/ca7CEcVquFhZq4jU+PH01wFZVJj/Lkip3kjYEG8qiA1cw
         z1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724775499; x=1725380299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOhxBsKUFIDmJNhTpFufRBEpgeTUQARAVWMaF5nOBgM=;
        b=r2/sKNFuHUpVFuXvYZbDrA8euwKjDUjjmqxvvwD6ubk21jTVthYwyzr2VyMIf4InF8
         NG86ga7yT78ksDtoDs9FeQXN8E1YZVxPHERdmn1PCCbXh3sVp/e8bZfAdcCg81hD7WyN
         FdE0QQoe5869NuZFRD/ApuhKzPlMYW03kPDM1DQGHuJgm84DqtXP0WdGWT1XfgO1nSX1
         3XtBshT6ok2l80wYZULXnwB1wt7nvE0OP7FfqxToBzYrO922Fvyl1kBfTFlAnKfL+na9
         asIus/MUBuc6Huksm/e/CKcezDMPC0NecdtJ2fWsQ1G5F00RqXa78aLv3UhItPtMNnMj
         tCqg==
X-Gm-Message-State: AOJu0YxmJEn/sgXXV6bOHzibb/g5RXPd/MvZVy7WODGn/wRXrXRPeUQg
	sSsoAQ6Eak97l68hCnm5fn6WXD8BLsfa8Ph3XSALHWMmUtF+6eBN7CvgCQ==
X-Google-Smtp-Source: AGHT+IEn9ONBYlumfoAAhK/QgvcsgMeiFE+OS9JqgNtY4eOz6FV2A/rn7sANqnJC3lRRBgTKA3EZQQ==
X-Received: by 2002:a17:902:cece:b0:202:4bd9:aea5 with SMTP id d9443c01a7336-204ddce3126mr42792015ad.14.1724775499016;
        Tue, 27 Aug 2024 09:18:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385dcd932sm84698045ad.288.2024.08.27.09.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:18:18 -0700 (PDT)
Date: Wed, 28 Aug 2024 00:19:10 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] ref: add regular ref content check for files
 backend
Message-ID: <Zs38frYexwFt0xlP@ArchLinux>
References: <Zs348uXMBdCuwF-2@ArchLinux>
 <Zs353oLDaw2SbNQs@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs353oLDaw2SbNQs@ArchLinux>

On Wed, Aug 28, 2024 at 12:08:03AM +0800, shejialuo wrote:

> And we cannot either report a warn fsck message to the user. This is
> because if the caller set the "strict" field in "fsck_options" to
> to upgrade the fsck warnings to errors.
> 

Sorry for this paragraph, because I have changed commit message for this
patch, the range-diff part would be outdated. But the code is still the
same. So I hope this will not cause much trouble. And this paragraph
should be the following:

  And we cannot either report a warn fsck message to the user. This is
  because if the caller set the "strict" field in "fsck_options", fsck
  warnings will be converted to errors.

I will fix this in the next version until I receive enough feedback.

Thanks.

