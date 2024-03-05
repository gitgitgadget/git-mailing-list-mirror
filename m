Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEDF171A2
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658836; cv=none; b=n2JMk/YUKxBb5LajKZdKZ0GgD75hn8v+d88/k5dde9u3TBxvPRqu6B+6fayBLcNLOXGCCNSyofcuqqhMeG90P8gVYmikCZGFdZOhh01uWclsPp5l0fITjgIKc3o2uzyKQ7PzvhC+ZXGx6YpAe0hrEI/5b6WOoRfGqsVrO9L9jLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658836; c=relaxed/simple;
	bh=n/Dl1gASiV45xPdLEt/i9EX7qx+zFC6zZf1AH2S1iiA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FLYnuWALN7lUFH6zYFmcvoyQl05G46C/IGbcuIR0BjYvmU0U1flp5McENYjCLRJFULhL23m9iwO1KyDw5TkUno5lSgYraYDKiz5Bqkn6J5otJS5sDshuOVCSHlX+Kj8l+DINajgrqflV7kba3PEryCWK1yBty10Y/ACN8RKaOJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RyHCYbdi; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RyHCYbdi"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 09F8D3E20F;
	Tue,  5 Mar 2024 12:13:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=n/Dl1gASiV45xPdLEt/i9EX7qx+zFC6zZf1AH2
	S1iiA=; b=RyHCYbdixAcMf0cnmHIe6QpLIbZqHNib5Rn36Sdgdxv2ZuO0oHxJ/A
	ppnmlrbUXmSS/LKsyKk/i2j9FCs5rW/ZQ0TuT3Esqm93XH5ESfky1iw9ha90DCQG
	HbrivhIlFTyDPsUTFc3HtUKWx+GvBlf/2Mt28pvC9W5hzBLnz9fZM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 01C413E20E;
	Tue,  5 Mar 2024 12:13:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2E13D3DEAA;
	Tue,  5 Mar 2024 11:38:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Manlio Perillo
 <manlio.perillo@gmail.com>,  git@vger.kernel.org
Subject: Re: Clarify the meaning of "character" in the documentation
In-Reply-To: <52d6850914982ffaf15dda937d611ffb@manjaro.org> (Dragan Simic's
	message of "Tue, 05 Mar 2024 16:42:07 +0100")
References: <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
	<5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
	<xmqqsf1466eh.fsf@gitster.g>
	<52d6850914982ffaf15dda937d611ffb@manjaro.org>
Date: Tue, 05 Mar 2024 08:38:17 -0800
Message-ID: <xmqqmsrc4osm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CC802752-DB0E-11EE-AE0C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> On 2024-03-05 16:32, Junio C Hamano wrote:
>> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
>>> I think this is more about `git config --add` not doing any
>>> validation. It just sets things. You can do `git config --add
>>> core.commentChar 'ffd'` and get the same effect.
>> As you said, we should document core.commentChar as limited to an
>> ASCII character, at least as a short term solution.
>> I personally do not see a reason, however, why we need to be limited
>> to a single byte, though.  If a patch cleanly implements to allow us
>> to use any one-or-more-byte sequence as core.commentChar, I do not
>> offhand see a good reason to reject it---it would be fully backward
>> compatible and allows you to use a UTF-8 charcter outside ASCII, as
>> well as "//" and the like.
>
> May I ask why would we want the comment character to possibly be
> a multibyte character?  I mean, I support localization, to make it all
> easier for the users who opt not to use English, but wouldn't allowing
> multibyte characters for the comment character simply be a bit unneeded?
>
> Maybe I'm missing something?

That's not a question for me ;-).

It is not my personal itch, so I haven't done anything to make the
commentChar take more than one byte.  But if it is somebody else's
itch, I do not see a reason why we should forbid them from
scratching.  If the setting seeps through across repository
boundaries, that may create a compatibility issue and that by itself
might be such a reason.  If it greatly makes the code more complex,
that may be another reason you can use to argue against adding such
a "feature".  If it makes the semantics of what "a comment string"
is and how they are added and stripped at various stages of
processing commit log messages fuzzy and harder to document and
understand, that might be another reason.  I however do not think
any of these to be true.  Maybe I am overly optimistic.  I haven't
looked deeply into the code around commentChar for quite some time.


