Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00101F8AD6
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242712; cv=none; b=IBdoc3+BcOO7PmXHwnb9k/sCvT0/5Zmk638sptcHRkinkNGRQwtDODq3ZQPlnxTcrznJCK1M5Fw55nqxTAUt7A5LvMVhXlAYyqtOOdltA5E3hpRPjeElhVgqZutPvTUoFd9rIww751vHDh+RAXrWtE94RQ6Gc7yAc5t7d00yQAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242712; c=relaxed/simple;
	bh=xICQzzMDrtahf8yDb61jhHQUoz8wgB2eGr8PtyHgPL4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jhiPxRKWU/PFRW8dSVmh63ppAS9sdraWD8iLR5E2jKeZkV1sB5SCm1aTPy96y0Hg9RHabznvqYMQloKXAiMyw2W4d3EzOT+3bvp5iz/WrvK6nByM6KZ215rrmHAmDdArsU73gSOfJTRil46wQbsz+cx3NHwp2DDiqwg1x34oi9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=tq/QkhXg; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="tq/QkhXg"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:666:7ab6:84f4:fbbf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 906D060AA3;
	Tue,  3 Dec 2024 17:18:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1733242707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=5qZfgtyX/DgLVkArqP8oKvRn/zk/Qk+JwE6ufWn1WH4=;
	b=tq/QkhXg4U14Ks8gRh+Q94glElfgzyViExzJj85sEMJCpcurd3HsUg39YE8VrPSbF5ggWA
	8mPWREmJygMd/6scNn7oj2O5pGnXRbQ7HF+uibSkIB+bbfrydkB1wgUe362oZUhF6Brqeq
	YZFyY16BflqYwts3VWkb8Id+odkqlDHzMATWHceYG1JGVvz4b1a1eElDYNCmC+wWMS0h7i
	xg165IIeTHkUx7T7PznnpleLFjq3wkQHzXuCRNw881ODzywPnIDCyYM67n1V7oRcTgOCZE
	lSODdB9hItyo29Wlw8QTszhYFQZrUdbhLIgXSCh8PWutgWK6ww2b7xmxhsu6bw==
Date: Tue, 3 Dec 2024 17:18:27 +0100
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: mg@max.gautier.name, liu.denton@gmail.com
Subject: Re: Detecting squash-merged branches (and question about
 git-diff-tree)
Message-ID: <Z08vUxoyK67LXZc3@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z08N4AlQKiNi-IOI@framework>

Uh, btw, there is a typo in the script in the previous email, it should
actually be:

 commit_by_patch_ids[${patch_id[0]}]=$ref

on line 20 (instead of $patch_id[0])

Not sure how I ended up sending the wrong version.

-- 
Max Gautier
