Received: from renault.us.lt (renault.us.lt [79.98.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C02A55C26
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.98.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912449; cv=none; b=UvzB+l4NrXrDc943A04CosOP0o1bk8P3y5bEMpio53+twTu/ARnmwBxsAiBWR15nXVO9wZ2GoF652M2X1GbcQ24FCv5DmE99Jdga82nEpcxAMCLlJcSevoa9TraP6dPf+qC7e9aQiot+2MlI34RooYAf5Gx87BTboK8zT+g/K4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912449; c=relaxed/simple;
	bh=hcmNUkopjc+TAPb0kKoFdI6vRvvNuSi5kZ3xgFgyeAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwXqgYB9xCSBbxnj9BMLVDjd4gV7GfsXTdnmGQXOc4EObxuvNl/yLtz+IstDcKLqLMLruCPxQmiYm8ib23jIJgNtLy5nm2hfJAey3O0osigw8rtme8GCSWfEk1g5EF7FAvDEaYDnSDSCvqzxBBlNzG09nDOqLZELqS4OWoqd8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org; spf=pass smtp.mailfrom=kipras.org; arc=none smtp.client-ip=79.98.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kipras.org
Received: from [157.230.0.129] (helo=localhost.localdomain)
	by renault.us.lt with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <kipras@kipras.org>)
	id 1rvCm1-0001vk-VT; Fri, 12 Apr 2024 12:00:42 +0300
From: Kipras Melnikovas <kipras@kipras.org>
To: spectral@google.com
Cc: git@vger.kernel.org,
	kipras@kipras.org,
	rsbecker@nexbridge.com,
	wyattscarpenter@gmail.com
Subject: Re: Short form of --force-with-lease
Date: Fri, 12 Apr 2024 12:00:36 +0300
Message-ID: <20240412090035.87612-2-kipras@kipras.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <CAO_smVhB0QUomdSxGqwvFKrb53NGMZE+y=3zbRnQX+ciLRZyOw@mail.gmail.com>
References: <CAO_smVhB0QUomdSxGqwvFKrb53NGMZE+y=3zbRnQX+ciLRZyOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: kipras

> > > If this is mostly about saving typing, you could get a similar effect adding
> > > an alias. Something like
> > >
> > > git config --global alias.pushfl 'push --force-with-lease'
> >
> > Correct, and I already have an alias:
> > 'pf = push --force-with-lease --force-if-includes'.
> >
> > However, I see the config option more valuable - it would protect against
> > accidental `push -f`, which, out of habit, is very probable to run on accident.
> > With the config option, would feel safe and wouldn't need the alias either.
> 
> It would normalize the use of `push -f` in people's muscle memory,
> which would be a potential disaster if someone lost their
> configuration, but not this muscle memory. It also would break
> automation/scripts - `git push` is likely used by both humans and
> automation <...>. A separate flag (or just using an alias if it's for
> saving typing) would be safer.

Fair point, I retract my config option proposal.
A separate flag, as proposed by OP, would make more sense. Thanks.

