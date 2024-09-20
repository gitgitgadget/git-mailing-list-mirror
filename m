Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3823D530
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726854814; cv=none; b=OYcuNI4Ebmvn+N8FNg2HGtdVgEgQrA8B3WWBhCfb5h1i0NMJwuZlCzHcwla4lgmawPXOX3DMQt1H5F/fxEP+5XKDHKxfWW02YL/miaS73lPa6Ygx0QgDW6vLvEcfJdZqeb5Q/nwYXK+45h2H9jbA38UEmn2GiB/tmhUYZye1jno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726854814; c=relaxed/simple;
	bh=kqf7UFk7yFk4Ijbav9MFYSI/QEwQKceDo9JbRtTzZbQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=ENn0XObEVgZQOowvqNx0G5S9fvemCL8yKfiGZbn17kancTaPcqIkR43KQWX8YRuZGumWWkBiGovtxkF8ia10kuDmEMwY2ClyxRaIagUEmAjUrmVa/g6pblNogV46EEXZaIYz9V6sEtCzAPC+slFhpko12RfToo56TTIcaAloBkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie; spf=pass smtp.mailfrom=rjp.ie; dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b=WeWyig1o; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="WeWyig1o"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1726854809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XpFyVpJoHnXp9FB9TGErmTxCupMplTJlZQ9H6LPYArg=;
	b=WeWyig1oQDyUtNKI6ZGQObxOdGP93jKIjXW/ZvQgjCwnLcPFiuY2WH+7cAB1gL2BtKs+Ez
	SKBvzTsiEj0uzQfu2yTBPowiZVVqX5bor2qZYM+9n7IQ/mCddJ075t4fb9E389ko3oaYzo
	gjDFGOA0EPfvjYM7B4j7700/uK1BtIg=
Date: Fri, 20 Sep 2024 17:53:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ronan Pigott" <ronan@rjp.ie>
Message-ID: <23220a9ab261d3d8d09586cce3964e6772f531a6@rjp.ie>
TLS-Required: No
Subject: Re: Archive from bare repo?
To: git@vger.kernel.org
In-Reply-To: <4ace58897feee2d86839af1a36770e49810e59b8@rjp.ie>
References: <4ace58897feee2d86839af1a36770e49810e59b8@rjp.ie>
X-Migadu-Flow: FLOW_OUT

September 20, 2024 at 10:48 AM, "Ronan Pigott" <ronan@rjp.ie> wrote:

>  $ git --work-tree=3D/var/empty --git-dir=3Dtest ls-files ':(attr:myatt=
r)' # list of files with myattr set
=20
>=20 $ git --git-dir=3Dtest archive @ ':(attr:login)'
>=20
>=20 fatal: pathspec ':(attr:login)' did not match any files

Sorry for the typo, both cases are using the same pathspec
':(attr:login)' but the issue as described remains.
