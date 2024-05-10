Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B21171078
	for <git@vger.kernel.org>; Fri, 10 May 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355948; cv=none; b=YPi8Ub5S01QpQGrDHq+d3hndV1+UDi4TAkaxkDJb4OCe7qIPjMfXn9JfH65kruG7FQF43lOLem2rrje56SwhGxTeyY1kq20TyC5Kr6AYEHVgySTU+xAmau1ITFyP/zS4Mcxq6Wvf7S312E52A+yD4LcW++Dp7Gflru6WJs5bY3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355948; c=relaxed/simple;
	bh=YT2i9StyqyjFtaMPo+UEpSKlPE2ytOUgjo0/HskKkXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mExOhB7fr6sAlzgcgiBzL5xYVAAyOpMUjeI2Q19UexzSylmgO1gKJQc/0HxfhmTQdMGLzpUAmFVg+lyhgYGvUjFReOL8HYJTd0jrF2+ZEwR1wbQ+/AzVa6cnkY3WK52Bqaj1Ab4QA8FnU3EU6MV5/m0Gp5sKWtu6dM0Ra+8BddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=USm3VGbg; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="USm3VGbg"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C54BB19507;
	Fri, 10 May 2024 11:45:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YT2i9StyqyjF
	taMPo+UEpSKlPE2ytOUgjo0/HskKkXw=; b=USm3VGbgDKY8smMU8ZqegCahbBLE
	B739XwIqZJeGNxgSpLsphWU/YKQiQGVdGpY6q6XjFE10zc00ccRNXfug7flhoBl7
	S8u1itWci1+RtZ687f9IpsRtwlfxvsN43NYShSFVd2MigyFaM4y1FzrGjKs6uVk+
	5DWNLimgo3CF3GQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BE7C619506;
	Fri, 10 May 2024 11:45:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3008719505;
	Fri, 10 May 2024 11:45:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
Cc: Peter Krefting <peter@softwolves.pp.se>,  Helge Kreutzmann
 <debian@helgefjell.de>,  git@vger.kernel.org
Subject: Re: i18n of git man pages
In-Reply-To: <3298196.44csPzL39Z@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Fri, 10 May 2024 09:39:02 +0200")
References: <Zjuokc2H0zI1JCVH@meinfjell.helgefjelltest.de>
	<d130d861-0071-33ef-5d40-9fd703ff97f6@softwolves.pp.se>
	<xmqqr0ebuft5.fsf@gitster.g> <3298196.44csPzL39Z@cayenne>
Date: Fri, 10 May 2024 08:45:38 -0700
Message-ID: <xmqqseyp657h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5A4DC66C-0EE4-11EF-B553-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl AVILA <avila.jn@gmail.com> writes:

> Giving more visibility to the presence of translated content and to the=
=20
> project on git-scm.com or in the community of translators may have more=
 impact=20
> than on  the git mailing list.

Yeah, I agree that the set of people who read this message has only
a very small overlap with our target audience whose majority are
elsewhere.  But a small overlap is still an overlap, so...

> All this tells me that, except for the missing visibility, the current =
way of=20
> working is good, and trying to merge the doc translation of Git into th=
e main=20
> repo would make more trouble than needed.

Thanks.
