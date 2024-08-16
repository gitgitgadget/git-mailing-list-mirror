Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F41B1BE238
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826550; cv=none; b=qdpG6DtXemVUXGTqjP2QNEFJje8JRbaRdw/GTY7r4Bqq7SFXws08NkwOkfiYUyo3751zV/e7o8x2dYcYMmNSWgUQ2dK77uUzJuJdUNjTPO53xkp22HwYuHv1ppFbQL3zlTNrgAHmHXNrenTNPwPuNaRXpxDj6JchJp/SZAHfDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826550; c=relaxed/simple;
	bh=fIAg+ML/HJe5yZ+QLtqNe7HcaqZanRSp+GmpOs8nMk8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q0ALwRX/i0Sccp7WvVqrBkaXkM7LBhjFzSBmD79ocw7cEprawl5dpWpvfWR3jVALz71Uw14RIwk2f7+7zh4I630JPdP1BIWwg002HN9n+0o9WZ0Ep8WcpZ1wudy8I7kaGudpe3F/DWF3IKLKVs2E9Ne+eXIKZjzG8p7JRsKmaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xtQz75Ow; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xtQz75Ow"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EEFC62DFB4;
	Fri, 16 Aug 2024 12:42:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fIAg+ML/HJe5yZ+QLtqNe7HcaqZanRSp+GmpOs
	8nMk8=; b=xtQz75Ow5qXNDOSoEO2Klry5cb6hRfx/nesqOBoqWQBSjB3gml+6A9
	wLqmPFm5rlh8JGRys+DKuJ/pTB3QeJjp708gaDsl0W5YVO2i5qqyt+ak9YbUfUu/
	NkvZLOmHN7owRQV7E+KV69+iCoH36PKbjJBG6I6U/f1B0fQFpip08=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E699C2DFB3;
	Fri, 16 Aug 2024 12:42:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5BBEE2DFB2;
	Fri, 16 Aug 2024 12:42:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: avih <avihpit@yahoo.com>
Cc: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 4/8] git-prompt: replace [[...]] with standard code
In-Reply-To: <1371885213.4494853.1723804592269@mail.yahoo.com> (avih's message
	of "Fri, 16 Aug 2024 10:36:32 +0000 (UTC)")
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
	<232340902a1feeafe526528eb88b8d0814d11545.1723727653.git.gitgitgadget@gmail.com>
	<xmqqsev5u4yr.fsf@gitster.g>
	<1371885213.4494853.1723804592269@mail.yahoo.com>
Date: Fri, 16 Aug 2024 09:42:26 -0700
Message-ID: <xmqqttfkl8r1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 859F2E80-5BEE-11EF-9597-9B0F950A682E-77302942!pb-smtp2.pobox.com

avih <avihpit@yahoo.com> writes:

> FWIW, the common form in this file was "[" (46 instances),
> then "[[" (13 instances), and finally "test" (3 instances).

Yes, that came from the fact that this file has historically been
considered bash-only and our Bourne shell coding guidelines do not
apply.  

> So I'd still think changing "[[" forms into "[" is the better choice
> for this file in a compatibility-focused change, as it leaves the
> file in a mostly consistent usage of "[" throughout.

Absolutely.  We are in agreement (I said this is a good first step).
I do think making it more consistent after the dust settles (read:
not before the series graduates to 'master') would be a good idea,
though.
