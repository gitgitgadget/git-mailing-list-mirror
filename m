Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A95943AA4
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 03:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708399607; cv=none; b=RsCCUPgjTe20St3fdLbfb22qLttzpXQwn1s5dOC4hW4VyrjD/ROZTxygMXYZzkj3QRPpHJU3dpG07m84rYvHeayqd/fsiwGATiF763ty5XbfuDsq/GSzFhs2UtWIAbsAn2f6mHTkBcryk8YEFgoTD6GoxHwyeB5+s/mSHzr70No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708399607; c=relaxed/simple;
	bh=Zr64am/Kigi0Q39FgXkSazUBQifwT5L3WLB6lWFBfN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BKWnt4OOfXKhhaKwtdILqoWaslUaNhB1NKbzM9qbMjcCuq1KcjFnMUkmpQTZ7JYkdXaeeso3M3YaGGrkrKc/Fs7qKR0vGXpNhm04Y2F460y6ZsvnKi7tzGrFKjZaq2W8NLTR0LTn9xCdQD7UIOgEBk1KIgSv2/LJXufC7EM3s0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KFEkWbRg; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KFEkWbRg"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D81961D5459;
	Mon, 19 Feb 2024 22:26:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Zr64am/Kigi0Q39FgXkSazUBQifwT5L3WLB6lW
	FBfN8=; b=KFEkWbRgHSTPzXv6Z4JtikLBPrZjvIRmZtjqvyPg7UhLWtJwCtp8if
	nwJHdUahqoNmsZVXbqIUeZuUwG9kSiYm4LdEkL82dEGReyd1XPrpsQPnVP9XcKwM
	i7xEvscuPSUSSM3X0SA0SZI+m/2VAW8izD/m9hpWWPjCJo1j/y5RU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CF0FD1D5458;
	Mon, 19 Feb 2024 22:26:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4445E1D5456;
	Mon, 19 Feb 2024 22:26:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,  Linus Arver
 <linusa@google.com>,  Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] trailer: fix comment/cut-line regression with
 opts->no_divider
In-Reply-To: <20240220010936.GA1793660@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 19 Feb 2024 20:09:36 -0500")
References: <8b4738ad-62cd-789e-712e-bd45a151b4ac@gmail.com>
	<20240217060434.GE539459@coredump.intra.peff.net>
	<ca6a73d3-58b4-e65c-4a8f-e6ddb3e86902@gmail.com>
	<xmqqfrxo9ty2.fsf@gitster.g>
	<20240220010936.GA1793660@coredump.intra.peff.net>
Date: Mon, 19 Feb 2024 19:26:43 -0800
Message-ID: <xmqqttm3x1cc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DEFDC5DA-CF9F-11EE-B27E-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> On Mon, Feb 19, 2024 at 10:42:45AM -0800, Junio C Hamano wrote:
>
>> Thanks, both, for finding a rather unfortunate regression.  Perhaps
>> it is worth delaying 2.44 final by a week or so to include a fix (or
>> a revert if it comes to it).
>
> Hmm, I had thought this was pre-2.44, but it was actually in the 2.43.x
> maintenance series (so it is not a regression going from 2.43.2 to
> 2.44.0, but it is from 2.43.0 to 2.44.0).

I've been trying to be a bit aggressive this cycle to merge various
clean-up topics, together with real bugfixes, to 'maint'.  Those who
often skip the -rcX but diligently follow numbered releases found a
few potential regressions in 2.44-rc as a result, which I could say
is a great success ;-).  In addition, I was planning to have only
one -rc release without going -rc2 before the final, but we may need
one if only for this fix.

The fix in the patch looks quite straight-forward.  Thanks.
