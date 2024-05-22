Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C6841A80
	for <git@vger.kernel.org>; Wed, 22 May 2024 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716410497; cv=none; b=loc7qFpUdOxarrrK65EOx7nDXYGXTRrCsFyne9A1DnP4BF8SkQZy3coBs2erl0iU1mHOtqAbtdG/M9JgvYONmtD0VBiAdj8NMiwJHl0ZB6R2tt9m+Ef80ilQx1TFyls/vWJ8t2/9ccTzQJLR5XTPmbxbRDgNXXkCGNPEdZy4rbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716410497; c=relaxed/simple;
	bh=5efewYuOTuI3ExLEOtNEmJPs0ksnylcIbQ4aOe4x86w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OcBLU+4WZHDwjGlKuF2TC1O5K5murc+vojdZHX0IKSZZXbL5IxAa10Ae2WZs4MJGoN6B2OdX/sSkfdK/PvXH/NW7Cl1s/7AsJ7O/SMcsvD+sAuNd7Vfx6JUTQ72wyJu+TGTYGp85NikIfi/S9hIEL6qS8ZF5+HsGyjs4uIJHX0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=o5h9URcj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o5h9URcj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E9F062AF4F;
	Wed, 22 May 2024 16:41:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5efewYuOTuI3ExLEOtNEmJPs0ksnylcIbQ4aOe
	4x86w=; b=o5h9URcjPVtosFeqXEW7DuFWZ6qe3w0vKxTd4H6lfJUaQWvxsP4TkB
	m+5E/M/BBu3R/x9tiJCVtJ6FCI4brn+FHVsfZWr6N8UZHhGe0tOGawBoUH7IKL/k
	Wv8BO/k+ruPzm1Eoc3dVwZrluGGjzynMV7QDttcAZptIYXwFMbtKY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D2FC62AF4E;
	Wed, 22 May 2024 16:41:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3955B2AF4B;
	Wed, 22 May 2024 16:41:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2] add-patch: enforce only one-letter response to prompts
In-Reply-To: <11abab810253d654119fab69adf44fab@manjaro.org> (Dragan Simic's
	message of "Wed, 22 May 2024 21:03:20 +0200")
References: <xmqqr0dvb1sh.fsf_-_@gitster.g> <xmqqh6eqiwgf.fsf@gitster.g>
	<fbb9c7d3e7c2129bc1526dfa5a8eca0c@manjaro.org>
	<xmqqzfsh6cjf.fsf@gitster.g>
	<11abab810253d654119fab69adf44fab@manjaro.org>
Date: Wed, 22 May 2024 13:41:26 -0700
Message-ID: <xmqqzfsh37gp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A9EA0302-187B-11EF-B82A-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>> For more backstory,
>>     https://lore.kernel.org/git/?q=%22textual+order%22+%22actual+order%22
>
> That's exactly what I assumed, but frankly, in this particular case
> I really can't force myself, despite trying quite hard, into liking
> it.  It's simply strange to me.

You asked me why, and the reason was given to you.  End of story.

I never asked you to like it and you do not have to like it ;-).
