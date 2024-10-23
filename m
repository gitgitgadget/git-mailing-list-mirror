Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174061D14E4
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715695; cv=none; b=UnCMEciM08CLy0t9h5jMiKYpYjo+SYXZG8KgvSbqmlcv0PAdArdNGEiE/eM9XVVW1MMNdpCjL1thDhkv/azULpzR7erc+AU7ODrx0kDgWBPnc8AvxevChULbzFFLt00wLDTg6ZmbU6FQj6RNIo2yD8XLHzXGe2W9uJ5cPh53Er0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715695; c=relaxed/simple;
	bh=TSNzaivmzrD1IoiXRfDxS68wcTwELn8KUGNrrroK8xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zz1vNRfuQpoPMtJSJllrmEX9ccLJv1+6MyMcVAOptU0+1TixcHMz0SAOFX+Aq9S345Pa0Q+i5bmB11lWDQ7ZkwSTtw2/OHTu87FwITT019iVhtpmLFLYfkVFnEvXsDh6nU01xUSzp5Je1EBPyXVvHiQEUpjUMtn/Pu+L/U3djEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=RboL//9y; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="RboL//9y"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e28e4451e0bso252105276.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729715693; x=1730320493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+zNbdn5UWwhN+s0mylPYWeTJNQmmqHdQBALsd7rNs1k=;
        b=RboL//9yBmowFfpdqk9dv8ijkOVNpD2wTVuZmgVVFQgI6gj0ZqZWknV9otLRqWZ1Dv
         tpOQJpzhqg3iHjiLmbxS+U148v8FkDRzanlbD6+bSwXFYHNN5tuNsO/4QJ4du51RY3rI
         3Slnlw+7I19YUCBe1QhZuAf7yBErfOppjGm412hFQaczm+WKyT/o+NrYqqtAkT6YXfUa
         ixCYDyvpLOxV9qVkMZpGGLKGbjl9QhTnvPYsNziMg2EfL/3/h5QEqh3SLkw3tFV2LnKl
         o9cG3Aswvc6DZxrtr6Uw//mJtJVTMlxBFSs9qi+4ZhOs9kQO+/e4aP6cJS3L7KlyI01k
         vFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729715693; x=1730320493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zNbdn5UWwhN+s0mylPYWeTJNQmmqHdQBALsd7rNs1k=;
        b=nakp1JgRW4t0Qd3pDfh+gRzfgXB8QTW0ZMBkA0Cg3O3YXPgaA+m+la/6goujW/+Tng
         6UU8W9+ZAgmL1FrtD16TDXjazZ7uodI2WAawy/cGX2JaKGoaLu98JBQBj56Lrx5ZiZYZ
         nQ2lzQAsZyqATEBfiYWbA9o6ra+rBpZor5+5OMJ/Xoh7isk0nTxG55H3kxM9jfCMZc5u
         wwjTr8zpk4Z51iPGWHUNe1fT6Y0j71VOuUXIxepbU09mBxAdNruFjfl+f+oabniHPqtp
         2YlRWPDbhw0ve9tlnD6Pd5Q2gyw1ISNytrmWUx8+q2J05zj8GWo+5yX5dF25L/AohZvY
         RsHw==
X-Gm-Message-State: AOJu0Yz2juiKO6fqOIUSJrWOm6zvWY1nEjgKPZFvGiye4unzQmSUmmaQ
	aZzHVvbqjEyn2JsKL8nIitoEtICAdGnNS2oSiVsB8j+Iii588KkgHFfKHAlt2+JKgCZaIcogSeQ
	mPrM=
X-Google-Smtp-Source: AGHT+IHqVDBA4rV+oNhfqK/FVyjTUR8IP8UR5Dm+nbRubAKU/495payIuLuYOqTqY6CD/FboC5fw2Q==
X-Received: by 2002:a05:6902:91d:b0:e29:629f:8a7f with SMTP id 3f1490d57ef6-e2e3a6ccf71mr4072519276.35.1729715692982;
        Wed, 23 Oct 2024 13:34:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdcb02b51sm1590929276.61.2024.10.23.13.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:34:52 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:34:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH v2] CodingGuidelines: discourage arbitrary suffixes in
 function names
Message-ID: <Zxld62svV9iDCcJJ@nand.local>
References: <20241021124145.636561-1-karthik.188@gmail.com>
 <20241023075706.1393147-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023075706.1393147-1-karthik.188@gmail.com>

On Wed, Oct 23, 2024 at 09:57:06AM +0200, Karthik Nayak wrote:
> + - Function names should be self-explanatory, clearly reflecting their
> +   purpose or behavior.
> +
> +   The '_1' suffix for function names has historically indicated:
> +
> +    - functions processing one of several elements that all need to be
> +      handled similarly.
> +
> +    - recursive functions that need to be separated from a setup stage.
> +
> +   To maintain clarity and avoid confusion, such arbitrary suffixes are
> +   discouraged, as they provide no meaningful insight into the function's
> +   role.
> +

I'm still not sold on the suggestion to discourage the use of '_1' in
the future, so we may want to further qualify this statement with cases
where it is OK (in the spirit of Patrick's "as long as this is loosely
applied" comment from earlier).

> +To maintain clarity and avoid confusion,
> +   arbitrary suffixes such as _1 are discouraged, as they provide no
> +   meaningful insight into the function's role.
> +

Stray diff from the first round?

Thanks,
Taylor
