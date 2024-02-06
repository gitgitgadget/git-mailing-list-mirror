Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D913AE3
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245379; cv=none; b=gxvzZm5vj9PYyBvy2dQhboxg797FZKhwc4tp8BDKmwSaC3AXanMsMqUT9DbVM24pgvUrPxN7LF33q7GXwpiP9zNqPl6oRgN+wfuwfGqnnG58dSPAiqvkUAmy7HWJo63KAA9av3C+CrwgT9r9fmJ7FW8hCuSRBBL3SChctLDBou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245379; c=relaxed/simple;
	bh=uIboDrTXuKAeEaMfTsmqooRfTq1aDGnVnHp6IMxCwx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q07Fp8hYSUXczDPvQFdj/QqgmI9giEC698KT9uXVuHc9VMuFaTMpYKkFfp2haibybDKILkwFZRDMvlOfvnUJFEG9j22k9kTOsiB6B7IKOqWlz0YUwarpRoSwR76RyTfKSFlAbQhtsrBk2n+v312MOH9kGbx4XTLw7rTokhSgxd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ib9Nt0o6; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ib9Nt0o6"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BC1751CD070;
	Tue,  6 Feb 2024 13:49:36 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uIboDrTXuKAeEaMfTsmqooRfTq1aDGnVnHp6IM
	xCwx4=; b=Ib9Nt0o6h/jEbLw8c/q2IA+3somGNZCytq4cRRw0r2MRCxs4yPVDAT
	sSPWO0wbPEbWw/N4/2FbQaPm8DBhf50Pdd5UQNNSFNb+2NxQDyf30utTFp4xCvuC
	AuZ6pcRjKHSBuLZmZIk5sfmfpXOLa+Fsu5gEBoic5b4NKGTHyp0sg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B38841CD06D;
	Tue,  6 Feb 2024 13:49:36 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 272611CD067;
	Tue,  6 Feb 2024 13:49:36 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Tobias Boesch <tobias.boesch@googlemail.com>,  git@vger.kernel.org
Subject: Re: git-gui desktop launcher
In-Reply-To: <ZcFhNPRprfMqeRu1@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 5 Feb 2024 22:29:08 +0000")
References: <beeab03c564e94861ab339d26c4e135b879a1ccd.camel@googlemail.com>
	<ZcFhNPRprfMqeRu1@tapette.crustytoothpaste.net>
Date: Tue, 06 Feb 2024 10:49:35 -0800
Message-ID: <xmqqle7xh1hc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 796B25C0-C520-11EE-BDD7-25B3960A682E-77302942!pb-smtp2.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I think such functionality would be generally useful, and probably be
> beneficial to a wide variety of distributors.

How have the various distros been packaging their binaries?  Would
this change affect what they have done already?

As long as it does not conflict, I am all for it (i.e. we do it once
and everybody benefits).

Thanks.

