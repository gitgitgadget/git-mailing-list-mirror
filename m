Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5CC12F5B6
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723914; cv=none; b=IkdSKtLOkncI4kHT9A18hlWMk8otZE+0XuOFdovMrkVt7rGaNfnvADC/9+JFU8S851KjJO2m5I2+TDYWE8RtmUkBhMYHLYGUfK0+0jSWiHMtXsqCm38CS/sKa9NKIxjXAP17dfTtn8G8b99Uo8phgt5mC1/v0WAROGj7du2aFnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723914; c=relaxed/simple;
	bh=hiO6LOkbQnqiKQqvG/PtfPJ6nbJdcR2qA6+1NdcLn4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WsEQae8kWydn46Iyb2ZlyGIJWBdnZ6sbh3DkPfKegOTk25dmANIRnaNu7MY/3Q/cRT/xR41i2wVRqYxoa3ym5towAImgfNhfdG3U9sBcfWRlzVZ/TESbI8bZQgN1wQDff79+0hrXMhpZK2zy2sHMgUvnt0bsdahDHUbZ38aGHyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YmpKBeaJ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YmpKBeaJ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A2E73284A;
	Wed, 31 Jan 2024 12:58:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hiO6LOkbQnqiKQqvG/PtfPJ6nbJdcR2qA6+1Nd
	cLn4I=; b=YmpKBeaJ3beHsrOd4rPQkXHoVn8KSxHOVj4nSjPAIFpItrBLcDtvCW
	lS47Z7298qCOIIM6ftc4tydejthn4hSqJ8VwDrVEQ50tANkICdXrMjfP96DcH993
	Wm4U9KAeIe1XaZV+iYny5PobUHqOgpgarN5hmpsOex0c299b6thdE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2252732849;
	Wed, 31 Jan 2024 12:58:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5ADB432848;
	Wed, 31 Jan 2024 12:58:28 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Josh Soref" <gitgitgadget@gmail.com>,  Haritha <harithamma.d@ibm.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] This PR enables a successful git build on z/OS.
In-Reply-To: <4d0efd0f-f35d-4a3a-aea1-e08cc55bd2d9@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 31 Jan 2024 17:12:27 +0100")
References: <pull.1663.git.git.1706710861778.gitgitgadget@gmail.com>
	<4d0efd0f-f35d-4a3a-aea1-e08cc55bd2d9@app.fastmail.com>
Date: Wed, 31 Jan 2024 09:58:26 -0800
Message-ID: <xmqqmssl75bx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 56655A9A-C062-11EE-86D7-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> Hi
>
>> [PATCH] This PR enables a successful git build on z/OS.
>
> Maybe the subject could be:
>
>> [PATCH] build: support z/OS (OS/390)

Nice.  This is nicer than what I came up with, that placed too much
stress on the runtime path to the dynamic library.  With all the
stuff added to config.mak.uname, yours is much more appropriate.

Thanks.
