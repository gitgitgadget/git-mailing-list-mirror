Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3428D1A76DE
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981555; cv=none; b=SvYTASHmRd5YqF1hx2dS5JCWIbwJ07zcU4ms9ajDraNjTT5tXGPJ+X/9u10uVDD2hlHFw2yQeZRm7OkLVJbU0XYJPfBwp9UV3zgrONrOcGRUl4oiUxL7kMWz4yWDzKKr93DG0biNWi6kNzNgGuAzWPzWyc+ftilmYIMZFXeJmvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981555; c=relaxed/simple;
	bh=SZG+Fp2JE0u/MYPqRtPq+rqk6AIycf6JA+9Jm2Z2ULg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUnCbJx6EA+GiRs8dxTc9TL96v2knhgR9+LgabNDyvSZfRYE/ra3rcD7dRdK7+FF1BLjwNVh9cePas3ZE1HVQErsEnz2wAM3oqEeHuSHIJ9+oz66gS6fSvNkpEIWd4d5Dv/HnsyZ+ekXa1qbpR8TtneFT55dbIzVBu5SVzwomds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4cr2Yn4lmKzRpKn;
	Mon, 20 Oct 2025 19:32:29 +0200 (CEST)
Message-ID: <5d780103-285b-4e6c-9b26-2a87609837cf@kdbg.org>
Date: Mon, 20 Oct 2025 19:32:29 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t7500: fix tests with absolute path following
 ":(optional)" on Windows
Content-Language: en-US
To: Ben Knoble <ben.knoble@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Noah Pendleton
 <noah.pendleton@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood123@gmail.com>, Thranur Andul <thranur@gmail.com>,
 Michael Grosser <grosser.michael@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
References: <6a83c7d1-7cd4-432e-a0ab-7b18ce3af08d@kdbg.org>
 <A563E028-19E7-48A0-B538-82ACE821DB67@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <A563E028-19E7-48A0-B538-82ACE821DB67@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.10.25 um 15:43 schrieb Ben Knoble:
> Going forward I will probably stick with using pwd, given the
> difference in platform behavior.
$(pwd) is usually safe, but not always. If we have to look at every
instance anyway, we can use $PWD for efficiency if it does not matter,
and $(pwd) only when it is necessary.

> Is there a doc or test lint for that? If not, might be useful.

If this were documented somewhere, would you have found it and obeyed
the recommendations?

-- Hannes

