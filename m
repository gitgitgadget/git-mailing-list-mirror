Received: from mx01.frank.fyi (mx01.frank.fyi [5.189.178.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329A2383A5
	for <git@vger.kernel.org>; Sun, 13 Apr 2025 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.178.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744571850; cv=none; b=Z4qVcdsbLXXr1oAGviJwbC1uR8YUTCPbd3bicqjhy+CKplifzoZZier4doZdwnhcuuyhnB5JwXlf5nmt/S47mfQUPJNq/VahQHj1hJCx0xN3V5N0LXqQo4lcoQCs7DB9wh0bWaAgrhdM0sd9GbCyMm0PgJeMChd4K63ytE7+i5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744571850; c=relaxed/simple;
	bh=dxdCtog9Lz2aPV+ivHOZM7F5H58IRVno+Dt6XriQvLU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TE1M3O3/VgYTi3+Vyge3yvEG1Kzd55WQaymrDX21YAERtN9Sa9U6GRTcjv+ihc0747VA874GKZs/AGv/HGC+B92qYA4lG4g2WOtQy4BOkOyEJxwLqiDbQX9hq4zcbn88dicdDyDKqgDQ0Gp064vH4aAqvq8+5D10ZqkbiyppRVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi; spf=pass smtp.mailfrom=frank.fyi; dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b=hDtloFcL; arc=none smtp.client-ip=5.189.178.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frank.fyi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b="hDtloFcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=frank.fyi; s=mail;
	t=1744571846; bh=dxdCtog9Lz2aPV+ivHOZM7F5H58IRVno+Dt6XriQvLU=;
	h=Date:From:To:Subject:Reply-To:From;
	b=hDtloFcLcrL8xDr6WSuYOMv2oOUIrSNS/RWgnfeQnCDM0yYoIAvYgelxFB/RY7Ea3
	 JlPAQDyxXsukAJPC0V1LFix8jx8LCUmK8MLpEmIK3uy+tvF4scqs5fKVFjCPolGAUn
	 d5GaQzORDKfMM0EN2spFvH9SkA1V+LRa8lxLFwMZM71s/3EeWRtWWVmwWNOwLBAVys
	 7MX9qrjelcoYcQhDSDrVxfMfdYaLdSbNkQhNvoxaYR8tBMmSoB/bOPkJqiiDT/gNjI
	 KK5koL73bGoW0+vTIvcqniztv6XT43kSUpXlZQvryOo6DpKbLWOj0LCOttAj7FcZxd
	 Qjmh65TlJGBAw==
Received: by mx01.frank.fyi (Postfix, from userid 1001)
	id 25ADB112016D; Sun, 13 Apr 2025 21:17:26 +0200 (CEST)
Date: Sun, 13 Apr 2025 19:17:26 +0000
From: Klaus Frank <vger.kernel.org@frank.fyi>
To: git@vger.kernel.org
Subject: How to gpg signed email patches?
Message-ID: <fx2ofmmhkjmjqfqya5e3qvmovvmpnjepteqobcz4eia5sw64bg@yquuljpwok3f>
Reply-To: git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

how do I get "git send-email" to send the patches gpg signed? I tried
first signing the commit but after spending time looking into the
documentation I couldn't work out how to do it. All I discovered so far
is that the "git send-email" appears to be using "git format-patch"
internally and that's where it currently gets lost.

Sadly none of the man pages I looked at so far mentions anything about
gpg signing in this regards. Not even "git am" does.

Ideally I'd like to have "git send-email" send my patches gpg-signed to
ensure authenticity and integrity.

I also considered alternatives like using my MTA to GPG-Sign these mails
however as the "git am" documentation also didn't mention gpg signing I
refrained from it to avoid breaking it and causing issues for anyone
receiving that patch. Same for sending it using "git pack".

Is this currently a limitation or am I just doing it wrong?

Sincerely,
Klaus Frank
