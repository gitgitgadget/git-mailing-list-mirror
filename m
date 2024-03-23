Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215811A38C9
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711189692; cv=none; b=n3fT3FMrWaUvX8i+/p/rd3K1OP/8ZQwP/DPD0gAmOC1219wTTUG3J37ij3epvV6zaCUG34W2wRD8HOtTP1bODZeSg+RJLJOIT2vLfE/vu7TNB6YSYy97CVVqhIdiAUce3jjxrNGFaUrO1y8mVbLXj9opCNc6xnNcCc4xsowiBi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711189692; c=relaxed/simple;
	bh=eX7Q8Be1lL6har2GFGXfxuN+qwcI2utSI9tRCtFf1d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtNEUjYwMyzzNRCr3Y6F61a4E/Wrb48RD241fpkhdd3x70ECSpC6ThuQGt+MNPg7wtLKveRwm+n62dc8/pqF+WThUuosTDe5YOCLFK3b70iVyZtYEbfEr5ekilVMviAW+V4w/JpLMwCyTbZPmg2pfdOrZnNIcNE40PYj01Dv7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=USlqXn+P; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="USlqXn+P"
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 9024460389;
	Sat, 23 Mar 2024 11:28:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711189687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5JGUifZvsoZmgrMhhhcMixaNoM0niDc6fgSHY4dfng=;
	b=USlqXn+PyQj0kuI7lY57WD9QomgjIsLPAhDnXD4njuTFXcWMorqIea9qZkUJI/WU1r7PdR
	ENdK0n3KlYND4VYEIXvtLCVQQvfO1GJqjDJ87S9HyGZHjqchBjLJuDVrGa4Juc7FPzo2iX
	9RYT/p/m0kA6sNVG2TfG8DUwRJFmXwQqOp5JFrO+8TjMfjhl9W5uXe1o+6F42tVfcJjltg
	X12xH8ok8aPqxn6C4d1n7FKP/XIfyjhNHU72pExbkAB6bsW06R6zuCJF6lpNtPDvGQ5iue
	KOXd8IuPVDcHowmhKi5jmCz+0z+tiIbb9Dg7+seKzByCgn2b/F1o2bSySXGqsQ==
Date: Sat, 23 Mar 2024 11:28:07 +0100
From: Max Gautier <mg@max.gautier.name>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] maintenance: update tests for systemd scheduler
Message-ID: <Zf6ut_ZTCi-csjd3@framework>
References: <20240322221327.12204-1-mg@max.gautier.name>
 <20240322221327.12204-7-mg@max.gautier.name>
 <CAPig+cT=8WkxZF1vy-2dgSspFeGOQzUFRk6w+MYVCXyRAsfR8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cT=8WkxZF1vy-2dgSspFeGOQzUFRk6w+MYVCXyRAsfR8A@mail.gmail.com>

On Fri, Mar 22, 2024 at 07:02:36PM -0400, Eric Sunshine wrote:
> On Fri, Mar 22, 2024 at 6:13 PM Max Gautier <mg@max.gautier.name> wrote:
> > The systemd units are now in the source tree, rather than produced when
> > running git maitenance start. There is no need anymore to couple
> > validating the units and testing `git maintenance start`.
> 
> s/maitenance/maintenance/
> 
Ack
> > Adjust the test to verify the new `systemctl` command used, discard
> > checks for presence/absence of unit files in $XDG_CONFIG_HOME.
> >
> > Validate the systemd units in the source tree, with one test per unit to
> > have more distinct failures.
> >
> > Signed-off-by: Max Gautier <mg@max.gautier.name>
> 
> In a patch series, in order to preserve "bisectability", we want to
> ensure that the entire test suite continues to pass after each patch
> is applied. A such, we normally update tests -- to ensure that they
> continue passing -- in each patch which changes some
> testable/observable behavior. However, this series only updates test
> in the final patch. Doesn't that break bisectability? Or am I
> misunderstanding something?

No you're right, good point. I'll split this one up and fold the parts
where the behavior was changed.
And I'll keep that in mind in the future.

-- 
Max Gautier
