Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BCB158DD9
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724685604; cv=none; b=RmtUmCS+/x9SSsRKcLQwd8fqT2rmMvbiZ6DAgAljBxOP9MummWxUM2OIzz1W3TZ94I/z+t5wWRqQEgQo8ExUXoNoxVK3r9wku6FO1r+nMnbVArbFBRk0F3DnUI8CWM/OxfXZLXgspDuV/RBgVREgMyHve5edTgxbvRAnjqA1CCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724685604; c=relaxed/simple;
	bh=j/xXNOLeYEp66f/wkg3m+30iA/EyUe4fMI0iZoy7lAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sO4UC8ntj55YDq36irQMPnHMoZLOQQTPZ8TRj+jCRcQ0PUfH/+6tI1TW2kdug/aHMvci05PvqUiW7lzi8UyGNRGFA0xa/98XJzRP7wgvpRl6M16cSuM3ObBx10L/5FTGU0LEeL8bmiW+wpL9LCuRfP94bVWBKZDz97Lsjejp4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=futrl+Km; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="futrl+Km"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1362626ECD;
	Mon, 26 Aug 2024 11:20:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=j/xXNOLeYEp66f/wkg3m+30iA/EyUe4fMI0iZo
	y7lAw=; b=futrl+Kma4fdl9z0wC+qteJBbCXPJaiVJ0CPYR0SHiauaABSThA4bR
	uqJicFQvqUmDhuaR6pQv3wIhsd+qvDWTfl40NU/1f8IuLn5Ynnbw7oaD9Pc2y/KT
	5fs0VIGH1tfvYJovFlMWL11K3aQzCZLRYmyYPbVuswsfNHYLHlZcc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A54226ECC;
	Mon, 26 Aug 2024 11:20:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 516A626EC9;
	Mon, 26 Aug 2024 11:19:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Celeste Liu <coelacanthushex@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] doc: replace 3 dash with correct 2 dash in git-config(1)
In-Reply-To: <ZswfgYsZrzY6kc1E@tanuki> (Patrick Steinhardt's message of "Mon,
	26 Aug 2024 08:24:14 +0200")
References: <20240822172042.54065-1-CoelacanthusHex@gmail.com>
	<Zsgh4LacdOt8N69o@tanuki>
	<6c9f666e-12ad-4b67-a44a-3111686454f3@gmail.com>
	<ZswfgYsZrzY6kc1E@tanuki>
Date: Mon, 26 Aug 2024 08:19:54 -0700
Message-ID: <xmqqa5gznwf9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A74BC1F6-63BE-11EF-B9B7-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> > There's one more thing I noticed: the synopsis for `git config get` says
>> > `--regrexp=<regexp>`, which is clearly wrong. As you're already at it,
>> > would you mind including a second patch that corrects this?
>> 
>> I couldn't find this typo. Did I miss something? If something missed, please 
>> tell me. I will include it in v3.
>> v2 has been sent.
>
> It's in line 13 in Documentation/git-config.txt. Seeing that your v2 is

Ahhhh.  You weren't saying "regexp is misspelt as regrexp".  You're
right.  I too missed it.

The synopsis should lose "=<regexp>" part, as the option does not
take any arguments.

Thanks.
