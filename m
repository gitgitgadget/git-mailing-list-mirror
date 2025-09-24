Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382CA1F7910
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758690717; cv=none; b=aq7OSu5v6tDlT2r2OOREKsTkGzhCZWs6Mh6CrGYnNqRIrnA0KOv39t8b9LOlgiXKYtQ94jeLST6Gn0hmNaPv6Uc6VthDa1rLo5oWQUVIZQo6rrDajy0RGXOGEL5x3H+sT23/xsxl11bPTURRQtv3kyEzAws+gVITwDdj9lHTB8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758690717; c=relaxed/simple;
	bh=yKRvLrsu2Ys5SmoqrWWHoUPBvQbkpXoZF2+PCAHIlro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zqf2Kd7XWV44XmHVcWQRdJyyxljJwuH5w89z5d0w9LkHqmnX84oxBTtz8JKH6WMNLXPSBJ2hUfKxBsuHt1Ck71K57yq11aFH/EwodrHObJomc06rMu1iZBOS9t7lJ4wS/sJrf0wTdzecCKrRVKPqrxSjQhIkGpGdLfvOl5c+DWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SsezVR4H; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SsezVR4H"
Received: (qmail 12270 invoked by uid 109); 24 Sep 2025 05:11:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=yKRvLrsu2Ys5SmoqrWWHoUPBvQbkpXoZF2+PCAHIlro=; b=SsezVR4HV1mCV3p/bTmb/p9PLQ1iZxySHgF4w1BxZQPOyWrek4RmGjDaoG21Xbrozfn+e1l0ebWz/pGtSQBUIT+9KECSgHAC6XmLf9mVk16tzMXyb13TsyTG8VcU9fMg6JjYoBXrScijSPLDcfy9fjqNr8ijKLU1S9qB0V6G665k6t/RDLj2mPsK8R/8nLO7JDZDVL5ltEgN2py4enseso5FyFEW1LbZNrVFZk3hyJPyjNgcUZefB7bKVpW8fM7Hr4brZcqnHCV5/tc4YGVsRTt8EjpmcoOFvfxDIWr8kMdd4ubL2VoRrIGPTZqSmamtCz4I4YfncdFIjC/Xv+N6xA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Sep 2025 05:11:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19051 invoked by uid 111); 24 Sep 2025 05:11:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Sep 2025 01:11:53 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 24 Sep 2025 01:11:53 -0400
From: Jeff King <peff@peff.net>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: format-patch: why are the Range-diff: and Interdiff: headers
 translated?
Message-ID: <20250924051153.GA1173044@coredump.intra.peff.net>
References: <20250924004133.GA1142438@coredump.intra.peff.net>
 <43606056-D212-408C-8E53-0B082ED1BF55@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43606056-D212-408C-8E53-0B082ED1BF55@gmail.com>

On Tue, Sep 23, 2025 at 10:08:42PM -0400, Ben Knoble wrote:

> Yep. My own patches have probably come in with French titles here
> because I set LANG that way.

TBH, I hadn't even noticed. I think after a while I end up just looking
past stuff like:

> > Le 23 sept. 2025 à 20:42, Jeff King <peff@peff.net> a écrit :

without even reading it. I did a quick search in the archives, and yeah,
one of your v2's has "Diff-intervalle contre v1". It's pretty clear what
it means in context even if you don't understand any French, and I think
it adds some flavor to the list. ;)

-Peff
