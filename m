Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D413CFAE
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353697; cv=none; b=o85YtiUXfv4tVBMh+MaPhxO9FrZRKIFmAJ6SOmm4jBQRgd4uw9VlWG8nP8JBvF0pUd43P6Uwo3QVHU6XBvDxx4+b/ZyV5aLapV9mZE6LTVAH3azzCKFQYpdqaQapK3kQbhNVW1V0ofCc09qWhQrrvz7EVQ/EFj3rQyjvSdalr/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353697; c=relaxed/simple;
	bh=+LI+8kdMhxEXNgF+/kjFApnftbpoIa8BfrGMrWUQM6s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nGNwsf4/ow2Nq0Dp9Rm6Ox0lO3aUH0wRfOPj0mUTWx5xRrS+btGK9dI8ZX8IW4xtN5/KBP+W5OAAPV5MzwbeamNY9UCTwzvMSZ0gAE5+nL/AacVwkAMSSK7HvzUclNpS1lKJoz8xoaOO7nGcyGWUk+ifTpaw+Bc/xRnueQvx0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QJ2CC+vq; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QJ2CC+vq"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713353692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0NEWWjUe+PH/UujrkzbVxHNBL+cLFZG5QUFw/ndV4w=;
	b=QJ2CC+vqdzdazApmon8fKFJv6ffy3au7j38CoCyJK7Xw2gmq1seH+xyKWumEf/VbiZyLS4
	i7PrLuEP/OUteXwVdEu0GUXULlndbfMG+UoRrUFB2U1BIT/4EzFeIO/+DeTXkJHAa45uu4
	KxzlUr9lpa/VwO6SdVcSV8ulJ2wf1nuPj2ij0/iaAf2wENt1+unHih8jWtss/9nOniIlJc
	sZTkqmF9RlUSrBnXFEZewWfiKh0YihtnTOYlKhuq1JhIHe9p3nbRPebNRBiVLvxM4zxUMl
	Shs0ruMrThnM1Gf10ZGY7jmYTs5E6WXL66vCZlVFhargiVzp1+MgFPxwVnAhNA==
Date: Wed, 17 Apr 2024 13:34:52 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>, Eric
 Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
In-Reply-To: <d60e5ddd-643d-41f2-849d-6ab660df734c@app.fastmail.com>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
 <1f31004bd8445e1e4717817638d5509a@manjaro.org>
 <d60e5ddd-643d-41f2-849d-6ab660df734c@app.fastmail.com>
Message-ID: <e3caab896300a2da9fcde2e0b2efe3d2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-17 13:31, Kristoffer Haugsbakk wrote:
> On Wed, Apr 17, 2024, at 12:52, Dragan Simic wrote:
>> On 2024-04-17 12:02, Phillip Wood wrote:
>>> On 17/04/2024 04:32, Dragan Simic wrote:
>>>> Add --resend as the new command-line option for "git format-patch"
>>>> that adds
>>>> "RESEND" as a (sub)suffix to the patch subject prefix, eventually
>>>> producing
>>>> "[PATCH RESEND]" as the default patch subject prefix.
>>>> 
>>>> "[PATCH RESEND]" is a patch subject prefix commonly used on mailing
>>>> lists
>>>> for patches resent to a mailing list after they had attracted no
>>>> attention
>>>> for some time, usually for a couple of weeks.  As such, this subject
>>>> prefix
>>>> deserves adding --resend as a new shorthand option to "git
>>>> format-patch".
>>> 
>>> Playing devil's advocate for a minute, is this really common enough 
>>> to
>>> justify a new option when the user can use "--subject-prefix='PATCH
>>> RESEND'" instead?
>> 
>> Based on my experience, "[PATCH RESEND]" is roughly as commonly
>> used as "[PATCH RFC]".  In other words, it obviously isn't used
>> as much as the good, old plain "[PATCH]", but it is used.
> 
> The format-patch generated string is `RFC PATCH`.

True.  It's just that I more often see "PATCH RFC", for some reason.
Please note that I'm also taking other mailing lists into account.

> The number of emails with `PATCH RESEND` for this list:[1]
> 
> $ git log --oneline --fixed-strings --grep='[PATCH RESEND' | wc -l
> 28
> 
> For RFC:
> 
> $ git log --oneline --fixed-strings --grep='[RFC PATCH' | wc -l
> 1181
> 
> † 1: According to http://lore.kernel.org/git/1

I wonder what does it say for "RESEND" only?
