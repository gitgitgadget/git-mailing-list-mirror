Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EAF16427
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659731; cv=none; b=r9XEiNFTA4WtF0ndQWbtl6ehVExPx1j1iOWPTeUtJptRiyP4SIMZJJ/XkoW3U7fvoKwZo8fxSVkDch0ZMqf4gUyMxHw0oXuI2yqdsq4sLQzlFUGn2846nZdrLrQ5ELpg9eO+bmMB+HMvFmUqtz3tTZC8OhX8laVvn5ljxDrqZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659731; c=relaxed/simple;
	bh=WeEqU1iar+zKFZbu6fndXUt1+Peqtg3oU4rao5iX5X8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FDebhEwzevzJBNaXBfO5i0oDjJITR2znIkpdmQANWVWaJlKicXwVCRtLEHdqvfTnT2+iwiAP0GhX1G5F8FZlMQaH6sOwmNStI1hae0vJeIOy1ZADy8weiLG5Bnf1R56L5RAo1DVxy96nOPDvZYK+a8SjR4n5y3IIIx/hk87Tuuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ASRL7ib3; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ASRL7ib3"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709659726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzLrp4HjZVNGW23LfuK6RDr8uE2iOxKS6HCPvoUjvHQ=;
	b=ASRL7ib3ToBeitRpqJ9GKJDEvyyuaiczOOan5xEIVq312dRFMys5MroMYkJcThmym+FYOR
	a5amKPFdg1fG2/+GrM9S9zWuQzSZz9rbnFCq5rSV0mioZL+qhPweXoK1/j+C1DNWNfzvuQ
	9S0lN0yWfNMI946Up650eX8fAnnIQljWK8Bbgwq2SNE4jiN29cq2gjlc7arTJyYFxFv7xE
	BveM+s73UlylhfNTqFgrc1GW1MzgqgFtFvyNwoS6nZtI2SNs/DW4L07vNFKRcikOnbrERD
	N34DdkpzbPj6TwCsS6YS0j1mo9Dcef3DSsHF18WH7t/KlYtL1mDOel7We7bIcw==
Date: Tue, 05 Mar 2024 18:28:46 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, Manlio Perillo
 <manlio.perillo@gmail.com>, git@vger.kernel.org
Subject: Re: Clarify the meaning of "character" in the documentation
In-Reply-To: <xmqqmsrc4osm.fsf@gitster.g>
References: <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
 <5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
 <xmqqsf1466eh.fsf@gitster.g> <52d6850914982ffaf15dda937d611ffb@manjaro.org>
 <xmqqmsrc4osm.fsf@gitster.g>
Message-ID: <1a4a04fd6b99e1de1696563cecbe14d1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-05 17:38, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
>> On 2024-03-05 16:32, Junio C Hamano wrote:
>>> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
>>>> I think this is more about `git config --add` not doing any
>>>> validation. It just sets things. You can do `git config --add
>>>> core.commentChar 'ffd'` and get the same effect.
>>> As you said, we should document core.commentChar as limited to an
>>> ASCII character, at least as a short term solution.
>>> I personally do not see a reason, however, why we need to be limited
>>> to a single byte, though.  If a patch cleanly implements to allow us
>>> to use any one-or-more-byte sequence as core.commentChar, I do not
>>> offhand see a good reason to reject it---it would be fully backward
>>> compatible and allows you to use a UTF-8 charcter outside ASCII, as
>>> well as "//" and the like.
>> 
>> May I ask why would we want the comment character to possibly be
>> a multibyte character?  I mean, I support localization, to make it all
>> easier for the users who opt not to use English, but wouldn't allowing
>> multibyte characters for the comment character simply be a bit 
>> unneeded?
>> 
>> Maybe I'm missing something?
> 
> That's not a question for me ;-).
> 
> It is not my personal itch, so I haven't done anything to make the
> commentChar take more than one byte.  But if it is somebody else's
> itch, I do not see a reason why we should forbid them from
> scratching.  If the setting seeps through across repository
> boundaries, that may create a compatibility issue and that by itself
> might be such a reason.  If it greatly makes the code more complex,
> that may be another reason you can use to argue against adding such
> a "feature".  If it makes the semantics of what "a comment string"
> is and how they are added and stripped at various stages of
> processing commit log messages fuzzy and harder to document and
> understand, that might be another reason.  I however do not think
> any of these to be true.  Maybe I am overly optimistic.  I haven't
> looked deeply into the code around commentChar for quite some time.

Yes, there are quite a few possible obstacles.  As I replied to 
Kristoffer
a bit earlier, I see this more as a programming exercise.  Of course,
unless someone really needs it as a new feature, in which case they will
probably need to overcome all those obstacles. :)
