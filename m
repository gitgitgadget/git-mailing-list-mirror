Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1B01DA24
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712481230; cv=none; b=ZrC8ylQgx0fy4e0S483OMWrfqJzXhfaXYY9SkxBHr3oQgclpaJbBwhWHkRB2wvdWrgMQ4tQ3ZMV3t6rtvwdtwX9CzCXPeJAtnUFGiLxB1UXMFjRvaMsoaoOFvwY+KDTRjXCD2kv6NF1ieoY3AmyPWr4SHscnReIEofHh+thSSnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712481230; c=relaxed/simple;
	bh=WwHDr4rfp6BNLclLLJLFiiv4P5lNND42zJQi1mv4V9Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TZGdGmLBcbStfUMCLPY0w7eZdLIV8/O/YvFNoLhBky/hW0LhRKw0/QQyPAHNQhLuQEuhqHcgdt1eUjVrtKjFvl/c2Mbjsrz73JEDQmeyH2eyTuSgvj1x65Nqw2b5APh42K5TWvjC+eEUpBcfMPJ9LNj4LjLwRXvNyM2v/RPR06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=eRfsxcTu; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="eRfsxcTu"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712481225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJw5Y0niO0CGF9vC3Ps5zGAn62lDRZGMp+PUefmjeDs=;
	b=eRfsxcTuvAYer1aw68b9WuJ2A7bfey5pT7DXKvrVybVvoqzM/DuLvXo++/8UgLmT7bll15
	2++Oi2wdcvEUcTA3Kl0HGyJ8lvzY5rLW12oLf5jZtS77ZyJW08kT67KCR2rMgjupT41Rgj
	np2riSapsh+bNx5370DetMpVQPuxijZwquV9XpJFwnZPOOigwdqHruAUzlYevu8xohqpqF
	Ky2VdZTaS6j0/05nozLxbBuOafVd4xiX5O5XciDQOxjg7tf/Vc5JbDLQ+/Wb3YaQViGO26
	K4FaH7cJylsvvPRHbkCUnxOEL3fATpirWoBsfMEFJzOBHlf0w2XMY8h8W7FX4g==
Date: Sun, 07 Apr 2024 11:13:45 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Quang_L=C3=AA_Duy?= <leduyquang753@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Add lines to `git log --graph` to separate
 connected regions
In-Reply-To: <CACXAH52+ZZGW7xwutZ8Chrap3e07Xm-5zwDg=L2PBV2nVEvOXQ@mail.gmail.com>
References: <20240407051031.6018-1-leduyquang753@gmail.com>
 <CAPig+cQVQrrXrDqys-TyCqFynR6=pmbxs-NK-ca-s0K8mjADaA@mail.gmail.com>
 <xmqq4jcdivgw.fsf@gitster.g>
 <CACXAH50KHrnmc1At_DHX5O=BGuGT_pe9n5nGLSJYt7fXTbe_Yg@mail.gmail.com>
 <1e5dfc946c38809f159776f41e23c7c6@manjaro.org>
 <CACXAH52+ZZGW7xwutZ8Chrap3e07Xm-5zwDg=L2PBV2nVEvOXQ@mail.gmail.com>
Message-ID: <e4919f6afe9db5fa62769bb52c6f1e00@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-07 10:46, Quang Lê Duy wrote:
> On Sun, Apr 7, 2024 at 3:34 PM Dragan Simic <dsimic@manjaro.org> wrote:
>> These days, very few computer screens aren't in widescreen format,
>> so there's inevitably less vertical screen space available than the
>> horizontal space.
> 
> The ability to scroll makes all the diffence though, there is quite a 
> chance any
> non-trivial commit log is going to span more than one screen height 
> already
> anyway. There's no risk in sprinkling a few more lines into it; 
> meanwhile if the
> number of columns actually gets too many, in many cases you will not 
> have a
> horizontal scrollbar to play with.
> 
> But it depends on how this idea will be expanded, as it has been only 
> an initial
> hint from the original reply.

Please note that less(1), which is commonly used as the pager, also
supports horizontal scrolling.  Perhaps that isn't a very well known
feature of less(1), but it is supported.
