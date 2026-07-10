Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A04B3EE1E4
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679393; cv=none; b=grZBFvQEEhWZE/VfvFcjTN3D9SVKb1Gi7Mz4DicgIvPJB8o/cUw7efzquCpivcAC8iZSE/FLUSR3zLTO5EtX3amaGkrPHvjxGvEjnLQ7DkxwCnwYKG7WwOtIEk1V3wkgYRv5hZzhhPyzgTEq7K7lZHRKsmok9pPN65ftD+AN5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679393; c=relaxed/simple;
	bh=CQo0eLbR6082CNxxs18zkZvqtSqwYvouq0klvEdJzig=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S5wkjBcQ+fDSbtr5NRvTRCsPOCXZNvZERCD8McON32w0NKjU6Cz5T3bg0DQ90ALLzg6jnR8UP2vetbhTUg9DR83ZoUhm8506ntTtjF0bls+tn8n+tcYWsiNrN8fDttlXJtAZPs7Q2iDDy/e+f9q9X0VM3raEjbThwoNDJgJC03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=T9YGMtkw; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="T9YGMtkw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783679388; x=1784284188;
	i=johannes.schindelin@gmx.de;
	bh=CQo0eLbR6082CNxxs18zkZvqtSqwYvouq0klvEdJzig=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=T9YGMtkwGalU8e2KH/clMzwtsswQDEck9xnLrcxX0hzcjtGreN0h9VgVyixQIl5g
	 +Snztiinfy2zj9xZdmYGr29tyjhBME1emPZilMpTYF66Fpb+e9QrJjYZQ0asPp9U1
	 JhalA5QdCq22cNo+rc4mUgBM3KAT9OU5wWugw/Tc1xuhh7m+542WqERZWjI1vHoUG
	 hhSn6a5SCkNLrkwUKZzcGWGel/80yUJe4Z2CEb0IboQZHKye5vaYXm6dKeYua3GN3
	 hQd3nAAlpjCIt2k/6AdK/veamcFuoPuxr2T3ub+8NneB6MZp6q0YQ4Y9Dxz8OOCiK
	 2+Zo6Xr0xrg3gPuVPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS5A-1xSlyz3TDe-00fEvR; Fri, 10
 Jul 2026 12:29:47 +0200
Date: Fri, 10 Jul 2026 12:29:47 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tian Yuchen <cat@malon.dev>
cc: git@vger.kernel.org, ps@pks.im, phillip.wood123@gmail.com, 
    stolee@gmail.com
Subject: Re: [PATCH v3 0/2] environment: move ignore_case into
 repo_config_values
In-Reply-To: <20260619155152.642760-1-cat@malon.dev>
Message-ID: <9ade3ca2-fdd9-c5da-3d87-a754a0643d6f@gmx.de>
References: <20260618114207.605211-1-cat@malon.dev> <20260619155152.642760-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:64PO7G6ipYIgwSEOcYhujypqx0I+MLY4+lXYzSEDY+CVAkFWRjV
 kCej8l/43zkZLhhthVvWDKbCtNWGqr26OX+mJ+yM1fl5gFC1p6BKgXIYN/HphYJLK4KRrBR
 t6TJ5lYEQ/vZcIIONRiwVH8bDfeony8Aj+2f7V5lqFQpurtF4Y/tdvLIpLfZTumVGbamMEB
 F7vF7rV8PmVG2MqDdpS5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vUoynwSZV4w=;ln2W6YBOq9eFKw249+/P/zguwmH
 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
 96FtIKRZmJV6m43+hY+GoNrwdKA=

Hi Yuchen,

On Fri, 10 Jul 2026, Tian Yuchen wrote:

> compat/win32/path-utils.c --- Is it appropriate to include the
> repository.h header file?

Since path-utils.c implements logic that is repository-dependent (as your
patch points out), including that header is appropriate.

Ciao,
Johannes
