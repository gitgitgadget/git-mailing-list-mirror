Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F67376
	for <git@vger.kernel.org>; Fri, 10 May 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345033; cv=none; b=H2FPwN3lv0AC4cQkGqIZmAxxC4J3vWweKEI/SqFTzviSkWbu6lVK+bxdGdTHYC5VqAcswO/gmjFjI4i3TbYbc6HJEE2L8gYBpyIjUiUdMBQBFFrhXBIgP0Tf2uCw0iaPpDPjhpVqns2cXkOEcTMLRiG2T7ldEEwa6K0Q273CMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345033; c=relaxed/simple;
	bh=08l9rmOIRpM0VeEcZreWBXx3MHS3I/c7lW9Q8ar2A3s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=e7v3W0wFDRAZn9Jm5IXipkIeK3BfnargNwDt87N1+Zo2z1BR91IQAK8a2eafoPwADJhEOEnX5mMX+ci423Lbnk5SK1txLdqydr9+Ry7rq9qrFR6k3rAGtc6A30b3vWq95GWp6dHW2gtQsAOPZVJn3h0BCZo4um6KSoMeV26oq2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=h/00CIwx; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="h/00CIwx"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1715345022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNbrG9cDlmMaU/xmHw6zfKMv3Ix+SiCGs2Bk4KByBJM=;
	b=h/00CIwxeqDgjECyTFm8h2J4Q9KHRHmp7157sAsVD6Zxjs3gNPKkFPRPhJwC12R7OY+u6G
	PF2QFbqofzRBnF1eZ596zUYLbJsCDmTF7qnSBIJW6Kwgs/J2+ldu7Am/pbJiKixy7fJbVB
	L2sTGBpljKy5DJr9dCnfG27UidiCCM/y0IXIMFaV8bMqhjbsVz+oIr9h7HwkWFBQVFLW2I
	qgKWrmhMsb+MYIO4BCrH48X64Dx1XkK9QCF3iKOf1FZWJpfnzRhYm/N/ykET+6RZ38oB8t
	FNPyvG5e9lzF866QaZ8b0tc+0yNRwE0mdJ6z1kViFRTedF9SJ+K4ujvYPogvtA==
Date: Fri, 10 May 2024 14:43:42 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] docs: document upcoming breaking changes
In-Reply-To: <Zj4Gx6LGSoTGc3eW@tanuki>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <xmqqle4lnuvy.fsf@gitster.g> <ZjuEMNsw-KARJjwx@tanuki>
 <112b6568912a6de6672bf5592c3a718e@manjaro.org> <Zj4Gx6LGSoTGc3eW@tanuki>
Message-ID: <bcaa054e4081a43bef349a1079895374@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Patrick,

On 2024-05-10 13:36, Patrick Steinhardt wrote:
> On Wed, May 08, 2024 at 05:59:01PM +0200, Dragan Simic wrote:
>> On 2024-05-08 15:54, Patrick Steinhardt wrote:
>> > Okay, I see how that may make sense for some parts. I guess one of the
>> > motivations here is things like git-checkout(1) and git-switch(1) /
>> > git-restore(1)?
>> 
>> As I wrote already, [1] I really see no reasons why git-switch(1) or
>> git-restore(1) should be deprecated.  That would make zero sense to 
>> me.
>> 
>> [1] 
>> https://lore.kernel.org/git/3d84f2eac9b03eda814332d73b5d5ba6@manjaro.org/
> 
> Note that the discussion here is the other way round: whether we want 
> to
> eventually deprecate tools like git-checkout(1) that have newer
> replacements. Junio argues that there being a replacement is not by
> itself a good enough reason to eventually remove the old one, which I'm
> fine with.

I agree that not deprecating git-checkout(1) and similar utilities is
the way to go.  It's rather safe to assume that many users still use
them, despite the existence of the newer replacements.  Also, not just
users, but various scripts.

