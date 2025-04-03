Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEB1190679
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697562; cv=none; b=oO5hPwAn99ldSMQVpCi4fEDTofwufT/Jz4W/LVde6709i/yLHcRPzzRruF8KpoqGtfmil+yEuCku437tXrCV90IOQ7fR8eFCKXgD2dFavB7REXZY4wnIoZi2BZHqqduQGiqJD0aaFWGnY4d3mRU611gzUCMxWlf86Y0IdeZ38mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697562; c=relaxed/simple;
	bh=kFFaY4cZWRAzzIcDyc91XM3AwfyxNCQSvozUrVRFyj0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EyBQljKMRpPdmqGS6iD6iy892tzaVppkRoUi0DqBDCvi30v/pViYpsB65uqMHYEBAdxvgzEaGEnhTmjGvjBfYG9mRuHxEXIF0P/BBnIr49ahcyeRWtl2dnexcNDIdjWT0DSVontbYBbUKCC/bmEeLPYyJHLvBZgFC5trMAaFKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZT6YJ3Tt5z9sc4;
	Thu,  3 Apr 2025 18:25:56 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Apr 2025 18:25:53 +0200
Message-Id: <D8X571K4M77Y.2PVKK2KQCRBOM@buenzli.dev>
Cc: "Martin von Zweigbergk" <martinvonz@google.com>, "Git Mailing List"
 <git@vger.kernel.org>, "Edwin Kempin" <ekempin@google.com>, "Scott Chacon"
 <scott@gitbutler.com>, "philipmetzger@bluewin.ch"
 <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Elijah Newren" <newren@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com> <Z-5QR57zgSsm6jNP@pks.im> <CABPp-BGwXaiohvfSdr96hzKNPYXQqz+_okxLNj7P9KSjX2PW6g@mail.gmail.com>
In-Reply-To: <CABPp-BGwXaiohvfSdr96hzKNPYXQqz+_okxLNj7P9KSjX2PW6g@mail.gmail.com>

On Thu Apr 3, 2025 at 5:56 PM CEST, Elijah Newren wrote:
> On Thu, Apr 3, 2025 at 2:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>>
>>   - Extending revisions to allow specifying commits by change ID.
>
> Would this essentially be similar to <rev>^{/<text>} except searching
> specifically change-id headers rather than commit message?

One benefit of using the "reverse-hex" format (hex with a different
alphabet: z(0) through k(25)) we're proposing is that it allows a
change-id or its prefix to be used in the same place as a commit hash,
without ambiguity.

Remo
