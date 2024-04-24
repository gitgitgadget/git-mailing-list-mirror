Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041141598EA
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976458; cv=none; b=ZdBhCXGWoiISJYC5H+eXICNSUgNjP/nmRwhltBgQmkH/Ls/ttKqoJ0UCW48xS14GXFKCgF+jjfSdQSxXtbNEvdSBSXf6rbRevxFk5yOSImf4QaswN7ysbm7gq9aF3OplaJ5bqzYEWxrtHuJ9n+L0aUeKLuf76RR2Th8vDnpVi3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976458; c=relaxed/simple;
	bh=Y/4rvGxviBfJwCMOazcbGZu9dM2tXV+fliL6jYlQtXU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ilE6Scr2mJT5u9Wl+sfXgivpkNPFL9leuhKpuTXaoH0EZBAVwPp0j0etHXuqY3vTSrOUs1VUyfvKwFtkek+Uw8h5IjULJIESZGHYeUGEjMG9gSSqIaBGEWYuUvuL5p2sQkIKF2xSED18rMFcipFgrE2hzY11xOona5bXkb1iJMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QxuImUpP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QxuImUpP"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713976454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNulb0+43nOqJ7W3cHDDyW6HhgTsCMBZWRp+WlIc9TY=;
	b=QxuImUpP06dXtIvgCLYA36fEjSvzjnr23xXB7TLaaYbfEDmvhu69XFomQ4yY2ivN2+rLtn
	tuXzyPgoV+REQQ4FJxgUFlCcFmbuWQNePwlLp7i4SDNK9xP9ISG0oN1vPYRfsqLsbGZh03
	Bd32Eo/LmtItU7QljxSme73jay3xg0SfUqbSdNZGumOGa5vefVLyOqPJaznSUBwfjlKXsU
	jUgrYVcIciLB5lyrJAd5m8DVAXEzjOsGaeHXYieOJfpNyJfEnjO2BjJljpFKr4jNrMK8w5
	QCI9j6D8rx1eKP6Hjld/5fMupoExOENjnpEtlCGlSzeom/4BCTULh0RH3g9Xtw==
Date: Wed, 24 Apr 2024 18:34:13 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 2/2] format-patch: "--rfc=-(WIP)" appends to produce
 [PATCH (WIP)]
In-Reply-To: <xmqqplue2361.fsf@gitster.g>
References: <20240421185915.1031590-1-gitster@pobox.com>
 <20240423175234.170434-1-gitster@pobox.com>
 <20240423175234.170434-3-gitster@pobox.com>
 <aa628eba-1545-47ac-9773-8aff47ca4adf@gmail.com>
 <xmqqplue2361.fsf@gitster.g>
Message-ID: <6f379c7c2fcca2194dcb28032216b4b1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-04-24 17:25, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I'm not convinced this is a good idea as I'm not sure how adding "RFC"
>> at the end of the subject prefix makes the world better than just
>> having at the start of the prefix and I find using "-" to do that
>> quite confusing.
> 
> I am not convinced it is a good idea, either.  "PATCH (WIP)" was the
> best example I could come up with.  I am also a fan of "a list of
> space separated labels or keywords" you mentioned, but *if* a
> project convention somewhere is to have them before "PATCH", then it
> is not entirely unreasonable to wish to have a way to prepend these
> labels.
> 
> But I am fine to drop it for the sake of simplicity.  It would help
> discourage users from trying to be "original" in a way that does not
> make a material difference.  If a project comes with a concrete need
> to prepend, the patch is always resurrectable from the list archive.

Yes, it would help with discouraging the users from becoming
"inventive", but would also promote the rot of English grammar,
as I already tried to explain. [1][2]

I'm always for simplicity, unless it actually results in some
possibly negative effects.

[1] 
https://lore.kernel.org/git/f9aae9692493e4b722ce9f38de73c810@manjaro.org/
[2] 
https://lore.kernel.org/git/115acd1529d9529ef5bb095c074ad83d@manjaro.org/

> As to the syntax, I think "-" is a fairly good way to indicate
> whether it goes to the front or back.  When told to "Combine '-RFC'
> and 'PATCH'", I expect that most people would give 'PATCH-RFC' and
> not '-RFC PATCH'.

I find the syntax just fine.
