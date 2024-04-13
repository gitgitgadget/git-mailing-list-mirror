Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C584A31
	for <git@vger.kernel.org>; Sat, 13 Apr 2024 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712971628; cv=none; b=qokVpxO6g1SpdvnVrShI0uj89ITeOFuZJeTjGrZPB7AVLLGYiQKu2oRw8fvBqUTl6zSmLFZqq1jvKwDvPWPix7xtRvzkRtLWJ1O4C0kv8U4+o+eIQ30bl6Ez1m8yf9rVmJ0RoHXZGb/m/cMB2vm+Km8YXkBVnVRbFinz0jxQRD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712971628; c=relaxed/simple;
	bh=4yXBotGw/TUzU0B8Nc/sALska4xe1q64VpKkZsCEg14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j0cTR5BL2gHhgduRt4DFGwnwxtFnsj4dS89U0vlPtkJmS+now9JOHB6aV5jfzWV3PwfdW+37xV9cMLFmND7eoHFMFQrNtcaln09R5t9hELkhE5T/SzLJpZpWPtdkCLdrh+R5WdoYzNaCUiOA/4prqfBXOWFOHE0w2YFo+GP1NIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CYnbo/5D; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CYnbo/5D"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B054E336C4;
	Fri, 12 Apr 2024 21:27:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4yXBotGw/TUzU0B8Nc/sALska4xe1q64VpKkZs
	CEg14=; b=CYnbo/5D9YT69DfiCCE8IyBf9Q9WreoOOKbHpzXisJh7IhKjbihwo6
	RnRpj4DqJUNXd5hllnbJtd7pXzSwS6OXw3Tbsnt4lHXsOK9FvK+fMsa1FniKjx5/
	t4tbAAWQWbFQDRDpDI8oaE5jNFeGbZNyPTsdnZ8iUAl28av0c25Bs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A7204336C3;
	Fri, 12 Apr 2024 21:27:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E55F6336BB;
	Fri, 12 Apr 2024 21:27:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,  Matthieu Moy
 <git@matthieu-moy.fr>,  Kipras Melnikovas <kipras@kipras.org>,  Linus
 Arver <linusa@google.com>
Subject: Re: [PATCH v4 2/8] SubmittingPatches: clarify 'git-contacts' location
In-Reply-To: <CAPig+cT4Jc-wvpZxoe_ZLBZ01-C7LTnbe968_33hwaEGeN+vtQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 12 Apr 2024 14:45:48 -0400")
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
	<c43de19d867cb5e63fe6689b2b7d645dc4741950.1712878339.git.gitgitgadget@gmail.com>
	<xmqqsezqmrtd.fsf@gitster.g>
	<CAPig+cT4Jc-wvpZxoe_ZLBZ01-C7LTnbe968_33hwaEGeN+vtQ@mail.gmail.com>
Date: Fri, 12 Apr 2024 18:26:59 -0700
Message-ID: <xmqqle5ihx24.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ED47B754-F934-11EE-B848-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> An alternative would be to deprecate and/or remove `git-contacts` from
> "contrib" and instead point people at Felipe's `git-related`[1], which
> is the direct parent[2] of `git-contacts`, as well as a more
> functional drop-in replacement for `git-contacts`.

I am not sure it is wise to add an external dependency on a tool
that is not very well known ([1] has only 68 stars), not packaged
for distros [*] and is more or less dormant (the last update was
April last year).

Unless the one we locally carry is vastly inadequate in comparison,
I somehow doubt that it is a better alternative to ask our target
audience to use it, than letting them use git-contacts from in-tree.


[Footnote]

 * "git imerge" and "tig" are what I compare with to use as a
   yardstick, when trying to judge how well-known and easily
   obtainable a package related to us is.
