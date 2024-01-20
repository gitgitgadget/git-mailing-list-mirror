Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641EC2101
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705782289; cv=none; b=TLglA7ksuFjEYbm7Gz7D1XA6aqtVqFLAw8kIUouonShzj65yOTCO3KXa/FSngHbkHENsBuliebZ15ieG8/HH1ChTmKoA5QJy1KG5P2zurKTGqnnB3b5674jZ7pw3wfNS5Vaml0Bz4IVUNGRbbjYh2R1E/x7GUAN46+iGvi8BnP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705782289; c=relaxed/simple;
	bh=MUzdFONYilqu2pCnL+xQSZFDUZPnrZfI12QnynYOnUM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=aG9ycqAIvkeJ4E6wVSvn5nzDKFjmTRWQGdPQytEacZKfCK4XfjH1j1Owge8wrbax0o2KVNT8uruXPrLmsac9OKO29zyH2k90NJvMUToQ60NhO4Ekbqe4q8l5A1qDs4KMVH+8sK3FddPi0JtVxtHIIaKwfCii5WusMh/peil2qFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=kx7vjC7e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PKanDWm0; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="kx7vjC7e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PKanDWm0"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 3C66F3200A0F;
	Sat, 20 Jan 2024 15:24:46 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sat, 20 Jan 2024 15:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1705782285; x=
	1705868685; bh=svp9Vfq02MsZFCtfGRGzWhFaasGAGAxbbkhZOkOGQyM=; b=k
	x7vjC7e6+X+1Ib+c0ick8TvUSdJO1wRZrnM1CbqcFLAnrwZAbfg9HyMwatL7lr/R
	+7jSGnxdUqFyHXMM8Fn5Sn93VK26rAdQ+ISBVIN3dEHqJiJufK12hM4Mhq404+Vq
	9Bno1fNN9kDdMcZSmyEoiw65Yd2i98jFizPvzC7btQE0PoCefBSmtYJQEBij27bl
	B7eAi/kMdI7vWUS2d+KQ9uzLcyURMk1OzNyHwyOhy1jXAcZyWhPf4vl5TON4eMx4
	tqVak2295yHP0wPEWtNvJUyFvRyTUTFthiDbO7K/excH/xDHikgnTtMsEPQsS00M
	ePX4b3zETw+7iUzNkBo6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705782285; x=1705868685; bh=svp9Vfq02MsZFCtfGRGzWhFaasGA
	GAxbbkhZOkOGQyM=; b=PKanDWm0JMKgMKrZsLJHUIJcOOoy3HFUnuKDWNGrND6b
	z0V76HfqKSy+kP7qA1XNNDED3PVdpFtEcn7SCbwFIlT3DLQ+uBnIfW9Or/Wwoeec
	Wn8u6+pFGkqNcrO0NlApnC1L+re7QOSW/k3ZgVz2cRwS8Lb3Mi6acjAPlyTvukp6
	tWF6IZyzpyNABR2LgarC5JVEOkU+DN8VOtW73WqmZ8ERpUe/QM8UdcQ1NHMKEdBm
	Pz1f2S+jKUILJ6iRHzpqSRYE4HvYN8YN1MBhPHG2SifrDmoW146X66alqAU/JBU+
	uw2VSUWTDaAehYVL2LXhjIo6dG4G+UoFoStTFr2m/g==
X-ME-Sender: <xms:DSysZe6RnKxr5O53Nl9R-GJID9-4kSL2Xlenm0UmpqR3a9x3GCppPfo>
    <xme:DSysZX4SJF1c9xfv99xJWwRLRDqOpFRj3CeL6UmM53VE8kaEdtk9rr4NeKWNecD_8
    H6vP8XTGB8w2Q_F5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekvddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffg
    heelueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:DSysZddrgViGbOSRxzP1seH8ne0J5_2lt3vIwsYcdGBB7qlPPoBOpQ>
    <xmx:DSysZbKAFRdAWDD8c-IzYEEP0u6qHqcaLarobzpF0F0lpnHzlQx6fw>
    <xmx:DSysZSJ8I2Io4J0xHSmeT0IBBLsZCg7qXXwO7j0pBJmU_wQwa18rDQ>
    <xmx:DSysZUgwxZez94XpMD76uAdGVlRQgKoOb8V2MABUjMjQtVhbap4_2g>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6742E15A0092; Sat, 20 Jan 2024 15:24:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <06eb93d7-7113-4583-9860-28a6a6d528a2@app.fastmail.com>
In-Reply-To: <20240119060721.3734775-5-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-5-brianmlyles@gmail.com>
Date: Sat, 20 Jan 2024 21:24:02 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: brianmlyles@gmail.com
Cc: "Taylor Blau" <me@ttaylorr.com>, "Elijah Newren" <newren@gmail.com>,
 git@vger.kernel.org
Subject: Re: [PATCH 4/4] cherry-pick: Add `--empty` for more robust redundant commit
 handling
Content-Type: text/plain

Hi

On Fri, Jan 19, 2024, at 06:59, brianmlyles@gmail.com wrote:
> From: Brian Lyles <brianmlyles@gmail.com>
> ---keep-redundant-commits::
> -	If a commit being cherry picked duplicates a commit already in the
> -	current history, it will become empty.  By default these
> -	redundant commits cause `cherry-pick` to stop so the user can
> -	examine the commit. This option overrides that behavior and
> -	creates an empty commit object. Note that use of this option only
> +--empty=(stop|drop|keep)::
> +	How to handle commits being cherry-picked that are redundant with
> +	changes already in the current history.
> ++
> +-- 

Trailing whitespace on this line.

-- 
Kristoffer Haugsbakk
