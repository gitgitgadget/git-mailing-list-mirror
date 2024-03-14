Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B44DDB7
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710397208; cv=none; b=OT4DkuXZ+/y28Y+c/QEFzA5tyKZ3xtdGcFxmXPDAsf5Bfg0rAYpAWwh/aLtQE278H8HC0MY7tlTItv6qaXn/SEUmTkBmnLbV9TtSlJQvVQl+2ce1VLxo/DH0+/GwxRmVF9xfW/4wy4TBNx4hcpB+p1qPH4f6Nta2k30nWMV9Hwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710397208; c=relaxed/simple;
	bh=SHLwpKmQXO4ekaQglmM0I0aQR2i6b4BwBCu6Yh+v5Tw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hN3g4czgay2nQpd/hzLg9R66dsR0whssoaDhJ1tcgYMTaqmNMtB+xaIbiG23TwciUAoQSOZRJeqsBuvxt5PUijjeXGrblKLjK2MLgtpY8mpYh5RfNnMTnc/7WqKMJWWVhJQoXf7YNmdWreXb0m+kvRApBDzIn4lrmepfh7uT4XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=UmMQ/uqJ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="UmMQ/uqJ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710397201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnF9rc7EnsoS43sWPgB+sYBVASPY19kIAv+GGlCYJ4I=;
	b=UmMQ/uqJtz7OYJnEaSI9aojQFqqN2LJRPeOLLMhtPpqcqvqCdE43tREoMU/SN9lkcWKPGb
	SdcxBhzVtA1MfoZacbSKa5LEnM8H+OB6nSLituRLwATV0EGpyh5ESv6A1YDAsISWm0kbaL
	Dum/1kXBSYEgKuq8NNHwF1m8R9TqiWPs8I79adLXdh2O3gX6udaG8luBZdciiLJBMzHuo1
	PWDyY6sY2wxpeCA6GcY3sFoqO4iBkUiA5nLSk/sVZnLstlcmuImIozky1An8jvjN8xQjFI
	w4K+ptfdTbAIAnMdrSBrHgfGUnbC+kuuAyB/RSkj97IONCFyMvj3u5BG7SED3Q==
Date: Thu, 14 Mar 2024 07:20:00 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rsbecker@nexbridge.com, github@seichter.de
Subject: Re: [PATCH 1/3] config.txt: describe whitespace characters further
 and more accurately
In-Reply-To: <xmqqjzm51ugt.fsf@gitster.g>
References: <cover.1710258538.git.dsimic@manjaro.org>
 <1c670101fc29a9ccc71cf4d213545a564e14aa05.1710258538.git.dsimic@manjaro.org>
 <xmqqjzm51ugt.fsf@gitster.g>
Message-ID: <ff7b0a2ead90ad9a9456141da5e4df4a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-14 02:18, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
>> -The syntax is fairly flexible and permissive; whitespaces are mostly
>> -ignored.  The '#' and ';' characters begin comments to the end of 
>> line,
>> -blank lines are ignored.
>> +The syntax is fairly flexible and permissive.  Whitespace characters,
>> +which in this context are the space character (SP) and the horizontal
>> +tabulation (HT), are mostly ignored.  The '#' and ';' characters 
>> begin
>> +comments to the end of line.  Blank lines are ignored.
> 
> OK, except for "whitespace characters"---do we need to say
> "whitespace characters", after we already listed HT and SP are the
> ones, instead of just "whitespaces"?

I also spent some time thinking about that.  To me, the plural form, 
i.e.
"whitespaces", simply doesn't sound very good, because "whitespace" 
feels
to me more like a mass noun, and I really haven't seen it used in plural
form in other projects.

>>  A line that defines a value can be continued to the next line by
>> +ending it with a `\`; the backslash and the end-of-line are stripped.
>> +Leading whitespace characters after 'name =', the remainder of the
>>  line after the first comment character '#' or ';', and trailing
>> +whitespace characters of the line are discarded unless they are 
>> enclosed
>> +in double quotes.  This discarding of the trailing whitespace 
>> characters
>> +also applies after the remainder of the line after the comment 
>> character
>> +is discarded.
> 
> "also" makes it sound as if we do it twice, once to remove trailing
> whitespaces after the remainder of the line after '#", and then trim
> the trailing whitespaces after we removed the comment.

Good point, I also felt it the same way, but went with such wording 
simply
because I thought it should be more understandable to the users, despite
being technically a bit incorrect.

> I wonder if we can make it clearer by following the step-by-step
> nature of the earlier part of the paragraph through.  We already say
> the folded line processing is done first, so break things down in
> conceptual phases/steps, perhaps like
> 
>  * The backslash at the end-of-line is removed, together with the
>    end-of-line, to form a single long line.
> 
>  * Anything that come after the first unquoted comment character,
>    either '#' or ';', are discarded.
> 
>  * The leading and trailing whitespaces around the value part
>    (i.e. what follows 'name =') are discarded.
> 
>  * Remaining unquoted whitespaces inside the value part are munged.

Hmm, I'm not really sure that such a description would be more clear
to the users, despite being technically more correct.  I'll think a bit
more about it.

>> +Any number of internal whitespace characters found within
>> +the value are converted to the same number of space (SP) characters.
> 
> The last one sounds like a bug to me, by the way.
> 
> At least the very original 17712991 (Add ".git/config" file parser,
> 2005-10-10) squashed a run of whitespace characters into a single
> SP, which makes sense as a "clean-up".
> 
> But ebdaae37 (config: Keep inner whitespace verbatim, 2009-07-30),
> while claiming to "Keep" inner whitespaces, broke it by replacing
> any isspace() bytes that are not SP with SP, contradicting its
> stated purpose.

Thank you for the investigation.  The ebdaae37 commit certainly
introduced a bug to the value parsing, which presumably has remained
undected because the included test passes.

The way I see it, fixing the bug may actually be a breaking change,
because some user configurations may actually rely on the current
(mis)behavior.  This makes me somewhat afraid that fixing this bug,
which I already thought about, may actually do more harm than good.
However, fixing this bug seems to be only right thing to do, which
I'll explain further below.

> As the latest change by the author of that change is from more than
> 10 years ago, I do not expect that he is still interested in this
> part of the codebase, but thanks to a very clearly written log
> message, we can read what the motivation behind that change was, and
> seeing that what the code does contradicts with the stated
> motivation we can safely declare that this is an ancient bug.

Agreed, the evidence is clear.

> Fixing that bug can of course be left outside the series.  For those
> who are looking for microproject ideas who discovered this message
> by searching for the #leftoverbits keyword, one possible fix would
> be to revert ebdaae37, make sure a value with any whitespace in it
> gets quoted, and document clearly that an unquoted run of
> whitespaces is squashed into a single SP.  Another way that is
> milder is to finish what ebdaae37 wanted to do and retain the
> whitespaces "verbatim".

I already though about fixing the bug so the value parser actually does
what git-config(1) currently says, but as I already noted above, I'm
afraid a bit that fixing this bug may actually do more harm than good.

Though, further investigation shows that setting a configuration value,
by invoking git-config(1), converts value-internal tabs into "\t" escape
sequences, which the value-parsing logic doesn't "squash" into spaces.
That's why the test included in the ebdaae37 commit passes.  On the 
other
hand, value-internal literal tab characters, found in a configuration
file, do get "squashed" by the value-parsing logic, so I'd say that the
only right thing to do is to fix this bug by making the value-internal
whitespace characters preserved verbatim.

I'd be happy to include the bugfix into this series, if my 
above-mentioned
fears prove to be unnecessary.
