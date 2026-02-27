Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508DF3EFD3C
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772196088; cv=none; b=IKI+6s0GDw1tsopvWq5otNHpYsKuFlVp3ZNG6Xu07ej+xTB9tUCidEElPIry1zoF3gK9+RtRKx40FgPT9YgJ4hGvw//W221gfTTTWtWNTMXoFShdF12FM+Sr8/uDL+lsEseFStlOPCDa1U2dHqjqmdvYGmXwAgzeIiFOmlMijAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772196088; c=relaxed/simple;
	bh=X2ehvGN15WVFYBCdXAvO8C8dTGt1T8tNVbDD2E3NRhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJhwqIG5nDXPS/UBMgOXOX19GxCK3YlrngfF08mHKGghi/eoCnpoydWDjg/aj2tfvhFZ/i0bvNG3lpyXxtze5JNfCVTpxNa+L+87JI38IrNUQVpHbQeD7Bv0kK3r60YA8yTpD+4Jk9SG8CaCqF0fXZ6VXBG+v36OVffTbfDISGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Hu808+Gu; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Hu808+Gu"
Date: Fri, 27 Feb 2026 13:41:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772196084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4qfLdDmj18+yNS1zOJHJ+fwVsfWHgMjTpG8zuzrRD0=;
	b=Hu808+GufDN4ZSjojZZxOaU25qNUdtI/dq4z7eQJeErU+bZV92BfwK0l+ynyDQPOTQzaFK
	Czt++XOdWfD+Nwd5vXkXSwQNJ2VrzfWdj8G9OGEvjAreYK+X28ABIBI04YJc4VCCYvq+ZU
	nb6uVLmBzGPhWEdsh+ojzl+aBxdc+9FiCT2uGEjbooNwqosAK0jtOeeWA7KqNNCupAmA1K
	AOcPUfU9ep3V+0H3W3Z/fOMKyQDIIKBcQt7OWGZKb9r2mq5kXc8p15nVf8eFdvU9ziZiyp
	5JQHseTD7I1ad8ZR51WoEY/YeLhI/mbljzMyDrXzIjsuMaUjrHJ3Kb5ggERwVg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v3 3/4] format-patch: add ability to use alt cover format
Message-ID: <aaGQoLt_HlfZf5Zr@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=376; i=mroik@delayed.space;
 h=from:subject:message-id; bh=X2ehvGN15WVFYBCdXAvO8C8dTGt1T8tNVbDD2E3NRhg=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpoZDii1y+a6pY0Om5Y+jEqCbj/w/NzTPcz2Hml
 pQiB6EbQ1OJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaaGQ4gAKCRBIeX6hnBm+
 0Wa9D/wMsjgagOig26P4Xe4K71wn/ETabW/tJxE4WMw+sKn1D8aoVFs9AbAp1DzwjGUmXTsnZqZ
 fhXDG6/Z0Pr6AushAW/Oag3LIk6hALu/s+ehTKsZD9IE7L5G84oKXHTP9w2v24Wa1jPXlt8yopT
 +yYWNWcFtjbTC72z3FKjzKA7icSsqUH2ODCjZ0I3Cu/Hnf8hy8jLNokn4Z0Ykb70K5vyiUSEt3W
 qCs+YvVZ/d5kbWPwty3mOHnNYY+3mN/xWXOHQ0fqM/ZKF3rgrKaMPy9edPwaQIquSEx0v+7LUcc
 yAOcou41NhYcqy7OPEDRKLGAMW2hhbFfqroTR/pKf28l5lKvu9SYTFp8yjh11dMME9veC8JvQJJ
 glXt1Nr8/UIfXy+59PjbenkKyhQhR8iBfOhVxeGUYsGD7zS+NWvS1OxzCtTfGcAKZGReSpdxPHs
 rC+9SZYeGQyIz66d2ySZhzUuMlRpurES/rYgKzb7ge3gIZfjZOpVwsLY7LX8iSD1P8CGBjdR2Vt
 x6+HH6M8S7Z2tdxj5WVaQe6eE7eBxfb9dv58eoQLpxuc7qoCGV1RdrLgbVTTLfMmJozXxtPROl5
 xYPrAGqobQz1Ab6mTH3RkFplsVKlAnFkbuN92Eq1xhmCwGrNhyV8WIavXGKFyRML3Di7Z3KN5M7
 GSS5jRwYd1YuhYA==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <cover.1771925291.git.mroik@delayed.space>
 <cover.1772156996.git.mroik@delayed.space>
 <190817fe6ac5199c6df95558a7dee4be3d2fffdd.1772156996.git.mroik@delayed.space>
 <xmqq1pi6vmpo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pi6vmpo.fsf@gitster.g>
X-Spamd-Bar: --

On Thu, Feb 26, 2026 at 08:23:31PM -0800, Junio C Hamano wrote:
> Don't you need to update this example?  I personally find the
> %(count)/%(total) thing a bit overengineered, but now we have it,
> you'd need to write it in your forrmat string if you want to get the
> [N/M] prefix, right?

Right, forgot to change this commit message. I will send the updated
series.
