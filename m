Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97633207A16
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354219; cv=none; b=PvXUCQ40o+enMg71IZyQ3nYsgZpwxo3kv9Jx0sNG1b3uWjVY2GuZwdgf09ZZ5tKgcW4OxzKZNi8Vfj2sLLGx15pfdCmhcbbmmHNgpPPY4h0wU35EKFrswAINhfzwP/c+1ZYdlXzrTHfiWmur/ScbJ1YBDvecJSH67h24GUrdKVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354219; c=relaxed/simple;
	bh=r0lvXKSVzca4U02rREeyvOV6XkPUvBzKTx03wogaiJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVeD0+JLPonImU39V2URaOu6ajcNlSuRaQHoBqIo5DTP/KkVfA6Z6S9fJE3OhXIv+rK6kMilQkeI8qQw3s2r1g0sqkzscGlGmz8458tQB7ynH+FcTxHGxrFtKam7TbXt//luRSQkoDikux+HvMVzT52LAP2FlEoglE3fTsMPPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qPQpbCTn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tTLdlm8s; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qPQpbCTn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tTLdlm8s"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C7B81380983;
	Wed, 12 Feb 2025 04:56:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 12 Feb 2025 04:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739354216; x=1739440616; bh=cRDxnNvR5p
	F0GYYOf54qln2nHRJlqPY5L+UN+N/5UOw=; b=qPQpbCTn8nVXz0aO1o0qN9bL+H
	atTH9gm+HGlZu/ehNBLrWR9Ie6Vh+7rykMsxlFOYxcKpmvKurZxCb4ZXb+e0RzzZ
	7uCqDb6gsE5OlGbizUp1t8rtE3+KdCXvH+xK1r9y/puVxGWoHhVQD7G9aPAnfAr2
	LtgmiqLkwdFPfhGgXcWmsEYMM1B9gx7xjEHlECgr8Tf1iI7/HYMNxT5aMFmxDkri
	q2yYA/6OOeeOO+oFP4nr0O/PWRsnABcJTqcuA43StaJsjeeWbfRVLEmCuJ/oFA5u
	juBL8otPMTNpsqn0pkNEgnx/DTDxBik0yI0eajnbkvF97Xe7ug7PWF8kPdow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739354216; x=1739440616; bh=cRDxnNvR5pF0GYYOf54qln2nHRJlqPY5L+U
	N+N/5UOw=; b=tTLdlm8s5MTNUZGxmxYqoIxNzA26IMIjhH2SohxJQ0VeAbDrxBI
	79wfddSOTbYRHI2hahuqebzN5Hh1f71CLI9xbfdXsFWGgOvIDI4pt4SSLRI3O9MV
	kt3agSLTSH2KgmtnvYZyE2oxCpVleaBedKU4ybaEQCsYOziACsg7laWcc/9I/U3Z
	fhzRVBSnVkFvAN3fT8COezMDVyJAodo5kW4xP6tyhBiNqwTrH5cPKqKrwi3reZly
	Gjl889xfvQticSslNxJaGY/QxsF03uTFcGnLhNacMmh0hOjVNtI2b6PjyF7fjyQs
	t1ZNy2TviGjbLf6uZZNCUJM1Ps0UjQqtgFw==
X-ME-Sender: <xms:aHCsZ1dTwfxb05JFGh00RaJnKS7Cdh-Gqn-_EgU9qD0AHtu7kPG5wQ>
    <xme:aHCsZzPCWt1VC0j01AfWh0ykrLdOf_1vLTs4it7rztZiWe6VSJ10muxmKdkU_tean
    UqrYBOdSkqOIaagwQ>
X-ME-Received: <xmr:aHCsZ-jZggJRcdJ_xp4X2-uBXcKHTHlZ6F3ZHiEF_UA7v7rMS-vOopCtailnexQSXoGBdQeb7ydUV-pBlGJYynJNGSZk-IX3RnHt2gAb5VzcVyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdrvgguuh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirg
    hluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:aHCsZ--jQPi1Qp8MY_xbvV_8GZTCtRcCdbds-i9L7CZfOJdb6XMrfg>
    <xmx:aHCsZxtLZmVHc--JakMPxGwC7a1iLP9wPEIZo9goyxeO77mDrykxGw>
    <xmx:aHCsZ9HY0jvs2Vt0f95gLKuiXASqhtFl8IktpId9I3VOWnPKIYs99g>
    <xmx:aHCsZ4Oo23jZVO33wpw071_BPNZt-HQpfOX5kqG3gADE_zwvU7TShw>
    <xmx:aHCsZ_UBcSeMMO0T6YklxqUf8WUIyNTT3--lkme5g2RSCuEqvTzh8d_c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 04:56:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9ebfaa69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 09:56:54 +0000 (UTC)
Date: Wed, 12 Feb 2025 10:56:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 8/8] builtin/fsck: add `git refs verify` child process
Message-ID: <Z6xwZaYLfmWUVNNR@pks.im>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
 <Z6RP50d7eRsKRCG6@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6RP50d7eRsKRCG6@ArchLinux>

On Thu, Feb 06, 2025 at 02:00:07PM +0800, shejialuo wrote:
> diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
> index 5b82e4605c..9bd433028f 100644
> --- a/Documentation/git-fsck.txt
> +++ b/Documentation/git-fsck.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
>  	 [--[no-]full] [--strict] [--verbose] [--lost-found]
>  	 [--[no-]dangling] [--[no-]progress] [--connectivity-only]
> -	 [--[no-]name-objects] [<object>...]
> +	 [--[no-]name-objects] [--[no-]references] [<object>...]
>  
>  DESCRIPTION
>  -----------
> @@ -104,6 +104,10 @@ care about this output and want to speed it up further.
>  	progress status even if the standard error stream is not
>  	directed to a terminal.
>  
> +--[no-]references::
> +	Control whether to check the references database consistency
> +	via 'git refs verify'. See linkgit:git-refs[1] for details.

I think we should note the default, which is to check them.

It would also be nice to have a couple of tests to verify that the flag
does what it is intended to do.

Patrick
