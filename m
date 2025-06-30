Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD75D29CE6
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 03:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751253592; cv=none; b=WvAVibuEtWCTh1j0/L2fyCAv3Z1pdmoFst6rCdIWWj8jXhhG5FO20g8FPGSYZT8/CWLThONJ77kxAwpL1l4MoPFCedwlBy/+Qt7tuTqTjEJZxlIkb+u6+Vwbq5RK/GAR2gFZcoD33aKwyVOwBotrEdIw1P7FVZtjrcHRwGBBtoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751253592; c=relaxed/simple;
	bh=O6e/uk7PNpr3tmRykiwVpNRqt4SWgZvoeEXalEVzl3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl8QWRCbzY4qpUeAKmiu1scAGz69d4PpNi2T2W2YiyivE/1AGvy9ymA1FOM75rYfA0RYDilKu/uKk2ZH2vkqmKzyi0IyWukDJTc/etd7TnL1X+yFq3IUQKHmXoGFRzeMxupVWDqFpEd0m26dT/o5WOGVKRv9Rt5tjfnMc+gpvWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncUVx6Hc; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncUVx6Hc"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2ef8df09ce9so759529fac.1
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 20:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751253590; x=1751858390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VrWnUdrlX0HlFn3WmYMyRHgF6xrI+lTITxKdPG65teA=;
        b=ncUVx6HccB60DwI1SIOakUucYxrQvxYHOvb1moeSGgyxjpam0VWxSOUG4hkwmYsRuV
         t72Aarfh8sF6H/yE43IZaLt/jbeBiFdo17L44JYy94Hijr2T3OKY6Mq1drf3Us/p9Ccz
         3wK/dtMHTHiBo9ZxtU/K7tHAGkO4w1YoE5xwMzHBZoZPDo+pUbaqz/QzLbtXXNji5Oqn
         kCf4rWQ+9oBlVPGif+/KqOHL0f4EA1NTx5cnQndtxERHyNtz+0rDM2AfSr5noD0odoc0
         QTVF+d4Mcb8s7SEj0AZ9A+tYCfWOTRNyawBJs5XRr2axmubLKtbtykYIKnL7MZiSIRj9
         f+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751253590; x=1751858390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrWnUdrlX0HlFn3WmYMyRHgF6xrI+lTITxKdPG65teA=;
        b=m4l4kzyk+qNMt+PKKx58P9bZa3Lh7FC5Ry8NXH4XUXlpgM6h+OGBRiYOTNpInD/Ltf
         6zJP18EkkKMRcRYahI8xBD9sDJhhssJnrbi7prkNRg6M/KE/WQDkPDm43+/ycPV3AavO
         cI9TOSe1JBr1TCJ5eXIfrSuBEe8ROmzlmL5EKlROiWdvE4IysM+8v1Eao/ps0ETOU+Cw
         Pa6e/hAfIMjR8DxEhrpSRMFCsEgNjzpLC+zQjNaLpEkcFJNHrtgcdJMnp9x4SzTvzdjE
         8xz3yAazgGUcNdtnS5U4Gy5KxJk9qi+GFyGAcZ4StZLRG0ayt357Wd5E81w8iYvc2sqC
         fnJA==
X-Gm-Message-State: AOJu0YzYDaMYzdRzIlZVoKzDa26Bez0Zl0igPb4Vi7Lx4sVlmZ8PGXEt
	SvysdBbzLXIffL6GdV57jV+bcKAItX8kqllSxQytWNRGEmgDfEfT1FBu
X-Gm-Gg: ASbGnct7BDj2r+0ai4dAYqVMykjZJ/UcDre7l/1pJIWK5C62E+YKpS9B96DMdfypUoE
	PVDFBELf3A7n53a3kHQmArPOymkgbcap/xm9xDz6laCxn82ruw2D4pxbt5fr+JZ2qbDAphHRZv7
	tVpMsZzt+BB4Ih4qqyLSkGUQcRAP81lYjyf0AuCY0oi7IdvFJdHrh413QjiQwaceBhjHl6/QyNB
	vzNZhQ6COiE9aHPxerVFaOlGhjQOAX3rOgzaB2TabZFUrmzk6T2U+oZCQUuqNikHbZ61VjKgB31
	vwi3NeT9f4CTBnRGh6xeEn9ZShKNdeHCGI1H8nvW1RGTNCP39/MYLLNtJXJ0m9V1rA==
X-Google-Smtp-Source: AGHT+IF4YXZ6nWO/T2Dgn9P/DIFnNSU6D7WCOoVoaw8fgTPiviwhPeGbxZk1/hrOn3Db893lHS9t3g==
X-Received: by 2002:a05:6870:4409:b0:2e8:7471:6350 with SMTP id 586e51a60fabf-2efed44109amr8551651fac.1.1751253589836;
        Sun, 29 Jun 2025 20:19:49 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2efd50fb14esm2475269fac.42.2025.06.29.20.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 20:19:48 -0700 (PDT)
Date: Sun, 29 Jun 2025 22:14:23 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v5 16/17] odb: rename `pretend_object_file()`
Message-ID: <dzc7sculdp4orsvpi5kdf6h6tcgmtbz3c2ttzgiubbrhprtrpf@flzrwl5tso4z>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
 <20250605-pks-object-store-wo-the-repository-v5-16-779d1c28774b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-16-779d1c28774b@pks.im>

On 25/06/05 08:47AM, Patrick Steinhardt wrote:
> Rename `pretend_object_file()` to `odb_pretend_object()` to match other
> functions related to the object database and our modern coding
> guidelines.
> 
> No compatibility wrapper is introduces as the function is not used a lot

s/introduces/introduced

> throughout our codebase.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
