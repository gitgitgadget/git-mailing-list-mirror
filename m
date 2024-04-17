Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7FB13C3CF
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366348; cv=none; b=BaftvZQaRxVHSYHQs00CsIfcpMxj4rYvxpR9FkVWv92YOFBmSiCnNEanYZcd/16/QIYcgZ9pxgDefFxb2ylGFo10YKaTcAPafipZaymr/nAMT/E5Vk9+zxbgNzWq58fImpVX1gMgEet9/OeajOUPglUgM09WitTSX8uFQGNPf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366348; c=relaxed/simple;
	bh=puuU119cTeo7LnE/rxTvherXGH3B0GapsFdjWgvtcZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WoeU5LqTctDKJUeNmWQZRnWmJfm/C3WahiB9JZxtmMbVhxuMuOpmlYNol/9kK190YFNKeHI2oDUhzVs7va9wQ3YGF8hvLbgZZYVd+b2YwZClN6VXMvDmJaSZOyeJu1bCMld0EfjNWwjFtwciTRt2zPSaXKWxVbjQnA6Kcz/jLXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=X1r8CnG6; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X1r8CnG6"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2215419056;
	Wed, 17 Apr 2024 11:05:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=puuU119cTeo7LnE/rxTvherXGH3B0GapsFdjWg
	vtcZc=; b=X1r8CnG6wloVypx8OpAOGMV9fbEIXMR/ulDWJdE6U7e9OXAMH3qwpr
	b4+nWm/k0iI5ltN8u38EZgy+0DW2EoeWgL3aTfp0G2hLwF6tJZ9hjso1RmLJ2VWJ
	7dTw4NZonY0YqzTdMTwh2g4wziGixpydfpE2YespJEGRZxCpQPzjo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1AAFB19055;
	Wed, 17 Apr 2024 11:05:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D4CE519050;
	Wed, 17 Apr 2024 11:05:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
  phillip.wood@dunelm.org.uk,  Git List
 <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] add-patch: response to invalid option
In-Reply-To: <1d0e98cb-78a4-40d0-9bfe-390a3a30aad8@gmail.com> (phillip's
	message of "Wed, 17 Apr 2024 10:37:39 +0100")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<15f9252c-212f-43eb-84f3-6046fb2fab38@gmail.com>
	<20685fa0-815f-4cdf-95e0-7206588552b5@gmail.com>
	<1d0e98cb-78a4-40d0-9bfe-390a3a30aad8@gmail.com>
Date: Wed, 17 Apr 2024 08:05:35 -0700
Message-ID: <xmqqh6g0av28.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F2E7A8B4-FCCB-11EE-9B92-A19503B9AAD1-77302942!pb-smtp21.pobox.com

phillip.wood123@gmail.com writes:

> I tend to associate "option" with a command-line argument, not
> interactive input to a program.

"git add --help" is a bit mixed.  The choices offered by "git add
-i" are called "subcommand" (see "INTERACTIVE MODE" section), but
the choices you give to the prompt "patch" subcommand gives you are
presented with "You can select one of the following options and type
return".  So "option" is not too wrong, even though it is a word
used in other contexts as well.  I am OK with "option", but if I
were adding this new error message, I probably would have said
"unknown command".

In any case, whether you said option, command, or key , it is so
obvious from the context that we could even say "error: 'W' not
known, use '?' for help" without any noun there, so it would not
matter too much which noun you pick.

I'd still avoid "key", though, because to those who do not do
single-key input, myself included, it does not match their user
experience, and it is even more so if they forgot or do not even
know that they could choose to use single-key input.

> The test you are proposing only tests the last of these changes. We
> should be aiming to write tests that (a) verify all of the changes
> introduced by a commit (b) are likely to detect regressions to those
> changes (c) are reasonably efficient, for example if it is possible to
> test more than one key with a single "add -p" process we should do
> so. As this is an interactive program I have a strong preference for
> testing what the user sees printed to their screen, not just what
> happens to come out on stderr.

I do agree with these three points, but I do not have a strong
opinion on the new test that was added by the patch when judging
with them used as a yardstick.

Thanks.
