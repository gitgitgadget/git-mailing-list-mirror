Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06B83E9599
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768500040; cv=none; b=EIXCM0U+HVUJw1x1L6qUewsPz88eaW1M0S3+XYV/FosRmiXXS7t2i00JRCUrYCnTwdK5HGirHRpzl8yoXq9XioVI/o89NJcJN0PAuM1bIeCUYla9ZLhy5Wj5PXbji/pg5qIbSsznBkrTpR9IbWk7jJwgjfKUs4QolCIL8i+kF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768500040; c=relaxed/simple;
	bh=KmV9cVOC5rYE4ur2y956/IS0CcVFl92jB/ok7CHxfhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI6FADGtWaZ2qanr5C3Yo/3mKh/k7LwKQkkq+WVKoAOflah9X4qwjj+LZuBXk2ZgLKdcnVt82ad4Kta5A+JT1viJ1536y2kWfySZFyFYZAuA5jMcKOmQfRIxGJotM2xgn0Tl2lECDFcUR/CCMiPfzO61PnOfbRWDmKp1l6O5XGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZJiMJgW; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZJiMJgW"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6610f407959so315984eaf.2
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 10:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768500037; x=1769104837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KmV9cVOC5rYE4ur2y956/IS0CcVFl92jB/ok7CHxfhM=;
        b=gZJiMJgWgMUyBRjQwPkXJVc4k6Tu9J+HhToPGGYymi5Ajm9vky2jxQY2yhndq3Lsop
         xzeChh8dMB+bzJy+FBZHDW9sFt8VivFC2HqW7X66ABPxMddYQMhWgyc38tprzr+VqBsG
         MyZjVwUpOLNIqBkbYsTjOSkIehhdb4nGb+6kBlLBHnKDmp8Qk0SW9Bc+kKxdLQL9CDm7
         PPcth4xjPWmw0JJAxMVEuczwK6qozPxIbqt8ZUE9y+fbrzDvoRXTer3h4Po7wd0skuFm
         iV96m2vGIAaEw7CLgFQMFtUAfhqlAIPdSwt82djq0r5Bk1YuufchvIvWYNxqENroOYa8
         74Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768500037; x=1769104837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmV9cVOC5rYE4ur2y956/IS0CcVFl92jB/ok7CHxfhM=;
        b=DubE6KDu5sIoVkY7gqmX4jslshYvF11OFrQuffEpxb6VcuWuIb3c08fL1NRtkqoKfQ
         7O/NhR2YQ5CGZqE5eX/OkAKXgw8gZTUTSJtuL1/kM8F2RENm/i6EeCWIiesuCqGh+4gt
         eKBsowR5Vi2ga3kPfzzhd4KHet4jWRxLT5tpX9jH4u/SsB5UrdOySH72zEKCML70ZsY8
         olE5Mh11eN2cuULEaw6MULKEyok6EAiCg/bgrRr7JtviGih0JBtZX/ap9B6MXQIEOSsa
         9uGa19XV8l+Ap6NKLEExpbPmRlOszsgY0nVcBvC1MjYlyFzj2hERqt7pAa7lTytpPTbV
         3fXg==
X-Gm-Message-State: AOJu0Yx94LtYES+vlla7uUY03NAXNkSQklC3rYUAbowzsFMdPN4tB3He
	1dp2briM9Zos1830zCVOJ7N43fnxLFzdmfwKiaJptapq6ynbvMIrQggGe2qsCA==
X-Gm-Gg: AY/fxX58bZoQVxARzbgQc2/0S1PyH4GjvC2S3o34oYCumvp/ub6L0cdhuAtC4GD2Fm0
	SyiIuwpYFNFwjPJQ54Tt9ugRGCPwHFR56WUEtPuE+k7b5I1BFDx1ZDoYwjFh6FP7Raoyy2eszC4
	mPdw3HoBZauUCJVe3lfuHlbtl4Qc+I+6KURLLUXSlNckp+CjEDVopWrhqOEGYNzDLbbKga/0uku
	WVUPogrY6lQLJRRBKCzck/heQW2XAgFbgnjnX2UuC/4aMHzfF5GR79zfQffDewLZadruoG4pZrL
	zEc1puXxqOKsxsIhQitQ7VtIfmJzD7uKATSoKE5aQTWyCKSQ8No8dWlPH6nzGxsnr/fdCG5ZwKZ
	5jUefOsMMY4cZH7ilsdcEu34+rZt4/e7m1ygCQKIYSvCAe7IlvNYZ1xbEri5RvpWMYDW4UVDyKY
	TZhTr2
X-Received: by 2002:a05:6820:627:b0:65c:f019:ccca with SMTP id 006d021491bc7-661188f95d8mr25954eaf.21.1768500037255;
        Thu, 15 Jan 2026 10:00:37 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66118781fedsm32302eaf.11.2026.01.15.10.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:00:36 -0800 (PST)
Date: Thu, 15 Jan 2026 12:00:30 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/14] odb: rename `FOR_EACH_OBJECT_*` flags
Message-ID: <aWkq7j2f3VunsBPL@denethor>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260115-pks-odb-for-each-object-v1-1-5418a91d5d99@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-pks-odb-for-each-object-v1-1-5418a91d5d99@pks.im>

On 26/01/15 12:04PM, Patrick Steinhardt wrote:
> Rename the `FOR_EACH_OBJECT_*` flags to have an `ODB_` prefix. This
> prepares us for a new upcoming `odb_for_each_object()` function and
> ensures that both the function and its flags have the same prefix.

Makes sense. All the changes in this patch are just trivial renames.
Looks good.

-Justin
