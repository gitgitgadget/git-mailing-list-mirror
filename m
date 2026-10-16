Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BE64C9579
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157506; cv=none; b=jCFf/oJv78+bH5dYFezBi5emHMEgYvd3OU8q0hns94lE6X7163sXWcwuCXqAILd6UpNkCxlFmTpfa1tUloEpex36D9gjSz0qFy80m8OiBKb45l9hxY3Sjy2Udg10OAx8F8A/rCq2YTkHDl5x4xgpnDk+P/pVVbyUbZ5KrtD+thI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157506; c=relaxed/simple;
	bh=/0s+Ci8/K3Q1QBRrB/YV8tkw9B9ElI9I/9GtPM+bvls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5eQXSS8YlP3soLZYjmSOl+Cj+8PvyvqScJkOvz5/uyEo7vI/g3wHO2eFlx1kYpSuhKZqZW1MfRPymvUVwzt4cu9biFyWXhM4g7dMDqRyKTp/eCu+yl3dVQO+FJmKQ5SHjVi182gLTXLIMlFWlDyk2gv5OcKWsCrSLeCHo1onO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UA7Y5XId; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UA7Y5XId"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6ac76a02368so6252209a12.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792157504; x=1792762304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0/BkWjko5yPpUclHa+cvN3JDX/26+XmSrCN9UvMX7qg=;
        b=UA7Y5XIdMJ+N9fmXNI/YovsYciE5WQVcqUP/8BTfEOMuz64yM/poXisSuxEAa/o6an
         Txipkxqs/+N3GNpD9GXSEkofaleXQFZIqCjb1UZwJMmLh/V7KPxkrtcA6jSTD34RIUPV
         zYyxb1xnoP/PeOPDx6FSfJRT9XtkYaKMXdatVX8OkqRtQBni2o/OXhEskA44OTveNGux
         lScwmsJ8kcpCRnjLXfq1y/Yq9vf0Xqo3TpdOD9Mzw83CBkXOSTsc3KUNAzGG+/ycrAYS
         F6thw/fkW2lhCERHvKaVAj2FJ4jinXTaf/fC9w7HO7A4OSWFFdbQicZpWytlOZtQGI8f
         tBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792157504; x=1792762304;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0/BkWjko5yPpUclHa+cvN3JDX/26+XmSrCN9UvMX7qg=;
        b=vFSe4UKMiomrJ0Lvna+MKgLfWQSqx/ZvAsEzaJWaBheom0agZxgfZ5QxXqU0AyQwbZ
         bE1o7jGA5HJbtPkfqmLnok/gB4tPkkF82u4gxMPaJUurGG5jt3BFBivsti7FazBHo3c0
         kSxSO+Tnusn3taezOQ78Zghz6h4WJIaFGcTBdFuav606TDjmPps4QNQqzSYWo+/zPDD6
         CJHFBHUqHJ5DCMwTDrBM7ds6okCTI2uxqAOwbLV7EfhSK7gX29Wwl0IQ93viQmNVGwvV
         uNDJswghSgJ5wrGqjEZtcWgyvv/OQS3O90RnrU5sActPf/v4G3cSdJlfklFX4VhcWpxp
         t2jQ==
X-Forwarded-Encrypted: i=1; AKwUvBxaDRRxU6V5xge7UOVl3Hz+RfrZCRNN1dvOX5WYlOMuK324yCUwlpXDQRdMdQkSDhSZXjI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQsIk8M7ztdBRAA1DizSuVMYtfk4foQ//fTsZqs7T0tIqXi+6X
	E9WdxLghg/h6EH3g0jblIeNDgpu01udcR2xCb71aqBSo+se6kjyOT8ZkgVpr5Ymd1cH3q3u08+k
	PbWEWEGA=
X-Gm-Gg: AYBFou0S+dYS4XRCcBJ8KTuOYxGE58tlfRnaovoP6fLqc2CNUEUco5M5/m6xU08fKJt
	jqin4BM+hkSsbJ6isO/+m05fauH1FM5wEjvm+zt9KMfHtfO15z8oo3E+K9QngcHJQ4p6GqxTo/7
	mP0e2tE3kjMnhFIxSeXOm12Iy0PnoDnnTMg1wqk8XOmDYd9WG/VlK6vG4cI8/KMEkbFvbhZnlKV
	70PJXeU8o49JwasjHllDlWs9DK/ALyRG5uLYbQW+MGsYDX0Hfh6DyrLazeoJ06dyuF/25pvNnhw
	BzpODK0h9IrYAI89SJaY7OdXQsyiKZlBEc7Wat/DT+ZJOjPAev2bFbhLh2izBqOOX8wzg8H+g6C
	Acdhjc8OfV7UXGmARI7qBI29ofURwfNtTc9cf91s3k7JxJvrS8PAfXg/VO2nADe+qsKgfabsRg6
	JFbMwyrVLSp6JLqlMcrxSmtv9FK0Scg2dyopyfRJg/WeHUImgXV/f3z1VS4wG6WU1mqSKT9Vlyk
	w==
X-Received: by 2002:a05:6402:518d:b0:6af:f8c6:7859 with SMTP id 4fb4d7f45d1cf-6b17c28bef2mr17656364a12.41.1792157501863;
        Fri, 16 Oct 2026 06:31:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c4fc4sm4576494f8f.15.2026.10.16.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:31:41 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:31:39 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, 
	Jean Delvare <jdelvare@suse.de>, Elijah Newren <newren@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 2/2] merge-ll: use tempfile API for external driver
 files
Message-ID: <20261016-faceless-demise-8e4678750d2b@there>
References: <20260929051200.GA1100000@coredump.intra.peff.net>
 <20260929051312.GB1100669@coredump.intra.peff.net>
 <xmqqcxtwhufq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yxkksifpfd5ib4jb"
Content-Disposition: inline
In-Reply-To: <xmqqcxtwhufq.fsf@gitster.g>


--yxkksifpfd5ib4jb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 2/2] merge-ll: use tempfile API for external driver
 files
MIME-Version: 1.0

On Tue, Sep 29, 2026 at 09:51:53AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Will replace.  Let's mark it for 'next' (unless somebody notices
> what I overlooked, which is not a very high bar to cross).

I see this landed in next.
It'll make our users happy.

Thank you!
Michal

--yxkksifpfd5ib4jb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCatInNxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Aiw9AD/QqxOzOB6s8INvoUGWdiS
gLOH7euqNde0JezbKitc5/kA/1JdiYwqZZNVS5lEq5lQx8naQ8r8Eno/VxSRYH/q
/24N
=S2T3
-----END PGP SIGNATURE-----

--yxkksifpfd5ib4jb--
