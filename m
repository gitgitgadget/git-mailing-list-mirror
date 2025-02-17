Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E0021C192
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798176; cv=none; b=kdaPQh3sy+Gn7OrzVGJMppyBm8pit9lghioiLfd7hyo2+12/DYVyeJV3XgEw+7uD4vx4v3KpeoPDI49Cspbe+db7bNXoofljyXHia5XiedPD4Huh9xtmarmZbrtkqt39lPhVpULuvO2UxeEMPeGnekvABdw4+/jkXIibLme4M/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798176; c=relaxed/simple;
	bh=+deaqt7M+RRtJKnCLPgRobjXOm5rX+6fte2sREOS4sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYzKMT1h1jQY1li9ygalnFvQMHZOLHjE1ttphSSyRaOv2LJhxjKArYskphOnZUtlgLHChKYa4QTkDslmz3rnXzGAsQBdvg1vWMnvNPXPQfalzJu6gjorSPGvEfjXC+UDynsNA+iAZJ9nrN6laMRqJ/YcEazYg0v5vMQGOXjfies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjNh3lY9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjNh3lY9"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-221050f3f00so34355135ad.2
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 05:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739798174; x=1740402974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8zN0keaZaJTbLTwzVMNpQiyQuJK5BbVVRp6AMMM9caY=;
        b=LjNh3lY9BDd7nuws1dSLsdrO6Q4RJzL4KEFm+yEBqxnxDr5UZV8ZSxawHQo+A6K8MD
         mduWBF4JfKwfVxsxJZAwpRHygR/7VIImMWZPB51E5gpZMneRwPBSdlpGSQQMiVnYzsv8
         fdS5eFb0c47B3ntcgm2IeDVcBBjm40kaeHeuoPz8t1b3cS1CD7pEQ5mAtkrMG/ciFZrh
         nAj6rY/IzZfli1iH/6VV0vgX4GRU2KCDTeGjrKOVYZS7fj6nUe0TkkJ9/FNAwnbqHgIo
         ylcvcF6cYmT+cPUM18KFkR8uTXrUds0ECMfad3wkWHVnj9HbBEVg0747IPnG0Rjrt8vz
         pVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739798174; x=1740402974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zN0keaZaJTbLTwzVMNpQiyQuJK5BbVVRp6AMMM9caY=;
        b=u5QxgB1hd1F48luqmPOLdUFIEkgvbTk/VWvf2iA3IF2Gk+TlOKKdajz4/ZnndKIKUM
         4OxEAWZUxh85qD/e/SlB7ZLJDFqt1hPvEDLyPgVkHOytvaBZcZGx+0OEiNkuqoai7a3H
         WXeH53pfJPOMyDGIwP0L8N4v76fgTK1wnT/3Q2y0nnHuICsDm5FNJpUaQniJU9YyErx0
         k//SwIwnxXD5X0E/0vJzhH134sGb90QiHU4FGoaEkrQrR/49S7R1zwNPP4SSnYfEPmei
         gABLST9a9pq2Lmezq2IQOMUzxfr2ds6DmRAL+D4f/6i+IRnvIOt3hXUfcfNliuxDjMpY
         Kv6Q==
X-Gm-Message-State: AOJu0YwkZhHrJLDOQfPUlJsI34g47vsOPmQRTwSiNZKMchPu+ZTkB5IV
	aMZahs+HZTf3c8XvgLXLVrnCbRbMz2RSxBHYGBu9fjUkl+EiIzJ7
X-Gm-Gg: ASbGncvhp2o6ghSWTwpLtRQyNsUYcsT9jkcG/sq2x/GQfafQpWwJpSJd8zoaIqUEQtm
	UlvthKyPM6Nya4iYjE6iPcDEr5Jwizr3VbZS1mng5xgLSa46O3xohAISH8Mxh41Jp39h/dVaoza
	GSy9CU3tMq3cBBo0FByyGwjagu0+k2vTNzVwCKap7KUGVI6AX5H7CmZgvXYNNiMn4HculxsQdfj
	Gl1LGRLKYeXbN6ic0ROvv1wCg0eSxqAllGnTfSYTQURvxn0qfbhSUuPAIuvnX9iLhsRRbztmQip
	vnuT0guPMkw=
X-Google-Smtp-Source: AGHT+IGo4DHM/BfW89adbVm2xGl/8AapuU9CHSz6pa92oTalfIosHZdOxdqXWdkqq87d0s+zMlFl8Q==
X-Received: by 2002:a17:902:dac5:b0:21f:140e:2929 with SMTP id d9443c01a7336-22103f16b04mr155335965ad.15.1739798173947;
        Mon, 17 Feb 2025 05:16:13 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53491dfsm71241875ad.3.2025.02.17.05.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 05:16:13 -0800 (PST)
Date: Mon, 17 Feb 2025 21:16:11 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 04/10] packed-backend: add "packed-refs" header
 consistency check
Message-ID: <Z7M2m0diauWW2ARQ@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qN8U2VbZBnUSWj@ArchLinux>
 <Z4kQUb7og2Ce1iCo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4kQUb7og2Ce1iCo@pks.im>

On Thu, Jan 16, 2025 at 02:57:37PM +0100, Patrick Steinhardt wrote:

[snip]

> > @@ -1779,7 +1867,24 @@ static int packed_fsck(struct ref_store *ref_store,
> >  		goto cleanup;
> >  	}
> >  
> > +	if (strbuf_read_file(&packed_ref_content, refs->path, 0) < 0) {
> > +		/*
> > +		 * Although we have checked that the file exists, there is a possibility
> > +		 * that it has been removed between the lstat() and the read attempt by
> > +		 * another process. In that case, we should not report an error.
> > +		 */
> > +		if (errno == ENOENT)
> > +			goto cleanup;
> 
> Unlikely, but good to guard us against that condition regardless. It's
> still not entirely race-free though because the file could meanwhile
> have changed into a symlink, and we wouldn't notice now. We could fix
> that by using open(O_NOFOLLOW), fstat the returne file descriptor and
> then use `strbuf_read()` to slurp in the file.
> 

I have been looking back to the original discussion. I will follow this
advice which eventually avoids the race.

Thanks,
Jialuo
