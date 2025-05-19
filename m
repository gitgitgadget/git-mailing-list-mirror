Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4BDA55
	for <git@vger.kernel.org>; Mon, 19 May 2025 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664771; cv=none; b=l80XMOoIgvqV8RPA0KTnA+kUU6D56cgRz3Nf1q7Sr/W5c/Qt4H12Qp+oMw/14rchBQUcPEyqRMo4r7esGLgS1fF/ESvQZIw+T8FFCymXK+DWn62Fc2+zS/64+Ye2lHGU/UjAw2pK4B1ywIXIWhciiSwqIAMkUNNAMnytYeSb/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664771; c=relaxed/simple;
	bh=OFowy75vHRYAo2DGyocmoWF1Ap2N0V9oRNXA6+3KpoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n7MA6s8fxHzxaZ4DxFFQocj0aETvNDK/ReN+vC0cOwYG0i+JRHNqF2PnaEOfHAYtQTmhAL0GBTx+8p77moeuUrAJD/7q9R6y4OTsn5JFcMLl5YttRc/GBdtHurekEqsVkQLyUBv6LF4xOPZzr7CSEePOnt/+xwwWH8wwycFEJxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FJ/D98+L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IvLUqotF; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FJ/D98+L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IvLUqotF"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C4AE61140157;
	Mon, 19 May 2025 10:26:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 19 May 2025 10:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747664767; x=1747751167; bh=cH0ceC+XqW
	4cROLZU8NcJ4LLi4XXYJWJ4BjjTO+vX6g=; b=FJ/D98+L8npMx4I/RyeRfmo1f9
	IBzpnikNlxfz+zl6rMa13YWHOmaADr8lVT+TR3aoQrgEXgEEmQ+Ay7ilyzX1qYXl
	P7KCZw0/WLUgcRLtNEPi/A64y9fq8vRIDqW8NNwWsMxV02BrSb/nkknSTJKGuTho
	u7BL2mSM7HmwmHGENu4ee16XE25sK9JqIzgQhglIE3r06etQL8Ar1k7n4p7BjSQn
	y8WgTyy1DUGUSYWFYoUvCdWIltX0tUhdqfH4o8oG2kGuWhLMzctUsuv3E+yfCahy
	Y66u+r+kabYhmA09Wn4Dtri4XQ93C8+M+TiUZFXTzRbjZozxIH2NsUXLGuMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747664767; x=1747751167; bh=cH0ceC+XqW4cROLZU8NcJ4LLi4XXYJWJ4Bj
	jTO+vX6g=; b=IvLUqotFYtXSspyoK658rKTgwJXprJqJ6YZEFybHG7dDlyGIPWm
	F1/uFJYSmGEF0JqKvsP7oFdkYa+xT4LBQ6RZ3MGYCsqBxlZV5yOe+YSnDSeZE6pf
	ESRsG9Hq45PdtJAJQYjXuWxUhPGXJTsOKyG1FIVfydGCMEYeoQcX6p1HqgY+K6Rz
	9dHQaqR0TPsT/wSan7I6Cxpk9eFtyG/chaxF6JONYhzdWibsKLIEIi/w2EzlBwxa
	F48kjbOl/dtUAFUWX5rsaJLsTBqjQJiUU6K1zU1fzocD0+Psf6dNHVCBFev208yg
	6b/QP0CvEda0+o4Uwf84M9jmlnkFktfymsg==
X-ME-Sender: <xms:fz8raHdd00EEuAf9BoBAzO5hzH3VeuY6bO7bpVudGyXvEBHc10W_IA>
    <xme:fz8raNPRoZCVa5HsCN4LLODYBgNU-03EZIR4Ow7KN4Yg12WixlWzVeiKtJGagrKbu
    JZ3tm0f7Mgx1xXqyg>
X-ME-Received: <xmr:fz8raAhBTlcBl1dyr0TFi18qJgEn_unu7N8XLZ3OcuSDyZ6nkMFUDNTgW0S-mVHcgRBHPIsjf6Gx1Nk2C2ROBlxe-_FxlLNkXnK4UZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdduieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:fz8raI9MAqPr8-LudOit1_SXIdQJ0tubDMB1zP-TsHBZMliCwH39Mg>
    <xmx:fz8raDvX2kpa5y8tuMNmosC0vm7dJ3YY344jt09E0TR2eVnCkX8OfQ>
    <xmx:fz8raHFC15FRCv7PIIgGfWLAiznLXILhN57D7SmbYUrnad--dII25Q>
    <xmx:fz8raKNhIi-emRw1wXqXlhIPfy3Duy-9THqNN73z3nNdJ-D4iYYqoQ>
    <xmx:fz8raJpfZ6s_M7XHsiexJYZ-ZurcYHjVJp-noMn0DvwEenV7QDgD1Ap->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 10:26:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/13] fsck: stop using object_info->type_name strbuf
In-Reply-To: <20250516044953.GF22242@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 16 May 2025 00:49:53 -0400")
References: <20250516044916.GA21985@coredump.intra.peff.net>
	<20250516044953.GF22242@coredump.intra.peff.net>
Date: Mon, 19 May 2025 07:26:05 -0700
Message-ID: <xmqqy0uspthe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So we can simplify things by bailing immediately in read_loose_object()
> when we encounter an unknown type. This has a few user-visible effects:
>
>   a. Instead of producing a single line of error output like this:
>
>        error: 26ed13ce3564fbbb44e35bde42c7da717ea004a6: object is of unknown type 'bogus': .git/objects/26/ed13ce3564fbbb44e35bde42c7da717ea004a6
>
>      we'll now issue two lines (the first from read_loose_object() when
>      we see the unparsable header, and the second from the fsck code,
>      since we couldn't read the object):
>
>        error: unable to parse type from header 'bogus 4' of .git/objects/26/ed13ce3564fbbb44e35bde42c7da717ea004a6
>        error: 26ed13ce3564fbbb44e35bde42c7da717ea004a6: object corrupt or missing: .git/objects/26/ed13ce3564fbbb44e35bde42c7da717ea004a6

Just curious; is the difference between 'bogus' and 'bogus 4'
significant in the above examples?

>
>      This is a little more verbose, but this sort of error should be
>      rare (such objects are almost impossible to work with, and cannot
>      be transferred between repositories as they are not representable
>      in packfiles). And as a bonus, reporting the broken header in full
>      could help with debugging other cases (e.g., a header like "blob
>      xyzzy\0" would fail in parsing the size, but previously we'd not
>      have showed the offending bytes).

Yup, I do not think anybody minds the message that has overly long
object name toward the end, instead of the beginning, of line,
either.

>   b. An object with an unknown type will be reported as corrupt, without
>      actually doing a hash check. Again, I think this is unlikely to
>      matter in practice since such objects are totally unusable.

Agreed.

> We'll update one fsck test to match the new error strings. And we can
> remove another test that covered the case of an object with an unknown
> type _and_ a hash corruption. Since we'll skip the hash check now in
> this case, the test is no longer interesting.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/fsck.c  | 13 ++-----------
>  object-file.c   | 12 +++++++++---
>  t/t1450-fsck.sh | 29 +++--------------------------
>  3 files changed, 14 insertions(+), 40 deletions(-)

Pleasant.

Thanks.
