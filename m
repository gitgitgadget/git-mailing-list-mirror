Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE1D14EC62
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715125; cv=none; b=oP4K1c4UNa38VYHDPoE6zbzEtHp6iuystsMjdRdze+bsvqFFsM/a2SHsY7ehn/lvMIxhZPu8zSBthtCO/JRDDDyp48SUA1wAZgz1F8vUsZjYRixo3mdJ79YmuYK+8u3sKexhAUB5qKcUpA6AUXcHZuBYdnMH9XRrCmcHyM6+pHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715125; c=relaxed/simple;
	bh=UsfzMmpim81AJFRk6D73P8ypRErJ3dxgDeex4FtSoi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ6YF53frna0+PLYEeTxt/mf6yoBUNWUW9Clz/n5IIOuHMV9vKoA/svx2Yfs2HqKKre4SKNt2q/Pmzoqfqw7WTm+VYmQJ4w+yB+7XR7+ARWaUvbZN7iamm52NfbV4+gQQ5XoXdUgwKEjZiIk50tpXvd209y2V619soaOJxq/l9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=nKUAceLg; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nKUAceLg"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e305c2987bso1669087b3.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729715123; x=1730319923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UsfzMmpim81AJFRk6D73P8ypRErJ3dxgDeex4FtSoi4=;
        b=nKUAceLgvdFoRQeq8la/JQjpvqIfRMpCcB4MzeoS79Dn+5vJ6BX67gvsliTIJPJBUC
         4ETggv80fFSisCNYtKYAoI8KdQK1i7pM6gEG0+QsKwrF+MgDlbr4d5Ap0RzoyaXwAtgP
         sAvRpvFug9Ed7XocceXGvjpkTmCCjfqAV39JhgnUQvEVF6Qs2k8R5Dseepa63/gnssn/
         tD1FdZoKAUqMZlyt1CnRlLAsvlrepMTFutVUw/B58P5sZwGqBCkrzgJOC8NhK+3SNUSN
         bNtEc3snA4zmQAgsnP500ssXA33JFq3QMHiKgigJb7JCh3ag7BW8uPEhwkgHdIHkYRbX
         j0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729715123; x=1730319923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsfzMmpim81AJFRk6D73P8ypRErJ3dxgDeex4FtSoi4=;
        b=G6ha92G+uLt4+hZQkwhEp6bohRUZlYNzWBjhoDMI1am2GFBH2C/pWISza0hhHsjKuL
         ZsexhMFzWetKAEuByvZtImEVOuTgzvuH50sIznlaNFpWoaq40v2KmjLgXu+H069+RNRi
         dCWq/uWzkF56sGoOqf2SDXTnNE6QChxHbcFFH8Z2MdyT2AOHY/th95sjRdqJDjDmadyd
         XfwxeTYiE7A2kU+ZPG1vefNSOn61Llop/EdEl5ntKyhrbS8BP9OD4VPlpI2VbJOB+9Pt
         XLlrmhQ8cBq6XSq2RHZMkGQHShU+U+YtKDiTZGU+8PcrQAmsFJJoftYPsrbQZQlLr8U7
         xFTw==
X-Forwarded-Encrypted: i=1; AJvYcCVKA2rAhjukxSXpUKmCjrO5dznQUGM7OfsXFadsMuD5G1F/vx/wY8R/LzVR9eLEMBA2xuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0cO94oIXKz2/BLlSK4WuHi4br7zU8UMEoOVMMwHTxFDsojJqO
	jVvD1tlpy3ibTaTQZaBx23aERu+w97BDndhaN9lwI86rfVgFxz2xxyWIwFSzqRI=
X-Google-Smtp-Source: AGHT+IFhAD1U3eh1llvEPYRdtZGKXjIQ55D+JX7/klM5T5bwowOTA2nIiJHlAlkhT3TdstYKv56big==
X-Received: by 2002:a05:690c:102:b0:6e5:cb46:4641 with SMTP id 00721157ae682-6e7f0e33ee9mr34666437b3.13.1729715123423;
        Wed, 23 Oct 2024 13:25:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d5c702sm16760907b3.133.2024.10.23.13.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:25:23 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:25:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Eric Ju <eric.peijian@gmail.com>, git@vger.kernel.org,
	calvinwan@google.com, jonathantanmy@google.com,
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com,
	jltobler@gmail.com
Subject: Re: [PATCH v3 6/6] cat-file: add remote-object-info to batch-command
Message-ID: <ZxlbsizeDUz5yp11@nand.local>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240926013856.35527-1-eric.peijian@gmail.com>
 <20240926013856.35527-7-eric.peijian@gmail.com>
 <CAP8UFD24jDT1yFNTp-T==-avccd4QjrwRtfJ_-wPx78H31VSiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD24jDT1yFNTp-T==-avccd4QjrwRtfJ_-wPx78H31VSiw@mail.gmail.com>

On Wed, Oct 23, 2024 at 11:49:44AM +0200, Christian Couder wrote:
> Except the above nits and another one I found in patch 4/6, the rest
> of this patch series looks good to me.

Thanks for reviewing. Sounds like we are expecting another round here In
the meantime, do other reviewers have any feedback on this series?

Thanks,
Taylor
