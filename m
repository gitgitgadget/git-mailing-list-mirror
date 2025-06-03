Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86DC2C3261
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 05:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748926988; cv=none; b=hhLTG4zPngE+PbQ7b/KaIzG/Ei4fx8N51JbAYhq5inAFbIHsyBxrpZczK/fwznT9wMP3VI3mE0/wlnynTkWP7SGDgOXyEOOUc8Y9vvUfv1WxCfMG1m4Oa+aO6r9MMdKSCDy63Uexd+I2nJBphYxl45WL8o05KTFQyKzdMkH7loQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748926988; c=relaxed/simple;
	bh=jh10qOQBTj/fOWNcbGXpuNYjFYJjISXZBrBVco0l3I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzPaytUvYRJjP0G7k0bLrECNdul+qguEXNA38hpBQEDnZa/Y5jPllvkCmK19onE/vGEzZB+MvU5o1W24vUOmVrsrBw1nC3HA8mYcvr2FaKgELOPAvEjGD6oOfFeq3PaqX3qlEvIz7FHbI3TryKtRV6norMwFGX9jkBRFUFfEaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=XLDYBUuE; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="XLDYBUuE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1748926978; x=1749531778; i=tboegi@web.de;
	bh=2ZJhx73gV6obCEhRDahDf9AodYrH4TWj2cq4pGSpvV0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XLDYBUuERMV/L/fvMZ3wRKQp1X91rNAUBOq+EpJ2H8aHZ7pDg4gQOAijD1lw3jRJ
	 8j8lWjXCW8ThCzXKMwi3nscXrp5Mo/liQAnP6VRjvLmHH95G1fX5U0VFf18SnU3vv
	 ohN7Yf72rRR2LZ8sMI/rYebOSZb5RRFB1OT0HctJD0NF8qcahy+vRfQAt9ZJz7iJS
	 XbnHsdBoqNUyNs1k9cw/OAe4i6vQJ9IEUPgFigbDl1UHMbT2n8KLGVv01LHSM0a6Y
	 cUUJ6BhPzQyhHUF4KkZhF/owQnk+koswteIBf8yv3kwiZTe+rvAsQXUx72Ys8LUbH
	 w9FRygHnEevnGCNX1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mkmvj-1uj3F83FAV-00bVMb; Tue, 03
 Jun 2025 07:02:57 +0200
Date: Tue, 3 Jun 2025 07:02:56 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mark Mentovai <mark@chromium.org>,
	Git Development <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] t: run tests from a normalized working directory
Message-ID: <20250603050256.GA9449@tb-raspi4>
References: <20250523193722.68344-1-mark@chromium.org>
 <20250528201737.55268-1-mark@chromium.org>
 <20250528230804.GA16856@tb-raspi4>
 <xmqqfrgmhep3.fsf@gitster.g>
 <20250531054618.GA30443@tb-raspi4>
 <xmqqcybnxvr2.fsf@gitster.g>
 <f0d4c85a-b833-c52d-b54f-77ab81f22451@chromium.org>
 <xmqqy0u9subw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0u9subw.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:MjaPMJLX4S3GQoMmwaf9Zf2fQHipHqAXxC20j3q8/bzc0s9f9hu
 IH9FSnef3hByZzJFIx6dO5Z5P4JlLUWbpqRkwdcUOHNpSETULFKuIFC3/o7eJi8G/AIwjp1
 yNW1UQluz9mE/3SaICI5TC2KuAxz3AikTrRFgAHHbEDCQarn0Czq2uFilBZR7UwyMRoI49T
 5clmtxUe+JMMuaIOYMFDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W2O+MTpHUM4=;uhSaSbLrPzgeIfwfJVw0fDkcMHI
 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
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2025 at 02:32:35PM -0700, Junio C Hamano wrote:
> Mark Mentovai <mark@chromium.org> writes:
>=20
> > `realpath` is a library interface that transforms paths to those
> > having the semantics at issue, but it's somewhat obscure, and easily
> > confused with "real path" whose meaning would be entirely
> > ambiguous. realpath(3) documentation from POSIX[4] explains the
> > semantics fully; glibc[5], and Linux man-pages[6] provide full
> > explanation while also using the term "canonicalize".
> >
> > "Canonicalize" alone is too generic, because there are several axes of
>=20
> Yes.  You need to specify what you are canonicalizing to, and once
> you are going to do so, there is no need for that heavy verb, i.e.
> you do not need to say "canonicalize it to realpath"---you say "turn
> it into realpath" and you convey what you want to say just fine.
>=20
> > All of this illustrates the difficulty in choosing a single term to
> > unambiguously convey the meaning. I chose to write a commit message
> > that favored technical precision, even if it meant tending toward what
> > Junio called "the more verbose and repetitive side". I believed that
> > to be necessary to fully explain the background, the problem, and the
> > solution.
>=20
> Yup, that is why I said I thought your original was clear enough.
>=20
> I am tempted to say that we take what we have from you and merge it
> down.
>=20

Thanks for the long explanations.
I still stumble across the headline:
t: run tests from a normalized working directory

Re-reading the help for realpath() and pwd, would this makes sense:
t: run tests from an absolute pathname
