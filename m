Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C614EC73
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160804; cv=none; b=AUeAYpnJB4/jElWMCiCwjWcVqiCOEowJLWzE6pOkmscPGdZoZ6Iyyh5DQyTDwEIzkQ8mx5uqq7bMWiFCuyBse2i9rleN/e9buih2Q48c8+mQq1mS4dfI5Ce2fNwQUjZQXaGjj0MU57c36C9c9qtUSjHcoN+fodgTUs6E4Pl2ZAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160804; c=relaxed/simple;
	bh=TzBC1fidNI/QO7wbV+O6B1g5eWzf8q0ZWxjvjPd/Jws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ew3OhsPXpBNRylN/+Ew8K5LDcHEjcRxtPlLyvVnHcJhongYEgiUuDNUTARP0qdiqMze5Qj6dUAAb+as+nSKf5mZy/vRK20Ojdw1+bqX1d+pLUJnDzMpHpe9GC33vhfni9OZUhJcfyVkLeiVkyaQNySaJPAY3RM+OIiERboNdEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JmqoKC0b; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JmqoKC0b"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EA29B32B4B;
	Wed,  3 Apr 2024 12:13:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TzBC1fidNI/Q
	O7wbV+O6B1g5eWzf8q0ZWxjvjPd/Jws=; b=JmqoKC0bbWHdPmvl6+7axmarY5Zf
	OJ2iH9qgTSI5Nr52ePj9JmmO7ADw6xa7oTQho1GL+IVMRGvGQ8wCIaYSYdoi9hg0
	DufZ7TBdicUNVD7OaynpP5d23SpgfH60+JLUAC/URYXOxNaMYwPMRK35xFQ+XtQm
	N4r7iEWyuSoPV/4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E2E4B32B4A;
	Wed,  3 Apr 2024 12:13:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6581532B49;
	Wed,  3 Apr 2024 12:13:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Pablo CHABANNE
 <pablo.chabanne@etu.univ-lyon1.fr>,  Nathan BERBEZIER
 <nathan.berbezier@etu.univ-lyon1.fr>,  Corentin BOMPARD
 <corentin.bompard@etu.univ-lyon1.fr>,  Matthieu MOY
 <matthieu.moy@univ-lyon1.fr>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH] docs: recommend using contrib/contacts/git-contacts
In-Reply-To: <DB9P250MB0692A99BBDC70A0E65B18A1FA53D2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
	("Matthias =?utf-8?Q?A=C3=9Fhauer=22's?= message of "Wed, 3 Apr 2024
 10:42:58 +0200
	(CEST)")
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<DB9P250MB0692A99BBDC70A0E65B18A1FA53D2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Date: Wed, 03 Apr 2024 09:13:17 -0700
Message-ID: <xmqqbk6qa0gy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 15FDD280-F1D5-11EE-B088-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Matthias A=C3=9Fhauer <mha1993@live.de> writes:

> There is already a paragraph about this in
> Documentation/SubmittingPatches just a few paragraphs below.
>
>> Send your patch with "To:" set to the mailing list, with "cc:" listing
>> people who are involved in the area you are touching (the `git
>> contacts` command in `contrib/contacts/` can help to
>> identify them), to solicit comments and reviews.  Also, when you made
>> trial merges of your topic to `next` and `seen`, you may have noticed
>> work by others conflicting with your changes.  There is a good possibi=
lity
>> that these people may know the area you are touching well.
>
> Could we improve the existing paragraph instead of duplicating this
> information?

Absolutely.  I am glad that you were paying attention to the
question that triggered this patch ;-)

We may want to add to coding guidelines to try avoiding to word wrap
a line in the middle of a multi-word phrase.  If such a rule were
followed,

    $ git grep git.contacts Documentation

would easily had found the existing passage.

Thanks.
