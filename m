Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098F2AD1C
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317983; cv=none; b=o6PfW+R8JnOurp/A2safj4aBSBiZLuSe6CN6rXPuC+DWIPjgrx1MnpzZh/peB/mRbU13lPcNcJEHUQIlrZvBcyXd8YLalfjgnr4QRdb5tutoB1daiieCBZs7qBRrX6ukEDBZn/5iz2kSIT8H5SqKvJSmBm4S8PUDiBbYp/DLyAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317983; c=relaxed/simple;
	bh=1M/dGBbA8ziZl76WEHZHk1P9DRg26R+As4M8h7E7IU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qM5wJRzpNA3JnGl+V/LHh5w3D6iTbphbABGFLQqUFoR3oCku/uifXnjLFbxCyWyCZOGrtOC2Hh4scZY6SJmTsA2nQqlKe6LhGQa5FvpU9uKQSELX29euyCNehigi/PsGFVfJYplRsRjjJXZKQYbJ5HuBDcPR6wPkrnyCCTepN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W86OzfgK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W86OzfgK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F0D11D8191;
	Fri,  1 Mar 2024 13:33:00 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1M/dGBbA8ziZl76WEHZHk1P9DRg26R+As4M8h7
	E7IU0=; b=W86OzfgK+SqlbtHXWGeV41P5NkFVFPWcr/+uNBCzmgqJrDu+KS7chj
	zeLU9I+IQyyjgT46vPV276D8TmalOu5mNZwUedD+8KVyQyhZrAQK13T63EeKYf5G
	d5mUgmcbWlTS5offkD9ewj8PslxtTvC0nmvl+oMJwrLXmuzxRiYUA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 838061D8190;
	Fri,  1 Mar 2024 13:33:00 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCF9E1D818F;
	Fri,  1 Mar 2024 13:32:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] branch: advise about ref syntax rules
In-Reply-To: <1ba698b2-a0da-4d62-8174-0ee6d6cd9bbc@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 01 Mar 2024 19:13:33 +0100")
References: <d275d1d179b90592ddd7b5da2ae4573b3f7a37b7.1709307442.git.code@khaugsbakk.name>
	<xmqq1q8t7roc.fsf@gitster.g>
	<1ba698b2-a0da-4d62-8174-0ee6d6cd9bbc@app.fastmail.com>
Date: Fri, 01 Mar 2024 10:32:58 -0800
Message-ID: <xmqq34t96bvp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 217B03AC-D7FA-11EE-8719-25B3960A682E-77302942!pb-smtp2.pobox.com

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> I thought of doing that, but I reckoned that people who have a good
> intuition for the ref syntax would not get this error enough to want to
> turn if off.

If that is your choice, that is perfectly OK, as long as the
proposed log message clearly records why we did not bother using
advice_if_enabled().

If that is the case, then a rewrite for existing die() would become:

	int code = die_message(_("'%s' is not a valid branch name"), name);
	advise(_("See `man git check-ref-format`"));
	exit(code);

Thanks.
