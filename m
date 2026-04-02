Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6379B3D5643
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123932; cv=none; b=TGJkgHax8i7jXAYozXFxXULZb/Opjvk4b2NPUE7eL5RHxDz7WF0YubcmtL0F3bKNGhQvMm44rUPYKgIHj3NQioinxwTEfe3fE9B/l/SjV7mb+Z7+LMS/ENHL8RrlTnBHL6eajbZK/nWyWCrG0AOMRLjtYQJrWbC8GRHOYqyf9yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123932; c=relaxed/simple;
	bh=nGIHMl8odZO+GPlB67X0Ysv8KE9n8uKcLqx2qLVJ/jU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NsdIsE9I4qxcfjAoL3GPwAWiEeyfKf26p6Mrp7YWttzlAoEUwRs6mYg4iq/upp6+PV3Jlbo9Gz867PCs3z9Dyc0tfm6MX3MMd7weVe5B9QESTHpcxAu6KQ3fRCmqKuGOtcwLLYkr8g0rhrcngGCP/F6+yLggECvRVWysKnH7A5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F19YyoQo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BB7tB769; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F19YyoQo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BB7tB769"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 742187A02FE;
	Thu,  2 Apr 2026 05:58:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 02 Apr 2026 05:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775123926; x=1775210326; bh=vwI81Zx7Pu
	gxyJhjzg6GgQovxWyiJIsMK78hy9ZE/dU=; b=F19YyoQoRO8DQ7ZQVTm9Oh2jUw
	muUGSf1wTc1XmDcwX1GHkmNv2z1JzJwF9gsuBOhxcKmM3QctbA2hPZCAEHV+W4Dx
	26poyzcb2FTRh0Jeqj+exKLHXDlDc2zK32nBFri5NzXjKlc9INoYWj2cVA2Nqjql
	ngFEwBJd40D5PvV1EY0ToB1JRgUyemTgJBZIudvILs+Q4s/RIPgekiQrVA5CW3Yj
	NrupccFfdYWWnfScOEhwsoVsnnIGVy7NjveB3rEGftQaILQseLO1QXTM6T10RFRq
	vUdfcXJ6RG2bSDq2G5SO/bJ7OWbSNdbWWf+jiGElE/f5cic7nldpM0Widtjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775123926; x=1775210326; bh=vwI81Zx7PugxyJhjzg6GgQovxWyiJIsMK78
	hy9ZE/dU=; b=BB7tB769fDedxZ7dfpUoq9bEf/qcjD7ngg+TZsw6LAWxtM/r/nI
	fFMOz/gjR/ayj0tkrwl1ignG34zzhKom8OsM0fd1ZA9W7yboKQQQ3K5Fc12ywGHH
	MTZgsxyW1spT3coKpmqX7GzP+dVvuApfV0YJEeeW7oWdP3LsjSEYU5coqJT+ZZNm
	v6fN0ZnWDT2JK4nRRB7fTDQbPwD9WDFghsjnSdtcCda/kSW5fwUfUjN61ZH1Z7ao
	MnPxph4ipcpikxPzmqGuajoJ3y4wp25QsSiw6sD+vICNr9buNOfWb6fgl8xD6ci/
	Qeww1N5JKaz53OH9VvYNVuuG33MRNKkum0Q==
X-ME-Sender: <xms:1T3OadVJbV4jVOGqaFi_HqKLFNfX27R_4cGvtG0TZ8G684not6zNHw>
    <xme:1T3OacrIorlDfmDv0IZcPIXO1Y3rO1eNk5ErcWeDniy6i9yBZBeq8Nml5PixWIsGQ
    YB2Pb2_aCzNVbRWAcDWy9H5e24Z9wNKMJ9A-bd-h_P7i4VQI289>
X-ME-Received: <xmr:1T3Oafm3eSRHs7XyYw-znWwOF53f21yVCo90HeGUlzE8EejKybnfX5h0DQgI3H-tWH0bV6FVTJNswxUts6-cmnDozgZFHqqAZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholh
    esthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:1T3Oac0okt_GaKn8VyjohhXRLNmoWVkCH6XVHxjGSpgEfeSEY5Wrvw>
    <xmx:1T3OacQbHg0vmCVl_RRBVgOSDQUpPZxLOVRq1ud2vSqJNeG4FBo80A>
    <xmx:1T3OaVzoKxTo3i2--3YhbUnFGMy-MZQxGaz5JDTYHYU_z7PorW2Kmw>
    <xmx:1T3OacDnB4lfay7dBPJOkaE8QrpRmTjfzvE6sJkZqvaqzDS8Dcbgbw>
    <xmx:1j3OaRVr4t6orMKy5KTG2pSmYx0icKAovKc42vS_-fNbczVy5hVUYeo_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 05:58:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 10/10] t5710: use proper file:// URIs for absolute paths
In-Reply-To: <20260402070613.85934-11-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 2 Apr 2026 09:06:13 +0200")
References: <20260402070613.85934-1-christian.couder@gmail.com>
	<20260402070613.85934-11-christian.couder@gmail.com>
Date: Thu, 02 Apr 2026 02:58:44 -0700
Message-ID: <xmqqa4vlu1ij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> +# On Windows, 'pwd' returns a path like 'D:/foo/bar'. Prepend '/' to turn
> +# it into '/D:/foo/bar', which is what git expects in file:// URLs on Windows.
> +# On Unix, the path already starts with '/', so this is a no-op.
> +pwd_path=$(pwd)
> +case "$pwd_path" in
> +[a-zA-Z]:*) pwd_path="/$pwd_path" ;;
> +esac
> +PWD_URL="file://$pwd_path"
> +# Same as PWD_URL but with spaces percent-encoded, for use in URL patterns.
> +ENCODED_PWD_URL="file://$(echo "$pwd_path" | sed "s/ /%20/g")"

Two comments.

 - I was a bit surprised that these are not given as functions but
   as variables, as a caller that chdirs around in the trash
   directory would want a URL that points at its current working
   directory (the expectation is from "pwd" in the name PWD_URL).
   But a variable based interface "Here is the URL that corresponds
   to the trash directory" is OK and probably easier to use than
   "give me the URL corresponding to my current working directory",
   simply because it allows a caller to append some string to it to
   come up with a URL for any subdirectory on its own without
   actually going there.  But in that case, the name PWD_URL would
   become misleading, as it is PWD as of the moment the variable
   gets defined, and the true meaning of the variable is not "URL
   for the current directory", but "URL for the trash directory" is
   more usable definition.

 - Is it sufficient to only special case SP?  My repository may be
   $HOME/w/git.git, for example, and the trash repository may be
   "$HOME/w/git.git/t/trash directory.t5710/", so you need to cope
   with SP between "trash" and "directory" the test framework adds
   (to force you to be careful), but the test framework does not
   control what can be in the leading $HOME part.
