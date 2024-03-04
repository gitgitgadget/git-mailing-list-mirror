Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265307D07C
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596343; cv=none; b=C0qsitMJuHF2qzpy61bos18W6Uwmwm68EhuLHEAfXxTdBwhSrgLJ6pxKWGfCydFCuqazFUVsLkPodjKxEnz5JE/dPYX02+SXwVwcoqJFBHDMCEr2cBC6OlTsnM94KkrU///MGczb8fABfn+1uGQlAyP5W026cNBY6OULJiAsmxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596343; c=relaxed/simple;
	bh=xodU5BU61oR0F8hDvtJszo2vOhb00bVPg5ttc2+ccYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U6l2N4DqV/ORwVyoZ2/YAR6g/+GzvVKL6qwqRMZ4RKs7iK6qoVLhMBL5MvYhI0si8qHuXk+kLUdQDDj/qH17bJKSWXA0cDVY0kAr3NSobPPvwMt2lUAsuXOV7h2k93yfVxrblNmkwgVlUJb8HW1burj4HujcuUjGmPyepBOiLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=m5wGUaHa; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m5wGUaHa"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 50CCC1D1C1E;
	Mon,  4 Mar 2024 18:52:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xodU5BU61oR0
	F8hDvtJszo2vOhb00bVPg5ttc2+ccYs=; b=m5wGUaHapLCe0zlmzgfs5nCOrQX+
	cUVf3U8Hy29hpKc8pPxbDiaq24gy6XMHD+G0YJEZFzkz3QODUvhBPXtUIzBG7c+q
	Uoxyt7gUvik80MhbsAL6a5lfAWTT/CoogS9rV1kHHkql0SdhG/ZjkOjy4OU7DPJd
	DPStXQaI9uBoc+Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48E291D1C1D;
	Mon,  4 Mar 2024 18:52:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B35BB1D1C1C;
	Mon,  4 Mar 2024 18:52:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/5] advice: make all entries stylistically consistent
In-Reply-To: <d48b4719c275ef06da014b6d22983db9ae484db2.1709590037.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Mon, 4 Mar 2024 23:07:27 +0100")
References: <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name>
	<cover.1709590037.git.code@khaugsbakk.name>
	<d48b4719c275ef06da014b6d22983db9ae484db2.1709590037.git.code@khaugsbakk.name>
Date: Mon, 04 Mar 2024 15:52:13 -0800
Message-ID: <xmqq4jdlmu6q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 39ED5040-DA82-11EE-B187-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> 1. Use =E2=80=9Cshown=E2=80=9D instead of =E2=80=9Cadvice shown=E2=80=9D
>    =E2=80=A2 =E2=80=9Cadvice=E2=80=9D is implied and a bit repetitive
> 2. Use =E2=80=9Cwhen=E2=80=9D instead of =E2=80=9Cif=E2=80=9D
> 3. Lead with =E2=80=9CShown when=E2=80=9D and end the entry with the ef=
fect it has,
>    where applicable
> 4. Use =E2=80=9Cthe user=E2=80=9D instead of =E2=80=9Ca user=E2=80=9D o=
r =E2=80=9Cyou=E2=80=9D
> 5. detachedHead: connect clause with a semicolon to make the sentence
>    flow better in this new context
> 6. implicitIdentity: rewrite description in order to lead with *when*
>    the advice is shown (see point (3))
> 7. Prefer the present tense (with the exception of pushNonFFMatching)
> 8. Use a colon to connect the last clause instead of a comma
> 9. waitingForEditor: give example of relevance in this new context
> 10. pushUpdateRejected: exception to the above principles

I'll let others comment on these as general principles.  I do not
immediately see anything objectionable, but I may change my mind
after reading the updated text in the patch.

> Suggested-by: Junio C Hamano <gitster@pobox.com>

I am getting too much credit for this; I merely suggested to use
"when" instead of "if" in the one you are newly adding.

>  	detachedHead::
> -		Advice shown when you used
> +		Shown when the user uses
>  		linkgit:git-switch[1] or linkgit:git-checkout[1]
> -		to move to the detached HEAD state, to instruct how to
> +		to move to the detached HEAD state; instruct how to
>  		create a local branch after the fact.

I agree "Advice shown when" -> "Shown when" is a good change for
brevity, but I do not think the other change is an improvement.

This advice message is shown when the user does X, in order to
instruct the user how to do Y after that.  And "to instruct" is a
common way to say the same thing as "in order to instruct".

>  	implicitIdentity::
> -		Advice on how to set your identity configuration when
> -		your information is guessed from the system username and
> -		domain name.
> +		Shown when the user's information is guessed from the
> +		system username and domain name: tell the user how to
> +		set their identity configuration.

Should that be a colon?  Stopping a half-sentence and connecting to
another half-sentence is usually done with a semicolon (like you did
in the new version of detachedHEAD above).

	Shown when ... and domain name, to tell the user how to set
	their identity configuration.

perhaps?  There may be other similar entries whose updated text uses
colon followed by an imperative sentence, but I didn't look very
carefully.

>  	statusUoption::
> -		Advise to consider using the `-u` option to linkgit:git-status[1]
> -		when the command takes more than 2 seconds to enumerate untracked
> -		files.
> +		Shown when linkgit:git-status[1] takes more than 2
> +		seconds to enumerate untracked files: consider using the
> +		`-u` option.

Earlier ones after a colon (or semicolon in detachedHEAD case), you
gave an order to the advice message (e.g. "hey detachedHead advice,
tell the user how to create a local branch"), but this one is giving
an order to the end user, which feels inconsistent.

I do not have a strong objection against giving an order to the
advice message, as long as it is done consistently.  If we did so,
the part after the colon would start with "instruct the user ..." or
"tell the user ..." and the like, and the gist of what this one
would say would be "shown when it is taking too long: suggest the
user to consider `-u`".

FWIW, my earlier "in order to" took an approach that is different
from either of the two "giving an order" approaches.  I was trying
to make the description explain what the message tries to do and/or
why the message is given (e.g., "shown if it takes too long in order
to suggest users to consider the -u option").

Thanks.
