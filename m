Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF0156C6D
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704046; cv=none; b=oHT6EfGtI9R+JXbwe6NSElBvOulgX7EwANglsC3Gcvpw9oKLsQhLRgYduqVsmY4SfScPzNQHRJpmbfctssuU8lqugctEWb5WuwZwkDHGMw0w1s0D/6vaPNxUl3B0kQ2N7bq49baAJaNKi6MWlJ/sybGacuMrHjFXsyUlvUu/wKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704046; c=relaxed/simple;
	bh=UDGPGU9be2CAD7wksaoqClQhxCGAfpzt2mDt2eEIIt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kDGmtlApqv5n43QDh+1tkHhEXY/FcV8w1+9PGrNJQmMIIy64HHpCuqtwpGxwj481uvLBgiZZ75Dene2KZ4g6iOmRxKUIE7iWWKNurtoTr6uaLDuzTQN3KPWbgwnmucYrsV+7wEuNKw/kh+bG9BFcoTZ+W523R3sZsQXWo/ZluEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=O0WwOcxM; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O0WwOcxM"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C978B293DC;
	Tue,  9 Apr 2024 19:07:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UDGPGU9be2CAD7wksaoqClQhxCGAfpzt2mDt2e
	EIIt0=; b=O0WwOcxMtAv4+KHR60TQh5F71+msK9SzswQxOwD/dNtbG3FlqU6lTM
	X/JSNjIiWyW+St7hg0LrfoJPuoT8v97QYEb5vUFvvR3gEXDQYM9s+WtRDy+y+Wlo
	0USviQMVfzms2/t5kXCgnSvM8TYL+aaROUoJOJDCUatUHfzChC3yA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C369A293DB;
	Tue,  9 Apr 2024 19:07:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4B7B6293D8;
	Tue,  9 Apr 2024 19:07:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] t3428: use test_commit_message
In-Reply-To: <cbe355e6ae84414118badd5c98d302010f4e2a47.1712676444.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Tue, 09 Apr 2024 15:27:23
	+0000")
References: <pull.1713.git.1712676444.gitgitgadget@gmail.com>
	<cbe355e6ae84414118badd5c98d302010f4e2a47.1712676444.git.gitgitgadget@gmail.com>
Date: Tue, 09 Apr 2024 16:07:19 -0700
Message-ID: <xmqq4jca16fs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EB63B40E-F6C5-11EE-8EDA-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Using a helper function makes the tests shorter and avoids running "git
> cat-file" upstream of a pipe.

Nice.
