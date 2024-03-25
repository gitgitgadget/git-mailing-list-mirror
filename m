Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701AF1849
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393020; cv=none; b=mjRtBDSCT0SDugfUzNGNAgeRYSxqLHwbYhFQ+WkWR2QgOeJ/KUqJNMMy3PsQR+6oGwZdvh7hvW738sORF+BfaB9n8s0HN2sjgZXpKuCjC6TkRdBm16ItCysTNlPX0rQSFYe1NbmFrb58/oW5zDvGM6F0CslUgMrO6vIYqlJp7bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393020; c=relaxed/simple;
	bh=ELNNNLkz4AFLGsspzX++kuEinF4p5+U5Nf9zVUrmmf4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K/JizOqzDybM38lZ9PVDRZzEISJw3w4xYFMVDs9GrCfSMPnvbR/zrAHDRyrpUr3+xZbnVJgKYT97KM2LckO2CVZnLyfOT3+ZSUXUJN8gJSkoBAKu57iizg4PlktP21OUTA24ir1RNbf4PLlu2YECapwj2JSD6N110BbCsP0p1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rTczFW9E; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rTczFW9E"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DEE51E8159;
	Mon, 25 Mar 2024 14:56:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ELNNNLkz4AFLGsspzX++kuEinF4p5+U5Nf9zVU
	rmmf4=; b=rTczFW9EdhsrXwTYkIWKm6XUTRCoxJ4DB7AK2daEyNZ39RseGOP1Yn
	CkvAMPs0YTAZTMxGK0fkIsIsODwOinElSZIbINNZ09g8NEWXWZE1ZhVokuXndwCv
	g9pRLgloH9fyn4Pjp9i97keY+BJkIo9wGSVii0FhLHyvLD5FzRIlM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 670421E8158;
	Mon, 25 Mar 2024 14:56:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CABD41E8157;
	Mon, 25 Mar 2024 14:56:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tim Landscheidt <tim@tim-landscheidt.de>,  git@vger.kernel.org
Subject: Re: Inconsistent/buggy behaviour of "git config --add"
In-Reply-To: <ZgEnqE23PYVCNeKc@tanuki> (Patrick Steinhardt's message of "Mon,
	25 Mar 2024 08:28:40 +0100")
References: <87o7b5dj8h.fsf@vagabond.tim-landscheidt.de>
	<xmqq8r28ygwi.fsf@gitster.g>
	<87o7b3xxta.fsf@vagabond.tim-landscheidt.de> <ZgEnqE23PYVCNeKc@tanuki>
Date: Mon, 25 Mar 2024 11:56:56 -0700
Message-ID: <xmqqy1a6jg1z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7480E08E-EAD9-11EE-A02D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I plan to reroll this patch series soonish. Please feel free to provide
> your feedback on it so that we can iterate on the proposed UI/UX and
> make it match user's expectations better.

;-)
