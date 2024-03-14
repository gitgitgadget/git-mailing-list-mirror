Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10BF1113
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710379145; cv=none; b=mg4kjlcKyi2JcFTIu/m7CpeJO0fbbaFQgVCflrbkQTu+RoElnDKWPR96d/aDSX3LZ9ZzOcfJ2wNatf3HMTfEdShuePK0bDgOmEp7IaFJ1Sd/+yFZeu5472p6aLiuHNwmblkvsldwbppUL9Cvvv/13rIDiYLBpQClvHx2SaHUiRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710379145; c=relaxed/simple;
	bh=kFhsX0terjYFCpZmn7028frpYxlWIop24XLMKkTuICk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IY7mlrDBXvy92KbruO1o+Hv2QWpxF5TDrg0+MyvDLdmiSOYx/19/kJ/0apr5zWAqWBUQ2uMkOETKm4gTdue6Iky/CQuiHhkMU3WiMYcutdrjjN+NBXOXMU19HR1YM9pygARY/1FtMPUd73f8/AGx15ukjUwqKscnBzweg9XaUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JvJXGhn1; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JvJXGhn1"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5024D1D486;
	Wed, 13 Mar 2024 21:19:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kFhsX0terjYFCpZmn7028frpYxlWIop24XLMKk
	TuICk=; b=JvJXGhn1J+F+3ftZ7Yxb78MHFN+mEzKVNj56E7ZYDPnnLGQWw3zlSE
	o0XELCJixOgSejp66C3GxyH7BuCgFxwXgCNbmsKUnIjYxc+/ozfZaDanY0oOG5U/
	nGd227NSSYi43OQQzEoOj7v8xvJMwWQY9tReXUI52LTDFvQSSJshM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 35D241D485;
	Wed, 13 Mar 2024 21:19:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B93191D481;
	Wed, 13 Mar 2024 21:18:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  rsbecker@nexbridge.com,  github@seichter.de
Subject: Re: [PATCH 1/3] config.txt: describe whitespace characters further
 and more accurately
In-Reply-To: <1c670101fc29a9ccc71cf4d213545a564e14aa05.1710258538.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Tue, 12 Mar 2024 16:55:44 +0100")
References: <cover.1710258538.git.dsimic@manjaro.org>
	<1c670101fc29a9ccc71cf4d213545a564e14aa05.1710258538.git.dsimic@manjaro.org>
Date: Wed, 13 Mar 2024 18:18:58 -0700
Message-ID: <xmqqjzm51ugt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D6143EB4-E1A0-11EE-8B23-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Make it more clear what the whitespace characters are in the context of git
> configuration, improve the description of the trailing whitespace handling,
> and correct the description of the value-internal whitespace handling.
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  Documentation/config.txt | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 782c2bab906c..4480bb44203b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -22,9 +22,10 @@ multivalued.
>  Syntax
>  ~~~~~~
>  
> -The syntax is fairly flexible and permissive; whitespaces are mostly
> -ignored.  The '#' and ';' characters begin comments to the end of line,
> -blank lines are ignored.
> +The syntax is fairly flexible and permissive.  Whitespace characters,
> +which in this context are the space character (SP) and the horizontal
> +tabulation (HT), are mostly ignored.  The '#' and ';' characters begin
> +comments to the end of line.  Blank lines are ignored.

OK, except for "whitespace characters"---do we need to say
"whitespace characters", after we already listed HT and SP are the
ones, instead of just "whitespaces"?

> @@ -64,12 +65,14 @@ The variable names are case-insensitive, allow only alphanumeric characters
>  and `-`, and must start with an alphabetic character.
>  
>  A line that defines a value can be continued to the next line by
> +ending it with a `\`; the backslash and the end-of-line are stripped.
> +Leading whitespace characters after 'name =', the remainder of the
>  line after the first comment character '#' or ';', and trailing
> +whitespace characters of the line are discarded unless they are enclosed
> +in double quotes.  This discarding of the trailing whitespace characters
> +also applies after the remainder of the line after the comment character
> +is discarded.

"also" makes it sound as if we do it twice, once to remove trailing
whitespaces after the remainder of the line after '#", and then trim
the trailing whitespaces after we removed the comment.

I wonder if we can make it clearer by following the step-by-step
nature of the earlier part of the paragraph through.  We already say
the folded line processing is done first, so break things down in
conceptual phases/steps, perhaps like

 * The backslash at the end-of-line is removed, together with the
   end-of-line, to form a single long line.

 * Anything that come after the first unquoted comment character,
   either '#' or ';', are discarded.

 * The leading and trailing whitespaces around the value part
   (i.e. what follows 'name =') are discarded.

 * Remaining unquoted whitespaces inside the value part are munged.

> +Any number of internal whitespace characters found within
> +the value are converted to the same number of space (SP) characters.

The last one sounds like a bug to me, by the way.

At least the very original 17712991 (Add ".git/config" file parser,
2005-10-10) squashed a run of whitespace characters into a single
SP, which makes sense as a "clean-up".

But ebdaae37 (config: Keep inner whitespace verbatim, 2009-07-30),
while claiming to "Keep" inner whitespaces, broke it by replacing
any isspace() bytes that are not SP with SP, contradicting its
stated purpose.

As the latest change by the author of that change is from more than
10 years ago, I do not expect that he is still interested in this
part of the codebase, but thanks to a very clearly written log
message, we can read what the motivation behind that change was, and
seeing that what the code does contradicts with the stated
motivation we can safely declare that this is an ancient bug.

Fixing that bug can of course be left outside the series.  For those
who are looking for microproject ideas who discovered this message
by searching for the #leftoverbits keyword, one possible fix would
be to revert ebdaae37, make sure a value with any whitespace in it
gets quoted, and document clearly that an unquoted run of
whitespaces is squashed into a single SP.  Another way that is
milder is to finish what ebdaae37 wanted to do and retain the
whitespaces "verbatim".

Thanks.
